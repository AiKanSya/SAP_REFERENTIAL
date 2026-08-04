# EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC

## RÉSULTAT ATTENDU

- Exploiter une interface sans présence utilisateur
- Diagnostiquer les échecs
- Appliquer une checklist de livraison

## ARRIÈRE-PLAN

Un job de fond ne dispose pas du poste utilisateur. Toute dépendance à `CL_GUI_FRONTEND_SERVICES` doit être supprimée du chemin automatique.

Vérifier :

- l’utilisateur du job ;
- ses autorisations `S_DATASET` et `S_PATH` ;
- l’instance d’exécution ;
- la visibilité du répertoire ;
- les variantes ;
- les horaires de dépôt ;
- la concurrence entre jobs.

## DIAGNOSTIC

| Symptôme              | Vérification                                                 |
| --------------------- | ------------------------------------------------------------ |
| Fichier introuvable   | Nom logique, instance, chemin, date de dépôt                 |
| Ouverture refusée     | Autorisations SAP et OS                                      |
| Caractères incorrects | Encodage, BOM, double conversion                             |
| Fichier partiel       | Dump, arrêt de job, espace disque, fermeture                 |
| Doublons              | Identifiant de lot, reprise, commit                          |
| Fichier bloqué        | Producteur encore en écriture, verrou externe                |
| Job vert sans données | Critères, fichier vide, erreurs uniquement en log applicatif |

## JOURNALISATION

Le journal doit contenir :

- nom logique et nom physique ;
- identifiant du lot ;
- heure de début et de fin ;
- nombre de lignes lues, acceptées et rejetées ;
- objets métier créés ou modifiés ;
- messages techniques et métier ;
- statut final et action de reprise.

Utiliser le journal applicatif lorsque l’interface doit être exploitée par les équipes support, plutôt que de dépendre uniquement de la liste du job.

## CHECKLIST

- [ ] Emplacement serveur ou frontend justifié
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

## PROCESS

### ÉTAPE 1 — IDENTIFIER L’EXÉCUTION EXACTE

Dans `SM37`, rechercher le job avec son nom, son utilisateur, son intervalle de dates et son statut. Ouvrir l’étape pour relever le programme, la variante et le serveur d’exécution. Comparer ces paramètres à ceux du scénario attendu avant d’analyser le code.

### ÉTAPE 2 — LOCALISER LA PREMIÈRE ERREUR PROUVÉE

Lire le journal du job et le spool. Corréler l’heure avec `ST22` pour les dumps et avec le journal applicatif si l’interface l’utilise. Relever le fichier, l’unité métier, le numéro de ligne, le message complet et le dernier statut persistant ; ne pas déduire la cause du seul statut « Annulé ».

### ÉTAPE 3 — VÉRIFIER LE FICHIER DANS LE BON CONTEXTE

Résoudre le nom logique avec les mêmes paramètres que le job, puis contrôler le répertoire sur le serveur d’application concerné. Vérifier existence, taille, horodatage, droits, encodage et preuve de fin de dépôt. Un contrôle depuis le poste utilisateur ou un autre serveur ne prouve pas que le job voyait le même fichier.

### ÉTAPE 4 — DÉTERMINER LE POINT DE REPRISE

Consulter le journal de traitement ou la table de pilotage afin d’identifier les unités déjà validées par `COMMIT WORK`. La reprise commence à la première unité non validée, jamais au dernier message affiché. Vérifier que la clé idempotente empêche de recréer les unités déjà enregistrées.

### ÉTAPE 5 — CORRIGER LA CAUSE AVANT DE RELANCER

Corriger la donnée, l’autorisation, le chemin logique, l’encodage ou le défaut de programme identifié. Conserver le fichier initial et les preuves du premier passage. Si un nouveau fichier corrigé est déposé, lui attribuer un identifiant distinct ou appliquer explicitement la règle de remplacement prévue.

### ÉTAPE 6 — RELANCER AVEC UN PÉRIMÈTRE MAÎTRISÉ

Exécuter d’abord en développement ou en qualité avec la même variante et un fichier représentatif. En production, relancer uniquement l’étape ou l’unité prévue par la conception de reprise. Éviter une relance complète tant que son innocuité sur les données déjà validées n’est pas démontrée.

### ÉTAPE 7 — VALIDER LE RÉSULTAT MÉTIER

Comparer les compteurs lus, acceptés, rejetés et enregistrés avant et après reprise. Vérifier l’absence de doublons, le statut final du fichier, son archivage et le journal applicatif. Le job est résolu seulement si le résultat métier attendu est atteint, pas uniquement parce que `SM37` affiche « Terminé ».

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
