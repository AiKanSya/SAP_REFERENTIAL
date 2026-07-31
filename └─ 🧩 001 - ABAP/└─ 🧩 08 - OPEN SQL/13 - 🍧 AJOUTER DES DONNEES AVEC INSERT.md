# 🌸 AJOUTER DES DONNÉES AVEC INSERT

## 🌺 OBJECTIFS

- Insérer une ligne dans une table client
- Insérer plusieurs lignes depuis une table interne
- Gérer une clé déjà existante
- Comprendre `sy-subrc` et `sy-dbcnt`
- Éviter les écritures directes dans les tables applicatives SAP

## 🌺 TABLE D’EXEMPLE

Les exemples supposent une table client fictive `ZDEV_PRODUCT` contenant notamment :

- `MANDT` ;
- `PRODUCT_ID` comme clé métier ;
- `DESCRIPTION` ;
- `CATEGORY` ;
- `PRICE` ;
- `CURRENCY` ;
- `ACTIVE`.

> [!CAUTION]
> Ne jamais transposer cet exemple à une table applicative SAP standard. Utiliser l’API métier, la BAPI ou l’objet de service prévu par SAP.

## 🌺 INSÉRER UNE LIGNE

```abap
DATA ls_product TYPE zdev_product.

ls_product-product_id = 'P000000001'.
ls_product-description = 'Produit de démonstration'.
ls_product-category = 'DEMO'.
ls_product-price = '10.00'.
ls_product-currency = 'EUR'.
ls_product-active = abap_true.

INSERT zdev_product FROM @ls_product.

IF sy-subrc = 0.
  MESSAGE 'Ligne insérée' TYPE 'S'.
ELSE.
  MESSAGE 'Clé déjà existante' TYPE 'E'.
ENDIF.
```

## 🌺 INSÉRER PLUSIEURS LIGNES

```abap
DATA lt_products TYPE STANDARD TABLE OF zdev_product
                 WITH EMPTY KEY.

lt_products = VALUE #(
  ( product_id = 'P000000001' description = 'Produit 1' category = 'DEMO' )
  ( product_id = 'P000000002' description = 'Produit 2' category = 'DEMO' ) ).

INSERT zdev_product FROM TABLE @lt_products.
```

## 🌺 CLÉ EN DOUBLE

Lorsqu’une clé primaire ou un index unique existe déjà :

- une insertion simple échoue avec un code retour approprié ;
- une insertion en masse peut lever `CX_SY_OPEN_SQL_DB` selon la variante ;
- `ACCEPTING DUPLICATE KEYS` ignore les lignes en double et fixe le code retour selon le résultat.

```abap
INSERT zdev_product FROM TABLE @lt_products
  ACCEPTING DUPLICATE KEYS.
```

Cette addition ne met pas à jour les lignes existantes. Elle ignore seulement les doublons impossibles à insérer.

## 🌺 MANDANT

Pour une table dépendante du mandant, la gestion implicite utilise le mandant courant. Une valeur de `MANDT` fournie dans la structure source n’est normalement pas utilisée comme un champ métier ordinaire.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [INSERT, Data Source — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Database Locks — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDB_LOCK.html)

---

➡️ [Chapitre suivant — MODIFIER DES DONNEES AVEC UPDATE ET MODIFY](<./14 - 🍧 MODIFIER DES DONNEES AVEC UPDATE ET MODIFY.md>)
