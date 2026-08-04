# VARIABLES AVEC `DATA`

## OBJECTIFS

- Déclarer une variable avec l’instruction `DATA`
- Choisir entre un type intégré, local ou global
- Initialiser explicitement une variable
- Comprendre la différence entre déclaration et affectation
- Appliquer des conventions de nommage utiles sans les confondre avec la syntaxe ABAP

## DÉCLARATION DE BASE

```abap
DATA lv_counter TYPE i.
```

Cette instruction :

1. crée une variable nommée `lv_counter` ;
2. lui attribue le type `i` ;
3. lui affecte la valeur initiale du type, soit `0`.

La syntaxe générale est :

```abap
DATA variable TYPE type.
```

## INITIALISATION

```abap
DATA lv_counter TYPE i VALUE 1.
DATA lv_text    TYPE string VALUE `Début du traitement`.
```

`VALUE` fournit une valeur lors de la création de la variable.

Une affectation ultérieure reste possible :

```abap
lv_counter = lv_counter + 1.
lv_text    = `Traitement terminé`.
```

## SOURCES DE TYPAGE

### TYPE INTÉGRÉ

```abap
DATA lv_index TYPE i.
DATA lv_name  TYPE c LENGTH 40.
```

### TYPE LOCAL

```abap
TYPES ty_status TYPE c LENGTH 1.

DATA lv_status TYPE ty_status.
```

### TYPE DU DICTIONNAIRE ABAP

```abap
DATA lv_company_code TYPE bukrs.
```

`bukrs` est un exemple de type global fourni par le Dictionnaire ABAP. Son utilisation doit correspondre à la sémantique réelle de la variable.

### TYPE PUBLIC D’UNE CLASSE

```abap
DATA ls_result TYPE zcl_demo_service=>ty_result.
```

Ce type n’est accessible que si la classe existe et si le type est déclaré dans une section visible.

## PLUSIEURS VARIABLES

La syntaxe chaînée est possible :

```abap
DATA:
  lv_count TYPE i,
  lv_text  TYPE string.
```

La forme non chaînée est souvent plus facile à modifier et à commenter :

```abap
DATA lv_count TYPE i.
DATA lv_text  TYPE string.
```

La convention retenue dépend du projet. La syntaxe chaînée n’apporte aucune différence fonctionnelle aux objets créés.

## AFFECTATION

L’opérateur `=` affecte une valeur compatible à une variable.

```abap
DATA lv_total TYPE i.

lv_total = 10.
lv_total = lv_total + 5.
```

Une conversion peut être effectuée implicitement lorsque les types sont compatibles. Une conversion implicite peut néanmoins entraîner :

- troncature ;
- arrondi ;
- perte de zéros initiaux ;
- exception de conversion ;
- résultat dépendant des règles de conversion ABAP.

Les conversions explicites seront détaillées dans le dossier consacré aux expressions et traitements de données.

## NOMMAGE

Les préfixes tels que `lv_`, `ls_` ou `lr_` sont des conventions fréquentes, pas des mots-clés ABAP.

| Préfixe courant | Intention habituelle        |
| --------------- | --------------------------- |
| `lv_`           | Variable locale élémentaire |
| `ls_`           | Structure locale            |
| `lr_`           | Référence locale            |
| `gv_`           | Variable globale            |
| `gs_`           | Structure globale           |

> [!IMPORTANT]
> Le nom doit d’abord exprimer la responsabilité métier ou technique. Un préfixe ne compense pas un nom vague comme `lv_data`, `lv_var` ou `lv_temp`.

## DÉCLARATION AU PLUS PRÈS DE L’USAGE

Dans une procédure, déclarer une variable au plus près de son premier usage réduit la zone de code dans laquelle elle doit être comprise.

```abap
METHOD calculate_total.
  DATA lv_total TYPE decfloat34.

  lv_total = iv_net_amount + iv_tax_amount.
  rv_total = lv_total.
ENDMETHOD.
```

Dans les programmes classiques, une déclaration placée dans la partie globale augmente la portée de la variable et les risques de dépendance entre blocs de traitement.

## EXEMPLE COMPLET

```abap
REPORT zdemo_data_statement.

TYPES ty_percentage TYPE p LENGTH 3 DECIMALS 2.

DATA lv_net_amount TYPE p LENGTH 8 DECIMALS 2 VALUE '100.00'.
DATA lv_tax_rate   TYPE ty_percentage VALUE '0.20'.
DATA lv_tax_amount TYPE p LENGTH 8 DECIMALS 2.
DATA lv_total      TYPE p LENGTH 8 DECIMALS 2.

lv_tax_amount = lv_net_amount * lv_tax_rate.
lv_total      = lv_net_amount + lv_tax_amount.

WRITE: / 'Montant net :', lv_net_amount,
       / 'Taxe        :', lv_tax_amount,
       / 'Total       :', lv_total.
```

Dans une application réelle, les montants et devises doivent être typés avec les objets métier adaptés du Dictionnaire ABAP.

## ERREURS FRÉQUENTES

| Erreur                                                | Correction                                        |
| ----------------------------------------------------- | ------------------------------------------------- |
| Déclarer toutes les données globalement               | Limiter la portée aux procédures lorsque possible |
| Utiliser un type technique sans sémantique métier     | Réutiliser le type global approprié               |
| Donner une longueur insuffisante                      | Vérifier la capacité avant affectation            |
| Réutiliser une variable pour plusieurs significations | Créer des variables distinctes et explicites      |
| Confondre `VALUE` et constante                        | Utiliser `CONSTANTS` pour une valeur immuable     |

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT zdemo_data_statement.

TYPES ty_percentage TYPE p LENGTH 3 DECIMALS 2.

DATA lv_net_amount TYPE p LENGTH 8 DECIMALS 2 VALUE '100.00'.
DATA lv_tax_rate   TYPE ty_percentage VALUE '0.20'.
DATA lv_tax_amount TYPE p LENGTH 8 DECIMALS 2.
DATA lv_total      TYPE p LENGTH 8 DECIMALS 2.

lv_tax_amount = lv_net_amount * lv_tax_rate.
lv_total      = lv_net_amount + lv_tax_amount.

WRITE: / 'Montant net :', lv_net_amount,
       / 'Taxe        :', lv_tax_amount,
       / 'Total       :', lv_total.
```

## TERMES DU LEXIQUE

- [Type de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)
- [Objet de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>)
- [Structure](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [DATA — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDATA.html)
- [DATA, TYPE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDATA_SIMPLE.html)
- [Descriptive Names — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENTELLING_NAMES_GUIDL.html)


---

[Chapitre suivant — CONSTANTES ET LITTÉRAUX](<./05 ├── CONSTANTES ET LITTERAUX.md>)
