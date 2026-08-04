# 13. AJOUTER DES DONNÉES AVEC INSERT

## 13.A RÉSULTAT ATTENDU

- Insérer une ligne dans une table client
- Insérer plusieurs lignes depuis une table interne
- Gérer une clé déjà existante
- Comprendre `sy-subrc` et `sy-dbcnt`
- Éviter les écritures directes dans les tables applicatives SAP

## 13.B TABLE D’EXEMPLE

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

## 13.C INSÉRER UNE LIGNE

```abap
" Modifier uniquement les données de la table cible maîtrisée.
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

## 13.D INSÉRER PLUSIEURS LIGNES

```abap
" Modifier uniquement les données de la table cible maîtrisée.
DATA lt_products TYPE STANDARD TABLE OF zdev_product
                 WITH EMPTY KEY.

lt_products = VALUE #(
  ( product_id = 'P000000001' description = 'Produit 1' category = 'DEMO' )
  ( product_id = 'P000000002' description = 'Produit 2' category = 'DEMO' ) ).

INSERT zdev_product FROM TABLE @lt_products.
```

## 13.E CLÉ EN DOUBLE

Lorsqu’une clé primaire ou un index unique existe déjà :

- une insertion simple échoue avec un code retour approprié ;
- une insertion en masse peut lever `CX_SY_OPEN_SQL_DB` selon la variante ;
- `ACCEPTING DUPLICATE KEYS` ignore les lignes en double et fixe le code retour selon le résultat.

```abap
" Modifier uniquement les données de la table cible maîtrisée.
INSERT zdev_product FROM TABLE @lt_products
  ACCEPTING DUPLICATE KEYS.
```

Cette addition ne met pas à jour les lignes existantes. Elle ignore seulement les doublons impossibles à insérer.

## 13.F MANDANT

Pour une table dépendante du mandant, la gestion implicite utilise le mandant courant. Une valeur de `MANDT` fournie dans la structure source n’est normalement pas utilisée comme un champ métier ordinaire.

## 13.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 13.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 13.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Modifier uniquement les données de la table cible maîtrisée.
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

## 13.J TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 13.K RÉFÉRENCES OFFICIELLES SAP

- [INSERT, Data Source — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Database Locks — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDB_LOCK.html)


---

[Chapitre suivant — MODIFIER DES DONNÉES AVEC UPDATE ET MODIFY](<./14 ├── MODIFIER DES DONNEES AVEC UPDATE ET MODIFY.md>)
