# 12. DEBUG DES JOBS ET TRAITEMENTS EN ARRIÈRE-PLAN

## 12.A RÉSULTAT ATTENDU

- Comprendre les différences entre dialogue et arrière-plan
- Déboguer un job[^terme-job] sélectionné dans `SM37`[^outil-sm37]
- Contrôler variante, utilisateur et étape du job
- Identifier les limites de la simulation dialoguée
- Éviter de perturber un job productif

## 12.B CONTEXTE D UN JOB

Un job de fond possède notamment :

- un utilisateur d’exécution ;
- une ou plusieurs étapes ;
- un programme ou une commande ;
- une variante ;
- une condition de démarrage ;
- un journal et éventuellement un spool[^terme-spool].

Avant de déboguer, vérifier que le problème ne provient pas simplement de la variante ou de l’utilisateur du job.

## 12.C DÉBOGAGE AVEC SM37

SAP[^terme-acro-sap] documente une procédure de débogage d’un job sélectionné dans `SM37` à l’aide de la commande `JDBG`[^outil-jdbg]. Le job et ses étapes sont alors exécutés dans un processus dialogué afin de permettre l’utilisation des outils habituels du débogueur.

Cette opération doit être réalisée sur un job approprié et avec les autorisations nécessaires.

## 12.D LIMITES DE LA SIMULATION

La simulation conserve certaines caractéristiques d’un traitement de fond, notamment `sy-batch = 'X'`, mais elle ne reproduit pas parfaitement tous les comportements d’un véritable processus de fond.

Différences possibles :

- zones mémoire ;
- absence d’accès réel à SAP GUI[^terme-sap-gui] ;
- environnement[^terme-environnement] de spool ;
- temporisation ;
- parallélisme ;
- appels externes ;
- ressources disponibles.

## 12.E MÉTHODE

```mermaid
flowchart TD
    A["Identifier le job et l étape"] --> B["Contrôler utilisateur et variante"]
    B --> C["Reproduire sur environnement adapté"]
    C --> D["Démarrer le debug du job"]
    D --> E["Comparer journal, spool et valeurs"]
```

## 12.F POINTS À CONTRÔLER

- `sy-batch` ;
- `sy-uname` ;
- `sy-repid` ;
- variante réellement chargée ;
- paramètres de sélection ;
- droits de l’utilisateur du job ;
- fichiers et chemins serveur ;
- dépendances à une interface graphique ;
- `COMMIT WORK`[^terme-commit-work] et mises à jour ;
- temporisation ou volume de données.

## 12.G ALTERNATIVE AU DEBUG

Pour un job long ou difficile à reproduire, préférer parfois :

- journal applicatif ;
- spool ;
- dump `ST22`[^outil-st22] ;
- analyse `SAT`[^outil-sat] ou `ST12`[^outil-st12] ;
- traces d’interface ;
- instrumentation temporaire contrôlée.

## 12.H PROCESS

### 12.H.1 Étape 1 — Identifier l’instance exacte

Ouvrir `SM37`, renseigner nom, utilisateur, statut et intervalle précis. Comparer heure de début et numéro de job avec le symptôme ; deux exécutions du même nom ne sont pas interchangeables.

### 12.H.2 Étape 2 — Lire le contexte avant de relancer

Ouvrir étapes, programme, variante, utilisateur d’exécution, serveur, journal et spool. Relever le premier message en erreur et les traitements déjà terminés.

### 12.H.3 Étape 3 — Déterminer le point de debug

Si le job peut être reproduit sans effet dangereux, utiliser le mécanisme de debug de job disponible depuis `SM37` ou exécuter le programme avec la même variante et le même utilisateur dans un environnement de test.

### 12.H.4 Étape 4 — Comparer dialogue et arrière-plan

Contrôler autorisations, paramètres utilisateur, accès frontend[^terme-frontend] interdit, fichiers serveur, formats de date/nombre et commit. Un succès en dialogue ne prouve pas le succès avec l’utilisateur du job.

### 12.H.5 Étape 5 — Valider sans doublon

Corriger puis créer une nouvelle exécution contrôlée. Vérifier journal, spool et documents déjà créés avant toute reprise. Le diagnostic est terminé lorsque le job finit dans le statut attendu sans répéter un effet métier.

## 12.I VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace[^terme-trace] ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 12.J ERREURS FRÉQUENTES

- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## 12.K FICHE DE CONTRÔLE À COPIER

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

## 12.L TERMES DU LEXIQUE

- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 12.M RÉFÉRENCES OFFICIELLES SAP

- [Starting and Directly Debugging ABAP Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)
- [Batch Debugging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/bf1a5464da734b559d94199e80926005.html)

---

[Chapitre suivant — ANALYSER LES DUMPS AVEC ST22](<./13 ├── ANALYSER LES DUMPS AVEC ST22.md>)

[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-environnement]: **ENVIRONNEMENT.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#environnement>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).

[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<../🧩 18 ├── TRAITEMENTS EN ARRIERE PLAN/15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
[^outil-jdbg]: **JDBG.** Commande utilisée depuis SM37 pour démarrer le débogage contrôlé d’un job sélectionné. Voir [le chapitre associé](<../🧩 18 ├── TRAITEMENTS EN ARRIERE PLAN/20 ├── DEBUGGER UN JOB AVEC JDBG.md>).
[^outil-st22]: **ST22.** Transaction d’analyse des terminaisons anormales et dumps ABAP. Voir [le chapitre associé](<13 ├── ANALYSER LES DUMPS AVEC ST22.md>).
[^outil-sat]: **SAT.** Runtime Analysis utilisée pour mesurer et analyser le temps d’exécution ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/07 ├── MESURER LE TEMPS D EXECUTION AVEC SAT.md>).
[^outil-st12]: **ST12.** Outil d’analyse ciblée combinant des traces ABAP et SQL pour un scénario reproduit. Voir [le chapitre associé](<16 ├── ANALYSE CIBLEE AVEC ST12.md>).
