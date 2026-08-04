# 13. CONSTRUIRE ET TRANSFORMER AVEC VALUE, FOR ET CORRESPONDING

## 13.A RÉSULTAT ATTENDU

- Construire une table avec `VALUE`
- Transformer une table avec une itération `FOR`
- Copier les composants homonymes avec `CORRESPONDING`
- Utiliser `BASE` pour conserver des données existantes
- Identifier les dépendances à la version ABAP[^terme-abap]

## 13.B VALUE

```abap
DATA lt_products TYPE STANDARD TABLE OF ty_product
                 WITH EMPTY KEY.

lt_products = VALUE #(
  ( matnr = 'MAT-001' maktx = 'Produit 1' stock = 10 )
  ( matnr = 'MAT-002' maktx = 'Produit 2' stock = 20 ) ).
```

## 13.C BASE

```abap
lt_products = VALUE #(
  BASE lt_products
  ( matnr = 'MAT-003' maktx = 'Produit 3' stock = 30 ) ).
```

`BASE` reprend le contenu d’une table avant d’ajouter les nouvelles lignes de l’expression.

## 13.D FOR

```abap
" Traiter la collection sans lecture SQL dans la boucle.
DATA lt_available_products TYPE STANDARD TABLE OF ty_product
                           WITH EMPTY KEY.

lt_available_products = VALUE #(
  FOR ls_product IN lt_products
  WHERE ( stock > 0 )
  ( ls_product ) ).
```

L’expression parcourt la table source et construit la table résultat.

## 13.E TRANSFORMER LE TYPE DE LIGNE

```abap
" Traiter la collection sans lecture SQL dans la boucle.
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

## 13.F CORRESPONDING

```abap
lt_target = CORRESPONDING #( lt_source ).
```

Pour chaque ligne, les composants de même nom et de type compatible sont copiés.

### 13.F.1 Mapping explicite

```abap
lt_target = CORRESPONDING #(
  lt_source
  MAPPING product_id   = matnr
          product_text = maktx ).
```

### 13.F.2 Exclure un composant

```abap
lt_target = CORRESPONDING #(
  lt_source
  EXCEPT technical_field ).
```

## 13.G COMBINER FOR ET EXPRESSIONS DE TABLE

```abap
" Accéder à la ligne par une clé adaptée au besoin.
lt_result = VALUE #(
  FOR ls_item IN lt_items
  ( vbeln = ls_item-vbeln
    posnr = ls_item-posnr
    maktx = VALUE #( lt_products[ matnr = ls_item-matnr ]-maktx
                     OPTIONAL ) ) ).
```

## 13.H LISIBILITÉ

Les expressions constructeurs réduisent le code impératif, mais une expression trop imbriquée devient difficile à déboguer.

Préférer plusieurs étapes nommées lorsque :

- plusieurs recherches peuvent échouer ;
- la transformation contient des règles métier ;
- des messages ou traces doivent être produits ;
- l’expression dépasse une lecture immédiate.

## 13.I COMPATIBILITÉ

> [!NOTE]
> `VALUE`, les itérations `FOR` et les variantes modernes de `CORRESPONDING` dépendent de la version ABAP. Vérifier la documentation accessible depuis le système avant de retenir cette syntaxe dans un développement destiné à plusieurs paysages SAP[^terme-acro-sap].

## 13.J VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 13.K ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## 13.L SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Traiter la collection sans lecture SQL dans la boucle.
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

## 13.M TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 13.N RÉFÉRENCES OFFICIELLES SAP

- [Processing the Contents of Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-the-contents-of-internal-tables_b69864af-3b88-4887-83c8-7ac6701add94)
- [VALUE, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENVALUE_CONSTRUCTOR_PARAMS_ITAB.html)
- [FOR, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFOR_ITAB.html)
- [CORRESPONDING, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCORRESPONDING_CONSTR_ITAB.html)


---

[Chapitre suivant — FILTRER, REGROUPER ET AGRÉGER](<./14 ├── FILTRER REGROUPER ET AGREGER.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
