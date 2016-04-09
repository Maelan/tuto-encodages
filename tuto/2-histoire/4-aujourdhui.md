Notre périple au fil des âges nous a ramené au temps présent. On a vu les
encodages historiques, mais lesquels sont utilisés aujourd’hui, et dans quels
contextes ?

Avant l’apparition d’Unicode, les systèmes d’exploitation fonctionnaient avec un
système de pages de code régionales, c’est-à-dire qu’on utilisait des variantes
d’encodage sur huit bits en fonction du pays. Depuis, ils ont migré vers Unicode
en interne (y compris Windows, depuis XP, même si ça ne se répercute par
forcément pour l’utilisateur).

-   Sous Windows, **UTF-16** (_little endian_) est maintenant utilisé en interne
    et UTF-8 est également supporté, mais Unicode cohabite encore avec les pages
    de code. Ces dernières, incorrectement appelées « ANSI » et proches des
    ISO 8859, sont encore fréquemment utilisées. Je vous rappelle que celle pour
    nous autres Occidentaux est **Windows-1252** et dérive de latin-1. Celles-ci
    ont remplacé les anciennes pages de code dites « OEM » (CP437 et CP850 pour
    l’Occident), dont l’usage perdure pourtant pour la console.
-   Sous Mac OS, l’encodage en vigueur en Occident était nommé [MacRoman][],
    mais depuis Mac OS X on utilise **UTF-8**.
-   Les distributions GNU/Linux utilisaient latin-1 par défaut, mais elles ont
    maintenant (presque ?) toutes migré à **UTF-8**.

[MacRoman]: https://fr.wikipedia.org/wiki/MacRoman

[[information]]
| __Changer la page de code sous Windows__
| 
| Sous Windows, on peut changer la page de code en vigueur depuis le Panneau de
| Configuration, « Options régionales et linguistiques », onglet « Avancé ». En
| fait, c’est la [_locale_][locale] du système qu’on règle ainsi, ce pourquoi
| c’est présenté comme le choix de la langue par défaut des programmes.
| 
| Il est également possible de changer temporairement la page de code d’une
| console Windows grâce à la commande « CHCP » ; elle prend en argument le nº de
| la page de code à utiliser (`CHCP 1252` pour Windows-1252) ; sans argument,
| elle affiche l’encodage actuel de la console (probablement 437 ou 850).

[locale]: https://fr.wikipedia.org/wiki/Paramètres_régionaux

*[CHCP]: CHange CodePage

[[information]]
| __Changer la _locale_ sous Linux__
| 
| Sous un système unixoïde, c’est la [_locale_][locale-linux] qui détermine
| l’encodage en vigueur. On peut donc le changer à la volée _via_ des variables
| d’environnement, à condition que la _locale_ désirée soit installée. La vôtre
| est probablement `fr_FR.UTF-8` (votre ordinateur vous parle en français de
| France avec l’encodage UTF-8).
|
| Le système de _locales_ sert aussi (surtout !) à adapter les programmes aux
| conventions propres à chaque langue et région :
|
|     :::console
|     $  date
|     Sun Aug 26 13:37:42 CET 2012
|     $  LC_ALL=fr_FR.UTF-8  date
|     dimanche 26 août 2012, 13:37:42 (UTC+0100)

[locale-linux]: https://wiki.archlinux.org/index.php/Locale

Il est bien sûr possible, avec les bons outils, d’encoder un fichier de
n’importe quelle façon, sous n’importe quel système d’exploitation. L’encodage
d’un OS est simplement celui qu’il utilise en interne, et donc aussi celui que
les programmes auront tendance à utiliser (ce qui détermine l’encodage des
documents d’un utilisateur λ).

De plus, UTF-8 est maintenant l’encodage le plus utilisé sur la Toile, ce qui
semble logique puisqu’il s’agit d’un réseau international mettant en contact
toutes les langues. L’autre principal encodage sur Internet reste latin-1.

L’ASCII seul n’est plus employé, mais tous les encodages répandus conservent la
base ASCII par compatibilité. Les trois principaux, cités ci-dessus, se basent
même tous sur latin-1 (même si l’UTF-8 n’est pas compatible avec ce dernier
puisque les codes supérieurs à 127 sont encodés par deux octets).

[[information]]
| Si Unicode tend à remplacer progressivement tout le reste, il reste un endroit
| où survivent des encodages plus exotiques : l’informatique embarquée dans les
| petits appareils (lave-linges, calculettes, affichage des arrêts dans un
| bus…). En effet, ceux-ci n’ont parfois besoin que d’un jeu très restreint, et
| n’échangent pas de données avec un réseau.
|
| Dans le même ordre d’idées, il existe une application qu’on utilise tous les
| jours et qui n’utilise pas Unicode : les SMS ! Ils emploient un encodage nommé
| [GSM 03.38][GSM], un ensemble de pages de code sur sept bits vaguement
| compatibles avec l’ASCII. Toutefois, on peut utiliser UTF-16 à la place, ce
| que fait évidemment le trio Chine-Japon-Corée. Les téléphones actuels
| utilisent GSM 03.38 par défaut et basculent automatiquement en UTF-16 si
| jamais on écrit un caractère non supporté autrement. Un SMS étant limité à 140
| octets, GSM 03.38 permet jusqu’à 160 caractères, alors qu’UTF-8 n’en permet
| que 70. On a beau s’entendre répéter que de nos jours la mémoire ne coûte rien
| et qu’on peut se permettre l’UTF-16, voilà un cas où l’on préférerait
| nettement faire des économies !

[GSM]: https://en.wikipedia.org/wiki/GSM_03.38
