# 14. FILTRER, REGROUPER ET AGRÉGER

## 14.A RÉSULTAT ATTENDU

- Extraire un sous-ensemble avec `FILTER`
- Regrouper des lignes avec `LOOP AT ... GROUP BY`
- Calculer un résultat avec `REDUCE`
- Agréger des lignes avec `COLLECT`
- Choisir entre traitement impératif et expression

## 14.B FILTER

```abap
" Traiter la collection sans lecture SQL dans la boucle.
DATA lt_category_a LIKE lt_products.

lt_category_a = FILTER #(
  lt_products
  WHERE category = 'A' ).
```

`FILTER` nécessite une clé triée ou hachée adaptée à la condition de filtre selon la variante utilisée.

Avec une clé nommée :

```abap
" Traiter la collection sans lecture SQL dans la boucle.
lt_category_a = FILTER #(
  lt_products
  USING KEY sk_category
  WHERE category = 'A' ).
```

## 14.C LOOP AT GROUP BY

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products INTO DATA(ls_product)
     GROUP BY ls_product-category
     INTO DATA(lv_category).

  WRITE: / 'Catégorie :', lv_category.

  LOOP AT GROUP lv_category INTO DATA(ls_member).
    WRITE: / ls_member-matnr.
  ENDLOOP.
ENDLOOP.
```

Le premier parcours construit des groupes. `LOOP AT GROUP` parcourt les membres du groupe courant.

## 14.D GROUPE STRUCTURÉ

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products INTO DATA(ls_product)
     GROUP BY ( category = ls_product-category
                size     = GROUP SIZE )
     INTO DATA(ls_group).

  WRITE: / ls_group-category, ls_group-size.
ENDLOOP.
```

## 14.E REDUCE

```abap
" Traiter la collection sans lecture SQL dans la boucle.
DATA(lv_total_stock) = REDUCE i(
  INIT total = 0
  FOR ls_product IN lt_products
  NEXT total = total + ls_product-stock ).
```

`REDUCE` retourne une valeur calculée à partir d’une itération.

## 14.F COLLECT

`COLLECT` recherche une ligne selon la clé primaire[^terme-cle-primaire]. Si elle existe, les composants numériques non-clés sont additionnés. Sinon, la ligne est insérée.

```abap
" Traiter la collection sans lecture SQL dans la boucle.
TYPES: BEGIN OF ty_stock_by_category,
         category TYPE c LENGTH 4,
         quantity TYPE i,
       END OF ty_stock_by_category.

DATA lt_totals TYPE HASHED TABLE OF ty_stock_by_category
               WITH UNIQUE KEY category.

LOOP AT lt_products INTO DATA(ls_product).
  COLLECT VALUE ty_stock_by_category(
    category = ls_product-category
    quantity = ls_product-stock )
    INTO lt_totals.
ENDLOOP.
```

> [!IMPORTANT]
> `COLLECT` n’est adapté que lorsque son comportement d’agrégation numérique par clé correspond exactement au besoin. Ne pas l’utiliser comme simple mécanisme générique de déduplication.

## 14.G COMPARAISON

| Besoin                                            | Mécanisme                             |
| ------------------------------------------------- | ------------------------------------- |
| Extraire un sous-ensemble                         | `FILTER` ou `VALUE ... FOR ... WHERE` |
| Parcourir des groupes et leurs membres            | `LOOP AT ... GROUP BY`                |
| Calculer une valeur unique                        | `REDUCE`                              |
| Additionner des composants numériques par clé     | `COLLECT`                             |
| Ajouter règles, messages et traitements complexes | `LOOP AT` explicite                   |

## 14.H COMPATIBILITÉ

Les expressions `FILTER`, `REDUCE` et les groupements modernes ne sont pas disponibles sur toutes les versions ABAP[^terme-abap]. Prévoir une alternative avec `LOOP AT`, `READ TABLE` et `INSERT` lorsque le code doit fonctionner sur des systèmes anciens.

## 14.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 14.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## 14.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Traiter la collection sans lecture SQL dans la boucle.
TYPES: BEGIN OF ty_stock_by_category,
         category TYPE c LENGTH 4,
         quantity TYPE i,
       END OF ty_stock_by_category.

DATA lt_totals TYPE HASHED TABLE OF ty_stock_by_category
               WITH UNIQUE KEY category.

LOOP AT lt_products INTO DATA(ls_product).
  COLLECT VALUE ty_stock_by_category(
    category = ls_product-category
    quantity = ls_product-stock )
    INTO lt_totals.
ENDLOOP.
```

## 14.L TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 14.M RÉFÉRENCES OFFICIELLES SAP

- [Processing the Contents of Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-the-contents-of-internal-tables_b69864af-3b88-4887-83c8-7ac6701add94)
- [FILTER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCONSTRUCTOR_EXPR_FILTER.html)
- [Grouping Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENLOOP_AT_ITAB_GROUP_BY.html)
- [REDUCE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCONSTRUCTOR_EXPR_REDUCE.html)
- [COLLECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCOLLECT.html)


---

[Chapitre suivant — CLÉS SECONDAIRES](<./15 ├── CLES SECONDAIRES.md>)

[^terme-cle-primaire]: **CLÉ PRIMAIRE.** Ensemble minimal de champs identifiant de manière unique une ligne de table. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#cle-primaire>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
