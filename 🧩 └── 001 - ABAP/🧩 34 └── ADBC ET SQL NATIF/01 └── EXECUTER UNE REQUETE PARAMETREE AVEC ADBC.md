# EXÉCUTER UNE REQUÊTE PARAMÉTRÉE AVEC ADBC

## RÉSULTAT ATTENDU

Exécuter une requête native paramétrée sans concaténer une valeur externe dans le texte SQL.

## CODE PRÊT À ADAPTER

```abap
DATA lv_bukrs TYPE bukrs VALUE '1000'.
DATA lv_count TYPE i.

TRY.
    DATA(lo_statement) = NEW cl_sql_statement( ).
    lo_statement->set_param( REF #( lv_bukrs ) ).

    DATA(lo_result) = lo_statement->execute_query(
      `SELECT COUNT(*) FROM T001 WHERE BUKRS = ?` ).
    lo_result->set_param( REF #( lv_count ) ).
    IF lo_result->next( ) = 0.
      MESSAGE e001(zdemo) WITH 'Aucun résultat SQL'.
    ENDIF.
    lo_result->close( ).
  CATCH cx_sql_exception INTO DATA(lx_sql).
    MESSAGE lx_sql TYPE 'E'.
ENDTRY.
```

## CONTRÔLE

- Comparer le résultat avec une requête ABAP SQL équivalente.
- Ne jamais concaténer directement une saisie utilisateur dans l’instruction.
- Fermer le jeu de résultats après lecture.

## COMPATIBILITÉ S/4HANA

Statut : compatible mais spécialisé. Vérifier la syntaxe native acceptée par SAP HANA et la politique du projet.
