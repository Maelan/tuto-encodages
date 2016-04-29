Comment fait-on alors pour écrire du texte ? Tout simplement, on associe à
chaque caractère (une lettre, un signe de ponctuation, une espace…) un nombre.
Un texte est alors une séquence de tels nombres, ce qu’on appelle une « chaîne
de caractères ».

Par exemple, on peut décider ceci :

+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
|**Caractère     **|`A`|`B`|`C`|…|`Z`|`0`|`1`|`2`|…|`9`|`.`|`,`|`:`|`?`|`!`|`-`|_espace_|
+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
|**Nombre associé**|0  |1  |2  |…|25 |26 |27 |28 |…|35 |36 |37 |38 |39 |40 |41 |42      |
+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
Table: Exemple de correspondance nombre – caractère

Avec cet exemple, le texte `MARTINE ECRIT EN UTF-8.` serait codé comme suit :

    :::text
     M  A  R  T  I  N  E     E  C  R  I  T     E  N     U  T  F  -  8  .
    12 00 17 19 08 13 04 42 04 02 17 08 19 42 04 13 42 20 19 15 41 38 36

On a donné un nombre unique pour chaque lettre de l’alphabet (de `A` à `Z`),
pour les dix chiffres (de `0` à `9`) et pour les signes de ponctuation, sans
oublier l’espace.

Cet exemple montre comment les informaticiens inventent une façon de coder du
texte en mémoire.

1.  D’abord, on décide de l’ensemble des **caractères** dont on a besoin. On
    appelle cet ensemble un **répertoire (ou jeu) de caractères** (_character
    set_ en anglais, abrégé _charset_).
1.  Ensuite, on assigne à chaque caractère un numéro unique appelé **code**. Le
    résultat est appelé **jeu de caractères codés** et se résume à un tableau de
    correspondance comme ci-dessus.
1.  Enfin, il faut déterminer l’**encodage** (_encoding_), c’est-à-dire la façon
    de transcrire du texte grâce aux codes des caractères qui le composent.

Évidemment, l’encodage le plus simple consiste à écrire directement chaque code.
Le jeu et l’encodage sont alors confondus, et on parle de **page de code**
(_charmap_). La distinction entre les deux peut sembler artificielle et, en
fait, elle n’était pas faite jusqu’à récemment[^terminologie], le besoin ne s’en
étant fait ressentir qu’avec Unicode. Mais pas de panique, on verra tout ça.

[^terminologie]: d’où une tendance à mélanger allégrement tous les termes

[[information]]
| Mais qu’est‐ce qu’un caractère ? On pourrait les définir comme les éléments
| permettant de coder du texte. Ça correspond _grosso modo_ aux « graphèmes »,
| c’est‐à‐dire aux plus petits éléments constitutifs d’un système d’écriture :
| les lettres pour un système alphabétique, les idéogrammes pour un système
| idéographique… sans oublier les divers symboles de ponctuation. Ce n’est pas
| toujours évident à définir. Par exemple, pour l’alphabet latin, faut‐il
| considérer une lettre accentuée comme un seul graphème, ou comme deux ?
| Jusqu’en 2010, l’espagnol considérait `ll` comme une seule lettre, et un
| lingüiste vous dirait que `ch`, `ou`, `ai`… forment chacun un seul graphème en
| français. Pourtant, dans les jeux actuels, ces digrammes ne possèdent pas de
| caractère attitré, contrairement aux [ligatures][wiki-ligature] comme `œ`,
| `æ`, `ß` (allemand), `ĳ` (néerlandais) `ǳ` (polonais)…
|
| Un caractère n’est donc pas exactement un graphème, d’autant plus qu’on
| définit aussi des « caractères de contrôle » qui ne représentent pas des
| symboles « imprimables », mais contrôlent le codage du texte et donnent des
| indications aux programmes qui le lisent. Par exemple, un caractère « fin de
| texte ».

[wiki-ligature]: https://fr.wikipedia.org/wiki/Ligature_(écriture)
