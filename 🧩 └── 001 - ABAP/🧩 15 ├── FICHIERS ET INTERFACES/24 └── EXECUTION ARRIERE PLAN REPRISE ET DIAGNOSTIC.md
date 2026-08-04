# 24. EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC

## 24.A RÉSULTAT ATTENDU

- Exploiter une interface sans présence utilisateur
- Diagnostiquer les échecs
- Appliquer une checklist de livraison

## 24.B ARRIÈRE-PLAN

Un job[^terme-job] de fond ne dispose pas du poste utilisateur. Toute dépendance à `CL_GUI_FRONTEND_SERVICES` doit être supprimée du chemin automatique.

Vérifier :

- l’utilisateur du job ;
- ses autorisations `S_DATASET` et `S_PATH` ;
- l’instance d’exécution ;
- la visibilité[^terme-visibilite] du répertoire ;
- les variantes ;
- les horaires de dépôt ;
- la concurrence entre jobs.

## 24.C DIAGNOSTIC

| Symptôme              | Vérification                                                 |
| --------------------- | ------------------------------------------------------------ |
| Fichier introuvable   | Nom logique, instance, chemin, date de dépôt                 |
| Ouverture refusée     | Autorisations SAP[^terme-acro-sap] et OS                                      |
| Caractères incorrects | Encodage[^terme-encodage], BOM, double conversion                             |
| Fichier partiel       | Dump, arrêt de job, espace disque, fermeture                 |
| Doublons              | Identifiant de lot, reprise, commit                          |
| Fichier bloqué        | Producteur encore en écriture, verrou externe                |
| Job vert sans données | Critères, fichier vide, erreurs uniquement en log applicatif |

## 24.D JOURNALISATION

Le journal doit contenir :

- nom logique et nom physique ;
- identifiant du lot ;
- heure de début et de fin ;
- nombre de lignes lues, acceptées et rejetées ;
- objets métier créés ou modifiés ;
- messages techniques et métier ;
- statut final et action de reprise.

Utiliser le journal applicatif lorsque l’interface doit être exploitée par les équipes support, plutôt que de dépendre uniquement de la liste du job.

## 24.E CHECKLIST

- [ ] Emplacement serveur ou frontend[^terme-frontend] justifié
- [ ] Aucun chemin physique codé en dur
- [ ] Encodage et format documentés
- [ ] Autorisations testées avec l’utilisateur réel
- [ ] Fichier fermé dans tous les chemins
- [ ] Volume et mémoire maîtrisés
- [ ] Numéros de ligne conservés
- [ ] Doublons et reprise définis
- [ ] Succès partiel défini
- [ ] Publication d’un fichier complet uniquement
- [ ] Archive et purge définies
- [ ] Logs exploitables sans débogage
- [ ] Test DEV, QAS et exécution en job

## 24.F PROCESS

### 24.F.1 ÉTAPE 1 — IDENTIFIER L’EXÉCUTION EXACTE

Dans `SM37`[^outil-sm37], rechercher le job avec son nom, son utilisateur, son intervalle de dates et son statut. Ouvrir l’étape pour relever le programme, la variante et le serveur d’exécution. Comparer ces paramètres à ceux du scénario attendu avant d’analyser le code.

### 24.F.2 ÉTAPE 2 — LOCALISER LA PREMIÈRE ERREUR PROUVÉE

Lire le journal du job et le spool[^terme-spool]. Corréler l’heure avec `ST22`[^outil-st22] pour les dumps et avec le journal applicatif si l’interface l’utilise. Relever le fichier, l’unité métier, le numéro de ligne, le message complet et le dernier statut persistant ; ne pas déduire la cause du seul statut « Annulé ».

### 24.F.3 ÉTAPE 3 — VÉRIFIER LE FICHIER DANS LE BON CONTEXTE

Résoudre le nom logique avec les mêmes paramètres que le job, puis contrôler le répertoire sur le serveur d’application[^terme-fichier-serveur-application] concerné. Vérifier existence, taille, horodatage, droits, encodage et preuve de fin de dépôt. Un contrôle depuis le poste utilisateur ou un autre serveur ne prouve pas que le job voyait le même fichier.

### 24.F.4 ÉTAPE 4 — DÉTERMINER LE POINT DE REPRISE

Consulter le journal de traitement ou la table de pilotage afin d’identifier les unités déjà validées par `COMMIT WORK`[^terme-commit-work]. La reprise commence à la première unité non validée, jamais au dernier message affiché. Vérifier que la clé idempotente empêche de recréer les unités déjà enregistrées.

### 24.F.5 ÉTAPE 5 — CORRIGER LA CAUSE AVANT DE RELANCER

Corriger la donnée, l’autorisation, le chemin logique, l’encodage ou le défaut de programme identifié. Conserver le fichier initial et les preuves du premier passage. Si un nouveau fichier corrigé est déposé, lui attribuer un identifiant distinct ou appliquer explicitement la règle de remplacement prévue.

### 24.F.6 ÉTAPE 6 — RELANCER AVEC UN PÉRIMÈTRE MAÎTRISÉ

Exécuter d’abord en développement ou en qualité avec la même variante et un fichier représentatif. En production, relancer uniquement l’étape ou l’unité prévue par la conception de reprise. Éviter une relance complète tant que son innocuité sur les données déjà validées n’est pas démontrée.

### 24.F.7 ÉTAPE 7 — VALIDER LE RÉSULTAT MÉTIER

Comparer les compteurs lus, acceptés, rejetés et enregistrés avant et après reprise. Vérifier l’absence de doublons, le statut final du fichier, son archivage et le journal applicatif. Le job est résolu seulement si le résultat métier attendu est atteint, pas uniquement parce que `SM37` affiche « Terminé ».

## 24.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 24.H ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 24.I TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 24.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)

[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-fichier-serveur-application]: **SERVEUR D’APPLICATION.** Emplacement du backend où un programme ABAP peut lire ou écrire avec `OPEN DATASET`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).

[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<../🧩 18 ├── TRAITEMENTS EN ARRIERE PLAN/15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
[^outil-st22]: **ST22.** Transaction d’analyse des terminaisons anormales et dumps ABAP. Voir [le chapitre associé](<../🧩 11 ├── DEBUG ET ANALYSE/13 ├── ANALYSER LES DUMPS AVEC ST22.md>).
