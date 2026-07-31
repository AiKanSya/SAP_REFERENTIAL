# 🌸 TYPES LOCAUX AVEC `TYPES`

## 🌺 OBJECTIFS

- Définir un type local réutilisable avec `TYPES`
- Distinguer définition de type et création d’un objet de données
- Construire des types élémentaires et structurés
- Comprendre la portée d’un type local
- Choisir entre type local et type global du Dictionnaire ABAP

## 🌺 `TYPES` NE CRÉE PAS DE VARIABLE

```abap
TYPES ty_customer_id TYPE c LENGTH 10.
```

Cette instruction définit un type nommé `ty_customer_id`. Elle ne réserve pas de zone de données et ne contient aucune valeur.

Pour créer une variable :

```abap
DATA lv_customer_id TYPE ty_customer_id.
```

```mermaid
flowchart LR
    A["TYPES ty_customer_id"] --> B["Définition locale"]
    B --> C["DATA lv_customer_id TYPE ty_customer_id"]
    B --> D["DATA lv_payer_id TYPE ty_customer_id"]
```

## 🌺 TYPE ÉLÉMENTAIRE LOCAL

```abap
TYPES ty_percentage TYPE p LENGTH 3 DECIMALS 2.

DATA lv_discount_rate TYPE ty_percentage.
DATA lv_tax_rate      TYPE ty_percentage.
```

L’intérêt est de centraliser une définition technique utilisée plusieurs fois dans la même zone de visibilité.

## 🌺 TYPE BASÉ SUR UN TYPE GLOBAL

```abap
TYPES ty_company_code TYPE bukrs.
```

Cet alias local peut améliorer la lisibilité dans certains contextes, mais il ne faut pas multiplier les alias qui masquent inutilement le type métier global.

## 🌺 TYPE STRUCTURÉ LOCAL

```abap
TYPES:
  BEGIN OF ty_employee,
    id        TYPE i,
    first_name TYPE c LENGTH 30,
    last_name  TYPE c LENGTH 30,
  END OF ty_employee.
```

Puis :

```abap
DATA ls_employee TYPE ty_employee.
```

Les composants de la structure sont accessibles avec le tiret :

```abap
ls_employee-id         = 1.
ls_employee-first_name = 'Ada'.
ls_employee-last_name  = 'Lovelace'.
```

## 🌺 TYPES IMBRIQUÉS

```abap
TYPES:
  BEGIN OF ty_address,
    city    TYPE c LENGTH 40,
    country TYPE c LENGTH 3,
  END OF ty_address.

TYPES:
  BEGIN OF ty_customer,
    id      TYPE c LENGTH 10,
    name    TYPE c LENGTH 60,
    address TYPE ty_address,
  END OF ty_customer.
```

Accès à un composant imbriqué :

```abap
DATA ls_customer TYPE ty_customer.

ls_customer-address-city = 'Paris'.
```

## 🌺 PORTÉE

Un type déclaré dans la partie globale d’un programme est utilisable dans les blocs de traitement et procédures de ce programme.

Un type déclaré dans une procédure n’est utilisable que dans cette procédure.

```abap
FORM display_value.
  TYPES ty_local_text TYPE c LENGTH 20.
  DATA lv_text TYPE ty_local_text.

  lv_text = 'Valeur locale'.
  WRITE / lv_text.
ENDFORM.
```

Pour une classe locale ou globale, la visibilité dépend de la section et de l’emplacement de la déclaration.

## 🌺 TYPE LOCAL OU DICTIONNAIRE ABAP

| Besoin                                       | Choix généralement adapté                               |
| -------------------------------------------- | ------------------------------------------------------- |
| Type utilisé uniquement dans une procédure   | Type local                                              |
| Structure technique interne à un programme   | Type local                                              |
| Type partagé par plusieurs objets Repository | Dictionnaire ABAP ou type public d’une classe/interface |
| Donnée métier SAP existante                  | Réutilisation du type global approprié                  |
| Champ d’interface RFC, table ou écran        | Type global selon les contraintes de l’interface        |

> [!IMPORTANT]
> Ne créer un type global que lorsqu’un partage réel ou une sémantique globale le justifie. Un type global devient un contrat utilisé par d’autres objets.

## 🌺 TYPES TABULAIRES

`TYPES` permet également de définir des types de tables internes :

```abap
TYPES ty_texts TYPE STANDARD TABLE OF string WITH EMPTY KEY.
```

Cette syntaxe est indiquée ici pour situer le rôle de `TYPES`. Les catégories de tables, les clés et les opérations associées seront traitées dans le dossier consacré aux tables internes.

## 🌺 CONVENTIONS DE NOMMAGE

Les préfixes suivants sont fréquents :

| Préfixe      | Usage courant                                          |
| ------------ | ------------------------------------------------------ |
| `ty_`        | Type local                                             |
| `ts_`        | Type de structure                                      |
| `tt_`        | Type de table                                          |
| `ty_` unique | Convention simplifiée recommandée par certains projets |

Aucun de ces préfixes n’est imposé par le langage. Le projet doit appliquer une convention homogène.

## 🌺 EXEMPLE COMPLET

```abap
REPORT zdemo_local_types.

TYPES ty_order_id TYPE c LENGTH 10.

TYPES:
  BEGIN OF ty_order_header,
    order_id TYPE ty_order_id,
    status   TYPE c LENGTH 1,
    amount   TYPE p LENGTH 8 DECIMALS 2,
  END OF ty_order_header.

DATA ls_order TYPE ty_order_header.

ls_order-order_id = '4500000010'.
ls_order-status   = 'N'.
ls_order-amount   = '125.50'.

WRITE: / ls_order-order_id,
         ls_order-status,
         ls_order-amount.
```

## 🌺 CAS D’USAGE

Dans un contexte où un programme de contrôle manipule des identifiants, montants, dates, statuts et structures dont le typage doit rester explicite, le besoin consiste à **déclarer et utiliser types locaux avec `types` avec un typage explicite dans un programme ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir un type trop générique ou dépendant d’une variable existante sans justification.
- Utiliser une référence ou un field-symbol non lié.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT zdemo_local_types.

TYPES ty_order_id TYPE c LENGTH 10.

TYPES:
  BEGIN OF ty_order_header,
    order_id TYPE ty_order_id,
    status   TYPE c LENGTH 1,
    amount   TYPE p LENGTH 8 DECIMALS 2,
  END OF ty_order_header.

DATA ls_order TYPE ty_order_header.

ls_order-order_id = '4500000010'.
ls_order-status   = 'N'.
ls_order-amount   = '125.50'.

WRITE: / ls_order-order_id,
         ls_order-status,
         ls_order-amount.
```

## 🌺 TERMES DU LEXIQUE

- [Type de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)
- [Objet de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>)
- [Structure](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **déclarer et utiliser types locaux avec `types` avec un typage explicite dans un programme ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [TYPES — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTYPES.html)
- [Declaration of Local Data Types — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-concepts/declaration-of-local-data-types)
- [Bound and Standalone Data Types — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENBOUND_INDEPENDENT_DTYPE_GUIDL.html)


---

➡️ [Chapitre suivant — STRUCTURES](<./07 - 🍧 STRUCTURES.md>)
