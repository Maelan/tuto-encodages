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

Le problème se pose même si tous les caractères font la même taille dans les
deux encodages, une même valeur pouvant désigner deux caractères différents d’un
encodage à l’autre (le fameux exemple du dollar `$` devenu livre `£`).

# Lire une page web

La plupart du temps, on n’a pas à se soucier de l’encodage pour lire une page
web, car celui-ci est précisé dans le code source. Il arrive toutefois que ce ne
soit pas fait, ou mal fait, et que le navigateur échoue à le deviner. Par
exemple :

![Exemple de page lue avec un mauvais encodage](archive:écran-Firefox-1.png)
Figure: Exemple de page lue avec un mauvais encodage

C’est moche. C’est désagréable à lire. Heureusement, on peut y remédier
manuellement. Tout navigateur qui se respecte permet de jongler entre les
encodages. Pour Firefox par exemple, le menu est caché sous « Affichage » :

![Menu des encodages dans Firefox](archive:écran-Firefox-2-rogné.png)
Figure: Menu des encodages dans Firefox

Pour l’instant, le navigateur est en « détection automatique », ce qui a conduit
à l’utilisation incorrecte d’ISO-8859-1 (latin-1). On peut en changer. Ici, la
page est probablement en UTF-8 (ça ressemble à l’erreur qu’on a vue en
introduction), donc on essaie cet encodage. On choisit l’option correspondante
dans le menu, et…

![Tadaam !](archive:écran-Firefox-3.png)
Figure: Tadaam !

La page s’affiche correctement. C’est du beau boulot.

# Éditer un fichier

On va maintenant voir comment gérer l’encodage de nos fichiers. Tout éditeur de
texte digne de ce nom permet de le faire de façon précise… mais commençons par
le Bloc-Notes de Windows. Ouvrons le Bloc-Notes, tapons un peu de texte avec des
accents, puis enregistrons.

![Boîte de dialogue d’enregistrement du Bloc-Notes](archive:écran-BlocNotes.png)
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

![Le menu des encodages dans Notepad++](archive:écran-Notepad++-1-déco.png)
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
faut pas cliquer sur « Encoder en _xxx_ », car cela n’adapte pas le contenu ;
pour ça, il faut faire « Convertir en _xxx_ ».

Enfin, on a quand même plus de choix que dans le Bloc-Notes !

Après cet aperçu, faites un tour dans la configuration de votre éditeur. Il y a
certainement des options qui nous intéressent.

![Fenêtre de configuration de Notepad++](archive:écran-Notepad++-2-déco.png)
Figure: Fenêtre de configuration de Notepad++

Ici, j’ai encadré la partie intéressante en vert. On peut choisir l’encodage (et
le format des fins de ligne) qui sera utilisé par défaut lors de la création
d’un nouveau fichier.

# Avec ou sans BOM ?

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
