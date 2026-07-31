# 🌸 CONVERSIONS IMPLICITES

## 🌺 OBJECTIFS

- Comprendre pourquoi ABAP convertit certaines valeurs automatiquement
- Identifier les principaux contextes de conversion
- Reconnaître les pertes de données possibles
- Éviter les conversions dépendantes d’un type cible mal choisi
- Savoir quand rendre une conversion explicite

## 🌺 PRINCIPE

Une conversion implicite intervient lorsqu’une valeur doit être utilisée avec un type différent et qu’ABAP possède une règle de conversion applicable.

```mermaid
flowchart LR
    A[Valeur source] --> B[Contexte typé]
    B --> C[Conversion implicite]
    C --> D[Valeur cible]
```

Contextes fréquents :

- affectation ;
- comparaison ;
- calcul ;
- passage de paramètres ;
- concaténation ou formatage ;
- écriture dans un composant de structure.

## 🌺 CONVERSION LORS D’UNE AFFECTATION

```abap
DATA lv_number TYPE i VALUE 125.
DATA lv_text   TYPE c LENGTH 10.

lv_text = lv_number.
```

Le nombre est converti selon les règles applicables à la cible caractère.

Cas inverse :

```abap
DATA lv_source TYPE c LENGTH 5 VALUE '00125'.
DATA lv_target TYPE i.

lv_target = lv_source.
```

La chaîne doit représenter une valeur convertible en nombre.

## 🌺 RISQUE DE TRONCATURE

```abap
DATA lv_source TYPE string VALUE `ABCDEFGHIJ`.
DATA lv_target TYPE c LENGTH 5.

lv_target = lv_source.
```

La cible ne peut conserver que cinq caractères. Le résultat est `ABCDE`.

> [!WARNING]
> Une perte de caractères peut être techniquement autorisée. Vérifier les longueurs avant l’affectation lorsque la donnée ne doit pas être tronquée.

## 🌺 TEXTE NUMÉRIQUE DE TYPE N

Le type `n` représente un texte numérique, pas un nombre destiné au calcul.

```abap
DATA lv_input TYPE string VALUE `A12B3`.
DATA lv_numc  TYPE n LENGTH 6.

lv_numc = lv_input.
```

Les conversions vers `n` possèdent des règles particulières. Elles peuvent supprimer les caractères non numériques et compléter avec des zéros à gauche. Ce comportement ne doit pas servir à valider une donnée métier.

## 🌺 DATES ET HEURES

Les types `d` et `t` sont techniquement caractère-like, mais certaines opérations leur donnent une sémantique de date ou d’heure.

```abap
DATA lv_date TYPE d.

lv_date = '20260231'.
```

Cette affectation peut placer une représentation techniquement conforme à la longueur, sans garantir une date civile valide dans tous les contextes.

Pour valider ou convertir une date externe, utiliser les mécanismes adaptés plutôt qu’une simple affectation de chaîne.

## 🌺 CONVERSION DANS UN CALCUL

```abap
DATA lv_integer TYPE i VALUE 5.
DATA lv_decimal TYPE p LENGTH 5 DECIMALS 2 VALUE '2.50'.
DATA lv_result  TYPE p LENGTH 8 DECIMALS 2.

lv_result = lv_integer * lv_decimal.
```

ABAP détermine un type de calcul à partir des opérandes et du contexte. Le résultat intermédiaire peut avoir des propriétés différentes du type final.

## 🌺 CONVERSION DANS UNE COMPARAISON

```abap
DATA lv_number TYPE i VALUE 10.
DATA lv_text   TYPE string VALUE `10`.

IF lv_number = lv_text.
  WRITE / 'Comparaison vraie'.
ENDIF.
```

Le type de comparaison peut entraîner une conversion. Une comparaison explicite est plus fiable lorsque les types proviennent de sources différentes :

```abap
IF lv_number = CONV i( lv_text ).
  WRITE / 'Comparaison explicitement numérique'.
ENDIF.
```

## 🌺 CAS OÙ LA CONVERSION DOIT ÊTRE EXPLICITE

Rendre la conversion visible lorsque :

- la valeur provient d’un fichier ou d’une interface ;
- une perte de décimales est possible ;
- une longueur cible est plus courte ;
- une chaîne doit être interprétée comme un nombre ;
- la comparaison dépend du type choisi ;
- une erreur de conversion doit être interceptée ;
- le code doit expliquer une règle métier.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Conversion Rules for Elementary Data Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCONVERSION_RULES.html)
- [Avoiding the Pitfalls of Type Conversions — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/avoiding-the-pitfalls-of-type-conversions_e1feca3f-d704-4cd4-aa4e-3072af1659c6)
- [Assignments — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENVALUE_ASSIGNMENTS.html)

---

➡️ [Chapitre suivant — CONVERSIONS EXPLICITES AVEC CONV ET EXACT](<./07 - 🍧 CONVERSIONS EXPLICITES AVEC CONV ET EXACT.md>)
