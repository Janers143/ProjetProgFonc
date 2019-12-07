# Projet de Programation Fonctionnelle réalisé par Alexandre JAVORNIK et Anthony SALINAS

==================================================================================================

## Le code est composé de plusieurs modules et de 2 programmes principaux

Modules :   
* **Gfile** : permet de lire et d'écrire des fichiers de graphes ayant différents formats
* **Graph** : définit le type graphe et déclare quelques fonctions utiles à appliquer sur des graphes
* **Tools** : contient 3 fonctions utiles pour travailler sur es différents algorithmes
* **Fordfulkerson** : permet d'exécuter l'algorithme de Ford-Fulkerson sur des graphes (contient toutes
les fonctions nécessaires pour cet algorithme)
* **Moneysharing** : permet de résoudre un problème de partage des paiements entre plusieurs personnes
en utilisant l'algorithme de Ford-Fulkerson

Programmes principaux : 
* **ftest** : permet de lancer l'algorithme de Ford-Fulkerson sur un graphe qu'on lui passe
en paramètre
* **moneysharingtest** : permet de résoudre un problème de partage des paiements entre 
plusieurs personnes à partir d'un fichier qu'on lui passe en paramètre

==================================================================================================

## Comment compiler nos programmes

* **Option 1** : Ouvrir VSCode/VSCodium dans le dossier "ocaml-maxflow-project/" (ouvrir un terminal dans ce 
dossier et y rentrer la commande "code ."). Une fois que VSCode est ouvert, les deux programmes seront
compilés en faisant Ctrl+Shift+b
* **Option 2** : Ouvrir un terminal dans le dossier "ocaml-maxflow-project/" et lancer la commande "make"

Ces deux options conduisent au même résultat : deux exécutables "ftest.native" et "moneysharingtes.native"
sont créés dans le dossier "ocaml-maxflow-project/".

==================================================================================================

## Comment exécuter nos programmes

Une fois que les deux programmes ont été compilés grâce au makefile, on peut exécuter nos deux programmes :
* **ftest** :

```
./ftest.native infile source_id sink_id outfile
```

*infile* : fichier dans lequel lire le graph au format 1¹

*source_id* : id du node que nous voulons qui soit consideré comme source dans l'algorithme de Ford-Fulkerson

*sink_id* : id du node que nous voulons qui soit consideré comme puits dans l'algorithme de
Ford-Fulkerson

*outfile* : fichier dans lequel sera écrit le résultat de l'exécution (le dernier graphe résiduel de 
l'algorithme de Ford-Fulkerson) au format 2¹

* **moneysharingtest** :

```
./moneysharingtest.native infile outfile
```

*infile* : fichier dans lequel lire le problème de partage des paiements au format 3¹

*outfile* : fichier dans lequel sera écrit le résultat de l'exécution au format 4¹

¹ : Les différents formats sont expliqués par la suite

==================================================================================================

## Présentation des formats de fichier utilisés

* **Format 1** : Graphes

```
% This is a comment

% A node with its coordinates (which are not used).
n 88.8 209.7
n 408.9 183.0

% The first node has id 0, the next is 1, and so on.

% Edges: e source dest label
e 3 1 11
e 0 2 8
```

* **Format 2** : Graphes utilisables par graphviz

```
digraph finite_state_machine {
rankdir=LR;
size="8,5";
node [shape = circle];

% Edges : source_id -> dest_id [label = lbl_value]

2 -> 4 [ label = "12" ];
1 -> 4 [ label = "1" ];
1 -> 5 [ label = "21" ];
4 -> 5 [ label = "14" ];
0 -> 2 [ label = "8" ];
}
```

* **Format 3** : Problème de partage de paiements

```
% Nom_personne Quantite_payee
Esteban 40
Alex 10
Anthony 10
```

* **Format 4** : Solution de problème de partage de paiements

```
% Nom1 has to pay Quantite_a_payer to Nom2
Anthony has to pay 20€ to Esteban
Alex has to pay 10€ to Anthony
```

==================================================================================================

## Auteurs :
**Alexandre JAVORNIK** et **Anthony SALINAS**