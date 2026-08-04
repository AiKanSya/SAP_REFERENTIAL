# INSPECTER UN TYPE AVEC RTTS

## RÉSULTAT ATTENDU

Déterminer à l’exécution si une donnée est une structure et obtenir la description de ses composants.

## CODE PRÊT À ADAPTER

```abap
DATA ls_data TYPE zdemo_structure.
DATA(lo_type) = cl_abap_typedescr=>describe_by_data( ls_data ).

IF lo_type->kind = cl_abap_typedescr=>kind_struct.
  DATA(lo_structure) = CAST cl_abap_structdescr( lo_type ).

  LOOP AT lo_structure->components INTO DATA(ls_component).
    WRITE: / ls_component-name, ls_component-type->absolute_name.
  ENDLOOP.
ENDIF.
```

## CONTRÔLE

- Tester la catégorie avant tout cast descendant.
- Ne pas utiliser RTTS pour remplacer une interface ou un type DDIC stable.
