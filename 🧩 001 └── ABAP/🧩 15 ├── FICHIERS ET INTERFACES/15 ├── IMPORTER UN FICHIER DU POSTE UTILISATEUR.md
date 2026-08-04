# 15. IMPORTER UN FICHIER DU POSTE UTILISATEUR

## 15.A RÉSULTAT ATTENDU

- Charger un fichier local dans une table interne[^terme-table-interne]
- Choisir le type de fichier adapté
- Contrôler les erreurs de frontend[^terme-frontend]

## 15.B IMPORT TEXTE

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

cl_gui_frontend_services=>gui_upload(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    OTHERS                  = 5 ).

IF sy-subrc <> 0.
  MESSAGE e003(zdev_file) WITH sy-subrc.
ENDIF.
```

Les exceptions exactes et les paramètres doivent être contrôlés dans `SE24`[^terme-class-builder-se24], car ils peuvent différer selon le niveau de composant.

## 15.C TYPES DE FICHIER

| Type  | Usage                                                   |
| ----- | ------------------------------------------------------- |
| `ASC` | Texte                                                   |
| `BIN` | Contenu binaire                                         |
| `DAT` | Format texte avec séparateurs selon le service frontend |

Pour un contrat d’interface strict, importer des lignes texte puis effectuer soi-même le parsing évite de dépendre de comportements implicites.

## 15.D LIMITES

- Impossible en arrière-plan.
- Le fichier traverse la connexion frontend vers le serveur ABAP[^terme-abap].
- Le volume doit rester compatible avec une interaction utilisateur.
- La sélection locale ne dispense pas des contrôles métier.

## 15.E ARCHITECTURE

La méthode[^terme-methode] d’import doit retourner un contenu brut ou une table de lignes. Une méthode distincte transforme ce contenu en données métier. Le test du parsing devient alors indépendant de SAP GUI[^terme-sap-gui].

## 15.F PROCESS

### 15.F.1 ÉTAPE 1 — CONTRÔLER LE CONTEXTE D’EXÉCUTION

Réserver l’import local à une exécution en mode dialogue avec SAP GUI. Tester la disponibilité des services frontend avant d’afficher une boîte de dialogue. Si le même traitement doit fonctionner en job[^terme-job], prévoir une entrée serveur distincte et réutiliser uniquement le parseur et le traitement métier.

### 15.F.2 ÉTAPE 2 — FAIRE SÉLECTIONNER LE FICHIER

Appeler `CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG` avec un filtre correspondant au format accepté. Exploiter uniquement la sélection renvoyée par la méthode. Si l’utilisateur annule ou si aucun fichier n’est sélectionné, quitter sans appel à `GUI_UPLOAD` et sans produire de message d’erreur technique trompeur.

### 15.F.3 ÉTAPE 3 — CHARGER LE CONTENU BRUT

Appeler `CL_GUI_FRONTEND_SERVICES=>GUI_UPLOAD` avec le chemin validé et un type de fichier adapté. Charger un fichier texte dans une table de lignes et un fichier binaire dans une table de type compatible avec l’API[^terme-api]. Conserver le contenu brut séparément des données métier afin de pouvoir diagnostiquer le parsing.

### 15.F.4 ÉTAPE 4 — VALIDER LE CONTRAT DE FICHIER

Contrôler l’extension autorisée, la taille, l’encodage[^terme-encodage], l’en-tête, le nombre de colonnes et les séparateurs avant toute mise à jour métier. Affecter un numéro à chaque ligne source. Une ligne invalide doit produire un rejet localisable indiquant la ligne, le champ, la valeur et la règle violée.

### 15.F.5 ÉTAPE 5 — TRANSFORMER ET TRAITER LES DONNÉES

Convertir les lignes validées vers une structure typée. Exécuter ensuite les contrôles métier dans une méthode indépendante du frontend. Définir explicitement si une erreur annule tout le fichier ou seulement l’unité concernée ; aligner les `COMMIT WORK`[^terme-commit-work] et les reprises sur cette unité transactionnelle.

### 15.F.6 ÉTAPE 6 — VÉRIFIER LES RÉSULTATS ET LA REPRISE

Comparer le nombre de lignes lues, acceptées, rejetées et enregistrées. Tester un fichier valide, vide, mal encodé, incomplet, dupliqué et partiellement incorrect. Rejouer le même fichier : le résultat doit respecter la règle d’idempotence documentée et ne pas créer de doublons silencieux.

## 15.G VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace[^terme-trace] ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 15.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 15.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

cl_gui_frontend_services=>gui_upload(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    OTHERS                  = 5 ).

IF sy-subrc <> 0.
  MESSAGE e003(zdev_file) WITH sy-subrc.
ENDIF.
```

## 15.J TERMES DU LEXIQUE

- [Import](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#import-transport>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## 15.K RÉFÉRENCES OFFICIELLES SAP

- [GUI_UPLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/ff557c806c5510149761a0c32c810458/1dac0155370648569fe843170e07c4da.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)

---

[Chapitre suivant — EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR](<./16 ├── EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR.md>)

[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
