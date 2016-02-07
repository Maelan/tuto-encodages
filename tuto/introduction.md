Vous avez déjà croisé des mots comme _charset_, _encodage_, _ASCII_, _UTF-8_,
_ISO-8859_, _latin-1_… et vous vous demandez ce que sont ces bestioles ?

Vos jolies lettres accentuées cèdent la place à d’affreux Ã© et � ?

Webmestre, vous recopiez au début de vos toutes pages HTML une ligne

    :::html
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>

sans en comprendre le sens ?

Vous êtes curieux de savoir comment un ordinateur code du texte ?

Ce cours est pour vous. On va tout expliquer en douceur.

![](archive:Martine.jpg)

# La théorie : le texte en informatique

Un ordinateur ne peut stocker que des nombres, ou plus précisément des 0 et des
1 (des « bits ») qu’on regroupe pour former des nombres en binaire. Comment
fait-on alors pour écrire du texte ? La réponse est toute bête : on associe à
chaque **caractère** (une lettre, un signe de ponctuation, une espace…) un
nombre. Un texte est alors une séquence de tels nombres, ce qu’on appelle une
**chaîne de caractères**.

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

Ça, c’est pour la théorie. En pratique, l’exemple qu’on a inventé était
simpliste. Dans la réalité, on a deux complications principales.

1.  Il faut considérer les contraintes matérielles. En effet, comme je l’ai dit,
    un ordinateur ne connaît que le binaire. Les bits sont regroupés par groupes
    de huit appelés « octets ». Un octet ne peut stocker que les nombres
    entiers de 0 à 255 (soit 256 = 2^8^ possibilités). Si cela ne suffit pas, on
    peut rassembler les octets par deux, quatre ou plus pour avoir de plus
    grands nombres. Dans nos encodages, il faudra tenir compte de ces limites,
    c’est-à-dire s’arranger pour que les codes de notre jeu tiennent tous sur un
    ou deux octets par exemple.
1.  Il y a beaucoup plus de caractères à gérer. Dans notre exemple, on a été
    négligent, on en a oublié plein :
    -   Il serait utile d’ajouter des caractères spéciaux, dits « de contrôle »,
        qui ne représentent pas un symbole « imprimable » mais donnent des
        indications aux programmes qui manipulent du texte. Par exemple, un
        caractère « fin de chaîne de caractères » ou « fin de fichier ».
    -   Ce serait vraiment bien d’avoir les lettres minuscules…
    -   Pour écrire vraiment correctement en français, il faudrait aussi les
        accents, le C cédille (`Ç`) l’E dans l’O (`Œ`), les symboles de monnaie…
    -   Enfin, n’oublions pas qu’il existe plein d’autres alphabets que
        l’alphabet latin, et que les Arabes et les Chinois — entre autres — ont
        peut-être envie de parler dans leur langue maternelle, eux aussi. C’est
        là que ça devient vraiment problématique, comme nous allons le voir.
