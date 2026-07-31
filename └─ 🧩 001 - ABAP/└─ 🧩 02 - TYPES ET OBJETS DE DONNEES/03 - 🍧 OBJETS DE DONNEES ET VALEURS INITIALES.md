# 🌸 OBJETS DE DONNÉES ET VALEURS INITIALES

## 🌺 OBJECTIFS

- Identifier les différentes formes d’objets de données
- Distinguer objet nommé, littéral et objet anonyme
- Comprendre la valeur initiale associée à un type
- Réinitialiser proprement un objet avec `CLEAR`
- Éviter les tests basés sur une représentation externe trompeuse

## 🌺 DÉFINITION

Un objet de données contient ou représente une valeur pendant l’exécution d’un programme ABAP. Son type définit les valeurs possibles et les opérations applicables.

```mermaid
flowchart TD
    A["Objets de données"] --> B["Objets nommés"]
    A --> C["Littéraux"]
    A --> D["Objets anonymes"]
    B --> E["Variables"]
    B --> F["Constantes"]
    D --> G["Créés dynamiquement"]
```

## 🌺 OBJETS NOMMÉS

Les variables et les constantes possèdent un nom utilisable dans le code.

```abap
DATA lv_status TYPE c LENGTH 1 VALUE 'A'.
CONSTANTS lc_active TYPE c LENGTH 1 VALUE 'A'.
```

- `lv_status` peut être modifiée ;
- `lc_active` ne peut pas être modifiée après sa déclaration.

Les paramètres d’interface, les paramètres d’écran de sélection et les attributs de classes sont également des objets de données nommés, mais ils seront détaillés dans leurs contextes respectifs.

## 🌺 LITTÉRAUX

Un littéral représente une valeur directement écrite dans le code.

```abap
DATA lv_count TYPE i.

lv_count = 10.
WRITE / 'Traitement terminé'.
```

Dans cet exemple :

- `10` est un littéral numérique ;
- `'Traitement terminé'` est un littéral texte de type caractère.

Les littéraux ne doivent pas remplacer les constantes lorsque la valeur porte une signification fonctionnelle ou technique réutilisée.

## 🌺 OBJETS ANONYMES

Un objet anonyme est créé dynamiquement et n’est pas identifié directement par un nom de variable métier. Il est accessible par une référence de données.

```abap
DATA lr_value TYPE REF TO i.

CREATE DATA lr_value.
lr_value->* = 25.
```

L’objet entier créé par `CREATE DATA` est anonyme. `lr_value` contient la référence permettant d’y accéder.

## 🌺 VALEUR INITIALE

Chaque type possède une valeur initiale déterminée par le langage.

```abap
DATA lv_count TYPE i.
DATA lv_text  TYPE c LENGTH 10.
DATA lv_date  TYPE d.
```

Sans addition `VALUE`, les objets reçoivent leur valeur initiale :

| Objet      | Valeur logique initiale |
| ---------- | ----------------------- |
| `lv_count` | `0`                     |
| `lv_text`  | Espaces                 |
| `lv_date`  | `00000000`              |

Une structure est initiale lorsque chacun de ses composants est initial. Une référence initiale ne pointe vers aucun objet.

## 🌺 TEST AVEC `IS INITIAL`

```abap
IF lv_date IS INITIAL.
  WRITE / 'La date n’est pas renseignée'.
ENDIF.
```

`IS INITIAL` compare l’objet à la valeur initiale définie par son type. Il est préférable à des comparaisons techniques dispersées telles que :

```abap
IF lv_date = '00000000'.
```

Le test typé exprime plus clairement l’intention.

## 🌺 RÉINITIALISATION AVEC `CLEAR`

```abap
DATA lv_quantity TYPE i VALUE 12.

CLEAR lv_quantity.
```

Après `CLEAR`, `lv_quantity` vaut `0`.

```abap
TYPES:
  BEGIN OF ty_result,
    code    TYPE i,
    message TYPE string,
  END OF ty_result.

DATA ls_result TYPE ty_result.

ls_result-code    = 4.
ls_result-message = `Erreur`.

CLEAR ls_result.
```

`CLEAR ls_result` remet tous les composants de la structure à leur valeur initiale.

## 🌺 `VALUE` À LA DÉCLARATION

```abap
DATA lv_retries TYPE i VALUE 3.
```

L’addition `VALUE` définit la valeur reçue lors de la création de l’objet. Elle ne rend pas la variable constante.

```abap
lv_retries = 5.
```

Cette affectation reste autorisée.

Pour imposer l’absence de modification, utiliser `CONSTANTS` lorsque la valeur est connue statiquement.

## 🌺 ÉTAT INITIAL ET VALEUR MÉTIER

Une valeur initiale technique ne signifie pas toujours « donnée absente » au niveau fonctionnel.

Exemples :

- `0` peut être une quantité métier valide ;
- une chaîne vide peut être autorisée ;
- une date initiale peut signifier « non renseignée » selon l’interface ;
- une structure initiale peut être différente d’une structure fonctionnellement incomplète.

Le contrôle métier doit donc être défini explicitement.

## 🌺 EXEMPLE COMPLET

```abap
REPORT zdemo_data_objects.

CONSTANTS lc_max_retries TYPE i VALUE 3.

DATA lv_retry_count TYPE i.
DATA lv_message     TYPE string VALUE `Prêt`.

IF lv_retry_count IS INITIAL.
  lv_retry_count = 1.
ENDIF.

WRITE: / lv_message,
       / 'Tentative :', lv_retry_count,
       / 'Maximum   :', lc_max_retries.

CLEAR: lv_retry_count, lv_message.
```

La forme chaînée de `CLEAR` est valide. Dans du code professionnel, des instructions séparées peuvent être préférées lorsqu’elles facilitent la lecture ou le débogage.

## 🌺 CAS D’USAGE

Dans un contexte où un programme de contrôle manipule des identifiants, montants, dates, statuts et structures dont le typage doit rester explicite, le besoin consiste à **répéter un traitement un nombre connu ou borné de fois**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
REPORT zdemo_data_objects.

CONSTANTS lc_max_retries TYPE i VALUE 3.

DATA lv_retry_count TYPE i.
DATA lv_message     TYPE string VALUE `Prêt`.

IF lv_retry_count IS INITIAL.
  lv_retry_count = 1.
ENDIF.

WRITE: / lv_message,
       / 'Tentative :', lv_retry_count,
       / 'Maximum   :', lc_max_retries.

CLEAR: lv_retry_count, lv_message.
```

## 🌺 TERMES DU LEXIQUE

- [Type de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)
- [Objet de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>)
- [Structure](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **répéter un traitement un nombre connu ou borné de fois**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Data Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDATA_OBJECTS.html)
- [Initial Values — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINITIAL_VALUES.html)
- [CLEAR — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLEAR.html)


---

➡️ [Chapitre suivant — VARIABLES AVEC `DATA`](<./04 - 🍧 VARIABLES AVEC DATA.md>)
