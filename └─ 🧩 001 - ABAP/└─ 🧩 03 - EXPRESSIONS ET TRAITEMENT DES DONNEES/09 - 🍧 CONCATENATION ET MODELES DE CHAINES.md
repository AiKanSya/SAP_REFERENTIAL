# 🌸 CONCATÉNATION ET MODÈLES DE CHAÎNES

## 🌺 OBJECTIFS

- Concaténer plusieurs valeurs
- Utiliser `CONCATENATE` et l’opérateur `&&`
- Construire un texte avec un modèle de chaîne
- Formater une valeur intégrée dans un texte
- Choisir une forme lisible et compatible avec la version ABAP

## 🌺 INSTRUCTION CONCATENATE

```abap
DATA lv_first_name TYPE string VALUE `Ada`.
DATA lv_last_name  TYPE string VALUE `Lovelace`.
DATA lv_full_name  TYPE string.

CONCATENATE lv_first_name lv_last_name
       INTO lv_full_name
       SEPARATED BY space.
```

Résultat :

```text
Ada Lovelace
```

`CONCATENATE` reste utile dans le code classique et permet une séparation explicite.

## 🌺 OPÉRATEUR &&

```abap
lv_full_name = lv_first_name && ` ` && lv_last_name.
```

L’opérateur `&&` produit une expression de chaîne.

Pour une concaténation simple, cette forme est compacte. Pour une phrase comportant plusieurs valeurs et formats, utiliser un modèle de chaîne.

## 🌺 MODÈLES DE CHAÎNES

Un modèle de chaîne est délimité par `|`.

```abap
DATA lv_name TYPE string VALUE `Ada`.
DATA lv_message TYPE string.

lv_message = |Bonjour { lv_name }|.
```

Une expression embarquée est placée entre accolades.

```mermaid
flowchart LR
    A["Texte statique"] --> D["Modèle de chaîne"]
    B["Objet de données"] --> D
    C["Option de formatage"] --> D
    D --> E["Valeur string"]
```

## 🌺 EXPRESSIONS EMBARQUÉES

```abap
DATA lv_quantity TYPE i VALUE 3.
DATA lv_price    TYPE p LENGTH 8 DECIMALS 2 VALUE '12.50'.

DATA(lv_message) = |Quantité : { lv_quantity }, prix : { lv_price }|.
```

Une expression peut être utilisée :

```abap
DATA(lv_total_text) = |Total : { lv_quantity * lv_price }|.
```

Pour un calcul métier important, conserver le résultat dans une variable avant le formatage.

## 🌺 FORMATAGE

Exemples d’options :

```abap
DATA(lv_date_text) = |{ sy-datum DATE = USER }|.
DATA(lv_number_text) = |{ lv_price NUMBER = USER }|.
DATA(lv_left) = |{ lv_name WIDTH = 20 ALIGN = LEFT }|.
```

Les options d’affichage ne modifient pas la valeur source.

> [!IMPORTANT]
> Une chaîne formatée pour l’utilisateur ne doit pas être réutilisée comme valeur technique destinée à une interface ou à un calcul.

## 🌺 CARACTÈRES DE CONTRÔLE

Les modèles de chaînes permettent d’insérer des caractères de contrôle :

```abap
DATA(lv_multiline) = |Ligne 1\nLigne 2|.
```

Selon le contexte de sortie, préférer les constantes prévues par les API utilisées, par exemple `cl_abap_char_utilities=>newline`, lorsque le consommateur attend une séquence précise.

```abap
DATA(lv_multiline) = |Ligne 1{ cl_abap_char_utilities=>newline }Ligne 2|.
```

## 🌺 CONVERSION ALPHA DANS UN MODÈLE

Pour un champ utilisant la conversion ALPHA :

```abap
DATA lv_customer TYPE kunnr VALUE '0000123456'.
DATA(lv_external) = |{ lv_customer ALPHA = OUT }|.
```

La conversion inverse peut être appliquée avec `ALPHA = IN` lorsque le contexte le justifie.

## 🌺 CHOIX DE LA TECHNIQUE

| Cas                                         | Technique                                                   |
| ------------------------------------------- | ----------------------------------------------------------- |
| Code classique simple                       | `CONCATENATE`                                               |
| Deux ou trois fragments sans formatage      | `&&`                                                        |
| Message comprenant plusieurs valeurs        | Modèle de chaîne                                            |
| Formatage de date, nombre ou identifiant    | Modèle de chaîne avec option                                |
| Construction d’un format d’interface strict | API ou sérialiseur adapté, pas une concaténation improvisée |

## 🌺 CAS D’USAGE

Dans un contexte où une interface reçoit des valeurs texte qu’elle doit convertir, comparer, nettoyer et reformater avant traitement, le besoin consiste à **traiter une valeur au moyen de concaténation et modèles de chaînes sans conversion ou perte de données involontaire**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage et les formats externes.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_quantity TYPE i VALUE 3.
DATA lv_price    TYPE p LENGTH 8 DECIMALS 2 VALUE '12.50'.

DATA(lv_message) = |Quantité : { lv_quantity }, prix : { lv_price }|.
```

## 🌺 TERMES DU LEXIQUE

- [Instruction ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **traiter une valeur au moyen de concaténation et modèles de chaînes sans conversion ou perte de données involontaire**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [String Expressions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTRING_EXPRESSIONS.html)
- [String Templates — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTRING_TEMPLATES.html)
- [Character String Processing in ABAP Release 7.40 — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENNEWS-740-CHARACTER_PROCESSING.html)


---

➡️ [Chapitre suivant — ACCÈS PAR OFFSET ET LONGUEUR](<./10 - 🍧 ACCES PAR OFFSET ET LONGUEUR.md>)
