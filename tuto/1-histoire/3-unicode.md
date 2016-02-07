Avec des normes comme ISO 8859 et ISO 2022, le problème d’interropérabilité
était à moitié résolu. On avait certes normalisé les communications entre
langues voisines, mais le système conservait des limites. Comment transmettre un
texte si l’encodage du destinataire ne contient pas tous les caractères
nécessaires (envoyer de l’arabe à un français p.ex.) ? Comment écrire un texte
contenant des caractères de plusieurs alphabets, s’il n’existe pas d’encodage
qui les regroupe simultanément (arabe et russe p.ex.) ?

La solution s’impose d’elle-même : créer un jeu de caractères universel qui
contienne tous les alphabets ! Cette idée toute simple a donné naissance à deux
monuments : la norme ISO 10646 et Unicode.

![logo d’Unicode](archive:Unicode-logo.jpg)
Figure: logo d’Unicode

**Unicode** est une norme développée par le [consortium Unicode][Unicode] depuis
1990 (version 8.0 en juin 2015). Elle repose sur le **jeu universel de
caractères** ou JUC (en anglais, _UCS_ pour _Universal Character Set_), défini
dans la norme parallèle **ISO 10646**.

[Unicode]: http://www.unicode.org

*[JUC]: Jeu Universel de Caractères

# Le jeu universel de caractères

L’objectif de ce jeu est d’accueillir tous les caractères existants de toutes
les langues du monde, actuelles ou passées. Un travail titanesque !
Concrètement, c’est un bête jeu de caractères, sauf que celui-ci offre pas moins
de 17×2^16^ = 1 114 112 codes. À l’origine, il prévoyait même
2^31^ = 2 147 483 648 codes, mais il a vite été restreint : c’est déjà bien
suffisant.

[[secret]]
| Devant une telle quantité, les polices d’écriture (qui n’ont rien à voir avec
| les encodages, il s’agit ici d’**affichage** des caractères et non de leur
| **codage** en mémoire) peinent à suivre. C’est ce qui explique les petits
| symboles du type ![�](archive:Unicode-glyphe-inconnu.png) qu’on peut voir sur
| certaines pages (en regardant bien, vous lirez le code du caractère dans le
| carré). Généralement, les auteurs de polices se contentent de créer les
| glyphes des parties qui les intéressent, et parfois de copier les glyphes de
| référence pour le reste ; si on a vraiment besoin de rédiger une partition
| suivant la [notation musicale grecque ancienne][musique-grecque] avec le JUC,
| on utilisera une police spécialisée…

[musique-grecque]: https://fr.wikipedia.org/wiki/Table_des_caractères_Unicode/U1D200

En juin 2015, environ 11 % des codes sont déjà attribués à des caractères (en
grande partie des idéogrammes asiatiques). Il reste encore de la place à
revendre. Et pourtant, dans ces 11 %, on a tout mis ou presque : les caractères
de tous les anciens jeux, tous les alphabets modernes, pléthore de symboles… Le
JUC n’est peut-être pas la solution définitive et éternelle, mais on peut dormir
sur nos deux oreilles pendant les décennies à venir.

Par souci de compatibilité, le JUC reprend latin-1 (donc l’ASCII) pour ses 256
premiers caractères.

Le jeu n’est pas définitif : de nouveaux caractères sont régulièrement créés et
assignés à des codes encore libres. Cependant, les caractères déjà en place ne
bougent plus.

[[information]]
| Au fait, **U+_code_** est une notation officielle pour désigner le caractère
| de code hexadécimal donné. Par exemples, U+0041 est la lettre `A` et U+23CF
| est le symbole `⏏`.

[[information]]
| __Écrire des caractères Unicode sous Linux__
| 
| Sous Linux, dans certains cas (selon la méthode d’entrée utilisée), le
| raccourci ||Ctrl||+||Maj||+||U||+||_code_|| insère directement le caractère
| Unicode spécifié.

On peut voir Unicode comme une surcouche d’ISO 10646. ISO 10646 liste les
caractères du jeu en leur assignant un nom et un code. Unicode leur ajoute des
attributs et des relations. Unicode décrit aussi des algorithmes de traitement
notamment pour la gestion des sens d’écriture et l’ordre alphabétique, et
surtout — ce qui nous intéresse ici — des encodages pour transcrire le JUC.

# Un jeu, des encodages

[[question]]
| Des encodages ? Mais, je croyais qu’Unicode était un encodage ?

Unicode est basiquement un **jeu de caractères** (un ensemble de caractères
auxquels on attribue à chacun un point de code unique) et non un **encodage**
(façon de représenter ce point de code en mémoire). C’est ici que la distinction
prend tout son sens. Auparavant, les deux se confondaient puisque tous les jeux
de caractères étaient associés à un encodage simple : vu que leur codes tenaient
sur un ou deux octets, on se contentait de les écrire tels quels en mémoire.

Or, les points de codes d’Unicode nécessitent beaucoup plus qu’un octet : il
leur en faudrait quatre[^petits-malins] ! Cela voudrait dire que si l’on
continuait à faire comme avant, on utiliserait quatre fois plus de mémoire
qu’avec nos pages de code sur un octet, comme latin-1.

[^petits-malins]: Des petits malins me diront que trois octets suffiraient, mais
  en informatique on préfère les puissances de 2.

Ça ferait beaucoup de mémoire utilisée, voire gaspillée, puisqu’il y aurait
plein d’octets nuls :

+--------------------------+-------------------------------------+------------------------------------------+
|Codes                     |Encodage selon UTF-32                |Caractères disponibles dans cet intervalle|
+==========================+=====================================+==========================================+
|jusqu’à U+00FF (2^8^-1)   |`00000000 00000000 00000000 bbbbbbbb`|langues occidentales (latin-1)            |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+FFFF (2^16^-1)  |`00000000 00000000 bbbbbbbb bbbbbbbb`|la quasi-totalité des alphabets           |
|                          |                                     |actuellement utilisés dans le monde       |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+10FFFF (2^21^-1)|`00000000 000bbbbb bbbbbbbb bbbbbbbb`|tous les caractères                       |
+--------------------------+-------------------------------------+------------------------------------------+
Table:
  Tableau pour mieux visualiser le problème
  (les codes sont en binaire, les `b` symbolisent les bits occupés)

Comme on le voit, il y aurait toujours au moins un octet nul, souvent deux. Le
cas extrême est celui d’un Occidental qui gaspille trois octets par caractère.

Cet encodage existe tout de même, il est nommé **UTF-32**, mais est rarement
employé — sauf en interne par quelques programmes, car il reste plus facile à
traiter que ses confrères que nous allons voir.


# UTF-16

Pour faire des économies, on a donc mis au point des encodages plus futés. Tout
d’abord, il y a l’**UTF-16** (_UCS transformation format_, seize bits). Celui-ci
a pour unité de base un doublet, c’est-à-dire deux octets (d’où le « 16 » dans
son nom, comme le nombre de bits de l’unité de base). Les points de code
inférieurs à 2^16^ = 65 536 sont représentés tels quels sur deux octets, et les
codes supérieurs sont représentés sur quatre octets _via_ une transformation
mathématique simple[^taille-juc].

[^taille-juc]: C’est d’ailleurs le codage UTF-16 qui a fixé la limite
  inhabituelle de 17×2^16^ points de code (la limite précédente, 2^31^, vient du
  codage UTF-8).

Les caractères de cet encodage ne font donc pas tous la même taille, ce qui
complique un peu les traitements : si on stocke une chaîne UTF-16 dans un
tableau de codes de deux octets, le _n_^e^ caractère ne se trouve pas forcément
dans la _n_^e^ case. Ceci dit, étant donné que l’ensemble des points de codes
inférieurs à 2^16^ (le « [BMP][] », pour _Basic Multilingual Plane_) contient
déjà tous les alphabets actuels et symboles courants, il peut être suffisant de
s’y restreindre (ce que fait Windows), et dans ce cas tous les caractères font
bien deux octets.

*[BMP]: Basic Multilingual Plane

[BMP]: https://en.wikipedia.org/wiki/Plane_(Unicode)

De plus, l’UTF-16 (et l’UTF-32) fait surgir une difficulté technique
supplémentaire : le [boutisme][] (_endianness_). Ce terme mystique désigne
l’ordre des octets d’un nombre multi-octet. Il en existe deux variantes
principales : le **gros boutisme** (_big-endian, BE_) et le **petit boutisme**
(_little-endian, LE_). Le boutisme dépend des machines. Or, en UTF-16, on lit
les données par groupes de deux octets, donc le boutisme influe sur le
résultat : si l’on lit du texte UTF-16 envoyé par quelqu’un utilisant un
boutisme différent du sien, les deux octets de chaque caractère seront échangés,
et c’est l’erreur assurée !

[boutisme]: https://fr.wikipedia.org/wiki/Boutisme

Pour pallier à cela, on utilise parfois un caractère spécial appelé BOM (_byte
order mask_, marque d’ordonnancement des octets). l’IANA a aussi créé deux noms
pour préciser le boutisme employé sur Internet : `UTF-16BE` et `UTF-16LE`.

*[BOM]: Byte Order Mark

Reprenons le texte d’exemple de tout à l’heure et encodons-le cette fois en
UTF-16. En passant, remplaçons les trois caractères « point » (`.`) par le
nouveau caractère « points de suspension » (`…`) qui est fait pour ça. Pour bien
faire, ajoutons la BOM facultative :

    :::text
    texte :          [BOM] «____ ▒____ À____       v____ a____ i____ n____ c____ r____ e____       s____ a____ n____ s____       p____ é____ r____ i____ l____ …____ ▒____ »____
    codage UTF-16 :  FE.FF 00.A0 00.A0 00.C0 00.20 00.76 00.61 00.69 00.6E 00.63 00.72 00.65 00.20 00.73 00.41 00.6E 00.73 00.41 00.70 00.E9 00.72 00.69 00.6C 20.26 00.A0 00.BB

Ici, la BOM indique que le texte est gros-boutiste (l’octet de poids fort est en
premier). En petit-boutiste, on aurait ça :

    :::text
    texte :          [BOM] «____ ▒____ À____       v____ a____ i____ n____ c____ r____ e____       s____ a____ n____ s____       p____ é____ r____ i____ l____ …____ ▒____ »____
    codage UTF-16 :  FF.FE A0.00 A0.00 C0.00 20.00 76.00 61.00 69.00 6E.00 63.00 72.00 65.00 20.00 73.00 41.00 6E.00 73.00 41.00 70.00 E9.00 72.00 69.00 6C.00 26.20 A0.00 BB.00

Si la chaîne contient une BOM, il suffit donc de lire ses deux premiers octets
pour connaître son boutisme.

Remarquons que ce texte s’encode en UTF-16 exactement comme en latin-1, avec des
valeurs sur deux octets au lieu d’un (donc un octet nul sur deux). On occupe
donc deux fois plus de mémoire.

# UTF-8

On a aussi inventé l’**UTF-8**. La taille des caractères codés est encore plus
variable, et l’économie de mémoire plus grande. Comme son nom l’indique, l’unité
de base est l’octet. Il code les premiers caractères (ceux de l’ASCII) sur un
octet, les suivants sur deux, trois et jusqu’à quatre octets.

Cet encodage est compatible avec l’ASCII : les caractères de l’ASCII sont codés
exactement de la même manière en UTF-8. De plus, l’encodage a été conçu afin que
certains algorithmes de traitement (comparaison lexicographique par exemple)
soient réutilisables sans modification. Ainsi, de vieux programmes qui n’ont pas
été conçus pour un autre encodage que l’ASCII fonctionneront aussi si on leur
passe du texte en UTF-8 : magique !

Enfin, contrairement à l’UTF-16, on n’a pas de problème de boutisme puisqu’on
lit les données octet par octet.

UTF-8 a de nombreux avantages (économie de mémoire, compatibilité, boutisme,
résistance aux erreurs). Un défaut aussi : la grande variabilité de taille des
caractères rend les traitements plus compliqués et nuit à leurs performances.
Ses points forts ont cependant suffi à lui assurer le succès : il est
probablement l’encodage le plus répandu aujourd’hui. Il est utilisé pour les
documents et les communications, et les systèmes d’exploitation (Mac et Linux)
s’y mettent aussi.

Pour ne pas changer, voici notre texte d’exemple encodé en UTF-8 :

    :::text
    texte :         «____ ▒____ À____    v  a  i  n  c  r  e     s  a  n  s     p  é____ r  i  l  …_______ ▒____ »____
    codage UTF-8 :  C2.AB C2.A0 C3.80 20 76 61 69 6E 63 72 65 20 73 41 6E 73 41 70 C3.A9 72 69 6C E2.80.A6 C2.A0 C2.BB

Constat flagrant, la consommation de mémoire est singulièrement réduite par
rapport à l’UTF-16 ! On peut aussi observer la compatibilité ASCII, et les
caractères non-ASCII s’étendant sur plusieurs octets (ici symbolisés par `__`).
Tous les caractères de latin-1 utilisent au plus deux octets, mais le
caractère `…` en prend trois.
