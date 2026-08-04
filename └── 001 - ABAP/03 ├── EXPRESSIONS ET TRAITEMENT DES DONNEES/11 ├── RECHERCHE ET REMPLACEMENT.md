# RECHERCHE ET REMPLACEMENT

## OBJECTIFS

- Rechercher une sous-chaîne avec `FIND`
- Récupérer le nombre, la position et la longueur des occurrences
- Remplacer une ou plusieurs occurrences avec `REPLACE`
- Utiliser les fonctions de recherche dans une expression
- Distinguer recherche littérale, motif simple et expression régulière

## FIND

Recherche simple :

```abap
DATA lv_text TYPE string VALUE `Développement ABAP sur SAP GUI`.
DATA lv_offset TYPE i.

FIND FIRST OCCURRENCE OF `ABAP`
  IN lv_text
  MATCH OFFSET lv_offset.
```

Après succès, `lv_offset` contient la position du début de la correspondance.

## PREMIÈRE OU TOUTES LES OCCURRENCES

```abap
DATA lv_text  TYPE string VALUE `ABAP SAP ABAP`.
DATA lv_count TYPE i.

FIND ALL OCCURRENCES OF `ABAP`
  IN lv_text
  MATCH COUNT lv_count.
```

`lv_count` vaut `2`.

Options fréquentes :

- `FIRST OCCURRENCE OF` ;
- `ALL OCCURRENCES OF` ;
- `IGNORING CASE` ;
- `MATCH OFFSET` ;
- `MATCH LENGTH` ;
- `MATCH COUNT` ;
- `RESULTS` pour récupérer plusieurs résultats.

## SY-SUBRC APRÈS FIND

Après une recherche classique :

| `sy-subrc` | Signification générale |
| ---------: | ---------------------- |
|        `0` | Correspondance trouvée |
|        `4` | Aucune correspondance  |

```abap
FIND FIRST OCCURRENCE OF `ABAP` IN lv_text.

IF sy-subrc = 0.
  WRITE / 'Texte trouvé'.
ENDIF.
```

Lorsque le résultat est directement exploité dans une expression, les fonctions de chaîne peuvent être plus lisibles.

## FONCTIONS DE RECHERCHE

```abap
DATA(lv_contains) = contains( val = lv_text sub = `ABAP` ).
DATA(lv_count)    = count( val = lv_text sub = `ABAP` ).
DATA(lv_offset)   = find( val = lv_text sub = `ABAP` ).
```

Autres fonctions utiles :

```abap
DATA(lv_before) = substring_before( val = lv_text sub = `ABAP` ).
DATA(lv_after)  = substring_after( val = lv_text sub = `ABAP` ).
```

## REPLACE

Remplacer la première occurrence :

```abap
DATA lv_text TYPE string VALUE `ABAP sur Eclipse`.

REPLACE FIRST OCCURRENCE OF `Eclipse`
  IN lv_text
  WITH `SAP GUI`.
```

Remplacer toutes les occurrences :

```abap
REPLACE ALL OCCURRENCES OF `-`
  IN lv_text
  WITH `/`.
```

## RÉSULTAT DE REPLACE

`REPLACE` modifie directement l’objet cible. Des compléments permettent de récupérer des informations sur le remplacement, notamment le nombre de substitutions selon la forme utilisée.

Pour produire une nouvelle valeur sans modifier la source, utiliser une fonction :

```abap
DATA(lv_new_text) = replace(
  val  = lv_text
  sub  = `SAP`
  with = `S/4HANA` ).
```

Pour toutes les occurrences :

```abap
DATA(lv_new_text) = replace(
  val  = lv_text
  sub  = `SAP`
  with = `S/4HANA`
  occ  = 0 ).
```

Dans les fonctions de chaîne, `occ = 0` désigne généralement toutes les occurrences pour les fonctions qui acceptent ce paramètre. Vérifier la documentation de la fonction utilisée.

## NORMALISATION D’UN CODE

```abap
DATA lv_code TYPE string VALUE ` abap--sap-gui `.

lv_code = to_upper( condense( val = lv_code ) ).
REPLACE ALL OCCURRENCES OF `--` IN lv_code WITH `-`.
SHIFT lv_code LEFT DELETING LEADING space.
SHIFT lv_code RIGHT DELETING TRAILING space.
```

Le traitement doit être aligné sur une règle fonctionnelle explicite. Une succession de remplacements ne constitue pas une validation complète du format.

## CHOIX DE L’OUTIL

| Besoin                               | Outil                               |
| ------------------------------------ | ----------------------------------- |
| Rechercher une sous-chaîne littérale | `FIND` ou `find( )`                 |
| Tester la présence                   | `contains( )`                       |
| Compter                              | `count( )`                          |
| Modifier une variable existante      | `REPLACE`                           |
| Produire une nouvelle chaîne         | `replace( )`                        |
| Rechercher un format complexe        | `FIND PCRE` ou API regex disponible |

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage et les formats externes.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
FIND FIRST OCCURRENCE OF `ABAP` IN lv_text.

IF sy-subrc = 0.
  WRITE / 'Texte trouvé'.
ENDIF.
```

## TERMES DU LEXIQUE

- [Instruction ABAP](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## RÉFÉRENCES OFFICIELLES SAP

- [FIND — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFIND_OPTIONS.html)
- [REPLACE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREPLACE_PATTERN.html)
- [count, find, and match — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTRING_FUNCTION_FIND_ABEXA.html)


---

[Chapitre suivant — EXPRESSIONS RÉGULIÈRES](<./12 ├── EXPRESSIONS REGULIERES.md>)
