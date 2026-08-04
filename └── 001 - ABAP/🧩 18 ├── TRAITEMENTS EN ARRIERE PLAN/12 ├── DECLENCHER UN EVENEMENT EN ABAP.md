# DÉCLENCHER UN ÉVÉNEMENT EN ABAP

## OBJECTIFS

- Émettre un événement depuis un programme
- Gérer les erreurs de déclenchement
- Séparer validation métier et signal technique

## API DISPONIBLES

SAP documente deux mécanismes principaux selon la version du système :

- la méthode `RAISE` de la classe `CL_BATCH_EVENT` ;
- le module fonction classique `BP_EVENT_RAISE`.

Consulter la signature active dans `SE24` ou `SE37` avant l’implémentation. Le module fonction classique permet l’exemple suivant.

```abap
CALL FUNCTION 'BP_EVENT_RAISE'
  EXPORTING
    eventid  = 'Z_FILE_RECEIVED'
    eventparm = lv_filename
  EXCEPTIONS
    bad_eventid = 1
    eventid_does_not_exist = 2
    eventid_missing = 3
    raise_failed = 4
    OTHERS = 5.

IF sy-subrc <> 0.
  " Journaliser et traiter l erreur
ENDIF.
```

## ORDRE TRANSACTIONNEL

Ne pas émettre l’événement avant la validation des données que le job consommateur devra lire.

```mermaid
flowchart LR
    A["Écriture des données"] --> B["COMMIT réussi"]
    B --> C["Émission de l événement"]
    C --> D["Job consommateur"]
```

## PROCÉDURE PAS À PAS

1. Saisir `/nSE24`.
2. Entrer le nom d’une classe globale Z puis choisir **Créer**, ou afficher une classe existante.
3. Maintenir définition, visibilité, types, attributs et méthodes dans les onglets appropriés.
4. Implémenter les méthodes dans l’éditeur.
5. Contrôler et activer la classe complète.
6. Utiliser la fonction de test ou un report Z appelant pour vérifier le comportement.

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
CALL FUNCTION 'BP_EVENT_RAISE'
  EXPORTING
    eventid  = 'Z_FILE_RECEIVED'
    eventparm = lv_filename
  EXCEPTIONS
    bad_eventid = 1
    eventid_does_not_exist = 2
    eventid_missing = 3
    raise_failed = 4
    OTHERS = 5.

IF sy-subrc <> 0.
  " Journaliser et traiter l erreur
ENDIF.
```

## TERMES DU LEXIQUE

- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [Triggering Events from ABAP Programs — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/b07e7195f03f438b8e7ed273099d74f3/4d983cd18e3d0b93e10000000a42189e.html)
- [Background Processing Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/4d906689eba36e73e10000000a15822b.html)


---

[Chapitre suivant — PLANIFIER UN JOB EN ABAP](<./13 ├── PLANIFIER UN JOB EN ABAP.md>)
