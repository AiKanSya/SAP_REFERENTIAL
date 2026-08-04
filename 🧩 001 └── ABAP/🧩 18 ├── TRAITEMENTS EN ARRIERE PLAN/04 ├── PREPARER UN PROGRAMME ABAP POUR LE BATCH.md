# 4. PRÉPARER UN PROGRAMME ABAP POUR LE BATCH

## 4.A RÉSULTAT ATTENDU

- Rendre un programme exécutable[^terme-programme-executable] sans interaction SAP GUI[^terme-sap-gui]
- Adapter les sorties et les erreurs
- Tester séparément le mode dialogue et le mode batch

## 4.B CONTRAINTES

Un programme exécuté en arrière-plan ne doit pas dépendre d’une interaction utilisateur pendant son traitement.

À éviter :

- `CL_GUI_FRONTEND_SERVICES` ;
- boîtes de dialogue ou popups ;
- dynpros nécessitant une saisie ;
- fichiers locaux du poste utilisateur ;
- contrôle frontend[^terme-frontend] ALV[^terme-alv] ou conteneur GUI ;
- attente d’une confirmation manuelle.

## 4.C DÉTECTER LE CONTEXTE

```abap
IF sy-batch = abap_true.
  " Comportement compatible arrière-plan
ELSE.
  " Comportement dialogue éventuel
ENDIF.
```

`sy-batch` vaut `X` lors d’une exécution en arrière-plan. Ce test ne doit pas servir à dupliquer toute la logique métier. Isoler le traitement dans une classe[^terme-classe] ou une procédure commune, puis adapter uniquement l’entrée et la sortie.

## 4.D SORTIES

- écrire les résultats métier dans des tables ou fichiers serveur maîtrisés ;
- produire un journal applicatif si une exploitation opérationnelle est requise ;
- utiliser une liste classique uniquement si un spool[^terme-spool] est utile ;
- lever ou propager des erreurs de manière contrôlée ;
- éviter les messages interactifs dépendant d’un écran.

## 4.E EXEMPLE D’ORGANISATION

```abap
START-OF-SELECTION.
  TRY.
      NEW zcl_dev_batch_service( )->run(
        iv_date = p_date ).

      WRITE: / 'Traitement terminé'.
    CATCH zcx_dev_batch INTO DATA(lx_batch).
      MESSAGE lx_batch->get_text( ) TYPE 'E'.
  ENDTRY.
```

## 4.F PROCESS

### 4.F.1 ÉTAPE 1 — SÉPARER SÉLECTION, TRAITEMENT ET SORTIE

Construire un report dont l’écran de sélection fournit uniquement les paramètres. Déléguer le traitement à une classe recevant des données typées. Isoler la journalisation et les sorties afin de tester le cœur sans SAP GUI.

### 4.F.2 ÉTAPE 2 — ÉLIMINER LES APPELS INTERACTIFS

Rechercher `CL_GUI_FRONTEND_SERVICES`, dialogues de fichiers, popups, contrôles GUI et attentes de commande utilisateur. Pour le batch, utiliser des fichiers serveur, des paramètres de variante et des messages non interactifs. Tester explicitement `sy-batch` si le comportement doit différer.

### 4.F.3 ÉTAPE 3 — VALIDER LA VARIANTE AU DÉMARRAGE

Contrôler les plages, dates, chemins logiques, taille de paquet et mode test. Rejeter une sélection vide ou excessivement large si le contrat l’interdit. Écrire les paramètres effectifs dans le journal sans données sensibles.

### 4.F.4 ÉTAPE 4 — TRAITER PAR UNITÉS REPRENABLES

Sélectionner et traiter par paquets ou documents métier déterministes. Définir les commits au niveau de l’unité prévue et enregistrer une clé de traitement. Une interruption ne doit pas obliger à deviner quelles données sont déjà persistées.

### 4.F.5 ÉTAPE 5 — PRODUIRE DES LOGS STRUCTURÉS

Émettre un résumé dans le journal de job[^terme-job] et utiliser le journal applicatif pour les messages détaillés exploitables. Compter les unités lues, réussies, ignorées et rejetées. Une erreur doit inclure la clé et l’étape technique sans nécessiter de debug.

### 4.F.6 ÉTAPE 6 — TESTER DANS LES DEUX MODES

Exécuter le report en dialogue avec la variante, puis comme étape de job sous l’utilisateur technique. Comparer résultats et autorisations. Tester un volume représentatif, un échec partiel et une relance ; contrôler données, spool, journal et absence de doublons.

## 4.G VÉRIFICATION

- Le job apparaît dans `SM37`[^outil-sm37] avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 4.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 4.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
IF sy-batch = abap_true.
  " Comportement compatible arrière-plan
ELSE.
  " Comportement dialogue éventuel
ENDIF.
```

## 4.J TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 4.K RÉFÉRENCES OFFICIELLES SAP

- [ABAP System Fields — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/f68e489816e043f1add91d69a6842931/7bfb96c8882811d295a90000e8353423.html)
- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)

---

[Chapitre suivant — VARIANTES ET PARAMÈTRES DE SÉLECTION](<./05 ├── VARIANTES ET PARAMETRES DE SELECTION.md>)

[^terme-programme-executable]: **PROGRAMME EXÉCUTABLE.** Programme ABAP de type report pouvant être lancé directement, généralement avec `F8` ou par une transaction. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
