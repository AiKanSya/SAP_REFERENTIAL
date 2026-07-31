# 🌸 SURVEILLER LES JOBS AVEC `SM37`

## 🌺 OBJECTIFS

- Rechercher un job de manière fiable
- Lire ses propriétés et ses étapes
- Accéder aux éléments de diagnostic

## 🌺 SÉLECTION

Les filtres principaux sont :

- nom du job ;
- utilisateur ;
- intervalle de dates ;
- statut ;
- programme exécuté ;
- condition de démarrage ;
- client selon les autorisations.

Éviter une recherche trop large en production. Commencer par un nom ou un utilisateur et une fenêtre temporelle précise.

## 🌺 INFORMATIONS À CONTRÔLER

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

## 🌺 ACTIONS

Selon le statut et les autorisations, `SM37` permet notamment de :

- afficher ;
- libérer ou retirer la libération ;
- copier ;
- replanifier ;
- supprimer ;
- annuler un job actif ;
- afficher le journal et le spool ;
- lancer un diagnostic ou un debug.

## 🌺 RÈGLE D’EXPLOITATION

Avant toute action destructive, capturer le nom, le numéro, les étapes, le journal, la variante et les horaires. Le numéro du job distingue plusieurs occurrences portant le même nom.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Managing Jobs from the Job Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc2224c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

➡️ [Chapitre suivant — STATUTS D UN JOB](<./16 - 🍧 STATUTS D UN JOB.md>)
