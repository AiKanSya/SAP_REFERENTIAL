# PLANIFIER UN JOB EN ABAP

## OBJECTIFS

- Créer un job depuis un programme
- Ajouter une étape ABAP
- Libérer le job avec une condition de démarrage

## CYCLE COMPLET

```mermaid
flowchart LR
    A["JOB_OPEN"] --> B["Ajout des étapes"]
    B --> C["JOB_CLOSE"]
    C --> D["Système batch"]
```

## EXEMPLE AVEC `SUBMIT ... VIA JOB`

```abap
DATA lv_jobname  TYPE btcjob VALUE 'Z_DEV_DEMO_JOB'.
DATA lv_jobcount TYPE btcjobcnt.

CALL FUNCTION 'JOB_OPEN'
  EXPORTING
    jobname          = lv_jobname
  IMPORTING
    jobcount         = lv_jobcount
  EXCEPTIONS
    cant_create_job  = 1
    invalid_job_data = 2
    jobname_missing  = 3
    OTHERS           = 4.

IF sy-subrc <> 0.
  MESSAGE 'Impossible de créer le job' TYPE 'E'.
ENDIF.

SUBMIT zdev_batch_report
  WITH p_date = sy-datum
  USER sy-uname
  VIA JOB lv_jobname NUMBER lv_jobcount
  AND RETURN.

CALL FUNCTION 'JOB_CLOSE'
  EXPORTING
    jobcount             = lv_jobcount
    jobname              = lv_jobname
    strtimmed             = abap_true
  EXCEPTIONS
    cant_start_immediate  = 1
    invalid_startdate     = 2
    jobname_missing       = 3
    job_close_failed      = 4
    job_nosteps           = 5
    job_notex             = 6
    lock_failed           = 7
    invalid_target        = 8
    OTHERS                = 9.

IF sy-subrc <> 0.
  MESSAGE 'Impossible de libérer le job' TYPE 'E'.
ENDIF.
```

## `JOB_SUBMIT`

`JOB_SUBMIT` permet également d’ajouter une étape. `SUBMIT ... VIA JOB` est une alternative ABAP documentée. Le choix dépend du besoin de contrôle sur la variante, le spool, la langue et l’utilisateur d’exécution.

## ROBUSTESSE

- générer un nom permettant la recherche ;
- conserver le numéro du job ;
- vérifier chaque code retour ;
- éviter de créer plusieurs jobs identiques lors d’une relance ;
- journaliser le job créé ;
- ne pas exécuter de `COMMIT WORK` caché dans une API appelante sans contrat clair.

## PROCÉDURE PAS À PAS

1. Saisir `/nSM36`.
2. Donner un nom explicite au job et définir sa classe/priorité selon les règles d’exploitation.
3. Ajouter une étape ABAP avec programme, variante et utilisateur d’exécution.
4. Définir la condition de démarrage : immédiate, date/heure, après job ou événement.
5. Enregistrer puis vérifier que le job est planifié.
6. Surveiller ensuite son exécution dans `SM37`.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_jobname  TYPE btcjob VALUE 'Z_DEV_DEMO_JOB'.
DATA lv_jobcount TYPE btcjobcnt.

CALL FUNCTION 'JOB_OPEN'
  EXPORTING
    jobname          = lv_jobname
  IMPORTING
    jobcount         = lv_jobcount
  EXCEPTIONS
    cant_create_job  = 1
    invalid_job_data = 2
    jobname_missing  = 3
    OTHERS           = 4.

IF sy-subrc <> 0.
  MESSAGE 'Impossible de créer le job' TYPE 'E'.
ENDIF.

SUBMIT zdev_batch_report
  WITH p_date = sy-datum
  USER sy-uname
  VIA JOB lv_jobname NUMBER lv_jobcount
  AND RETURN.

CALL FUNCTION 'JOB_CLOSE'
  EXPORTING
    jobcount             = lv_jobcount
    jobname              = lv_jobname
    strtimmed             = abap_true
  EXCEPTIONS
    cant_start_immediate  = 1
    invalid_startdate     = 2
    jobname_missing       = 3
    job_close_failed      = 4
    job_nosteps           = 5
    job_notex             = 6
    lock_failed           = 7
    invalid_target        = 8
    OTHERS                = 9.

IF sy-subrc <> 0.
  MESSAGE 'Impossible de libérer le job' TYPE 'E'.
ENDIF.
```

## TERMES DU LEXIQUE

- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [JOB_OPEN — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f4638486c4b10149ac3feef935d92ad/4d9140abe637497fe10000000a15822b.html)
- [JOB_SUBMIT — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12acb4f96c531014b9dad87356daf3a3/4d914143e637497fe10000000a15822b.html)
- [JOB_CLOSE — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12acb4f96c531014b9dad87356daf3a3/4d92c00d37621747e10000000a15822b.html)
- [Sample Program with ABAP SUBMIT — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4d938d6848846e73e10000000a15822b.html)


---

[Chapitre suivant — UTILISATEUR D’EXÉCUTION ET AUTORISATIONS](<./14 ├── UTILISATEUR D EXECUTION ET AUTORISATIONS.md>)
