# 🌸 PRINCIPES ET STRUCTURE D’UNE TABLE INTERNE

## 🌺 OBJECTIFS

- Comprendre le rôle d’une table interne en ABAP
- Distinguer table interne, structure et table de base de données
- Identifier le type de ligne, la catégorie et la clé d’une table
- Comprendre le caractère dynamique de son nombre de lignes
- Choisir une représentation adaptée au traitement attendu

## 🌺 DÉFINITION

Une table interne est un objet de données ABAP qui contient zéro, une ou plusieurs lignes de même type.

Elle est créée dans la mémoire de la session ABAP. Son contenu n’est pas automatiquement enregistré dans la base de données.

```mermaid
flowchart LR
    A["Type de ligne"] --> D["Table interne"]
    B["Catégorie de table"] --> D
    C["Clé de table"] --> D
    D --> E["Zéro à plusieurs lignes en mémoire"]
```

Une table interne est définie par trois propriétés principales :

| Propriété     | Rôle                                                                           |
| ------------- | ------------------------------------------------------------------------------ |
| Type de ligne | Définit la structure de chaque ligne                                           |
| Catégorie     | Définit l’organisation et les accès possibles                                  |
| Clé           | Définit les composants utilisés pour les accès par clé et l’unicité éventuelle |

## 🌺 TABLE INTERNE ET STRUCTURE

Une structure représente une seule occurrence.

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE c LENGTH 18,
         maktx TYPE c LENGTH 40,
         stock TYPE i,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

Une table interne représente une collection d’occurrences du même type.

```abap
DATA lt_products TYPE STANDARD TABLE OF ty_product
                 WITH EMPTY KEY.
```

Convention fréquemment utilisée :

- `ls_...` : structure locale ou ligne de travail ;
- `lt_...` : table interne locale ;
- `ty_...` : type local.

Ces préfixes sont des conventions de nommage, pas des mots-clés ABAP.

## 🌺 TABLE INTERNE ET TABLE DE BASE DE DONNÉES

| Table interne                                                    | Table de base de données              |
| ---------------------------------------------------------------- | ------------------------------------- |
| Objet de données en mémoire                                      | Objet persistant du Dictionnaire ABAP |
| Existe pendant l’exécution ou selon la portée de l’objet         | Existe indépendamment du programme    |
| Manipulée avec `APPEND`, `INSERT`, `READ TABLE`, `LOOP AT`, etc. | Lue ou modifiée avec ABAP SQL         |
| Nombre de lignes dynamique                                       | Données persistées en base            |

> [!IMPORTANT]
> Une table interne peut recevoir des données issues d’ABAP SQL, mais elle reste distincte de la table de base de données qui a servi de source.

## 🌺 CYCLE DE VIE SIMPLIFIÉ

```mermaid
flowchart TD
    A["Déclarer la table"] --> B["Ajouter ou charger des lignes"]
    B --> C["Lire et traiter les lignes"]
    C --> D["Modifier, trier ou supprimer"]
    D --> E["Vider ou libérer la table"]
```

## 🌺 PREMIER EXEMPLE

```abap
REPORT z_demo_itab_01.

TYPES: BEGIN OF ty_product,
         matnr TYPE c LENGTH 18,
         maktx TYPE c LENGTH 40,
       END OF ty_product.

DATA lt_products TYPE STANDARD TABLE OF ty_product
                 WITH EMPTY KEY.

APPEND VALUE #( matnr = 'MAT-001'
                maktx = 'Produit de démonstration' )
       TO lt_products.

LOOP AT lt_products INTO DATA(ls_product).
  WRITE: / ls_product-matnr, ls_product-maktx.
ENDLOOP.
```

## 🌺 POINTS À RETENIR

- Une table interne ne contient que des lignes compatibles avec son type de ligne.
- Son nombre de lignes est dynamique.
- Sa catégorie et sa clé doivent être choisies selon les accès attendus.
- Une table interne n’est pas une table de base de données.
- Le contenu est généralement temporaire et propre à la session ABAP.

## 🌺 CAS D’USAGE

Dans un contexte où un traitement de masse charge des commandes en mémoire, recherche des lignes, élimine des doublons et prépare un résultat, le besoin consiste à **manipuler une table interne avec principes et structure d’une table interne en contrôlant clé, présence des lignes et performance**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT z_demo_itab_01.

TYPES: BEGIN OF ty_product,
         matnr TYPE c LENGTH 18,
         maktx TYPE c LENGTH 40,
       END OF ty_product.

DATA lt_products TYPE STANDARD TABLE OF ty_product
                 WITH EMPTY KEY.

APPEND VALUE #( matnr = 'MAT-001'
                maktx = 'Produit de démonstration' )
       TO lt_products.

LOOP AT lt_products INTO DATA(ls_product).
  WRITE: / ls_product-matnr, ls_product-maktx.
ENDLOOP.
```

## 🌺 TERMES DU LEXIQUE

- [Structure](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Working with Simple Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-simple-internal-tables_a4beb937-0c7b-45b9-92be-ff26a5159fad)
- [Working with Complex Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-complex-internal-tables_f8c923f3-6f95-4b47-960f-557001f13977)
- [Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENITAB.html)


---

➡️ [Chapitre suivant — DÉCLARATION DES TYPES ET TABLES INTERNES](<./02 - 🍧 DECLARATION DES TYPES ET TABLES INTERNES.md>)
