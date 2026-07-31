# 🌸 TYPAGE AVEC `TYPE` ET `LIKE`

## 🌺 OBJECTIFS

- Distinguer `TYPE` de `LIKE`
- Choisir une source de typage explicite
- Comprendre les dépendances créées par `LIKE`
- Utiliser `LENGTH` et `DECIMALS` avec les types compatibles
- Éviter les déclarations techniquement valides mais sémantiquement faibles

## 🌺 `TYPE`

`TYPE` référence un type de données.

```abap
DATA lv_count TYPE i.
```

```abap
TYPES ty_status TYPE c LENGTH 1.
DATA lv_status TYPE ty_status.
```

```abap
DATA lv_company_code TYPE bukrs.
```

Dans ces exemples, la source de typage est respectivement :

- un type intégré ;
- un type local ;
- un type global du Dictionnaire ABAP.

## 🌺 `LIKE`

`LIKE` reprend le type d’un objet de données visible.

```abap
DATA lv_source TYPE p LENGTH 8 DECIMALS 2.
DATA lv_target LIKE lv_source.
```

`lv_target` reçoit les mêmes propriétés techniques que `lv_source`, mais reste un objet distinct avec sa propre valeur.

```mermaid
flowchart LR
    A["lv_source"] -->|fournit son type| B["lv_target"]
    A -. valeur indépendante .- B
```

## 🌺 DIFFÉRENCE PRINCIPALE

| Critère       | `TYPE`                  | `LIKE`                                            |
| ------------- | ----------------------- | ------------------------------------------------- |
| Référence     | Type de données         | Objet de données visible                          |
| Dépendance    | Définition de type      | Déclaration de l’objet source                     |
| Usage métier  | Généralement explicite  | Utile pour reprendre exactement un objet existant |
| Réutilisation | Type nommé réutilisable | Pas de nouveau type autonome                      |

Exemple :

```abap
DATA lv_company_code TYPE bukrs.
DATA lv_copy         LIKE lv_company_code.
```

`lv_copy` dépend techniquement de `lv_company_code`. Pour déclarer plusieurs objets partageant une sémantique, il est souvent plus clair de les typer tous avec `bukrs`.

```abap
DATA lv_company_code TYPE bukrs.
DATA lv_paying_code  TYPE bukrs.
```

## 🌺 `LENGTH`

`LENGTH` complète certains types intégrés dont la longueur doit être indiquée.

```abap
DATA lv_text TYPE c LENGTH 50.
DATA lv_raw  TYPE x LENGTH 16.
```

La longueur doit être compatible avec le type. Elle ne s’ajoute pas aux types dont les propriétés sont déjà entièrement définies par un type global ou local complet.

## 🌺 `DECIMALS`

```abap
DATA lv_amount TYPE p LENGTH 8 DECIMALS 2.
```

`DECIMALS` précise le nombre de décimales pour les types compatibles, notamment `p`.

La longueur doit permettre de contenir :

- les chiffres entiers ;
- les chiffres décimaux ;
- le signe éventuel.

Un choix insuffisant peut entraîner un dépassement arithmétique.

## 🌺 `TYPE LINE OF`

Pour une table interne visible, `TYPE LINE OF` permet de reprendre le type de ligne :

```abap
DATA lt_messages TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_message  TYPE LINE OF lt_messages.
```

Cette forme sera reprise dans le dossier consacré aux tables internes.

## 🌺 `LIKE LINE OF`

```abap
DATA lt_messages TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_message  LIKE LINE OF lt_messages.
```

La déclaration est liée à l’objet table `lt_messages`, alors que `TYPE LINE OF` s’appuie sur son type de ligne déterminé à la déclaration.

## 🌺 CHOIX PRATIQUE

Utiliser préférentiellement `TYPE` lorsque :

- un type métier ou technique précis existe ;
- plusieurs objets doivent partager le même contrat ;
- la déclaration doit rester compréhensible indépendamment d’une autre variable.

Utiliser `LIKE` lorsque :

- il faut reprendre exactement le type d’un objet visible ;
- cette dépendance est volontaire et améliore la maintenance ;
- aucun type nommé plus explicite n’est disponible ou nécessaire.

## 🌺 EXEMPLE

```abap
REPORT zdemo_type_like.

TYPES ty_amount TYPE p LENGTH 8 DECIMALS 2.

DATA lv_net_amount   TYPE ty_amount VALUE '100.00'.
DATA lv_tax_amount   TYPE ty_amount VALUE '20.00'.
DATA lv_total_amount TYPE ty_amount.
DATA lv_copy         LIKE lv_total_amount.

lv_total_amount = lv_net_amount + lv_tax_amount.
lv_copy         = lv_total_amount.

WRITE: / lv_total_amount, lv_copy.
```

`lv_total_amount` exprime explicitement le contrat `ty_amount`. `lv_copy` indique volontairement qu’il reprend le type exact de `lv_total_amount`.

## 🌺 ERREURS FRÉQUENTES

| Erreur                                       | Risque                                     |
| -------------------------------------------- | ------------------------------------------ |
| Utiliser `LIKE` par habitude                 | Dépendances indirectes difficiles à suivre |
| Répliquer partout `TYPE c LENGTH ...`        | Définitions divergentes                    |
| Redéfinir localement un type métier standard | Perte de sémantique et incompatibilités    |
| Sous-dimensionner un type `p`                | Débordement                                |
| Croire que `LIKE` partage la valeur          | Confusion : seul le type est repris        |

## 🌺 CAS D’USAGE

Dans un contexte où un programme de contrôle manipule des identifiants, montants, dates, statuts et structures dont le typage doit rester explicite, le besoin consiste à **déclarer et utiliser typage avec `type` et `like` avec un typage explicite dans un programme ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT zdemo_type_like.

TYPES ty_amount TYPE p LENGTH 8 DECIMALS 2.

DATA lv_net_amount   TYPE ty_amount VALUE '100.00'.
DATA lv_tax_amount   TYPE ty_amount VALUE '20.00'.
DATA lv_total_amount TYPE ty_amount.
DATA lv_copy         LIKE lv_total_amount.

lv_total_amount = lv_net_amount + lv_tax_amount.
lv_copy         = lv_total_amount.

WRITE: / lv_total_amount, lv_copy.
```

## 🌺 TERMES DU LEXIQUE

- [Type de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)
- [Objet de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>)
- [Structure](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **déclarer et utiliser typage avec `type` et `like` avec un typage explicite dans un programme ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Typing with TYPE and LIKE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENTYPE_LIKE.html)
- [DATA, TYPE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDATA_SIMPLE.html)
- [Bound and Standalone Data Types — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENBOUND_INDEPENDENT_DTYPE_GUIDL.html)


---

➡️ [Chapitre suivant — DÉCLARATIONS INLINE ET INFÉRENCE](<./09 - 🍧 DECLARATIONS INLINE ET INFERENCE.md>)
