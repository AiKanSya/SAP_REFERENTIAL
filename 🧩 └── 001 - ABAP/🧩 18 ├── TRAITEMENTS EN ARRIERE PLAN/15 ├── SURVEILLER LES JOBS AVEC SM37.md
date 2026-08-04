# SURVEILLER LES JOBS AVEC `SM37`

## RÉSULTAT ATTENDU

- Rechercher un job de manière fiable
- Lire ses propriétés et ses étapes
- Accéder aux éléments de diagnostic

## SÉLECTION

Les filtres principaux sont :

- nom du job ;
- utilisateur ;
- intervalle de dates ;
- statut ;
- programme exécuté ;
- condition de démarrage ;
- client selon les autorisations.

Éviter une recherche trop large en production. Commencer par un nom ou un utilisateur et une fenêtre temporelle précise.

## INFORMATIONS À CONTRÔLER

- statut ;
- date et heure prévues ;
- début et fin réels ;
- durée ;
- serveur d’exécution ;
- étapes, programmes et variantes ;
- utilisateur d’exécution ;
- journal ;
- spool ;
- éventuelle périodicité.

## ACTIONS

Selon le statut et les autorisations, `SM37` permet notamment de :

- afficher ;
- libérer ou retirer la libération ;
- copier ;
- replanifier ;
- supprimer ;
- annuler un job actif ;
- afficher le journal et le spool ;
- lancer un diagnostic ou un debug.

## RÈGLE D’EXPLOITATION

Avant toute action destructive, capturer le nom, le numéro, les étapes, le journal, la variante et les horaires. Le numéro du job distingue plusieurs occurrences portant le même nom.

## PROCESS

### ÉTAPE 1 — DÉLIMITER LA RECHERCHE

Relever le nom ou son motif, l’utilisateur, le mandant et la période. Saisir `/nSM37` et sélectionner uniquement les statuts utiles. Une plage trop large augmente le risque d’ouvrir une occurrence homonyme.

### ÉTAPE 2 — IDENTIFIER L’OCCURRENCE EXACTE

Comparer heure prévue, début, fin, statut et numéro de job. Ouvrir les détails pour relever classe, serveur, créateur et condition de démarrage. Conserver ces informations avant toute action.

### ÉTAPE 3 — ANALYSER LES ÉTAPES

Afficher la liste des étapes et identifier programme, variante, utilisateur et type de commande. Pour un job actif, déterminer l’étape courante. Pour un job annulé, localiser la première étape qui n’a pas atteint son résultat attendu.

### ÉTAPE 4 — LIRE JOURNAL ET SPOOL

Ouvrir le journal de job, puis chaque spool utile. Relever les messages dans l’ordre chronologique, les compteurs et les identifiants métier. Corréler l’heure avec `ST22`, le journal applicatif ou les traces seulement si le message le justifie.

### ÉTAPE 5 — VÉRIFIER LE RÉSULTAT MÉTIER

Contrôler le fichier, les documents, la table de pilotage ou le journal applicatif attendus. Un statut « Terminé » indique la fin technique du job, pas nécessairement la réussite fonctionnelle de toutes les unités.

### ÉTAPE 6 — DÉCIDER DE L’ACTION

Classer l’occurrence comme normale, en retard, bloquée, annulée ou terminée avec anomalie métier. Corriger la cause et vérifier l’idempotence avant toute relance, copie ou replanification. Documenter l’identifiant initial et le résultat final.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## FICHE DE CONTRÔLE À COPIER

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

## TERMES DU LEXIQUE

- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [Managing Jobs from the Job Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc2224c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

[Chapitre suivant — STATUTS D’UN JOB](<./16 ├── STATUTS D UN JOB.md>)
