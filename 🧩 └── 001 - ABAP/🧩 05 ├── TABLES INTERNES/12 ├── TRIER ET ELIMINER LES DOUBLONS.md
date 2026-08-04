# TRIER ET ÉLIMINER LES DOUBLONS

## RÉSULTAT ATTENDU

- Trier une table standard selon un ou plusieurs composants
- Comprendre le comportement des tables triées
- Utiliser `STABLE` lorsque l’ordre relatif doit être conservé
- Supprimer les doublons adjacents
- Éviter la suppression incorrecte de doublons non regroupés

## SORT

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
SORT lt_products BY category ASCENDING
                    stock    DESCENDING
                    matnr    ASCENDING.
```

Pour une table standard, `SORT` réorganise les lignes selon les composants indiqués.

## TRI PAR CLÉ

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
SORT lt_products BY matnr.
```

Une table triée est déjà maintenue selon sa clé primaire. Un `SORT` qui contredit cet ordre n’est pas le mécanisme normal de traitement de cette catégorie.

## TRI STABLE

```abap
SORT lt_products STABLE BY category.
```

`STABLE` conserve l’ordre relatif des lignes ayant la même valeur pour les critères de tri.

## SUPPRIMER LES DOUBLONS ADJACENTS

```abap
SORT lt_products BY matnr.
DELETE ADJACENT DUPLICATES FROM lt_products
  COMPARING matnr.
```

L’instruction ne compare que des lignes adjacentes. Il faut donc trier préalablement la table selon les composants utilisés pour la comparaison.

```mermaid
flowchart LR
    A["Lignes non ordonnées"] --> B["SORT BY composants"]
    B --> C["Doublons regroupés"]
    C --> D["DELETE ADJACENT DUPLICATES"]
    D --> E["Une occurrence conservée"]
```

## COMPARING

```abap
DELETE ADJACENT DUPLICATES FROM lt_products
  COMPARING matnr category.
```

Deux lignes sont considérées comme identiques pour cette opération lorsque les composants indiqués sont égaux.

Sans liste explicite, la comparaison dépend de la variante de l’instruction et du type de table. Une liste `COMPARING` explicite rend l’intention plus claire.

## EXEMPLE COMPLET

```abap
DATA lt_materials TYPE STANDARD TABLE OF string
                  WITH EMPTY KEY.

lt_materials = VALUE #(
  ( 'MAT-002' )
  ( 'MAT-001' )
  ( 'MAT-002' )
  ( 'MAT-003' )
  ( 'MAT-001' ) ).

SORT lt_materials BY table_line.
DELETE ADJACENT DUPLICATES FROM lt_materials
  COMPARING table_line.
```

## ALTERNATIVE PAR CLÉ UNIQUE

Lorsque l’unicité doit être garantie dès l’alimentation, utiliser une table triée ou hachée à clé unique.

```abap
DATA lt_materials_unique TYPE SORTED TABLE OF string
                         WITH UNIQUE KEY table_line.
```

Cette conception évite de construire des doublons pour les supprimer ensuite.

## CHOIX DE LA TECHNIQUE

| Besoin                                 | Technique                                |
| -------------------------------------- | ---------------------------------------- |
| Réordonner une liste existante         | `SORT`                                   |
| Conserver l’ordre relatif des égalités | `SORT STABLE`                            |
| Nettoyer une table existante           | `SORT` puis `DELETE ADJACENT DUPLICATES` |
| Interdire les doublons dès l’origine   | Clé unique                               |

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
DATA lt_materials TYPE STANDARD TABLE OF string
                  WITH EMPTY KEY.

lt_materials = VALUE #(
  ( 'MAT-002' )
  ( 'MAT-001' )
  ( 'MAT-002' )
  ( 'MAT-003' )
  ( 'MAT-001' ) ).

SORT lt_materials BY table_line.
DELETE ADJACENT DUPLICATES FROM lt_materials
  COMPARING table_line.
```

## TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [Processing the Contents of Internal Tables — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/processing-the-contents-of-internal-tables_b69864af-3b88-4887-83c8-7ac6701add94)
- [Sorting Table Content — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-concepts/sorting-table-content)
- [SORT itab — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSORT_ITAB.html)
- [DELETE ADJACENT DUPLICATES — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_DUPLICATES.html)


---

[Chapitre suivant — CONSTRUIRE ET TRANSFORMER AVEC VALUE, FOR ET CORRESPONDING](<./13 ├── CONSTRUIRE ET TRANSFORMER AVEC VALUE FOR ET CORRESPONDING.md>)
