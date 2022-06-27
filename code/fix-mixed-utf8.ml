#!/usr/bin/ocaml

(*
 * Reads an UTF-8 text and writes it on standard output. Invalid codes are
 * regarded as CP1252-encoded characters and are converted to UTF-8.
 *)

let substitute = "�"

let buf = object (self)
  val buf = Bytes.make 4 '\x00'
  val mutable first = 0
  val mutable cur   = 0
  val mutable last  = 0
  method input () =
    Char.code @@
    if cur < last then
      let b = Bytes.get buf (cur mod 4) in
      cur <- cur + 1 ;
      b
    else
      let b = input_char stdin in
      Bytes.set buf (cur mod 4) b ;
      cur  <- cur + 1 ;
      last <- cur ;
      assert (first <= last && last <= first + 4) ;
      b
  method rewind () =
    cur <- first
  method discard () =
    first <- cur
  method consume ?(keep=0) f =
    self#rewind () ;
    while cur < last - keep do
      f (self#input ())
    done ;
    self#discard ()
end

exception Invalid_code of int

let unicode_of_cp1252 =
  let mapping =
    [|
      (* codes from 0x80 to 0x8F: *)
      0x20AC ;      0 ; 0x201A ; 0x0192 ; 0x201E ; 0x2026 ; 0x2020 ; 0x2021 ;
      0x02C6 ; 0x2030 ; 0x0160 ; 0x2039 ; 0x0152 ;      0 ; 0x017D ;      0 ;
      (* codes from 0x90 to 0x9F: *)
           0 ; 0x2018 ; 0x2019 ; 0x201C ; 0x201D ; 0x2022 ; 0x2013 ; 0x2014 ;
      0x02DC ; 0x2122 ; 0x0161 ; 0x203A ; 0x0153 ;      0 ; 0x017E ; 0x0178 ;
    |]
  in fun code ->
    if 0x80 <= code && code < 0xA0 then
      let ucode = mapping.(code-0x80) in
      if ucode = 0 then raise (Invalid_code code) else ucode
    else
      code

let utf8_of_unicode ucode =
  assert (ucode < 0b1000000000000000000000) ;
  if ucode < 0x80 then
    [ ucode ]
  else if ucode < 0b100000000000 then
    let b1 = 0b10_000000 lor (ucode land 0b111111) in
    let b0 = 0b110_00000 lor (ucode lsr 6) in
    [ b0 ; b1 ]
  else if ucode < 0b10000000000000000 then
    let b2 = 0b10_000000 lor ( ucode         land 0b111111) in
    let b1 = 0b10_000000 lor ((ucode lsr 6 ) land 0b111111) in
    let b0 = 0b1110_0000 lor ((ucode lsr 12)              ) in
    [ b0 ; b1 ; b2 ]
  else
    let b3 = 0b10_000000 lor (ucode          land 0b111111) in
    let b2 = 0b10_000000 lor ((ucode lsr 6 ) land 0b111111) in
    let b1 = 0b10_000000 lor ((ucode lsr 12) land 0b111111) in
    let b0 = 0b11110_000 lor ((ucode lsr 18)              ) in
    [ b0 ; b1 ; b2 ; b3 ]

let output_utf8_byte =
  output_byte stdout

let output_cp1252_as_utf8 code =
  try
    List.iter output_utf8_byte (utf8_of_unicode (unicode_of_cp1252 code))
  with Invalid_code _ ->
    Printf.eprintf "unknown code %02X ; inserting “%s” instead\n" code substitute ;
    output_string stdout substitute

let rec read state =
  match buf#input () with
  | b when b < 0x80          && state = 0 ->
      buf#discard () ;
      output_utf8_byte b ;
      read 0
  | b when b lsr 6 = 0b10    && state > 0 ->
      if state = 1 then
        buf#consume output_utf8_byte ;
      read (state - 1)
  | b when b lsr 5 = 0b110   && state = 0 -> read 1
  | b when b lsr 4 = 0b1110  && state = 0 -> read 2
  | b when b lsr 3 = 0b11110 && state = 0 -> read 3
  | _ ->
      buf#consume ~keep:1 output_cp1252_as_utf8 ;
      read 0
  | exception End_of_file when state > 0 ->
      buf#consume ~keep:1 output_cp1252_as_utf8 ;
      read 0
  | exception End_of_file -> ()

let () =
  read 0