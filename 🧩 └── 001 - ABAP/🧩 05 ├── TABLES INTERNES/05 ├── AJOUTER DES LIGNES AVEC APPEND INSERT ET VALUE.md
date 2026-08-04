# AJOUTER DES LIGNES AVEC APPEND, INSERT ET VALUE

## RÉSULTAT ATTENDU

- Ajouter une ligne à une table interne
- Distinguer `APPEND` et `INSERT`
- Ajouter une ligne initiale avec affectation directe
- Construire plusieurs lignes avec `VALUE`
- Contrôler les violations de clé unique

## APPEND

`APPEND` ajoute une ligne à la fin d’une table d’index.

```abap
DATA lt_messages TYPE STANDARD TABLE OF string
                 WITH EMPTY KEY.

APPEND 'Premier message' TO lt_messages.
APPEND 'Deuxième message' TO lt_messages.
```

Pour une ligne structurée :

```abap
DATA ls_product TYPE ty_product.

ls_product-matnr = 'MAT-001'.
ls_product-maktx = 'Produit 1'.
APPEND ls_product TO lt_products.
```

## APPEND VALUE

```abap
APPEND VALUE #( matnr = 'MAT-002'
                maktx = 'Produit 2' )
       TO lt_products.
```

Cette forme évite une zone de travail lorsque la ligne n’est utilisée qu’une fois.

## APPEND INITIAL LINE

```abap
APPEND INITIAL LINE TO lt_products ASSIGNING FIELD-SYMBOL(<ls_product>).

<ls_product>-matnr = 'MAT-003'.
<ls_product>-maktx = 'Produit 3'.
```

La ligne est créée dans la table puis affectée directement au symbole de champ.

## INSERT

`INSERT ... INTO TABLE` respecte la catégorie et la clé de la table.

```abap
INSERT VALUE #( matnr = 'MAT-001'
                maktx = 'Produit 1' )
       INTO TABLE lt_sorted_products.
```

Cette forme convient aux tables standard, triées et hachées.

> [!TIP]
> Lorsque le code doit rester indépendant de la catégorie de table, préférer `INSERT ... INTO TABLE` à `APPEND`.

## CONTRÔLER SY-SUBRC

Pour une table à clé unique, une insertion en doublon échoue.

```abap
INSERT VALUE #( matnr = 'MAT-001'
                maktx = 'Produit dupliqué' )
       INTO TABLE lt_sorted_products.

IF sy-subrc = 0.
  WRITE: / 'Ligne ajoutée'.
ELSE.
  WRITE: / 'Clé déjà présente'.
ENDIF.
```

## CONSTRUIRE LA TABLE AVEC VALUE

```abap
lt_products = VALUE #(
  ( matnr = 'MAT-001' maktx = 'Produit 1' )
  ( matnr = 'MAT-002' maktx = 'Produit 2' )
  ( matnr = 'MAT-003' maktx = 'Produit 3' ) ).
```

Cette affectation remplace le contenu antérieur de la table cible.

## CONSERVER LE CONTENU EXISTANT AVEC BASE

```abap
lt_products = VALUE #(
  BASE lt_products
  ( matnr = 'MAT-004' maktx = 'Produit 4' ) ).
```

## APPEND LINES OF ET INSERT LINES OF

```abap
APPEND LINES OF lt_new_products TO lt_products.
```

```abap
INSERT LINES OF lt_new_products INTO TABLE lt_sorted_products.
```

La seconde syntaxe respecte les règles de clé de la table cible.

## COMPARAISON

| Besoin                                 | Syntaxe adaptée                        |
| -------------------------------------- | -------------------------------------- |
| Ajouter à la fin d’une table standard  | `APPEND`                               |
| Ajouter indépendamment de la catégorie | `INSERT ... INTO TABLE`                |
| Construire une table complète          | `VALUE #( ... )`                       |
| Ajouter plusieurs lignes existantes    | `APPEND LINES OF` ou `INSERT LINES OF` |
| Modifier immédiatement la ligne créée  | `ASSIGNING` ou `REFERENCE INTO`        |

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
INSERT VALUE #( matnr = 'MAT-001'
                maktx = 'Produit dupliqué' )
       INTO TABLE lt_sorted_products.

IF sy-subrc = 0.
  WRITE: / 'Ligne ajoutée'.
ELSE.
  WRITE: / 'Clé déjà présente'.
ENDIF.
```

## TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [Populating Internal Tables — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-concepts/populating-internal-tables)
- [Working with Simple Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-simple-internal-tables_a4beb937-0c7b-45b9-92be-ff26a5159fad)
- [APPEND — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPAPPEND.html)
- [INSERT itab — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_ITAB.html)


---

[Chapitre suivant — LIRE UNE LIGNE AVEC READ TABLE](<./06 ├── LIRE UNE LIGNE AVEC READ TABLE.md>)
