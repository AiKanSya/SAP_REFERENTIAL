# OBTENIR LE PROCHAIN NUMÉRO

## RÉSULTAT ATTENDU

Obtenir un numéro unique depuis l’objet de plage `ZDEMO_NR`.

## PRÉREQUIS

- Objet et intervalle créés dans `SNRO`.
- Intervalle `01` disponible pour l’exercice courant.

## CODE PRÊT À ADAPTER

```abap
DATA lv_number TYPE n LENGTH 10.

CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr = '01'
    object      = 'ZDEMO_NR'
  IMPORTING
    number      = lv_number
  EXCEPTIONS
    interval_not_found      = 1
    number_range_not_intern = 2
    object_not_found        = 3
    quantity_is_0           = 4
    quantity_is_not_1       = 5
    interval_overflow       = 6
    buffer_overflow         = 7
    OTHERS                  = 8.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH sy-subrc.
ENDIF.
```

## CONTRÔLE

- Deux appels validés ne doivent pas attribuer le même numéro.
- Un numéro demandé peut être consommé même si la transaction métier est annulée ; ne pas exiger une numérotation sans trou sans règle métier explicite.
