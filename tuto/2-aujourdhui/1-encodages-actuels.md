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
| Configuration, « Options régionales et linguistiques », onglet « Avancé ».
| C’est présenté comme un choix de la langue par défaut des programmes, mais
| c’est bien les pages de code qui se cachent derrière.
| 
| Il est également possible de changer temporairement la page de code d’une
| console Windows grâce à la commande « CHCP » ; elle prend en argument le nº de
| la page de code à utiliser (`CHCP 1252` pour Windows-1252) ; sans argument,
| elle affiche l’encodage actuel de la console (probablement 437 ou 850).

*[CHCP]: CHange CodePage

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
puisqu’un codet de huit bits sera encodé sur deux octets).

Il va de soi que je vous recommande d’utiliser l’UTF-8 exclusivement, partout.
