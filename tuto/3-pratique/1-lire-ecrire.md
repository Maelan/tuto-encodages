Commençons par apprendre à régler manuellement l’encodage si jamais la détection
automatique échoue.

# Lire une page web

La plupart du temps, lire une page web ne pose aucun souci car son encodage est
précisé dans son code source. Il arrive toutefois que ce ne soit pas fait, ou
mal fait, et que le navigateur échoue à le deviner. Par exemple :

![Exemple de page lue avec un mauvais encodage](http://zestedesavoir.com/media/galleries/2945/1adbca06-54f4-4077-897b-bc16ba78cb92.png)
Figure: Exemple de page lue avec un mauvais encodage

C’est moche. C’est désagréable à lire. Heureusement, on peut y remédier
manuellement. Tout navigateur qui se respecte permet de jongler entre les
encodages. Pour Firefox, le menu est caché sous « Affichage » :

![Menu des encodages dans Firefox](http://zestedesavoir.com/media/galleries/2945/e3fb4b6c-ae65-4c30-9586-b3dcafd6905c.png)
Figure: Menu des encodages dans Firefox

Pour l’instant, le navigateur est en « détection automatique », ce qui a conduit
à l’utilisation incorrecte d’ISO-8859-1 (latin-1). On peut en changer. Ici, la
page est probablement en UTF-8 (ça ressemble à l’erreur vue en introduction),
donc on essaie cet encodage. On choisit l’option correspondante dans le menu,
et…

![Tadaam !](http://zestedesavoir.com/media/galleries/2945/697a1a1c-ed7c-4889-839f-1fc88ab5c24e.png)
Figure: Tadaam !

La page s’affiche correctement. C’est du beau boulot.

# Éditer un fichier

On va maintenant voir comment gérer l’encodage de nos fichiers. Tout éditeur de
texte digne de ce nom permet de le faire de façon précise… mais commençons par
le Bloc-Notes de Windows. Ouvrons le Bloc-Notes, tapons un peu de texte avec des
accents, puis enregistrons.

![Boîte de dialogue d’enregistrement du Bloc-Notes](http://zestedesavoir.com/media/galleries/2945/eff7b79e-04b8-4301-95b1-d720ba4992b2.png)
Figure: Boîte de dialogue d’enregistrement du Bloc-Notes

Le Bloc-Notes permet au premier enregistrement de choisir l’encodage du fichier.
Le choix est assez limité cependant : « ANSI » (Windows-1252), « Unicode »
(UTF-16LE), « Unicode _big endian_ » (UTF-16BE), ou UTF-8. Comme exercice, vous
pouvez vous amuser à vérifier que les tailles des fichiers affichées sur ma
capture sont correctes, sachant que mon texte comporte quinze caractères et que
le Bloc-Notes ajoute automatiquement une BOM pour tous les encodages Unicode
(qui fait deux octets en UTF-16 et trois octets en UTF-8).

Le Bloc-Notes est vraiment très limité. Ainsi on ne peut pas choisir le latin-9
par exemple. De plus, rien n’indique l’encodage du fichier sur lequel on
travaille, et on ne peut pas en changer après coup.

Si vous programmez, vous utilisez certainement un éditeur plus avancé. Comme les
navigateurs web, la plupart incluent un menu pour passer d’un encodage à un
autre. Toujours sous Windows, voici l’exemple de [Notepad++][] (ici j’ai rouvert
les fichiers que je viens de créer avec le Bloc-Notes) :

[Notepad++]: http://notepad-plus-plus.org/fr/

![Le menu des encodages dans Notepad++](http://zestedesavoir.com/media/galleries/2945/66a2482b-725b-4057-9a31-13c52d68ea4b.png)
Figure: Le menu des encodages dans Notepad++

Première remarque, Notepad++ détecte automatiquement l’encodage et l’indique
dans la barre de statut (en bas, encadré en bleu). C’est déjà mieux. En passant,
remarquons la mention « Dos\Windows ». Elle indique le style utilisé pour les
fins de ligne. On avait vu qu’il existait plusieurs conventions, selon les OS.
Ici, notre fichier utilise le style Windows, c’est-à-dire ||_CR_||||_LF_||.

Ensuite, le menu « Encodage » permet de changer en direct l’encodage utilisé.
Comme dans les navigateurs web, les options « Encoder en _xxx_ » changent
l’interprétation des octets existants ; en plus, elles déterminent le codage des
caractères nouvellement insérés. Pour modifier l’encodage d’un fichier, il ne
faut pas cliquer sur « Encoder en _xxx_ », car cela n’adapte pas le contenu
existant ; pour ça, il faut faire « Convertir en _xxx_ ».

Enfin, on a quand même plus de choix que dans le Bloc-Notes !

Après cet aperçu, faites un tour dans la configuration de votre éditeur. Il y a
certainement des options qui nous intéressent.

![Fenêtre de configuration de Notepad++](http://zestedesavoir.com/media/galleries/2945/1de37a7c-51fe-4650-903d-adeb051c348b.png)
Figure: Fenêtre de configuration de Notepad++

Ici, j’ai encadré la partie intéressante en vert. On peut choisir l’encodage (et
le format des fins de ligne) qui sera utilisé par défaut lors de la création
d’un nouveau fichier.

## Avec ou sans BOM ?

Remarquons qu’il y a deux encodages UTF-8. L’une porte la mention « (sans
BOM) », ce qui signifie que l’autre est un « UTF-8 avec BOM ». On a déjà parlé
de la BOM, ce caractère Unicode spécial placé tout au début d’un fichier pour en
indiquer le boutisme. Cette technique est utilisée pour l’UTF-16 et l’UTF-32. En
revanche, elle est inutile en UTF-8 puisqu’on n’a pas de problème de boutisme.
Pire, elle peut rendre des fichiers invalides pour certains programmes. C’est
par exemple le cas des pages web, comme on verra plus tard. Pourtant, certains
éditeurs dont le fameux Bloc-Notes la rajoutent automatiquement même en UTF-8,
car ça les aide à détecter l’encodage du fichier. C’est une pratique
déconseillée. Dans votre éditeur favori, choisissez toujours la version sans BOM
si vous avez le choix.

Ici, nettoyons notre fichier de cette hérésie avec Notepad++. Pour ça, on fait
simplement « Convertir en UTF-8 (sans BOM) » et on enregistre. Dans les
paramètres, on choisit aussi l’UTF-8 sans BOM par défaut.

# Convertir un fichier

[man1-iconv]: http://man7.org/linux/man-pages/man1/iconv.1.html
[man3-iconv]: http://man7.org/linux/man-pages/man3/iconv.3.html

On peut aussi convertir un fichier sans passer par un éditeur. C’est par exemple
la fonction d’[`iconv`][man1-iconv], programme en ligne de commande disponible
sur les unixoïdes (il a donné son nom à [l’API standard][man3-iconv], intégrée à
la _glibc_, qui fait la même chose). Il s’utilise comme ça :

    :::console
    $  iconv [-f DEPUIS] [-t VERS]

les formats `DEPUIS` et `VERS` pouvant être omis pour utiliser la _locale_
actuelle. Par exemple :

<--COMMENT
    :::console
    $  echo "déjà"  | iconv -t latin1  | hexdump -C
    00000000  64 e9 6a e0 0a                                    |d.j..|
COMMENT-->

    :::console
    $  echo "déjà"  | iconv -t utf16  | hexdump -C
    00000000  ff fe 64 00 e9 00 6a 00  e0 00 0a 00              |..d...j.....|

On observe la BOM (U+FEFF) qui nous dit que l’encodage est petit-boutiste, et
les octets nuls insérés _après_ chaque octet de latin-1.

[[attention]]
| Attention, pour modifier un fichier en place, il ne faut surtout pas faire :
|
|     :::console
|     $  commande  < fichier > fichier
|
| car cela effacerait le contenu du fichier… Il faut passer par un fichier
| temporaire. De toute façon, il est plus prudent de vérifier le résultat
| avant d’écraser le fichier.

Il existe aussi le programme [`recode`][man1-recode], qui s’utilise de façon
similaire :

    :::console
    $  recode [DEPUIS][..VERS]

[man1-recode]: http://linux.die.net/man/1/recode

Sa spécificité est qu’il ne gère pas seulement les encodages textuels (le sujet
de cet article), mais plus généralement divers types de codages (ce que le
logiciel nomme « surfaces »), qui peuvent se superposer. Cela inclut les formats
de fin de ligne (LF, CR ou CRLF) et les « encodages de transfert » ([Base64][],
[Quoted-Printable][]…) utilisés notamment par les courriels.

[quoted-printable]: https://fr.wikipedia.org/wiki/Quoted-Printable
[Base64]:           https://fr.wikipedia.org/wiki/Base64

Par exemple, pour convertir le texte en UTF-16, coder les octets obtenus avec
Quoted-Printable, puis appliquer le format de fin de ligne CR-LF au tout :

<--COMMENT
    :::console
    $  echo "déjà"  | recode ..latin1/QP/CRLF  | hexdump -C 00000000
    64 3d 45 39 6a 3d 45 30  0d 0a                    |d=E9j=E0..|
COMMENT-->

    :::console
    $  echo "déjà"  | recode ..utf16/QP/CRLF  | hexdump -C
    00000000  3d 46 45 3d 46 46 3d 30  30 64 3d 30 30 3d 45 39  |=FE=FF=00d=00=E9|
    00000010  3d 30 30 6a 3d 30 30 3d  45 30 3d 30 30 0d 0a     |=00j=00=E0=00..|

Observons que chaque octet qui ne correspond pas à un caractère affichable de
l’ASCII est codé par `=XX` (Quoted-Printable), et que la fin de ligne est codée
par la séquence 0x0D, 0x0A (CR-LF).

`recode` a aussi une fonction très pratique pour examiner du texte !

    :::console
    $  echo "déjà, 한"  | recode ..dump
    UCS2   Mné   Description

    0064   d     lettre minuscule latine d
    00E9   e'    lettre minuscule latine e accent aigu
    006A   j     lettre minuscule latine j
    00E0   a!    lettre minuscule latine a accent grave
    002C   ,     virgule
    0020   SP    espace
    1112         hangûl tch'ôsong hiûh
    1161         hangûl djoungsong a
    11AB         hangûl djôngsong niûn
    000A   LF    interligne (lf)

# Corriger un encodage mixte

Il arrive qu’un fichier mélange plusieurs encodages, comme l’UTF-8 et le latin-1.
Ce peut être le cas d’un fichier texte récupéré sur Internet, ou de la base de
données d’un site web. Démonstration :

    :::console
    $  cat test
    ligne encodée en UTF-8
    ligne encodée en latin-1

Normalement, ma console qui est en UTF-8 devrait plutôt afficher :

    :::console
    $  cat test
    ligne encodée en UTF-8
    ligne encod�e en latin-1

mais elle utilise un mode spécial pour afficher quand même les caractères
encodés en latin-1 : lorsqu’une séquence d’octets n’est pas de l’UTF-8 valide,
elle est relue comme du latin-1. Cette astuce est utilisée par de nombreux
logiciels, dont la plupart des clients IRC[^IRC]. On peut la considérer comme
pratique, ou commme nuisible parce qu’elle masque les erreurs.

[^IRC]:
  En effet, IRC n’offre aucun moyen de préciser l’encodage des messages, alors
  qu’en pratique il met en contact des gens qui en utilisent de toutes les
  sortes…

Bref. On peut vérifier que le fichier mélange effectivement les deux encodages :

    :::console
    $  cat test  | hexdump -C
    00000000  6c 69 67 6e 65 20 65 6e  63 6f 64 c3 a9 65 20 65  |ligne encod..e e|
    00000010  6e 20 55 54 46 2d 38 0a  6c 69 67 6e 65 20 65 6e  |n UTF-8.ligne en|
    00000020  63 6f 64 e9 65 20 65 6e  20 6c 61 74 69 6e 2d 31  |cod.e en latin-1|
    00000030  0a                                                |.|

C’est bien une erreur, qui fait planter des programmes plus stricts :

    :::console
    $  cat test  | iconv -f utf8
    ligne encodée en UTF-8
    ligne encod
    iconv: séquence d'échappement non permise à la position 35
    $  cat test  | recode utf8..
    ligne encodée en UTF-8
    ligne encod
    recode: Entrée invalide dans « UTF-8..CHAR »

`iconv` peut ignorer les erreurs, mais ce n’est pas idéal :

    :::console
    $  cat test  | iconv -f utf8 -t //IGNORE
    ligne encodée en UTF-8
    ligne encode en latin-1

Il faut corriger un tel fichier. Il ne semble pas y avoir de programme répandu
pour ça, mais ce n’est pas difficile à coder. Vous pouvez par exemple jeter un
œil à [ce script][script-perl] en Perl ou à [celui-ci][script-ocaml] en OCaml.

[script-perl]:  https://gist.github.com/chansen/1522213
[script-ocaml]: https://gist.github.com/Maelan/e3f25ec0a6832ba1e0eb9584c3c58eff

    :::console
    $  cat test  | fix-mixed-utf8  | hexdump -C
    00000000  6c 69 67 6e 65 20 65 6e  63 6f 64 c3 a9 65 20 65  |ligne encod..e e|
    00000010  6e 20 55 54 46 2d 38 0a  6c 69 67 6e 65 20 65 6e  |n UTF-8.ligne en|
    00000020  63 6f 64 c3 a9 65 20 65  6e 20 6c 61 74 69 6e 2d  |cod..e en latin-|
    00000030  31 0a                                             |1.|

Ou alors, ce script interactif (suggéré par [Taurre][]) qui demande l’encodage
d’origine de chaque ligne et convertit tout en UTF-8 :

    :::sh
    #!/bin/sh
    last=utf8
    while read line ; do
    	echo "$line" | od -c -w256 >&2
    	read -p "Quel encodage ? [$last] " code </dev/tty >&2
    	last="${code:-$last}"
    	echo "$line" | iconv -f "$last" -t utf8
    done

Exemple d’utilisation :

    :::console
    $  ./convert-mixed.sh < test > test-corrigé
    0000000   l   i   g   n   e       e   n   c   o   d 303 251   e       e   n       U   T   F   -   8  \n
    0000030
    Quel encodage ? [utf8] 
    0000000   l   i   g   n   e       e   n   c   o   d 351   e       e   n       l   a   t   i   n   -   1  \n
    0000031
    Quel encodage ? [utf8] latin1

[Taurre]: https://zestedesavoir.com/membres/voir/Taurre
