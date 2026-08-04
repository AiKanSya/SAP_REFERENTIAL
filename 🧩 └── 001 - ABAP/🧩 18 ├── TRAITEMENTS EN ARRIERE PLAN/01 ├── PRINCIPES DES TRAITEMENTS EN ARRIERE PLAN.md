# 1. PRINCIPES DES TRAITEMENTS EN ARRIÈRE-PLAN

## 1.A RÉSULTAT ATTENDU

- Comprendre le rôle du traitement de fond dans un système SAP[^terme-systeme-sap]
- Distinguer une exécution en dialogue d’un job[^terme-job]
- Identifier les contraintes techniques d’un programme batch

## 1.B DÉFINITION

Un traitement en arrière-plan exécute une ou plusieurs étapes sans session utilisateur interactive. Le système planifie le job, attend que sa condition de démarrage soit satisfaite, puis affecte ses étapes à un processus de travail[^terme-processus-travail] de fond disponible.

```mermaid
flowchart LR
    A["Définition du job"] --> B["Condition de démarrage"]
    B --> C["File d attente"]
    C --> D["Processus de travail batch"]
    D --> E["Journal et spool"]
```

## 1.C CAS D’USAGE

- traitements longs ou volumineux ;
- traitements périodiques ;
- imports et exports ;
- clôtures et calculs planifiés ;
- nettoyages techniques ;
- traitements déclenchés par un événement ;
- opérations qui ne nécessitent aucune interaction utilisateur.

## 1.D DIALOGUE OU BATCH

| Critère                 | Dialogue                    | Arrière-plan                   |
| ----------------------- | --------------------------- | ------------------------------ |
| Interaction utilisateur | Possible                    | Impossible pendant l’exécution |
| Démarrage               | Immédiat depuis une session | Selon une condition planifiée  |
| Sortie classique        | Écran SAP GUI[^terme-sap-gui]               | Journal et spool[^terme-spool]               |
| Durée attendue          | Courte                      | Peut être longue               |
| Ressource               | Processus de dialogue[^terme-processus-dialogue]       | Processus de fond              |

## 1.E LIMITE DE PÉRIMÈTRE

Ce dossier traite des jobs classiques de l’AS ABAP[^terme-abap] accessibles principalement avec `SM36`[^outil-sm36] et `SM37`[^outil-sm37]. Les applications Fiori **Application Jobs**, les modèles RAP[^terme-acro-rap] et les développements ADT[^terme-acro-adt] sont hors périmètre.

## 1.F PROCESS

### 1.F.1 ÉTAPE 1 — DÉFINIR L’UNITÉ DE TRAITEMENT

Décrire les données sélectionnées, le volume, la fréquence et le résultat attendu. Définir l’unité de commit et la clé d’idempotence. Un redémarrage doit pouvoir distinguer les unités déjà validées de celles restant à traiter.

### 1.F.2 ÉTAPE 2 — SUPPRIMER LES DÉPENDANCES AU FRONTEND

Rechercher les boîtes de dialogue, services `CL_GUI_FRONTEND_SERVICES`, fichiers locaux, contrôles interactifs et messages bloquants. Remplacer ces dépendances par paramètres de variante, fichiers serveur, journal applicatif et statuts persistants.

### 1.F.3 ÉTAPE 3 — ENCADRER LES PARAMÈTRES

Créer un écran de sélection contrôlant dates, plages, mode test et taille de paquet. Enregistrer une variante d’exploitation explicite. Le programme valide à nouveau les paramètres au démarrage ; une variante n’est pas une preuve de validité.

### 1.F.4 ÉTAPE 4 — FOURNIR UNE JOURNALISATION EXPLOITABLE

Écrire les étapes, compteurs et erreurs dans le journal de job et, pour un traitement exploité régulièrement, dans le journal applicatif. Inclure programme, variante, identifiant d’exécution et première unité en erreur sans exposer de données sensibles inutiles.

### 1.F.5 ÉTAPE 5 — PLANIFIER AVEC LE BON UTILISATEUR

Créer le job avec un utilisateur technique possédant uniquement les autorisations requises. Définir l’étape, la condition de démarrage et la classe[^terme-classe] conformément aux règles Basis. Vérifier dans `SM37` le statut libéré et les paramètres effectifs.

### 1.F.6 ÉTAPE 6 — TESTER ÉCHEC ET REPRISE

Exécuter un faible volume en qualité, provoquer un échec après une unité validée puis relancer. Vérifier les données, les doublons, le journal, le spool et la durée. Le job est prêt seulement si la reprise produit le même état final qu’une exécution sans interruption.

## 1.G VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 1.H ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 1.I FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 1.J TERMES DU LEXIQUE

- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 1.K RÉFÉRENCES OFFICIELLES SAP

- [Background Processing: Concepts and Features — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/3ad3ba0715c5422eae08578d4c40328d/4b2b51c34c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

[Chapitre suivant — ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH](<./02 ├── ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH.md>)

[^terme-systeme-sap]: **SYSTÈME SAP.** Ensemble technique cohérent comprenant au minimum une base de données et un ou plusieurs serveurs d’applications. Il est généralement identifié par un SID de trois caractères. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#systeme-sap>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-processus-travail]: **PROCESSUS DE TRAVAIL.** Processus serveur exécutant une catégorie de traitement ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-travail>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-processus-dialogue]: **PROCESSUS DE DIALOGUE.** Processus de travail traitant les requêtes interactives SAP GUI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-dialogue>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-rap]: **RAP.** ABAP RESTful Application Programming Model. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rap>).
[^terme-acro-adt]: **ADT.** ABAP Development Tools, environnement de développement ABAP intégré à Eclipse. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-adt>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).

[^outil-sm36]: **SM36.** Transaction de définition et de planification des jobs d’arrière-plan. Voir [le chapitre associé](<06 ├── PLANIFIER UN JOB AVEC SM36.md>).
[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
