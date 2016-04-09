Maintenant qu’on a vu tout ça, il nous reste à pratiquer un peu !

Lorsqu’on consulte un document, que ce soit un fichier texte (code source par
exemple) ou une page web, il faut la lire avec le bon encodage. Sinon, les
valeurs seront mal interprétées. Par exemple, si on encode ce texte en UTF-8 :

> l'événement du siècle

et qu’on le lit en latin-1, on verra ceci :

> l'Ã©vÃ©nement du siÃ¨cle

Splendide, non ? Vous avez déjà dû croiser ce genre d’erreurs… Pour l’expliquer,
souvenons-nous qu’UTF-8 encode certains caractères, dont les lettres accentuées,
sur deux octets ; ici la lettre `é` donne les octets 0xC3 et 0xA9. Or, latin-1
encode tous ses caractères sur un octet. Les octets 0xC3 et 0xA9 sont donc
interprétés séparément, et donnent les caractères `Ã` et `©`, respectivement.
Notons que tous les autres caractères sont lus correctement, car ils
appartiennent à la base commune ASCII. On voit maintenant l’intérêt de cette
compatibilité : même avec un mauvais encodage, le texte reste globalement
lisible.

Réciproquement, si ce texte était encodé en latin-1 et qu’on tentait de le lire
en UTF-8, on aurait sans doute quelque chose comme :

> l'�v�nement du si�cle

car la séquence d’octets 0xE9.0x67, qui code `év` en latin-1, est invalide en
UTF-8.

Ces deux cas de figure sont faciles à reconnaître, et représentent une grande
partie des problèmes qui surviennent en pratique. Cependant, le diagnostic peut
être plus difficile quand il s’agit de deux encodages dans lesquels tous les
caractères font la même taille (le fameux dollar `$` devenu livre `£`).

Déterminer l’encodage d’un fichier est donc crucial, et compliqué par la
diversité des encodages existants. Or, les renseignements associés à un fichier
(sa date de création par exemple) n’indiquent rien sur son encodage. On doit
donc tenter de le deviner. Les programmes (navigateur web, éditeur de texte…)
emploient des algorithmes qui analysent le contenu du fichier. Ces algorithmes
sont efficaces la plupart du temps, mais [peuvent échouer][bush-hid]. Une
détection incorrecte explique l’affichage bizarre de certains documents.

[bush-hid]: https://en.wikipedia.org/wiki/Bush_hid_the_facts

Un moyen plus simple serait d’inclure cette indication directement dans le
contenu du fichier, au tout début pour diminuer les risques de perturbation. On
utilise pour cela la base de compatibilité ASCII. On verra une application de
cette idée avec les pages HTML.
