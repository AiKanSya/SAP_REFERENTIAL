# 🌸 EXPRESSIONS CONDITIONNELLES COND ET SWITCH

## 🌺 OBJECTIFS

- Distinguer une expression conditionnelle d’une structure de contrôle
- Produire directement une valeur avec `COND`
- Sélectionner une valeur avec `SWITCH`
- Connaître les limites de lisibilité de ces expressions
- Vérifier leur compatibilité avec la version ABAP du système

## 🌺 STRUCTURE DE CONTRÔLE OU EXPRESSION

`IF` et `CASE` pilotent l’exécution de blocs d’instructions.

`COND` et `SWITCH` produisent une valeur utilisable dans une affectation ou une autre expression.

```mermaid
flowchart LR
    A["Condition ou valeur source"] --> B{"Besoin recherché"}
    B -- "Exécuter plusieurs instructions" --> C["IF ou CASE"]
    B -- "Construire une seule valeur" --> D["COND ou SWITCH"]
```

> [!IMPORTANT]
> La disponibilité de `COND` et `SWITCH` dépend de la version ABAP. Vérifier la syntaxe sur le système cible et respecter les règles de compatibilité du projet.

## 🌺 EXPRESSION COND

`COND` produit une valeur selon une ou plusieurs conditions logiques.

```abap
DATA lv_amount TYPE p LENGTH 8 DECIMALS 2 VALUE '125.00'.

DATA(lv_category) = COND string(
  WHEN lv_amount < 0   THEN `NEGATIF`
  WHEN lv_amount = 0   THEN `NUL`
  WHEN lv_amount < 100 THEN `STANDARD`
  ELSE                      `ELEVE` ).

WRITE: / lv_category.
```

Équivalent avec `IF` :

```abap
DATA lv_category TYPE string.

IF lv_amount < 0.
  lv_category = `NEGATIF`.
ELSEIF lv_amount = 0.
  lv_category = `NUL`.
ELSEIF lv_amount < 100.
  lv_category = `STANDARD`.
ELSE.
  lv_category = `ELEVE`.
ENDIF.
```

## 🌺 EXPRESSION SWITCH

`SWITCH` produit une valeur en comparant une expression à plusieurs valeurs.

```abap
DATA lv_status TYPE c LENGTH 1 VALUE 'A'.

DATA(lv_status_text) = SWITCH string(
  lv_status
  WHEN 'A' THEN `ACTIF`
  WHEN 'B' THEN `BLOQUE`
  ELSE          `INCONNU` ).

WRITE: / lv_status_text.
```

Équivalent avec `CASE` :

```abap
DATA lv_status_text TYPE string.

CASE lv_status.
  WHEN 'A'.
    lv_status_text = `ACTIF`.
  WHEN 'B'.
    lv_status_text = `BLOQUE`.
  WHEN OTHERS.
    lv_status_text = `INCONNU`.
ENDCASE.
```

## 🌺 TYPE DU RÉSULTAT

Le type peut être indiqué explicitement :

```abap
DATA lv_flag TYPE abap_bool.

lv_flag = COND abap_bool(
  WHEN lv_quantity > 0 THEN abap_true
  ELSE                      abap_false ).
```

Le type explicite facilite la lecture et évite une inférence inadéquate.

## 🌺 QUAND LES UTILISER

Utiliser `COND` ou `SWITCH` lorsque :

- le résultat attendu est une valeur unique ;
- chaque branche reste courte ;
- l’expression reste immédiatement compréhensible ;
- la version ABAP cible les prend en charge.

Préférer `IF` ou `CASE` lorsque :

- chaque branche contient plusieurs instructions ;
- des messages, appels ou effets de bord sont nécessaires ;
- l’expression devient longue ou profondément imbriquée ;
- le code doit rester compatible avec une version ABAP plus ancienne.

## 🌺 ÉVITER L’IMBRICATION D’EXPRESSIONS

À éviter :

```abap
DATA(lv_result) = COND string(
  WHEN lv_active = abap_true
  THEN SWITCH string(
         lv_status
         WHEN 'A' THEN `AUTORISE`
         ELSE          `REFUSE` )
  ELSE `INACTIF` ).
```

Une structure explicite est souvent plus maintenable :

```abap
DATA lv_result TYPE string.

IF lv_active = abap_false.
  lv_result = `INACTIF`.
ELSE.
  CASE lv_status.
    WHEN 'A'.
      lv_result = `AUTORISE`.
    WHEN OTHERS.
      lv_result = `REFUSE`.
  ENDCASE.
ENDIF.
```

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Conditional Expressions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abenconditional_expressions.htm)
- [COND Conditional Operator — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abenconditional_expression_cond.htm)
- [SWITCH Conditional Operator — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abenconditional_expression_switch.htm)

---

➡️ [Chapitre suivant — BOUCLES COMPTEES AVEC DO](<./06 - 🍧 BOUCLES COMPTEES AVEC DO.md>)
