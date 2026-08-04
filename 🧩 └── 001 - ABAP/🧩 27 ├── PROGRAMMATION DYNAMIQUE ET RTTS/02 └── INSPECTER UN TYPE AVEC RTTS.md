# INSPECTER UN TYPE AVEC RTTS

## RÉSULTAT ATTENDU

Déterminer à l’exécution si une donnée est une structure et obtenir la description de ses composants.

## PROCESS

### ÉTAPE 1 — IDENTIFIER LE BESOIN D’INSPECTION

Utiliser RTTS pour une API générique qui ne connaît pas statiquement le type reçu. Si le contrat est stable, déclarer une interface typée plutôt que reconstruire cette interface à l’exécution.

### ÉTAPE 2 — OBTENIR LE DESCRIPTEUR

Appeler `CL_ABAP_TYPEDESCR=>DESCRIBE_BY_DATA` avec la donnée réelle. Conserver la référence retournée comme descripteur générique tant que sa catégorie n’est pas vérifiée.

### ÉTAPE 3 — TESTER LA CATÉGORIE DU TYPE

Comparer `KIND` à `CL_ABAP_TYPEDESCR=>KIND_STRUCT`. Prévoir le traitement attendu pour une table, un type élémentaire ou une référence au lieu d’exécuter un cast descendant systématique.

### ÉTAPE 4 — EFFECTUER LE CAST CONTRÔLÉ

Après le test de catégorie, convertir la référence avec `CAST CL_ABAP_STRUCTDESCR`. Le cast devient alors cohérent avec la catégorie observée.

### ÉTAPE 5 — PARCOURIR LES COMPOSANTS

Lire `COMPONENTS` et relever pour chaque entrée le nom et le descripteur de type. Ne pas supposer que `ABSOLUTE_NAME` est renseigné de la même manière pour un type local, anonyme et DDIC.

### ÉTAPE 6 — TESTER PLUSIEURS FORMES DE TYPES

Exécuter le code avec une structure DDIC, une structure locale, un type élémentaire et une table interne. Vérifier que seuls les types structures atteignent le cast et la boucle.

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
