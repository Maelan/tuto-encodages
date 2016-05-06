Enfin, lorsqu’on crée un programme, il faut bien sûr faire attention à
l’encodage du texte qu’on manipule !

# Le langage C

Le langage C est bas niveau. En C, on manipule directement les octets, avec le
type `char`. En particulier, **un `char` est un octet, *pas* un caractère**.
C’est le type `wchar_t` qui permet de stocker un caractère
arbitraire[^voca-extended].

La gestion des encodages en C de façon portable est excessivement compliquée si
l’on se contente de la norme. En effet, le C est un vieux langage, créé dans les
années 1970 lorsqu’on n’utilisait encore que des pages de code sur un _byte_.
Tout était plus simple. Avec le développement d’encodages plus complexes, il a
fallu adapter la norme… et comme d’habitude, le comité a décidé de ne pas
normaliser grand-chose (pour ne pas trop contraindre les implémenteurs et pour
garder la bibliothèque standard minimaliste).

Voici une synthèse des types disponibles et des encodages associés ; évidemment,
la norme laisse ces derniers non spécifiés, donc dans ce tableau figurent les
valeurs usuelles.

+----------------+--------------------------+-------------------------------------------+-------+
|Type des chaînes|Taille d’un caractère     |Jeu de caractère & encodage                |Version|
+================+==========================+===========================================+=======+
|`char[]`        |nombre variable de `char` |déterminé par la [« _locale_ »][man-locale]|C89    |
|                |[^voca-multibyte]         |(donc dynamique)                           |       |
|                |                          |                                           |       |
|                |(1 `char` = 1 octet)      |-    Windows : Windows-1252 (taille fixe)  |       |
|                |                          |-    Linux : UTF-8 (taille variable)       |       |
+----------------+--------------------------+-------------------------------------------+-------+
|`wchar_t[]`     |exactement un `wchar_t`   |dépend du système                          |C99    |
|                |[^voca-wide]              |                                           |       |
|                |                          |                                           |       |
|                |(= 1, 2 ou 4 octets, selon|-    Windows : UTF-16[^windows-utf16]      |       |
|                |le système)               |-    Linux : UTF-32                        |       |
+----------------+--------------------------+-------------------------------------------+-------+
|`int16_t[]`     |exactement un `char16_t`  |dépend du système, prévu pour UTF-16       |C11    |
|                |(= 16 bits)               |                                           |       |
+----------------+--------------------------+-------------------------------------------+-------+
|`int32_t[]`     |exactement un `char32_t`  |dépend du système, prévu pour UTF-32       |C11    |
|                |(= 32 bits)               |                                           |       |
+----------------+--------------------------+-------------------------------------------+-------+
Table: Types et encodages en C

[^windows-utf16]: Eh oui, la norme demande que les caractères soient de taille
  fixe, mais Windows a choisi UTF-16 restreint au BMP, comme on l’a déjà vu
  quand on a présenté UTF-16. Ceci permet un gain de mémoire par rapport à
  UTF-32.

Ces encodages sont ceux utilisés par les fonctions de la bibliothèque standard,
telles les [fonctions de conversion][man-mbtowc], mais bien sûr on fait ce qu’on
veut de nos octets.

[^voca-extended]: La norme appelle « jeu étendu » (_extended character set_)
  l’ensemble de caractères supporté par le système.
[^voca-multibyte]: La norme parle d’[« encodage multi-octet » (_multibyte
  encoding_)][man-multibyte].
[^voca-wide]: La norme parle de [« caractères larges » (_wide
  characters_)][man-wchar_t].

[man-wchar_t]:   http://www.sensi.org/~alec/man/man_h/wchar.html
[man-multibyte]: http://www.unix.com/man-page/FreeBSD/3/multibyte/
[man-locale]:    http://pwet.fr/man/linux/conventions/locale
[man-mbtowc]:    http://pwet.fr/man/linux/fonctions_bibliotheques/mbtowc
[man-mbsinit]:   http://pwet.fr/man/linux/fonctions_bibliotheques/mbsinit

[[information]]
| La console de Windows crée une difficulté supplémentaire puisqu’au lieu de la
| nouvelle page de code 1252, elle utilise toujours l’ancienne (850 ou 437) par
| défaut. Un logiciel qui respecte la _locale_ écrira en Windows-1252 et ses
| accents s’afficheront mal dans la console. Pour y remédier, demander à
| l’utilisateur de faire `CHCP 1252` ou, mieux, ajuster soi-même l’encodage de
| la console avec les fonctions `setConsoleOutputCP` et `GetACP` définies dans
| `<windows.h>`.

Bref, pour un résultat portable et sans prise de tête, il est avisé d’utiliser
une bibliothèque tierce. L’implémentation de référence est [la bibliothèque
ICU][ICU], extrêmement complète. Également, j’ai déjà évoqué [l’API
iconv][man3-iconv] intégrée à POSIX, pour les conversions d’encodages.

[ICU]: https://fr.wikipedia.org/wiki/International_Components_for_Unicode
[man3-iconv]: http://man7.org/linux/man-pages/man3/iconv.3.html

Je ne m’étendrai pas plus sur le sujet. Si vous voulez pousser plus loin, j’ai
donné des mots-clés pour guider vos recherches. Pour plus de détail sur la norme
C à ce sujet, lisez donc [ceci][msg-norme], c’est un bon moyen de se rendre
compte à quel point c’est l’enfer…

[msg-norme]: https://pdp.microjoe.org/forums/sujet/358/c-caracteres-unicode?page=1#p6937

# Autres langages

Les langages de plus haut niveau, ou tout simplement plus récents, peuvent mieux
prendre en charge Unicode et les conversions d’encodages.

Par exemple, en Java, la classe [`String`][java-String] utilise l’UTF-16. De
plus, des fonctionnalités supplémentaires pour contrôler plus finement l’Unicode
sont fournies par le _package_ [`Java.text`][java-text].

[java-String]: http://docs.oracle.com/javase/6/docs/api/java/lang/String.html
[java-text]:   http://docs.oracle.com/javase/6/docs/api/java/text/package-summary.html

De même, Python permet de [gérer Unicode et les encodages][python] facilement.
De plus, Unicode est devenu le défaut en Python 3.

-   La classe `unicode` (renommée `str` en Python 3…) est un texte Unicode
    décodé. C’est ce qu’il faut utiliser partout en interne, Unicode étant
    universel.
-   La classe `str` (renommée `byte` en Python 3) est un texte encodé suivant un
    certain encodage. Il ne faut l’utiliser que pour les entrées et sorties.

En Python 2, `u"déjà"` est un objet de type `unicode` tandis que `"déjà"` est un
objet de type `str`. Les méthodes `.encode(…)` et `.decode(…)` permettent de
passer de l’un à l’autre ; elles prennent en paramètre l’encodage du texte
`str`.

[python]: http://sametmax.com/lencoding-en-python-une-bonne-fois-pour-toute/

En OCaml, la maigre bibliothèque standard ne prend pas en charge Unicode
(jusqu’à récemment, la norme du langage utilisait latin-1), mais de nombreuses
bibliothèques tierces le font, comme [Camomile][ocaml-camomile] (intégrée à
[Batteries][ocaml-batteries]) ou [Uutf][ocaml-uutf].

[ocaml-camomile]:  https://github.com/yoriyuki/Camomile
[ocaml-batteries]: https://github.com/ocaml-batteries-team/batteries-included
[ocaml-uutf]:      http://erratique.ch/software/uutf
