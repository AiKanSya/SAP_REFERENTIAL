# APPELER UN SMART FORM

## RÉSULTAT ATTENDU

Résoudre dynamiquement le module généré d’un Smart Form puis l’appeler sans coder son nom technique généré en dur.

## PROCESS

### ÉTAPE 1 — ACTIVER ET TESTER LE SMART FORM

Dans `SMARTFORMS`, activer le formulaire et exécuter son test avec des données contrôlées. Relever son interface réelle, ses exceptions et les paramètres de contrôle ou de sortie utilisés par le scénario.

### ÉTAPE 2 — RÉSOUDRE LE MODULE GÉNÉRÉ

Appeler `SSF_FUNCTION_MODULE_NAME` avec le nom fonctionnel du formulaire. Tester immédiatement `SY-SUBRC` et interrompre le traitement si le formulaire ou le module généré est introuvable.

### ÉTAPE 3 — INSÉRER LA SIGNATURE RÉELLE

Ouvrir le module résolu ou insérer son modèle d’appel depuis l’éditeur. Ajouter les paramètres métier exacts générés pour ce formulaire ; ne pas inventer une signature générique.

### ÉTAPE 4 — PRÉPARER LES PARAMÈTRES DE SORTIE

Définir le périphérique, le mode de prévisualisation, la boîte de dialogue et la création de spool selon le contexte interactif ou batch. Ne pas dépendre d’une valeur utilisateur implicite non contrôlée.

### ÉTAPE 5 — APPELER LE MODULE DYNAMIQUEMENT

Transmettre les structures de contrôle, les options de sortie et les données métier, puis traiter chaque exception du module généré.

### ÉTAPE 6 — CONTRÔLER LE RÉSULTAT

Vérifier la prévisualisation ou la requête spool dans `SP01`, les pages produites, le périphérique et les données affichées. Tester aussi l’annulation utilisateur et une erreur de formatage.

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

" Insérer ici le modèle d’appel du module généré pour obtenir sa signature exacte.
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
