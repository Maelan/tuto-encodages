Avec des normes comme ISO 8859 et ISO 2022, le problème d’interropérabilité
était à moitié résolu. On avait certes normalisé les communications entre
langues voisines, mais le système conservait des limites. Comment transmettre un
texte (envoyer de l’arabe à un français p·ex·) si le jeu du destinataire ne
contient pas tous les caractères nécessaires ? Comment écrire un texte avec des
caractères de plusieurs alphabets (arabe et russe p·ex·), s’il n’existe pas de
jeu qui les contienne simultanément ? ISO 2022 constituait une réponse à ces
problèmes, mais on a vu qu’elle était loin d’être idéale.

La solution s’impose d’elle-même : créer un jeu de caractères universel, qui
contienne tous les alphabets ! Cette idée toute simple a donné naissance à deux
monuments : la norme ISO 10646 et Unicode.

![logo d’Unicode](http://zestedesavoir.com/media/galleries/2945/fd636340-71a2-42e3-bf51-5696fd8fd7d4.jpg)
Figure: logo d’Unicode

**Unicode** est une norme développée par le [consortium Unicode][Unicode] depuis
1990 (version 8.0 en juin 2015). Elle repose sur le **jeu universel de
caractères** ou JUC (en anglais, _UCS_ pour _Universal Character Set_), défini
dans la norme parallèle **ISO 10646**.

[Unicode]: http://www.unicode.org

*[JUC]: Jeu Universel de Caractères

# Le jeu universel de caractères

L’objectif de ce répertoire est d’accueillir tous les caractères existants de
toutes les langues du monde, actuelles ou passées. Un travail titanesque !
Concrètement, c’est un bête jeu de caractères, sauf que celui-ci offre pas moins
de 17×2^16^ = 1 114 112 codes. À l’origine, il prévoyait même
2^31^ = 2 147 483 648 codes, mais il a vite été restreint : c’est déjà bien
suffisant.

[[secret]]
| Devant une telle quantité, les polices d’écriture (qui n’ont rien à voir avec
| les encodages, il s’agit ici d’**affichage** des caractères et non de leur
| **codage** en mémoire) peinent à suivre. C’est ce qui explique les petits
| symboles du type ![�](http://zestedesavoir.com/media/galleries/2945/c92d7034-311b-4f24-81b4-95595df2b8c3.png) qu’on peut voir sur
| certaines pages (en regardant bien, vous lirez le code du caractère dans le
| carré). Généralement, les auteurs de polices se contentent de créer les
| glyphes des parties qui les intéressent, et parfois de copier les glyphes de
| référence pour le reste ; si on a vraiment besoin de rédiger une partition
| suivant la [notation musicale grecque ancienne][musique-grecque] avec le JUC,
| on utilisera une police spécialisée…

[musique-grecque]: https://fr.wikipedia.org/wiki/Table_des_caractères_Unicode/U1D200

En juin 2015, environ 11 % des codes sont déjà attribués à des caractères — en
grande partie des idéogrammes asiatiques. Il reste encore de la place à
revendre. Et pourtant, dans ces 11 %, on a tout mis ou presque : les caractères
de tous les anciens jeux, tous les alphabets modernes, pléthore de symboles… Le
JUC n’est peut-être pas la solution définitive et éternelle, mais on peut dormir
sur nos deux oreilles pour les décennies à venir.

Par souci de compatibilité, le JUC reprend latin-1 (et donc l’ASCII) pour ses
256 premiers caractères.

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
notamment pour les codages équivalents, les sens d’écriture, l’ordre
alphabétique et les encodages pour transcrire le JUC.

# Graphèmes _vs_ points de code

J’avais évoqué en introduction la nuance entre graphème et caractère (qu’on
appelle aussi **point de code** pour éviter les ambigüités). Cette distinction
importe en Unicode, à cause d’un mécanisme appelé **composition**.

Pour écrire le graphème `é` (e accent aigu), je peux utiliser le caractère
« précomposé » U+00E9 (hérité de latin-1), mais aussi la séquence U+0065,
U+0301. U+0065 est le caractère de base (`e`, la lettre e) et U+0301 est une
diacritique (` ́`, l’accent aigu) ; les deux se composent pour former un seul
graphème. Ce sont deux codages possibles du *même* graphème, ils doivent donc
être considérés comme équivalents.

[[information]]
| En pratique, la composition est peu utilisée pour les alphabets latins car on
| a hérité des caractères précomposés des jeux précédents ; et, de fait, les
| systèmes de rendu les gèrent assez mal. Testons le navigateur :
| 
|     é (U+00E9)
|     é (U+0065, U+0301)
| 
| Chez moi, Firefox 45 affiche l’accent de la deuxième version trop à droite.
| 
| En revanche, une application intéressante de la composition, et qui montre
| qu’elle n’est pas restreinte aux diacritiques, est le [hangeul][], l’alphabet
| coréen. Comme les alphabets européens, les unités de base sont des lettres,
| mais au lieu d’être écrites une à une, elles sont regroupées par syllabes.
| Chaque syllabe forme un graphème composé de deux à six lettres. Par exemple,
| `한` est la syllabe _han_, composée des trois lettres `ㅎ` (_h_), `ㅏ` (_a_)
| et `ㄴ` (_n_). Unicode inclut les lettres du hangeul (dont 51 sont encore
| d’actualité et de nombreuses autres optionnelles), avec pour chacune une
| [version isolée][hangeul-isolées] et plusieurs [versions
| composables][hangeul-composables] (selon la position dans la syllabe :
| initiale, médiane, finale). Cependant, Unicode inclut également les [syllabes
| précomposées][hangeul-syllabes] (utiles), évidemment beaucoup plus nombreuses
| (11 172).
| 
|     한 (forme précomposée)
|     한 (forme décomposée)
| 
| Le hangeul est un fantasme de lingüistes, je vous laisse en apprendre plus sur
| l’article Wikipédia !

[hangeul]: https://fr.wikipedia.org/Hangeul
[hangeul-isolées]:     https://en.wikipedia.org/wiki/Hangul_Compatibility_Jamo
[hangeul-composables]: https://en.wikipedia.org/wiki/Hangul_Jamo_(Unicode_block)
[hangeul-syllabes]:    https://en.wikipedia.org/wiki/Hangul_Syllables

Ces particularités d’Unicode ont plusieurs conséquences :

1.  Le mécanisme de composition implique que, même si les points de code sont
    encodés avec une taille fixe — ce qui n’est pas le cas, comme on verra —,
    les graphèmes ont, eux, une taille variable !
1.  L’existence de caractères précomposés implique que le codage des graphèmes
    n’est pas unique. Unicode définit les équivalences entre codages, ainsi que
    des algorithmes pour calculer une forme normale.

Une application soigneuse doit prendre en compte tout ceci. Toutefois, je ne
développerai pas plus sur ce sujet, cet article se focalisant surtout sur les
encodages.

# Un jeu, des encodages

Comme je l’ai dit, Unicode définit plusieurs encodages du JUC.

[[question]]
| Des encodages ? Mais, je croyais qu’Unicode *était* un encodage ?

Unicode est essentiellement un **jeu de caractères** (un ensemble de caractères
auxquels on attribue à chacun un point de code unique) et non un **encodage**
(façon de représenter ce point de code en mémoire). C’est ici que la distinction
prend tout son sens. Auparavant, les deux se confondaient puisque tous les jeux
de caractères étaient associés à un encodage simple : vu que leurs codes
tenaient sur un ou deux octets, on se contentait de les écrire tels quels en
mémoire.

Or, les points de codes d’Unicode nécessitent beaucoup plus qu’un octet : il
leur en faudrait quatre[^petits-malins] ! Cela voudrait dire que si l’on
continuait à faire comme avant, on utiliserait quatre fois plus de mémoire
qu’avec nos pages de code sur un octet, comme latin-1.

[^petits-malins]: Des petits malins me diront que trois octets suffiraient, mais
  en informatique on préfère les puissances de 2.

Ça ferait beaucoup de mémoire utilisée, voire gaspillée, puisqu’il y aurait
plein d’octets nuls :

+--------------------------+-------------------------------------+------------------------------------------+
|Codes                     |Encodage en UTF-32                   |Caractères disponibles dans cet intervalle|
+==========================+=====================================+==========================================+
|jusqu’à U+00FF (2^8^-1)   |`00000000 00000000 00000000 bbbbbbbb`|langues occidentales (latin-1)            |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+FFFF (2^16^-1)  |`00000000 00000000 bbbbbbbb bbbbbbbb`|la quasi-totalité des alphabets actuels   |
|                          |                                     |([BMP][])                                 |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+10FFFF (2^21^-1)|`00000000 000bbbbb bbbbbbbb bbbbbbbb`|tous les caractères                       |
+--------------------------+-------------------------------------+------------------------------------------+
Table:
  Consommation mémoire en UTF-32
  (les codes sont en binaire, les `b` symbolisent les bits occupés)

Comme on le voit, il y aurait toujours au moins un octet nul, très souvent deux.
Le cas extrême est celui d’un Occidental qui gaspille trois octets par
caractère.

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

+--------------------------+-------------------------------------+------------------------------------------+
|Codes                     |Encodage en UTF-16                   |Caractères disponibles dans cet intervalle|
+==========================+=====================================+==========================================+
|jusqu’à U+FFFF (2^16^-1)  |`bbbbbbbb bbbbbbbb`                  |la quasi-totalité des alphabets actuels   |
|                          |                                     |([BMP][])                                 |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+10FFFF (2^21^-1)|`bbbbbbbb bbbbbbbb bbbbbbbb bbbbbbbb`|tous les caractères                       |
+--------------------------+-------------------------------------+------------------------------------------+
Table:
  Consommation mémoire en UTF-16
  (les codes sont en binaire, les `b` symbolisent les bits occupés)

Les caractères de cet encodage ne font donc pas tous la même taille, ce qui
complique un peu les traitements : si on stocke une chaîne UTF-16 dans un
tableau de codes de deux octets, le _n_^e^ caractère ne se trouve pas forcément
dans la _n_^e^ case. Ceci dit, étant donné que l’ensemble des points de codes
inférieurs à 2^16^ (le « [BMP][] », pour _Basic Multilingual Plane_) contient
déjà tous les alphabets actuels et symboles courants, il peut être suffisant de
s’y restreindre (ce que fait Windows), et dans ce cas tous les caractères font
bien deux octets.

*[BMP]: Basic Multilingual Plane

[BMP]: https://en.wikipedia.org/wiki/Plane_(Unicode)#Basic_Multilingual_Plane

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
    codage UTF-16 :  FE.FF 00.AB 00.A0 00.C0 00.20 00.76 00.61 00.69 00.6E 00.63 00.72 00.65 00.20 00.73 00.41 00.6E 00.73 00.41 00.70 00.E9 00.72 00.69 00.6C 20.26 00.A0 00.BB

Ici, la BOM indique que le texte est gros-boutiste (l’octet de poids fort est en
premier). En petit-boutiste, on aurait ça :

    :::text
    texte :          [BOM] «____ ▒____ À____       v____ a____ i____ n____ c____ r____ e____       s____ a____ n____ s____       p____ é____ r____ i____ l____ …____ ▒____ »____
    codage UTF-16 :  FF.FE AB.00 A0.00 C0.00 20.00 76.00 61.00 69.00 6E.00 63.00 72.00 65.00 20.00 73.00 41.00 6E.00 73.00 41.00 70.00 E9.00 72.00 69.00 6C.00 26.20 A0.00 BB.00

Si la chaîne contient une BOM, il suffit donc de lire ses deux premiers octets
pour connaître son boutisme.

Remarquons que ce texte s’encode en UTF-16 exactement comme en latin-1, avec des
valeurs sur deux octets au lieu d’un (donc un octet nul sur deux). Ici, on
occupe donc deux fois plus de mémoire.

# UTF-8

On a aussi inventé l’**UTF-8**. La taille des caractères codés est encore plus
variable, et l’économie de mémoire plus grande. Comme son nom l’indique, l’unité
de base est l’octet. Il code les premiers caractères (ceux de l’ASCII) sur un
octet, les suivants sur deux, trois et jusqu’à quatre octets.

+--------------------------+-------------------------------------+------------------------------------------+
|Codes                     |Encodage en UTF-8                    |Caractères disponibles dans cet intervalle|
+==========================+=====================================+==========================================+
|jusqu’à U+007F (2^7^-1)   |`0bbbbbbb`                           |latin de base (ASCII)                     |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+07FF (2^11^-1)  |`110bbbbb 10bbbbbb`                  |alphabets d’Europe et du Moyen-Orient     |
|                          |                                     |[^alphabets-2octets]                      |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+FFFF (2^16^-1)  |`1110bbbb 10bbbbbb 10bbbbbb`         |la quasi-totalité des alphabets actuels   |
|                          |                                     |([BMP][])                                 |
+--------------------------+-------------------------------------+------------------------------------------+
|jusqu’à U+10FFFF (2^21^-1)|`11110bbb 10bbbbbb 10bbbbbb 10bbbbbb`|tous les caractères                       |
+--------------------------+-------------------------------------+------------------------------------------+
Table:
  Consommation mémoire en UTF-8
  (les codes sont en binaire, les `b` symbolisent les bits occupés)

[^alphabets-2octets]:
  alphabets[^fun-fact-phénicien] latin, API, grec, copte, cyrillique, arménien,
  hébreu, syriaque, arabe, thâna (utilisé aux Maldives), n’ko (utilisé en
  Afrique de l’Ouest) ; la carte se trouve [ici][carte-alphabets-2octets].

[^fun-fact-phénicien]:
  Le saviez‐vous ? à l’exception peut-être du n’ko (création récente vaguement
  inspirée de l’arabe), tous ces alphabets[^systèmes-écriture] sont les
  descendants encore en vie de l’alphabet phénicien, voire de son évolution en
  alphabet araméen. :-)

[^systèmes-écriture]:
  En fait, il faudrait dire « systèmes d’écriture » (l’arabe au moins n’étant
  pas un « alphabet »). Vous me pardonnez ?

[carte-alphabets-2octets]: https://fr.wikipedia.org/wiki/Table_des_caractères_Unicode_(0000-FFFF)#Alphabets,_abjads,_abugidas_et_syllabaires_modernes

*[API]: Alphabet Phonétique International

On voit que l’UTF-8 est particulièrement intéressant pour les langues à alphabet
latin[^importance-latin], qui bénéficient en plus de la compatibilité ASCII.
Pour les alphabets grec, arabe ou cyrillique, UTF-8 ou UTF-16, c’est kif-kif ;
on peut préférer UTF-16 pour sa plus grande constance, et l’économie qu’on
réalise quand même sur quelques caractères moins fréquents. Pour tous les autres
alphabets (dont les langues asiatiques), l’UTF-16 est préférable.

[^importance-latin]:
  qui, [d’après Wikipédia](https://fr.wikipedia.org/wiki/Alphabet_latin),
  représenteraient tout de même 39 % de la population mondiale et 84 % des
  connexions à Internet

En plus d’être compatible avec l’ASCII, l’encodage UTF-8 a été conçu afin que
certains algorithmes de traitement (comparaison lexicographique par exemple)
soient réutilisables sans modification. Ainsi, de vieux programmes
fonctionneront encore si on leur passe du texte en UTF-8 : magique !

Enfin, contrairement à l’UTF-16, on n’a pas de problème de boutisme puisqu’on
lit les données octet par octet.

UTF-8 a de nombreux avantages (économie de mémoire, compatibilité, boutisme,
résistance aux erreurs). Un défaut aussi : la grande variabilité de taille des
caractères rend les traitements plus compliqués et nuit à leurs performances.
Ses points forts ont cependant suffi à lui assurer le succès : il est l’encodage
le plus répandu aujourd’hui. Il est utilisé pour les documents et les
communications, et les systèmes d’exploitation (Mac et Linux) s’y mettent aussi.

Pour ne pas changer, voici notre texte d’exemple encodé en UTF-8 :

    :::text
    texte :         «____ ▒____ À____    v  a  i  n  c  r  e     s  a  n  s     p  é____ r  i  l  …_______ ▒____ »____
    codage UTF-8 :  C2.AB C2.A0 C3.80 20 76 61 69 6E 63 72 65 20 73 41 6E 73 41 70 C3.A9 72 69 6C E2.80.A6 C2.A0 C2.BB

Constat flagrant, la consommation de mémoire est singulièrement réduite par
rapport à l’UTF-16 ! On peut aussi observer la compatibilité ASCII, et les
caractères non-ASCII s’étendant sur plusieurs octets (ici symbolisés par `__`).
Tous les caractères de latin-1 utilisent au plus deux octets, mais le caractère
`…` en prend trois.
