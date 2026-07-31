# 🌸 CONSTRUIRE ET TRANSFORMER AVEC VALUE, FOR ET CORRESPONDING

## 🌺 OBJECTIFS

- Construire une table avec `VALUE`
- Transformer une table avec une itération `FOR`
- Copier les composants homonymes avec `CORRESPONDING`
- Utiliser `BASE` pour conserver des données existantes
- Identifier les dépendances à la version ABAP

## 🌺 VALUE

```abap
DATA lt_products TYPE STANDARD TABLE OF ty_product
                 WITH EMPTY KEY.

lt_products = VALUE #(
  ( matnr = 'MAT-001' maktx = 'Produit 1' stock = 10 )
  ( matnr = 'MAT-002' maktx = 'Produit 2' stock = 20 ) ).
```

## 🌺 BASE

```abap
lt_products = VALUE #(
  BASE lt_products
  ( matnr = 'MAT-003' maktx = 'Produit 3' stock = 30 ) ).
```

`BASE` reprend le contenu d’une table avant d’ajouter les nouvelles lignes de l’expression.

## 🌺 FOR

```abap
DATA lt_available_products TYPE STANDARD TABLE OF ty_product
                           WITH EMPTY KEY.

lt_available_products = VALUE #(
  FOR ls_product IN lt_products
  WHERE ( stock > 0 )
  ( ls_product ) ).
```

L’expression parcourt la table source et construit la table résultat.

## 🌺 TRANSFORMER LE TYPE DE LIGNE

```abap
TYPES: BEGIN OF ty_product_label,
         matnr TYPE c LENGTH 18,
         text  TYPE string,
       END OF ty_product_label.

DATA lt_labels TYPE STANDARD TABLE OF ty_product_label
               WITH EMPTY KEY.

lt_labels = VALUE #(
  FOR ls_product IN lt_products
  ( matnr = ls_product-matnr
    text  = |{ ls_product-matnr } - { ls_product-maktx }| ) ).
```

## 🌺 CORRESPONDING

```abap
lt_target = CORRESPONDING #( lt_source ).
```

Pour chaque ligne, les composants de même nom et de type compatible sont copiés.

### 🍧 Mapping explicite

```abap
lt_target = CORRESPONDING #(
  lt_source
  MAPPING product_id   = matnr
          product_text = maktx ).
```

### 🍧 Exclure un composant

```abap
lt_target = CORRESPONDING #(
  lt_source
  EXCEPT technical_field ).
```

## 🌺 COMBINER FOR ET EXPRESSIONS DE TABLE

```abap
lt_result = VALUE #(
  FOR ls_item IN lt_items
  ( vbeln = ls_item-vbeln
    posnr = ls_item-posnr
    maktx = VALUE #( lt_products[ matnr = ls_item-matnr ]-maktx
                     OPTIONAL ) ) ).
```

## 🌺 LISIBILITÉ

Les expressions constructeurs réduisent le code impératif, mais une expression trop imbriquée devient difficile à déboguer.

Préférer plusieurs étapes nommées lorsque :

- plusieurs recherches peuvent échouer ;
- la transformation contient des règles métier ;
- des messages ou traces doivent être produits ;
- l’expression dépasse une lecture immédiate.

## 🌺 COMPATIBILITÉ

> [!NOTE]
> `VALUE`, les itérations `FOR` et les variantes modernes de `CORRESPONDING` dépendent de la version ABAP. Vérifier la documentation accessible depuis le système avant de retenir cette syntaxe dans un développement destiné à plusieurs paysages SAP.

## 🌺 CAS D’USAGE

Dans un contexte où un traitement de masse charge des commandes en mémoire, recherche des lignes, élimine des doublons et prépare un résultat, le besoin consiste à **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
TYPES: BEGIN OF ty_product_label,
         matnr TYPE c LENGTH 18,
         text  TYPE string,
       END OF ty_product_label.

DATA lt_labels TYPE STANDARD TABLE OF ty_product_label
               WITH EMPTY KEY.

lt_labels = VALUE #(
  FOR ls_product IN lt_products
  ( matnr = ls_product-matnr
    text  = |{ ls_product-matnr } - { ls_product-maktx }| ) ).
```

## 🌺 TERMES DU LEXIQUE

- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Processing the Contents of Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-the-contents-of-internal-tables_b69864af-3b88-4887-83c8-7ac6701add94)
- [VALUE, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENVALUE_CONSTRUCTOR_PARAMS_ITAB.html)
- [FOR, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFOR_ITAB.html)
- [CORRESPONDING, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCORRESPONDING_CONSTR_ITAB.html)


---

➡️ [Chapitre suivant — FILTRER, REGROUPER ET AGRÉGER](<./14 - 🍧 FILTRER REGROUPER ET AGREGER.md>)
