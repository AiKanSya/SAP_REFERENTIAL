# EXPRESSIONS DE TABLE ET TEST D’EXISTENCE

## RÉSULTAT ATTENDU

- Lire une ligne avec une expression de table
- Comprendre le risque d’exception en cas de ligne absente
- Utiliser `line_exists` et `line_index`
- Fournir une valeur de remplacement avec `OPTIONAL` ou `DEFAULT`
- Choisir entre expression de table et `READ TABLE`

## EXPRESSION DE TABLE

Une expression de table permet d’utiliser une ligne dans une position opérande.

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(ls_product) = lt_products[ matnr = 'MAT-001' ].
```

Accès par index :

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(ls_first_product) = lt_products[ 1 ].
```

Accès avec une clé nommée :

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(ls_product) = lt_products[
  KEY primary_key
  COMPONENTS matnr = 'MAT-001' ].
```

## LIGNE ABSENTE

Une expression de table utilisée seule lève normalement l’exception de classe `CX_SY_ITAB_LINE_NOT_FOUND` lorsque la ligne n’existe pas.

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
TRY.
    DATA(ls_product) = lt_products[ matnr = p_matnr ].
  CATCH cx_sy_itab_line_not_found.
    MESSAGE 'Produit introuvable' TYPE 'I'.
ENDTRY.
```

## LINE_EXISTS

Lorsque seule l’existence est nécessaire :

```abap
" Accéder à la ligne par une clé adaptée au besoin.
IF line_exists( lt_products[ matnr = p_matnr ] ).
  WRITE: / 'Produit trouvé'.
ENDIF.
```

`line_exists` évite de récupérer la ligne.

## LINE_INDEX

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(lv_index) = line_index( lt_products[ matnr = p_matnr ] ).

IF lv_index > 0.
  WRITE: / 'Index :', lv_index.
ENDIF.
```

Pour une table ou une clé sans index exploitable, la fonction ne fournit pas un numéro de ligne utilisable comme pour une table d’index.

## OPTIONAL

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(ls_product) = VALUE ty_product(
  lt_products[ matnr = p_matnr ] OPTIONAL ).
```

Si la ligne est absente, `ls_product` reçoit sa valeur initiale.

## DEFAULT

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA(ls_product) = VALUE ty_product(
  lt_products[ matnr = p_matnr ]
  DEFAULT VALUE #( matnr = p_matnr
                   maktx = 'Produit inconnu' ) ).
```

## MODIFIER PAR EXPRESSION DE TABLE

Une expression de table peut être placée à gauche d’une affectation.

```abap
" Accéder à la ligne par une clé adaptée au besoin.
lt_products[ matnr = 'MAT-001' ]-stock = 50.
```

Cette instruction lève également une exception si la ligne n’existe pas.

## CHOISIR ENTRE READ TABLE ET EXPRESSION

| Besoin                                             | Mécanisme adapté                                |
| -------------------------------------------------- | ----------------------------------------------- |
| Contrôler avec `sy-subrc`                          | `READ TABLE`                                    |
| Utiliser directement une ligne dans une expression | Expression de table                             |
| Tester uniquement l’existence                      | `line_exists`                                   |
| Obtenir un index                                   | `line_index` ou `READ TABLE` selon la catégorie |
| Fournir une valeur initiale ou par défaut          | `VALUE ... OPTIONAL/DEFAULT`                    |

> [!NOTE]
> La disponibilité des expressions de table et de certaines additions dépend de la version ABAP du système. Utiliser l’aide syntaxique intégrée du système pour confirmer la syntaxe disponible.

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
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
TRY.
    DATA(ls_product) = lt_products[ matnr = p_matnr ].
  CATCH cx_sy_itab_line_not_found.
    MESSAGE 'Produit introuvable' TYPE 'I'.
ENDTRY.
```

## TERMES DU LEXIQUE

- [Expression](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [Table Expressions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENTABLE_EXPRESSIONS.html)
- [Table Functions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENTABLE_FUNCTIONS.html)
- [Internal Tables in Release 7.40 — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/ABENNEWS-740-ITAB.html)


---

[Chapitre suivant — PARCOURIR UNE TABLE AVEC LOOP AT](<./08 ├── PARCOURIR UNE TABLE AVEC LOOP AT.md>)
