Un problème posé par la diversité des encodages existants est la détermination
de l’encodage utilisé par un fichier. Les renseignements associés à un fichier
(sa date de création par exemple) n’indiquent rien sur son encodage. On doit
donc tenter de le deviner, au moyen d’algorithmes compliqués qui analysent le
contenu du fichier. Ces algorithmes sont efficaces la plupart du temps, mais
[peuvent échouer][bush-hid], et sont compliqués. C’est ce qui explique les
affichages bizarres de certains fichiers ou pages web : le programme n’a pas
réussi à déterminer le bon encodage.

[bush-hid]: https://en.wikipedia.org/wiki/Bush_hid_the_facts

Un moyen plus simple serait d’inclure cette indication directement dans le
contenu du fichier, au tout début (afin de diminuer les risques de
perturbation). On utilise pour cela le fait que tous les encodages actuels
soient compatibles avec l’ASCII. C’est ce qu’on verra tout à l’heure pour les
pages HTML.
