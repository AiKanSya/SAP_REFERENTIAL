# LIRE UN COMPOSANT DYNAMIQUEMENT

## RÉSULTAT ATTENDU

Lire un composant dont le nom est déterminé à l’exécution sans provoquer d’accès invalide.

## CODE PRÊT À ADAPTER

```abap
DATA ls_data TYPE zdemo_structure.
DATA(lv_component_name) = CONV string( 'BUKRS' ).

ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_data TO FIELD-SYMBOL(<lv_value>).
IF sy-subrc = 0.
  DATA(lv_text) = |{ <lv_value> }|.
ELSE.
  MESSAGE e001(zdemo) WITH lv_component_name.
ENDIF.
```

## CONTRÔLE

- Tester immédiatement `SY-SUBRC` avant d’accéder au field-symbol.
- Le nom dynamique doit provenir d’une liste blanche lorsque sa source est externe.
