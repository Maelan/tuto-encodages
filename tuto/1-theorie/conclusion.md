Ça, c’est pour la théorie. En pratique, l’exemple qu’on a inventé était
simpliste. Dans la réalité, on a deux complications principales.

1.  Il faut considérer les contraintes matérielles. En effet, comme je l’ai dit,
    un ordinateur ne connaît que le binaire. Les bits sont regroupés par groupes
    de huit appelés « octets ». Un octet ne peut stocker que les nombres
    entiers de 0 à 255 (soit 256 = 2^8^ possibilités). Si cela ne suffit pas, on
    peut rassembler les octets par deux, quatre ou plus pour avoir de plus
    grands nombres. Dans nos encodages, il faudra tenir compte de ces limites,
    c’est-à-dire s’arranger pour que les codes de notre jeu tiennent tous sur un
    ou deux octets par exemple.
1.  Il y a beaucoup plus de caractères à gérer. Dans notre exemple, on a été
    négligent, on en a oublié plein :
    -   Il serait utile d’ajouter des caractères spéciaux, dits « de contrôle »,
        qui ne représentent pas un symbole « imprimable » mais donnent des
        indications aux programmes qui manipulent du texte. Par exemple, un
        caractère « fin de chaîne de caractères » ou « fin de fichier ».
    -   Ce serait vraiment bien d’avoir les lettres minuscules…
    -   Pour écrire vraiment correctement en français, il faudrait aussi les
        accents, le C cédille (`Ç`) l’E dans l’O (`Œ`), les symboles de monnaie…
    -   Enfin, n’oublions pas qu’il existe plein d’autres alphabets que
        l’alphabet latin, et que les Arabes et les Chinois — entre autres — ont
        peut-être envie de parler dans leur langue maternelle, eux aussi. C’est
        là que ça devient vraiment problématique, comme nous allons le voir.
