# 23. DOCUMENTATION, TEST ET DEBUG AVEC SE24

## 23.A RÉSULTAT ATTENDU

- Documenter une classe globale[^terme-classe-globale] et ses composants.
- Exécuter un test simple depuis le Class Builder[^terme-class-builder-se24].
- Déboguer une méthode[^terme-methode] appelée depuis un programme.
- Positionner ABAP[^terme-abap] Unit par rapport au test manuel.

## 23.B DOCUMENTATION

La description courte doit expliquer la responsabilité de la classe. ABAP Doc peut documenter classes, interfaces, méthodes, types, données et constantes selon la syntaxe disponible dans la release.

```abap
"! Service de calcul des échéances contractuelles.
"! Ne réalise aucune mise à jour en base.
CLASS zcl_dev_due_date_service DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    "! Calcule l'échéance à partir d'une date de départ.
    "! @parameter iv_start_date | Date de départ
    "! @parameter rv_due_date   | Date d'échéance calculée
    METHODS calculate
      IMPORTING iv_start_date TYPE d
      RETURNING VALUE(rv_due_date) TYPE d.
ENDCLASS.
```

## 23.C PROCESS

### 23.C.1 Étape 1 — Qualifier la méthode

Ouvrir la classe active dans `SE24`, sélectionner une méthode publique et lire sa signature, sa documentation et ses exceptions avant le test.

### 23.C.2 Étape 2 — Préparer le cas nominal

Ouvrir l’outil de test disponible, renseigner chaque paramètre obligatoire avec une valeur vérifiable et noter le résultat attendu.

### 23.C.3 Étape 3 — Exécuter et inspecter

Lancer, examiner returning/exporting/changing et exception[^terme-exception]. Si le résultat diverge, placer un breakpoint[^terme-breakpoint] dans la méthode et refaire exactement la même saisie.

### 23.C.4 Étape 4 — Tester les limites

Répéter avec valeur initiale, limite et donnée invalide. Vérifier que les exceptions déclarées sont effectivement produites.

### 23.C.5 Étape 5 — Convertir en test automatique

Créer un test ABAP Unit pour les cas stables. Le contrôle est validé lorsque le résultat peut être rejoué sans saisie manuelle.

Le test manuel ne remplace pas un test automatisé : il dépend de la saisie et ne protège pas automatiquement contre les régressions.

## 23.D REPORT D’APPEL À COPIER

```abap
" Construire les dépendances avant d’exécuter le traitement.
REPORT zdev_test_due_date_service.

PARAMETERS p_date TYPE d DEFAULT sy-datum.

START-OF-SELECTION.
  DATA(lo_service) = NEW zcl_dev_due_date_service( ).
  DATA(lv_due_date) = lo_service->calculate( p_date ).
  WRITE: / lv_due_date.
```

## 23.E DEBUG

1. Placer un breakpoint externe ou de session dans la méthode.
2. Exécuter le report, job[^terme-job] ou transaction appelante.
3. Vérifier les paramètres d’entrée.
4. Examiner `ME`, les attributs d’instance et la pile d’appels.
5. Suivre les appels aux collaborateurs.
6. Contrôler l’exception ou la valeur de retour.

## 23.F ABAP UNIT

Les classes de test locales peuvent être placées dans le Class Pool[^terme-class-pool]. Elles doivent tester le comportement public et les cas limites, pas reproduire l’implémentation ligne par ligne.

## 23.G CONTRÔLE

- La classe possède une responsabilité compréhensible sans ouvrir son code.
- Chaque méthode publique non triviale possède des cas de test définis.
- Le test manuel et le test automatisé utilisent des données sans impact.
- Le debugger confirme le flux attendu sans modifier les données en production.

## 23.H ERREURS FRÉQUENTES

- Documenter uniquement ce que le code dit déjà.
- Tester uniquement le cas nominal.
- Modifier les valeurs dans le debugger et considérer le résultat comme une validation fiable.

## 23.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 23.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP Code Documentation — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Testing a Class — SAP Help Portal](https://help.sap.com/saphelp_em900/helpdata/en/91/67d406f53a11d194dc00a0c94260a5/content.htm)
- [ABAP Unit Tests — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f45cbc76c4b1014ad87ebc4a930e7bf/14a794422760c46ae10000000a155106.html)

---

[Chapitre suivant — PACKAGES, TRANSPORTS, VERSIONING ET BONNES PRATIQUES](<./24 └── PACKAGES TRANSPORTS VERSIONING ET BONNES PRATIQUES.md>)

[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-class-pool]: **CLASS POOL.** Programme technique généré qui contient la définition et l’implémentation d’une classe globale ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-pool>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
