L’un des premiers encodages historiques est l’**ASCII**, soit l’_American
Standard Code for Information Interchange_ (en français, le « code américain
normalisé pour l’échange d’informations »). C’est une norme étasunienne,
inventée en 1961, qui avait pour but d’organiser le bazar informatique à
l’échelle nationale. Ce n’est donc pas le premier codage de l’Histoire, mais il
s’est imposé au point d’éclipser les précédents.[^EBCDIC]

*[ASCII]: American Standard Code for Information Interchange

[^EBCDIC]:
  Parmi les dinosaures dont il subsiste encore des fossiles aujourd’hui, on peut
  citer [EBCDIC][].

*[EBCDIC]: Extended Binary Coded Decimal Interchange Code

[EBCDIC]: https://fr.wikipedia.org/wiki/EBCDIC

Le terme « ASCII » est souvent employé incorrectement pour désigner des pages de
code qui étendent l’ASCII ou qui en dérivent.

L’ASCII proprement dit utilise **sept bits** (et non huit !) et dispose donc de
128 (2^7^) caractères uniquement, numérotés de 0 à 127. En effet, à l’époque, il
était encore courant de regrouper les bits par sept et non par huit, ou alors de
réserver le huitième bit pour vérifier l’intégrité des données (bit de parité).

Sans plus attendre, voici la table de l’ASCII. Pour trouver le code d’un
caractère, il faut mettre bout à bout le chiffre _hexadécimal_ de sa ligne et
celui de sa colonne. Ainsi le caractère `Z` a pour code hexadécimal 0x5A (soit
90 en décimal).

+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|      |-0      |-1     |-2     |-3     |-4     |-5     |-6     |-7     |-8     |-9      |-A      |-B      |-C      |-D      |-E    |-F     |
+======+========+=======+=======+=======+=======+=======+=======+=======+=======+========+========+========+========+========+======+=======+
|**0-**|||NUL|| |||SOH|||||STX|||||ETX|||||EOT|||||ENQ|||||ACK|||||BEL|||||BS|| |||_HT_|||||_LF_|||||_VT_|||||_FF_|||||_CR_|||||SO|||||SI|| |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**1-**|||DLE|| |||DC1|||||DC2|||||DC3|||||DC4|||||NAK|||||SYN|||||ETB|||||CAN|||||EM||  |||SUB|| |||ESC|| |||FS||  |||GS||  |||RS|||||US|| |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**2-**|||_SP_|||`!`    |`"`    |`#`    |`$`    |`%`    |`&`    |`'`    |`(`    |`)`     |`\*`    |`+`     |`,`     |`-`     |`.`   |`/`    |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**3-**|`0`     |`1`    |`2`    |`3`    |`4`    |`5`    |`6`    |`7`    |`8`    |`9`     |`:`     |`;`     |`<`     |`=`     |`>`   |`?`    |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**4-**|`@`     |`A`    |`B`    |`C`    |`D`    |`E`    |`F`    |`G`    |`H`    |`I`     |`J`     |`K`     |`L`     |`M`     |`N`   |`O`    |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**5-**|`P`     |`Q`    |`R`    |`S`    |`T`    |`U`    |`V`    |`W`    |`X`    |`Y`     |`Z`     |`[`     |`\`     |`]`     |`^`   |`_`    |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**6-**|`` ` `` |`a`    |`b`    |`c`    |`d`    |`e`    |`f`    |`g`    |`h`    |`i`     |`j`     |`k`     |`l`     |`m`     |`n`   |`o`    |
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
|**7-**|`p`     |`q`    |`r`    |`s`    |`t`    |`u`    |`v`    |`w`    |`x`    |`y`     |`z`     |`{`     |`|`     |`}`     |`~`   |||DEL|||
+------+--------+-------+-------+-------+-------+-------+-------+-------+-------+--------+--------+--------+--------+--------+------+-------+
Table: Table des caractères ASCII

Un exemple (les valeurs sont en hexadécimal) :

    :::text
    texte :         "  A     v  a  i  n  c  r  e     s  a  n  s     p  e  r  i  l  .  .  .  "
    codage ASCII :  22 41 20 76 61 69 6E 63 72 65 20 73 41 6E 73 41 70 65 72 69 6C 2E 2E 2E 22

Regardons un peu ce qu’il y a dans l’ASCII :

-   les vingt-six lettres de l’alphabet latin, en majuscules (0x41 – 0x5A) et en
    minuscules (0x61 – 0x7A), ainsi que les chiffres de 0 à 9 ;
-   divers signes de ponctuation, et d’autres symboles tels que les crochets,
    les accolades, l’arrobase… ;
-   des caractères blancs, c’est-à-dire l’espace mais aussi d’autres tels que le
    retour à la ligne (eh oui, c’est aussi un caractère). Ils sont marqués comme
    ||_ça_||, en voici la liste :
    -   ||_SP_|| (0x20) : espace (_space_) ;
    -   ||_HT_|| (0x09) : tabulation horizontale (_horizontal tab_), le `'\t'`
        des programmeurs ;
    -   ||_VT_|| (0x0B) : tabulation verticale (_vertical tab_) ;
    -   ||_LF_|| (0x0A) : nouvelle ligne (_line feed_), le `'\n'` des
        programmeurs ;
    -   ||_CR_|| (0x0D) : retour chariot (_carriage return_), le `'\r'` des
        programmeurs ; marque la fin d’une ligne ;
    -   ||_FF_|| (0x0C) : nouvelle page (_form feed_) ;
-   des caractères de contrôle non imprimables (0x00 – 0x1F, et 0x7F), marqués
    comme ||ça|| ; en voici quelques-uns :
    -   ||NUL|| (0x00) : caractère nul (_null_), le `'\0'` des programmeurs ;
        marque la fin d’une chaîne de caractères ;
    -   des caractères servant à la communication entre programmes,
        périphériques ou machines ;
    -   des caractères correspondant à des actions, comme ||BS|| (_backspace_,
        retour arrière), ||ESC|| (_escape_, échappement), ||CAN|| (_cancel_,
        annulation) ou ||BEL|| (_bell_, le « bip ! ») ;
    -   d’autres encore.

Notons que ||_LF_|| et ||_CR_|| remplissent des rôles proches et sont tous deux
utilisés pour marquer les nouvelles lignes :

-   sous Linux et Mac OS X, on utilise ||_LF_|| ;
-   sous Mac avant Mac OS X, on utilise ||_CR_|| ;
-   enfin, sous Windows, on utilise la séquence ||_CR_||||_LF_||.

Un joyeux bazar ! En fait, les raisons sont historiques. Jadis, les ordinateurs
n’avaient pas d’écran ; au lieu de s’afficher sur un écran, le texte produit par
les programmes était imprimé sur du papier. Il y avait donc des caractères pour
donner des instructions au chariot (la tête d’écriture) de l’imprimante : ||BS||
indiquait de reculer d’un caractère, ||_CR_|| (le « retour chariot ») indiquait
de revenir au début de la ligne, ||_LF_|| indiquait de descendre d’une ligne…
Pour produire une nouvelle ligne, il était donc nécessaire de combiner ||_CR_||
et ||_LF_||.

Pour poursuivre la digression culturelle, les 128 caractères de l’ASCII n’ont
pas été placés au hasard. Leurs codes ont été soigneusement étudiés. Par
exemples :

-   À l’époque reculée où a été conçu l’ASCII, on communiquait encore parfois
    des données à l’ordinateur _via_ des cartes perforées. Chaque emplacement
    codait un bit : 1 s’il y avait un trou, 0 sinon. La perforation était
    irréversible. Lorsqu’on n’avait pas encore spécifié de caractère, on
    laissait tous les emplacements intacts et le caractère valait donc 0 (tous
    les bits à 0). Ce caractère « non spécifié » se retrouve en ASCII avec
    ||NUL||, le caractère nul, qui vaut 0. De même, lorsqu’on voulait effacer un
    caractère on perçait tous les emplacements, ce qui donnait 127 (tous les
    bits à 1) ; le caractère ASCII ||DEL|| (_delete_) correspond justement à
    cette suppression.
-   Les lettres majuscules sont séparées de leurs homologues minuscules par un
    intervalle de 32. Cela signifie qu’il suffit de modifier un bit (le sixième)
    pour passer des unes aux autres.

Pour plus de détails, consultez [l’article de Wikipédia][ASCII].

[ASCII]: https://fr.wikipedia.org/wiki/ASCII

Comme on le voit, l’ASCII est simple. Il ne comporte que le strict nécessaire
pour l’époque, pour utiliser un ordinateur… en anglais. Évidemment, les autres
pays ont voulu employer leur propre langue.
