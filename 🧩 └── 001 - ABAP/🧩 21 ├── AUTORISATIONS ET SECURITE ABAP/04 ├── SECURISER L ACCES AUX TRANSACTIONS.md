# SÉCURISER L’ACCÈS AUX TRANSACTIONS

## RÉSULTAT ATTENDU

Vérifier l’autorisation de démarrer une transaction appelée dynamiquement, sans confondre ce contrôle avec les autorisations métier internes.

## CODE PRÊT À ADAPTER

```abap
DATA(lv_tcode) = CONV tcode( 'ZDEMO' ).

CALL FUNCTION 'AUTHORITY_CHECK_TCODE'
  EXPORTING
    tcode  = lv_tcode
  EXCEPTIONS
    ok     = 0
    not_ok = 1
    OTHERS = 2.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH lv_tcode.
ENDIF.

CALL TRANSACTION lv_tcode WITH AUTHORITY-CHECK.
```

## CONTRÔLE

La vérification de `S_TCODE` autorise le démarrage. Le programme appelé doit toujours exécuter ses propres contrôles sur les données et opérations métier.
