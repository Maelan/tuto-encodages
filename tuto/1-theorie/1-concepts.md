Comment fait-on alors pour écrire du texte ? La réponse est toute bête : on
associe à chaque **caractère** (une lettre, un signe de ponctuation, une
espace…) un nombre. Un texte est alors une séquence de tels nombres, ce qu’on
appelle une **chaîne de caractères**.

Par exemple, on peut décider ceci :

+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
|**Caractère     **|`A`|`B`|`C`|…|`Z`|`0`|`1`|`2`|…|`9`|`.`|`,`|`:`|`?`|`!`|`-`|_espace_|
+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
|**Nombre associé**|0  |1  |2  |…|25 |26 |27 |28 |…|35 |36 |37 |38 |39 |40 |41 |42      |
+------------------+---+---+---+-+---+---+---+---+-+---+---+---+---+---+---+---+--------+
Table: Exemple de correspondance nombre – caractère

Avec cet exemple, le texte `MARTINE ECRIT EN UTF-8.` donnerait ceci en mémoire :

    :::text
     M  A  R  T  I  N  E     E  C  R  I  T     E  N     U  T  F  -  8  .
    12 00 17 19 08 13 04 42 04 02 17 08 19 42 04 13 42 20 19 15 41 38 36

On a donné un nombre unique pour chaque lettre de l’alphabet (de `A` à `Z`),
pour les dix chiffres (de `0` à `9`) et pour les signes de ponctuation, sans
oublier l’espace.

Cet exemple montre comment les informaticiens inventent une façon de coder un
texte en mémoire.

1.  D’abord, on décide de l’ensemble des caractères dont on a besoin, et on
    assigne à chacun un identifiant numérique unique appelé **code**. Cet
    ensemble est appelé **jeu de caractères codés** (en anglais _charset_,
    abréviation de _character set_) et peut se résumer dans un tableau de
    correspondance comme ci-dessus.
1.  Ensuite, il faut déterminer l’**encodage** (_encoding_), c’est-à-dire la
    façon de transcrire un texte grâce aux codes des caractères qui le
    composent, selon un jeu de caractères donné. Le moyen le plus simple est
    d’écrire directement chaque code, auquel cas on parle de **page de code**
    (_charmap_) ; le jeu et l’encodage sont alors confondus. On a procédé de
    cette façon dans l’exemple ci-dessus, mais ce n’est pas toujours
    satisfaisant. C’est pourquoi il faut bien retenir la différence entre jeu de
    caractères et encodage.
