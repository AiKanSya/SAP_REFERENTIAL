# 🌸 AFFECTATIONS ET OPÉRATEURS D’AFFECTATION

## 🌺 OBJECTIFS

- Affecter une valeur à un objet de données
- Distinguer affectation compatible et affectation avec conversion
- Comprendre le rôle du type cible
- Utiliser les formes d’affectation adaptées à la version ABAP
- Éviter les troncatures et pertes de précision silencieuses

## 🌺 AFFECTATION SIMPLE

L’opérateur `=` affecte la valeur de l’opérande source à l’objet cible.

```abap
DATA lv_source TYPE i VALUE 25.
DATA lv_target TYPE i.

lv_target = lv_source.
```

```mermaid
flowchart LR
    A["Valeur source"] --> B["Contrôle de compatibilité"]
    B --> C["Conversion éventuelle"]
    C --> D["Objet cible"]
```

Le type de la cible détermine la représentation finale de la valeur.

## 🌺 AFFECTATION ENTRE TYPES IDENTIQUES

Lorsque les types sont identiques, la valeur est transférée sans conversion de type.

```abap
DATA lv_text_1 TYPE string VALUE `ABAP`.
DATA lv_text_2 TYPE string.

lv_text_2 = lv_text_1.
```

Pour une structure, une affectation complète exige des types compatibles :

```abap
TYPES: BEGIN OF ty_address,
         city    TYPE c LENGTH 30,
         country TYPE c LENGTH 3,
       END OF ty_address.

DATA ls_source TYPE ty_address.
DATA ls_target TYPE ty_address.

ls_source-city    = 'Paris'.
ls_source-country = 'FRA'.

ls_target = ls_source.
```

## 🌺 AFFECTATION AVEC CONVERSION

Lorsque les types diffèrent, ABAP peut effectuer une conversion implicite selon les règles d’affectation.

```abap
DATA lv_number TYPE i VALUE 42.
DATA lv_text   TYPE c LENGTH 10.

lv_text = lv_number.
```

La valeur est convertie vers le format de la cible.

> [!WARNING]
> Une affectation syntaxiquement valide peut modifier la représentation, supprimer des caractères, arrondir une valeur ou provoquer une exception d’exécution. Les conversions importantes doivent être explicites.

## 🌺 AFFECTER UNE MÊME VALEUR À PLUSIEURS OBJETS

Chaque affectation reste une instruction distincte :

```abap
DATA lv_a TYPE i.
DATA lv_b TYPE i.
DATA lv_c TYPE i.

lv_a = 10.
lv_b = 10.
lv_c = 10.
```

Cette forme est explicite et permet de placer un point d’arrêt sur chaque affectation.

## 🌺 OPÉRATEURS D’AFFECTATION COMPOSÉS

Les versions ABAP récentes proposent des opérateurs qui combinent calcul et affectation :

```abap
lv_counter += 1.
lv_total   += lv_amount.
lv_balance -= lv_payment.
lv_factor  *= 2.
lv_average /= 2.
```

Ils correspondent conceptuellement à :

```abap
lv_counter = lv_counter + 1.
```

> [!NOTE]
> La disponibilité exacte de ces opérateurs dépend de la version du serveur ABAP. Sur un système plus ancien, utiliser l’affectation classique ou les instructions `ADD`, `SUBTRACT`, `MULTIPLY` et `DIVIDE`.

## 🌺 INSTRUCTIONS D’AFFECTATION HISTORIQUES

```abap
ADD      1         TO   lv_counter.
SUBTRACT lv_payment FROM lv_balance.
MULTIPLY lv_factor  BY   2.
DIVIDE   lv_average BY   2.
```

Ces instructions restent présentes dans le langage classique. Pour du nouveau code, une expression explicite avec `=` est généralement plus homogène avec le reste du langage.

## 🌺 INITIALISATION ET RÉINITIALISATION

Une affectation directe positionne une valeur précise :

```abap
lv_counter = 0.
```

`CLEAR` replace un objet de données à sa valeur initiale dépendant de son type :

```abap
CLEAR lv_counter.
CLEAR ls_address.
```

Ne pas confondre :

- **valeur initiale du type** ;
- **valeur métier par défaut**.

Pour une valeur métier, utiliser une constante ou une affectation explicite.

## 🌺 BONNES PRATIQUES

- Vérifier le type de la source et de la cible.
- Ne pas utiliser une conversion implicite pour masquer une incohérence de modèle de données.
- Utiliser `CONV` pour annoncer une conversion intentionnelle.
- Utiliser `EXACT` lorsque toute perte d’information doit être refusée.
- Fractionner une affectation complexe si sa valeur intermédiaire doit être contrôlée.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage et les formats externes.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TYPES: BEGIN OF ty_address,
         city    TYPE c LENGTH 30,
         country TYPE c LENGTH 3,
       END OF ty_address.

DATA ls_source TYPE ty_address.
DATA ls_target TYPE ty_address.

ls_source-city    = 'Paris'.
ls_source-country = 'FRA'.

ls_target = ls_source.
```

## 🌺 TERMES DU LEXIQUE

- [Instruction ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Assignments — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENVALUE_ASSIGNMENTS.html)
- [=, Arithmetic Expression — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEQUALS_ARITH_EXPR.html)
- [Processing Data — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/processing-data_b025c9e3-697d-423f-977a-43b9051a7c15)


---

➡️ [Chapitre suivant — CALCULS ARITHMÉTIQUES](<./03 - 🍧 CALCULS ARITHMETIQUES.md>)
