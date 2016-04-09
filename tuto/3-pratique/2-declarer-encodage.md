Comme évoqué en introduction, plutôt que de se reposer sur une détection
automatique, certains types de documents permettent — voire requièrent — de
préciser leur encodage directement dans le texte du fichier. On va voir
l’exemple des pages HTML et des documents LaTeX.

# HTTP, HTML & XML

[[information]]
| Au passage, notons [ce tutoriel][tuto-migration] pour migrer son site web de
| latin-1 vers UTF-8.

[tuto-migration]: https://openclassrooms.com/courses/passer-du-latin1-a-l-unicode

Pour le web, les serveurs HTTP peuvent indiquer l’encodage avec un champ
d’en-tête :

    :::text
    Content-Type: text/html; charset=‹ENCODAGE›

D’ailleurs, cet en-tête fournit aussi le type MIME du document (page HTML,
fichier CSS, image PNG…).

Toutefois, cette technique nécessite un serveur (ce qu’on n’a pas pour consulter
un fichier local) et empêche de fournir avec le même serveur des fichiers avec
des encodages différents (cas d’un serveur mutualisé).

À la place, pour les pages HTML, on peut renseigner l’encodage… directement dans
le fichier HTML. Ça semble bizarre puisqu’en théorie, on ne peut pas encore lire
le fichier. Mais le socle ASCII vient à notre secours : quel que soit
l’encodage, si on n’utilise que les caractères de l’ASCII, on pourra lire sans
problème. On utilise une balise `<meta http-equiv />` (dans `<head/>`) qui est
l’équivalent de l’en-tête HTTP.

    :::html
    <meta http-equiv="Content-Type" content="text/html; charset=‹ENCODAGE›" />

En HTML5, cette balise a été simplifiée en :

    :::html
    <meta charset="‹ENCODAGE›"/>

Elle doit se trouver au tout début de `<head/>` afin de ne pas perturber la
détection, et parce que le navigateur relit le fichier depuis le début dès qu’il
l’a rencontrée. Seul le strict nécessaire doit précéder cette balise, avec
uniquement des caractères ASCII (donc pas de BOM en UTF-8 !).

[[erreur]]
| Mauvais (il y a des caractères non-ASCII dans le commentaire) :
| 
|     :::html
|     <html>
|         <head>
|             <!-- ligne nécessaire pour spécifier l’encodage : -->
|             <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
|     …

[[information]]
| Bon :
| 
|     :::html
|     <html>
|         <head>
|             <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
|     …

On peut trouver [ici][liste-encodages] les noms d’encodage autorisés
(insensibles à la casse). Les plus intéressants pour nous sont `ISO-8859-1`
(alias `latin-1`) et `UTF-8`. Facile !

[liste-encodages]: http://www.iana.org/assignments/character-sets

Dans les langages XML en général (dont HTML), on peut également renseigner
l’encodage dans le prologue XML, une sorte de balise spéciale optionnelle qui
doit être placée sur la toute première ligne du fichier.

    :::xml
    <?xml version="1.0" encoding="‹ENCODAGE›" ?>

[[information]]
| À propos, XML (donc HTML) permet d’insérer un caractère Unicode arbitraire,
| même s’il n’existe pas dans l’encodage du code source : pour insérer le point
| de code U+CODE, la syntaxe est `&#xCODE;` (`&…;` est la syntaxe des entités
| XML, `#` signifie « nombre » et `x` signifie « hexadécimal »).
|
| Un mécanisme similaire existe dans de nombreux langages, par exemples `\CODE`
| en CSS ou `\uCODE` en C.

# LaTeX

L’encodage est très important avec LaTeX. Comme en HTML, il faut déclarer avec
quel encodage est enregistré le fichier en le précisant en paramètre du paquet
`inputenc` :

    :::latex
    \usepackage[‹ENCODAGE›]{inputenc}

(`latin1` ou `utf8` pour les plus courants). Les fichiers éventuellement inclus
avec la commande `\input` doivent être enregistrés avec le même encodage, mais
il n’y a pas besoin de le déclarer à nouveau.
