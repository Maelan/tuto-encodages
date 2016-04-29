Ça, c’est pour la théorie. L’exemple qu’on a inventé était simpliste. En
pratique, on a deux complications principales.

1.  Il faut considérer les contraintes matérielles. En effet, comme je l’ai dit,
    un ordinateur ne connaît que le binaire. Les bits sont regroupés par groupes
    de huit appelés « octets ». Un octet ne peut stocker que les nombres
    entiers de 0 à 255 (soit 256 = 2^8^ possibilités). Si cela ne suffit pas, on
    peut rassembler les octets par deux, quatre ou plus pour avoir de plus
    grands nombres. Dans nos codages, il faudra tenir compte de ces limites, par
    exemple en faisant tenir tous les codes de notre jeu sur un ou deux octets.
1.  Il y a beaucoup plus de caractères à gérer. Dans notre exemple, on a été
    négligent, on en a oublié plein :
    -   Il serait utile d’ajouter des caractères de contrôle.
    -   Ce serait vraiment bien d’avoir les lettres minuscules…
    -   Pour écrire vraiment correctement en français, il faudrait aussi les
        accents, le C cédille (`Ç`) l’E dans l’O (`Œ`), les symboles de monnaie…
    -   Enfin, n’oublions pas que l’alphabet latin est très loin d’être le seul
        système d’écriture du monde : les Arabes et les Chinois — entre autres —
        ont sans doute envie de parler dans leur langue maternelle, eux aussi.
        C’est là que ça devient vraiment problématique, comme nous allons voir.
