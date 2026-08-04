# PLANIFIER UN JOB EN ABAP

## RÉSULTAT ATTENDU

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

## PROCESS

### ÉTAPE 1 — DÉFINIR UNE CLÉ D’IDEMPOTENCE DE PLANIFICATION

Construire un nom et un identifiant métier permettant de reconnaître une demande déjà créée. Avant de planifier, rechercher ou consulter une table de pilotage afin qu’une relance du programme ne crée pas plusieurs jobs équivalents.

### ÉTAPE 2 — OUVRIR LE JOB AVEC `JOB_OPEN`

Préparer `jobname`, appeler `JOB_OPEN` et récupérer `jobcount`. Contrôler `sy-subrc` immédiatement. Conserver le couple nom/numéro dans le journal ; le nom seul peut correspondre à plusieurs exécutions.

### ÉTAPE 3 — AJOUTER L’ÉTAPE

Utiliser `SUBMIT ... VIA JOB ... AND RETURN` ou `JOB_SUBMIT` selon les paramètres requis. Fournir programme, variante ou valeurs de sélection, utilisateur et attributs de spool de manière explicite. Contrôler le retour avant de fermer le job.

### ÉTAPE 4 — FERMER ET LIBÉRER AVEC `JOB_CLOSE`

Définir une condition de démarrage cohérente : immédiate, date/heure ou autre option supportée par la signature. Appeler `JOB_CLOSE` avec le même nom et numéro, puis traiter chaque code d’erreur. Un job ouvert mais non fermé doit être signalé pour nettoyage.

### ÉTAPE 5 — PERSISTER LE RÉSULTAT DE PLANIFICATION

Enregistrer le nom, le numéro, l’étape, les paramètres, le créateur et la date. Restituer ces informations à l’appelant. Ne pas masquer un échec de fermeture après un `JOB_OPEN` réussi.

### ÉTAPE 6 — CONTRÔLER DANS `SM37`

Rechercher le couple créé, vérifier le statut libéré, le programme, la variante, l’utilisateur et la condition. Tester le succès, un programme ou une variante invalide, un `JOB_CLOSE` en échec et une relance de la demande initiale.

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

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [JOB_OPEN — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f4638486c4b10149ac3feef935d92ad/4d9140abe637497fe10000000a15822b.html)
- [JOB_SUBMIT — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12acb4f96c531014b9dad87356daf3a3/4d914143e637497fe10000000a15822b.html)
- [JOB_CLOSE — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12acb4f96c531014b9dad87356daf3a3/4d92c00d37621747e10000000a15822b.html)
- [Sample Program with ABAP SUBMIT — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4d938d6848846e73e10000000a15822b.html)

---

[Chapitre suivant — UTILISATEUR D’EXÉCUTION ET AUTORISATIONS](<./14 ├── UTILISATEUR D EXECUTION ET AUTORISATIONS.md>)
