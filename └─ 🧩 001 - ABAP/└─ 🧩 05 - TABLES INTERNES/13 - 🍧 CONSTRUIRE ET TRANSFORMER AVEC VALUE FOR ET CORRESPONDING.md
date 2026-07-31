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

### Mapping explicite

```abap
lt_target = CORRESPONDING #(
  lt_source
  MAPPING product_id   = matnr
          product_text = maktx ).
```

### Exclure un composant

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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Processing the Contents of Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-the-contents-of-internal-tables_b69864af-3b88-4887-83c8-7ac6701add94)
- [VALUE, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENVALUE_CONSTRUCTOR_PARAMS_ITAB.html)
- [FOR, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFOR_ITAB.html)
- [CORRESPONDING, Internal Tables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCORRESPONDING_CONSTR_ITAB.html)

---

➡️ [Chapitre suivant — FILTRER REGROUPER ET AGREGER](<./14 - 🍧 FILTRER REGROUPER ET AGREGER.md>)
