# 12. DÉCLENCHER UN ÉVÉNEMENT EN ABAP

## 12.A RÉSULTAT ATTENDU

- Émettre un événement depuis un programme
- Gérer les erreurs de déclenchement
- Séparer validation métier et signal technique

## 12.B API DISPONIBLES

SAP[^terme-acro-sap] documente deux mécanismes principaux selon la version du système :

- la méthode[^terme-methode] `RAISE` de la classe[^terme-classe] `CL_BATCH_EVENT` ;
- le module fonction[^terme-module-fonction] classique `BP_EVENT_RAISE`.

Consulter la signature active dans `SE24`[^terme-class-builder-se24] ou `SE37`[^outil-se37] avant l’implémentation. Le module fonction classique permet l’exemple suivant.

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

## 12.C ORDRE TRANSACTIONNEL

Ne pas émettre l’événement avant la validation des données que le job[^terme-job] consommateur devra lire.

```mermaid
flowchart LR
    A["Écriture des données"] --> B["COMMIT réussi"]
    B --> C["Émission de l événement"]
    C --> D["Job consommateur"]
```

## 12.D PROCESS

### 12.D.1 ÉTAPE 1 — VÉRIFIER L’ÉVÉNEMENT ET LES JOBS EN ATTENTE

Dans `SM62`[^outil-sm62], confirmer l’identifiant et le contrat de l’argument. Dans `SM37`[^outil-sm37], vérifier qu’un job de test libéré attend cette combinaison. Ne développer l’émetteur qu’après avoir prouvé la configuration du consommateur.

### 12.D.2 ÉTAPE 2 — CHOISIR L’API DISPONIBLE

Afficher `CL_BATCH_EVENT` dans `SE24` ou `BP_EVENT_RAISE` dans `SE37` et relever la signature active. Utiliser l’API[^terme-api] retenue derrière une méthode Z afin d’isoler les différences de release et de faciliter les tests.

### 12.D.3 ÉTAPE 3 — CONSTRUIRE IDENTIFIANT ET ARGUMENT

Utiliser des constantes ou une configuration validée pour l’identifiant. Construire l’argument selon le format documenté et vérifier longueur, casse et absence de données sensibles. Refuser une valeur initiale si le contrat la rend obligatoire.

### 12.D.4 ÉTAPE 4 — ÉMETTRE APRÈS LA VALIDATION DES DONNÉES

Valider d’abord les données que le consommateur doit lire. Émettre l’événement seulement lorsque leur état persistant est disponible. Si l’événement est envoyé après un commit, traiter son échec comme une situation de reprise distincte, car les données sont déjà validées.

### 12.D.5 ÉTAPE 5 — TRAITER CHAQUE ERREUR DE L’API

Pour `BP_EVENT_RAISE`, contrôler `sy-subrc` immédiatement et distinguer identifiant absent, événement inexistant et échec d’émission. Journaliser l’identifiant, l’argument et la cause. Ne pas annoncer le déclenchement si l’API a échoué.

### 12.D.6 ÉTAPE 6 — VÉRIFIER ET REJOUER

Contrôler dans `SM37` le démarrage du job attendu et son résultat métier. Tester un événement invalide, un argument ne correspondant à aucun job et une émission répétée. La reprise de l’émetteur ne doit pas produire de traitement métier en double.

## 12.E VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool[^terme-spool], le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 12.F ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 12.G SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 12.H TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 12.I RÉFÉRENCES OFFICIELLES SAP

- [Triggering Events from ABAP Programs — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/b07e7195f03f438b8e7ed273099d74f3/4d983cd18e3d0b93e10000000a42189e.html)
- [Background Processing Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/4d906689eba36e73e10000000a15822b.html)

---

[Chapitre suivant — PLANIFIER UN JOB EN ABAP](<./13 ├── PLANIFIER UN JOB EN ABAP.md>)

[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
[^outil-sm62]: **SM62.** Transaction de définition des événements utilisables par les traitements d’arrière-plan. Voir [le chapitre associé](<11 ├── EVENEMENTS DE FOND SM62 ET SM64.md>).
[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
