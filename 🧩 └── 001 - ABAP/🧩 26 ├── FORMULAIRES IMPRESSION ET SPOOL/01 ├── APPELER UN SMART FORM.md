# APPELER UN SMART FORM

## RÉSULTAT ATTENDU

Résoudre dynamiquement le module généré d’un Smart Form puis l’appeler sans coder son nom technique généré en dur.

## CODE PRÊT À ADAPTER

```abap
DATA lv_function_name TYPE rs38l_fnam.

CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname           = 'ZSF_DEMO'
  IMPORTING
    fm_name            = lv_function_name
  EXCEPTIONS
    no_form            = 1
    no_function_module = 2
    OTHERS             = 3.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH 'Smart Form introuvable'.
ENDIF.

"Insérer ici le modèle d’appel du module généré pour obtenir sa signature exacte.
CALL FUNCTION lv_function_name
  EXCEPTIONS
    formatting_error = 1
    internal_error   = 2
    send_error       = 3
    user_canceled    = 4
    OTHERS           = 5.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH sy-subrc.
ENDIF.
```

## CONTRÔLE

- Le nom généré n’est jamais persisté dans le code.
- Les paramètres métier doivent provenir de la signature réelle du formulaire.
