# SÉCURISER LES NOMS DYNAMIQUES

## RÉSULTAT ATTENDU

Empêcher qu’une saisie externe choisisse librement une table, un champ, une classe, une méthode ou un programme exécuté dynamiquement.

## CODE PRÊT À ADAPTER

```abap
TYPES ty_allowed_table TYPE c LENGTH 30.
DATA lt_allowed_tables TYPE HASHED TABLE OF ty_allowed_table WITH UNIQUE KEY table_line.
lt_allowed_tables = VALUE #( ( 'ZDEMO_HEADER' ) ( 'ZDEMO_ITEM' ) ).

DATA(lv_table_name) = CONV ty_allowed_table( to_upper( val = p_table ) ).
IF NOT line_exists( lt_allowed_tables[ table_line = lv_table_name ] ).
  MESSAGE e001(zdemo) WITH lv_table_name.
ENDIF.

"Le nom dynamique est désormais limité à une liste maîtrisée par le programme.
SELECT COUNT(*) FROM (lv_table_name)
  INTO @DATA(lv_count).
```

## CONTRÔLE

- La liste blanche est définie par le programme, pas par une table modifiable sans protection.
- Les autorisations métier restent vérifiées séparément.
- Une lecture des données doit en plus imposer filtres et limite de volume.
