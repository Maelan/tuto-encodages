C’est pourquoi des extensions de l’ASCII sont apparues.

Certaines gardent la base ASCII et utilisent le huitième bit laissé libre afin
d’avoir plus de caractères à disposition (deux fois plus, 256 = 2^8^ au total).
Ainsi, les codes de 0 à 127 correspondent encore aux caractères ASCII, tandis
que les codes supérieurs (de 128 à 255, c’est-à-dire ceux avec le huitième bit
valant 1) servent pour les nouveaux caractères.

D’autres restent sur sept bits, et modifient carrément les 128 caractères de
l’ASCII pour leur propres besoins.

On imagine la pagaille que ça a été, lorsque chaque pays s’est mis à éditer sa
propre page de code. Ça fonctionnait bien tant que les documents restaient dans
la zone où leur propre encodage était en usage, mais les échanges internationaux
étaient sujets à problèmes. Comme un même code signifiait des caractères
différents d’une page à l’autre, le récepteur ne lisait pas la même chose que
l’expéditeur. Par exemple, le symbole du dollar (`$`) aux États-Unis devenait
celui de la livre (`£`) au Royaume-Uni : dégâts assurés !

Il y a bien eu des tentatives de stopper la multiplication des pages de code,
mais elles ont été insuffisantes. L’exemple le plus significatif en est la norme
[ISO 646][ISO 646] de 1972. Elle a défini une page de code sur sept bits
dérivant de l’ASCII, avec des caractères fixes (principalement les lettres, les
chiffres et la ponctuation principale), les autres caractères étant laissés au
choix. Cette norme, qui devait permettre une certaine compatibilité et un
semblant d’ordre, a donné naissance à plusieurs pages de code nationales, mais
elle n’était pas adaptée aux langues non latines et ne permettait pas de
représenter assez de caractères.

[ISO 646]: https://fr.wikipedia.org/wiki/ISO_646

# ISO 8859 : huit bits pour les langues latines

Plus tard, une norme mieux pensée a fait son apparition : la norme **ISO 8859**.
Cette fois, elle utilise **huit bits donc 256 caractères au maximum**. La norme
ISO 8859 comporte en fait plusieurs « parties », c’est-à-dire des pages de code
indépendantes, nommées ISO 8859-_n_ où _n_ est le numéro de la partie. ISO 8859
a été pensée afin que les parties soient le plus largement compatibles entre
elles. Ainsi, la plage inférieure (codes 0 à 127) est la base commune ASCII, et
la plage supérieure (codes 128 à 255) est spécifique à chaque page de code ;
elle est remplie en s’arrangeant pour qu’entre deux pages de code, des
caractères en commun ou qui se ressemblent occupent le même code.

Cette norme a principalement servi aux langues latines d’Europe pour mettre au
point une page de code commune. À elles seules, elles utilisent en tout dix
parties d’ISO 8859, parfois appelées « latin-1 », « latin-2 », etc. ; la
première est la principale et les suivantes en sont des évolutions visant à
améliorer la prise en charge de certaines langues. En voici deux à connaître :

-   **ISO 8859-1 (« latin-1 » ou « Occidental »)** est une page de code très
    courante dans les pays latins et sur la Toile. C’est l’encodage utilisé
    initialement par les distributions Linux, mais elles migrent progressivement
    vers l’UTF-8 qu’on verra plus tard. Les systèmes Windows utilisent également
    un jeu dérivé, comme on le verra bientôt. Il a l’avantage de permettre
    d’écrire _grosso modo_ toutes les langues latines, et ceci avec un octet par
    caractère seulement.
-   **ISO 8859-15 (« latin-9 » ou « Occidental (euro) »)**, datant de 1998,
    introduit le signe de l’euro (`€`) et complète le support de quelques
    langues dont le français (avec `Œ`) en abandonnant des symboles peu usités
    (dont le mystérieux `¤` signifiant « monnaie »). Il est néanmoins moins
    utilisé que son grand frère ci-dessus.

+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|      |-0        |-1   |-2   |-3   |-4     |-5   |-6     |-7   |-8     |-9   |-A   |-B   |-C     |-D     |-E     |-F   |
+======+==========+=====+=====+=====+=======+=====+=======+=====+=======+=====+=====+=====+=======+=======+=======+=====+
|**0-**|                                                                                                                |
|      | -> __ASCII__ <-                                                                                                |
|**⋮** |                                                                                                                |
|      | -> _(sauf les caractères de contrôle, inutilisés)_ <-                                                          |
|**7-**|                                                                                                                |
+------+----------------------------------------------------------------------------------------------------------------+
|**8-**|                                                                                                                |
|      | -> _non utilisé_ <-                                                                                            |
|**9-**|                                                                                                                |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**A-**|||_NBSP_|||`¡`  |`¢`  |`£`  |`¤`/`€`|`¥`  |`¦`/`Š`|`§`  |`¨`/`š`|`©`  |`ª`  |`«`  |`¬`    |`-`    |`®`    |`¯`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**B-**|`°`       |`±`  |`²`  |`³`  |`´`/`Ž`|`µ`  |`¶`    |`·`  |`¸`/`ž`|`¹`  |`º`  |`»`  |`¼`/`Œ`|`½`/`œ`|`¾`/`Ÿ`|`¿`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**C-**|`À`       |`Á`  |`Â`  |`Ã`  |`Ä`    |`Å`  |`Æ`    |`Ç`  |`È`    |`É`  |`Ê`  |`Ë`  |`Ì`    |`Í`    |`Î`    |`Ï`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**D-**|`Ð`       |`Ñ`  |`Ò`  |`Ó`  |`Ô`    |`Õ`  |`Ö`    |`×`  |`Ø`    |`Ù`  |`Ú`  |`Û`  |`Ü`    |`Ý`    |`Þ`    |`ß`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**E-**|`à`       |`á`  |`â`  |`ã`  |`ä`    |`å`  |`æ`    |`ç`  |`è`    |`é`  |`ê`  |`ë`  |`ì`    |`í`    |`î`    |`ï`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
|**F-**|`ð`       |`ñ`  |`ò`  |`ó`  |`ô`    |`õ`  |`ö`    |`÷`  |`ø`    |`ù`  |`ú`  |`û`  |`ü`    |`ý`    |`þ`    |`ÿ`  |
+------+----------+-----+-----+-----+-------+-----+-------+-----+-------+-----+-----+-----+-------+-------+-------+-----+
Table:
  Table des caractères ISO 8859-1 (latin-1) et ISO 8859-15 (latin-9,
  caractères indiqués côte-à-côte si différents)

[[information]]
| Le caractère ||_NBSP_|| (0xA0) est l’espace insécable (_non-breaking space_),
| c’est-à-dire une espace qui, contrairement à l’espace habituelle, ne
| « sépare » pas les mots. Ça veut dire que si on écrit « Bonjour ! » avec
| une espace insécable et que ça se retrouve à la fin d’une ligne d’affichage,
| « Bonjour » ne sera pas séparé du point d’exclamation (ils iront ensemble au
| début de la ligne suivante) contrairement à une espace simple. Ce caractère
| est surtout utilisé avec les signes de ponctuation (avant « ? », « ! », « ; »,
| « : » et entre les guillemets “«” et “»”). Ce sont les espaces grises bizarres
| dans LibreOffice.

*[NBSP]: Non-Breaking SPace

À nouveau un exemple, avec cette fois des caractères accentués, des guillemets
et des espaces insécables (symbolisés par ▒ pour qu’on les voie), conformément
aux règles typographiques :

    :::text
    texte :           «  ▒  À     v  a  i  n  c  r  e     s  a  n  s     p  é  r  i  l  .  .  .  ▒  »
    codage latin-1 :  AB A0 C0 20 76 61 69 6E 63 72 65 20 73 41 6E 73 41 70 E9 72 69 6C 2E 2E 2E A0 BB

Les codes de 0x00 à 0x1F et 0x7F (les caractères de contrôle ASCII) et de 0x80 à
0x9F sont laissés inutilisés par la norme 8859. Pour les communications
Internet, l’[IANA][] a créé la norme ISO-8859 (attention, c’est le tiret qui
change tout !), qui ajoute des caractères de contrôle à ces emplacements.

[IANA]: https://fr.wikipedia.org/wiki/IANA

Windows s’est aussi basé sur latin-1 pour mettre au point son nouveau jeu de
caractères occidental dans les années 1990. **[Windows-1252][]** (ou « CP1252 »,
parfois dit « ANSI » à titre officieux) est maintenant le jeu utilisé dans tous
les systèmes Windows occidentaux, et remplace les anciennes pages de code (la
[page de code 437][CP437] pour les États-Unis, et la [850][CP850] pour
l’Europe). Il étend latin-1 avec des caractères supplémentaires dans les codes
libres (de 0x80 à 0x9F).

[Windows-1252]: https://fr.wikipedia.org/wiki/Windows-1252
[CP437]: https://fr.wikipedia.org/wiki/CP437
[CP850]: https://fr.wikipedia.org/wiki/CP850

[[information]]
| __Écrire des « caractères spéciaux » sous Windows__
| 
| Sous Windows, on peut insérer n’importe quel caractère de Windows-1252
| (donc de latin-1 et d’ASCII) avec
| [la combinaison ||Alt||+||_code_||][alt-codes] où _code_ est le code décimal
| du caractère, précédé du chiffre zéro (sinon, le code est lu selon la vieille
| page de code du système — 850 ou 437). Les exemples les plus utiles pour le
| français :
| 
| -   ||Alt||+||0||,||1||,||9||,||2|| → `À`
| -   ||Alt||+||0||,||1||,||9||,||9|| → `Ç`
| -   ||Alt||+||0||,||2||,||0||,||1|| → `É`
| -   ||Alt||+||0||,||1||,||6||,||0|| (ou ||Alt||+||2||,||5||,||5||) → espace
|     insécable
| -   ||Alt||+||0||,||1||,||7||,||1|| (ou ||Alt||+||1||,||7||,||4||) → `«`
| -   ||Alt||+||0||,||1||,||8||,||7|| (ou ||Alt||+||1||,||7||,||5||) → `»`
| 
| __Écrire des « caractères spéciaux » sous Linux__
| 
| Sous Linux, le clavier est plus complet et la touche ||AltGr|| (ou
| ||AltGr||+||Maj||) combinée avec les autres donne accès à de nombreux
| caractères. Et si cela ne suffit pas, [la touche ||Compose||][compose] donne
| accès à encore plus. Je vous laisse chercher !
| 
| -----
| 
| À partir de maintenant, plus d’excuse pour massacrer le français ! D’ailleurs,
| si vous êtes intéressé, je conseille la lecture de [ce cours sur la
| typographie][tuto-typo].

[alt-codes]: https://fr.wikipedia.org/wiki/Alt_codes
[compose]:   https://fr.wikipedia.org/wiki/Touche_compose
[tuto-typo]: http://www.siteduzero.com/tutoriel-3-454279-l-orthotypographie-bien-ecrire-pour-bien-etre-lu.html

ISO 8859 a aussi été utilisé pour l’alphabet cyrillique (ISO 8859-5), l’arabe
(ISO 8859-6), le grec (-7) l’hébreu (-8) et même le thaï (-11).

Il existe au total seize parties et il n’y en aura pas plus. En effet, on
privilégie désormais le développement de l’Unicode.

# ISO 2022 : du multi-octet pour les langues asiatiques

-> _Pendant ce temps en Asie…_ <-

Les langues latines s’en sont relativement bien tirées. Elles ont réussi à ne
pas dépasser la limite fatidique de l’octet, ce qui reste quand même le plus
pratique à la fois pour les traitements et pour la consommation de mémoire. Mais
les langues asiatiques — japonais, coréen et chinois — disposent de bien trop de
caractères pour que tout tienne sur huit bits. Les encodages mis au point en
Asie de l’Est étaient donc **multi-octet**. Certains utilisaient deux octets par
caractère, ce qui offre 65 536 (2^16^) codes différents.

Comme pour les langues latines, une norme a été mise au point pour les
organiser, on l’appelle **ISO 2022**. Elle permet de jongler entre plusieurs
jeux à l’aide de séquences d’échappement ; celles-ci indiquent le jeu utilisé
dans ce qui suit.

On peut ainsi employer plusieurs jeux différents dans une même chaîne de
caractères. En fait, la norme distingue une plage de codes pour les octets 0 à
127, une autre pour les octets 128 à 255, et permet d’assigner un jeu à chaque
plage de façon indépendante. Ainsi, on peut même employer deux jeux
simultanément (par exemples ASCII et kanjis japonais, ou sinogrammes et
latin-1) ! Ou alors, en n’utilisant que la première plage, on peut faire passer
du texte dans un vieux système à sept bits.

Les différents jeux sont totalement indépendants ; ils n’ont même pas à faire la
même taille ! Certains requièrent un octet par caractère, d’autres deux.

En théorie, ISO 2022 est une norme universelle puisqu’elle permet de passer d’un
encodage arbitraire à un autre. Elle contient d’ailleurs ISO 8859. Toutefois,
elle a plusieurs défauts, dont sa complexité et sa nature d’encodage *à état* :
non seulement les caractères n’ont pas une taille fixe, mais en plus il faut
absolument lire le texte depuis le début pour interpréter les octets !

En pratique, les occidentaux n’ont donc pas adopté ISO 2022, qui n’a servi que
pour le chinois (ISO 2022-CN), le coréen (ISO 2022-KR) et le japonais
(ISO 2022-JP). Ces variantes restent encore répandues, surtout la japonaise,
mais l’Unicode gagne du terrain.
