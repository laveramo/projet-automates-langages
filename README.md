# Analyseur (parser)

## Description

Cet projet permet de vérifier que le programme écrit par l'utilisateur respecte bien les règles de syntaxe du langage C.

L'analyseur est divisé en deux parties :

- **L'analyseur lexical** : Chargé de traiter le fichier d'entrée et de le diviser en tokens.
- **L'analyseur de grammaire** : Chargé de la grammaire du langage ; il prend les tokens générés précédemment et vérifie qu'ils respectent les règles grammaticales du langage.

## Utilisation

Pour utiliser l'analyseur, il suffit de générer les fichiers nécessaires en écrivant sur la ligne de commande **_Linux_** la commande `make` et, après ça, le parseur avec le fichier en argument. Par exemple :

```shell
./parser < mon_programme.c
```

## Exemple

Voici un exemple de programme en C :

```c
int main()
{
    int a = 5;
    int b = 3;
    int c = a + b;
    return c;
}
```

L'analyseur va vérifier que ce programme respecte les règles de syntaxe du langage C.

## Auteurs

- [Luz Vera](https://github.com/laveramo)
- [Valeria González](https://github.com/valeegms)
