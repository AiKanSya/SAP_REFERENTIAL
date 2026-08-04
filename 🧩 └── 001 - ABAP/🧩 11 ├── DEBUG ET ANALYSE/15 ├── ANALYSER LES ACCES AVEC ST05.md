# 15. ANALYSER LES ACCÈS AVEC ST05

## 15.A RÉSULTAT ATTENDU

- Utiliser `ST05`[^outil-st05] pour observer les accès SQL[^terme-acro-sql]
- Restreindre la trace[^terme-trace] à l’utilisateur et au scénario
- Lire les opérations et durées principales
- Repérer répétitions, lectures massives et accès non sélectifs
- Désactiver immédiatement la trace après reproduction

## 15.B RÔLE DE ST05

La transaction `ST05` fournit des fonctions de trace système, notamment la trace SQL. Selon le système, elle peut aussi couvrir d’autres catégories techniques comme les accès buffer, les contrôles d’autorisation, les enqueues ou les appels RFC[^terme-rfc].

Ce chapitre se concentre sur l’usage développeur pour comprendre les accès produits par un traitement ABAP[^terme-abap].

## 15.C PROCESS

### 15.C.1 Étape 1 — Préparer une requête reproductible

Fixer utilisateur, programme, sélection et volume. Exécuter une fois sans trace et confirmer le résultat fonctionnel.

### 15.C.2 Étape 2 — Activer un périmètre restrictif

Ouvrir `ST05`, choisir la trace SQL et cibler l’utilisateur ou le contexte disponible. Vérifier qu’aucune trace concurrente incompatible n’est active.

### 15.C.3 Étape 3 — Capturer uniquement l’action utile

Activer, exécuter une seule fois puis désactiver immédiatement. Une trace contenant connexion, navigation et plusieurs tests rend les temps difficiles à attribuer.

### 15.C.4 Étape 4 — Filtrer et agréger

Afficher la trace, filtrer sur programme ou table, puis regrouper les instructions identiques. Examiner durée cumulée, exécutions, lignes examinées et lignes retournées.

### 15.C.5 Étape 5 — Analyser la cause

Distinguer requête lente unique, requête répétée en boucle, prédicat non sélectif et volume excessif. Ouvrir l’explication du plan lorsque nécessaire.

### 15.C.6 Étape 6 — Mesurer après correction

Répéter exactement la capture. La correction est validée lorsque temps, exécutions ou volume diminuent avec un résultat fonctionnel inchangé.

```mermaid
flowchart LR
    A["Activer la trace"] --> B["Exécuter le scénario"]
    B --> C["Désactiver la trace"]
    C --> D["Afficher les résultats"]
    D --> E["Identifier les accès dominants"]
```

## 15.D INFORMATIONS À EXAMINER

- instruction SQL ;
- table ou vue ;
- nombre d’exécutions ;
- durée ;
- nombre de lignes ;
- clé ou prédicats utilisés ;
- programme et position d’appel ;
- préparation et exécution ;
- répétition de requêtes identiques.

## 15.E SIGNES CLASSIQUES

- `SELECT` dans une boucle ;
- requête exécutée des milliers de fois ;
- lecture d’un volume très supérieur au besoin ;
- absence de critère sélectif ;
- tri ou agrégation côté application alors que la base peut le faire ;
- accès à une table non nécessaire ;
- récupération de toutes les colonnes.

## 15.F TRACE D AUTORISATION

La trace système peut également aider à analyser certains contrôles d’autorisation. Limiter le périmètre et interpréter les résultats avec le responsable sécurité ; un contrôle échoué peut être volontaire et suivi d’une alternative autorisée.

## 15.G PRÉCAUTIONS

- ne jamais laisser la trace active ;
- éviter une trace globale sur un système chargé ;
- cibler l’utilisateur ;
- supprimer les données de trace devenues inutiles ;
- protéger les résultats contenant des valeurs techniques ou métier.

## 15.H VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 15.I ERREURS FRÉQUENTES

- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## 15.J FICHE DE CONTRÔLE À COPIER

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

## 15.K TERMES DU LEXIQUE

- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 15.L RÉFÉRENCES OFFICIELLES SAP

- [SQL Performance Monitoring — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/a24970c68fcf4770a64bf9a78e3719e2/355d59ff44ce4f789d6b29cda7ec45fa.html)
- [Preparations for SQL Trace — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/a24970c68fcf4770a64bf9a78e3719e2/9f6bbd60512c488499c02065ceb6033b.html)
- [System Trace — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/e067931e0b0a4b2089f4db327879cd55/47cc212e3fa5296fe10000000a42189b.html)

---

[Chapitre suivant — ANALYSE CIBLÉE AVEC ST12](<./16 ├── ANALYSE CIBLEE AVEC ST12.md>)

[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-rfc]: **RFC.** Remote Function Call, mécanisme permettant d’appeler un module fonction compatible dans un autre contexte ou système. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#rfc>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).

[^outil-st05]: **ST05.** Performance Trace utilisée notamment pour enregistrer et analyser les accès SQL. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/08 ├── ANALYSER LES ACCES SQL AVEC ST05.md>).
