J’espère que cet article aura aidé certains à comprendre ce qui se passe, et à
ne plus avoir peur des « caractères spéciaux »…

Il n’y a rien de sorcier et tout programmeur (voire tout informaticien) devrait
connaître ça pour ne pas faire n’importe quoi.

# Liens

Quelques autres documents sur le sujet :

-   [« Ce que tout programmeur doit savoir »][joel-fr] (et [sa version
    anglaise][joel-en]) : un article de *Joel on Software* destiné à
    sensibiliser les programmeurs
-   [« Introduction aux jeux de caractères »][openweb] : un cours de Steve
    Frécinaux sur le site Openweb
-   [`charsets(7)`][man-charsets] : une page du manuel de Linux qui décrit les
    encodages couramment utilisés avant leur remplacement progressif par Unicode

Ensuite, Wikipédia est très bien fournie sur le thème (ne pas hésiter à lire les
articles anglais qui sont souvent plus complets). On peut par exemple consulter
[cet article général][wiki-codage], [celui-ci][UTF-8] pour apprendre comment
fonctionne UTF-8, ou [ce comparatif des encodages Unicode][wiki-comparatif] (en
anglais). Pour connaître le code d’un caractère dans un encodage particulier,
elle fournit toutes les tables utiles de façon claire, par exemple : [ASCII][],
[CP850][], [latin-1][], et même le [JUC][] qui y est plutôt bien organisé.

On peut aussi trouver les tables du JUC [ici][Unicode-JUC-fr], avec des glyphes
informatifs et les noms officiels des caractères en français (car la norme
ISO 10646 est publiée conjointement en anglais et en français). Toutefois,
cette page n’a plus été mise à jour depuis 2007 (Unicode version 5.0) ; la
dernière version peut être trouvée en anglais [là][Unicode-JUC-en] (mais les
ajouts sont peu susceptibles de vous intéresser).

Enfin, [un outil pratique pour calculer l’UTF-8][outil-utf8].

[joel-fr]: http://french.joelonsoftware.com/Articles/Unicode.html
[joel-en]: http://joelonsoftware.com/Articles/Unicode.html
[openweb]: http://openweb.eu.org/articles/jeux_caracteres
[man-charsets]: http://man7.org/linux/man-pages/man7/charsets.7.html

[wiki-codage]:     https://fr.wikipedia.org/wiki/Codage_des_caractères
[wiki-comparatif]: https://en.wikipedia.org/wiki/Comparison_of_Unicode_encodings

[ASCII]:   https://fr.wikipedia.org/wiki/ASCII
[CP850]:   https://fr.wikipedia.org/wiki/CP850
[latin-1]: https://fr.wikipedia.org/wiki/latin-1
[UTF-8]:   https://fr.wikipedia.org/wiki/UTF-8
[JUC]:     https://fr.wikipedia.org/wiki/Table_des_caractères_Unicode

[Unicode-JUC-fr]: http://www.unicode.org/fr/charts/
[Unicode-JUC-en]: http://www.unicode.org/charts/

[outil-utf8]: http://www.ltg.ed.ac.uk/~richard/utf-8.cgi
