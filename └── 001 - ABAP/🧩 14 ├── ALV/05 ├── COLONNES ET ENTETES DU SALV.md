# COLONNES ET ENTÊTES DU SALV

## OBJECTIFS

- Accéder aux objets colonne
- Modifier textes, visibilité et largeur
- Exploiter les informations DDIC

## RÉCUPÉRER LES COLONNES

```abap
DATA:
  lo_columns TYPE REF TO cl_salv_columns_table,
  lo_column  TYPE REF TO cl_salv_column_table.

lo_columns = go_alv->get_columns( ).
lo_columns->set_optimize( abap_true ).

TRY.
    lo_column ?= lo_columns->get_column( 'PRICE' ).
    lo_column->set_short_text( 'Prix' ).
    lo_column->set_medium_text( 'Prix du vol' ).
    lo_column->set_long_text( 'Prix du vol sélectionné' ).
  CATCH cx_salv_not_found.
ENDTRY.
```

## PROPRIÉTÉS COURANTES

| Besoin                          | Méthode typique                                      |
| ------------------------------- | ---------------------------------------------------- |
| Ajuster les largeurs            | `SET_OPTIMIZE`                                       |
| Masquer une colonne             | `SET_VISIBLE`                                        |
| Définir la colonne technique    | `SET_TECHNICAL`                                      |
| Fixer un texte                  | `SET_SHORT_TEXT`, `SET_MEDIUM_TEXT`, `SET_LONG_TEXT` |
| Définir une cellule interactive | `SET_CELL_TYPE`                                      |

## DDIC ET SÉMANTIQUE

Lorsque les champs de la table interne sont typés à partir du Dictionary ABAP, SALV peut récupérer davantage d’informations : libellés, type de données, référence de devise ou d’unité. Une structure locale non référencée au DDIC oblige souvent à compléter manuellement ces propriétés.

## COLONNES TECHNIQUES

Une colonne technique est exclue de l’ensemble de colonnes manipulables par l’utilisateur. Une colonne seulement invisible peut généralement être réaffichée via la personnalisation.

Utiliser une colonne technique pour une donnée exclusivement interne, jamais pour masquer une information sensible sans contrôle d’autorisation.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA:
  lo_columns TYPE REF TO cl_salv_columns_table,
  lo_column  TYPE REF TO cl_salv_column_table.

lo_columns = go_alv->get_columns( ).
lo_columns->set_optimize( abap_true ).

TRY.
    lo_column ?= lo_columns->get_column( 'PRICE' ).
    lo_column->set_short_text( 'Prix' ).
    lo_column->set_medium_text( 'Prix du vol' ).
    lo_column->set_long_text( 'Prix du vol sélectionné' ).
  CATCH cx_salv_not_found.
ENDTRY.
```

## TERMES DU LEXIQUE

- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Columns (General) — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1e9df087c2b91e10000000a42189d.html)
- [Displaying Interactive Elements — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1afd0087c2b91e10000000a42189d.html)


---

[Chapitre suivant — TRI, FILTRES, TOTAUX ET AGRÉGATIONS SALV](<./06 ├── TRI FILTRES TOTAUX ET AGREGATIONS SALV.md>)
