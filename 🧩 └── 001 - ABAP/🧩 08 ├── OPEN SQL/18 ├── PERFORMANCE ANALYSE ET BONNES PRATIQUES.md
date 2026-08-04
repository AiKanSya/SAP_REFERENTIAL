# 18. PERFORMANCE, ANALYSE ET BONNES PRATIQUES

## 18.A RÉSULTAT ATTENDU

- Réduire les accès inutiles à la base
- Limiter le volume transféré
- Choisir entre jointure, agrégation et traitement ABAP[^terme-abap]
- Utiliser les outils SAP GUI[^terme-sap-gui] d’analyse SQL[^terme-acro-sql]
- Appliquer une checklist avant livraison

## 18.B RÈGLES PRIORITAIRES

1. Sélectionner uniquement les colonnes nécessaires.
2. Restreindre les lignes avec une condition sélective.
3. Éviter les `SELECT` dans les boucles.
4. Regrouper les lectures lorsque cela est possible.
5. Effectuer les jointures et agrégations en base.
6. Ne pas dépendre d’un ordre sans `ORDER BY`.
7. Contrôler la table pilote avant `FOR ALL ENTRIES`.
8. Utiliser les API[^terme-api] métier pour modifier les données SAP.

## 18.C SELECT DANS UNE BOUCLE

```mermaid
flowchart LR
    A["Boucle de 1 000 lignes"] --> B["1 000 SELECT individuels"]
    B --> C["Nombreux allers-retours base"]
```

Remplacer ce schéma par :

- une jointure ;
- un `FOR ALL ENTRIES` maîtrisé ;
- une condition `IN` ;
- une lecture groupée suivie d’un accès efficace en table interne[^terme-table-interne].

## 18.D FILTRER ET AGRÉGER EN BASE

Éviter de lire un ensemble massif uniquement pour :

- éliminer ensuite la majorité des lignes ;
- calculer une somme ;
- compter les lignes ;
- rechercher un minimum ou un maximum ;
- joindre manuellement deux collections.

## 18.E INDEX ET SÉLECTIVITÉ

Une condition n’utilise pas automatiquement un index. Le choix dépend notamment :

- des colonnes filtrées ;
- de l’ordre des colonnes de l’index ;
- de la sélectivité ;
- des statistiques de base ;
- du volume ;
- du système de base de données.

Ne pas créer un index secondaire[^terme-index-secondaire] sans mesure et sans analyse de son coût sur les écritures.

## 18.F OUTILS SAP GUI

| Outil         | Usage principal                                         |
| ------------- | ------------------------------------------------------- |
| `ST05`[^outil-st05]        | Trace[^terme-trace] SQL détaillée d’un scénario ciblé                 |
| `ST12`[^outil-st12]        | Analyse combinée ABAP et SQL selon disponibilité        |
| `SAT`[^outil-sat]         | Analyse du temps d’exécution ABAP                       |
| `SQLM`[^outil-sqlm]        | Collecte agrégée des instructions SQL exécutées         |
| `SWLT`[^outil-swlt]        | Combinaison d’analyses statiques et données SQL Monitor |
| `ATC`[^terme-acro-atc] / `SCI`[^outil-sci] | Contrôles statiques et règles de qualité                |

Les autorisations et transactions disponibles dépendent du système.

## 18.G CHECKLIST

- [ ] La liste des colonnes est-elle minimale ?
- [ ] La condition limite-t-elle correctement le volume ?
- [ ] L’ordre du résultat est-il explicitement garanti si nécessaire ?
- [ ] La requête évite-t-elle un accès dans une boucle ?
- [ ] Une jointure ou agrégation peut-elle remplacer un traitement ABAP massif ?
- [ ] La table `FOR ALL ENTRIES` est-elle contrôlée et préparée ?
- [ ] Les écritures utilisent-elles une table client ou une API métier officielle ?
- [ ] `sy-subrc`, `sy-dbcnt` et les exceptions sont-ils traités ?
- [ ] La frontière transactionnelle est-elle gérée au bon niveau ?
- [ ] Le scénario réel a-t-il été mesuré avec un outil adapté ?

## 18.H PROCESS

### 18.H.1 Étape 1 — Reproduire le scénario lent

Fixer programme ou transaction, utilisateur, sélection et volume. Exécuter une fois et relever le temps observable. Sans données identiques, les mesures avant/après ne sont pas comparables.

### 18.H.2 Étape 2 — Tracer les accès SQL

Lancer `ST05` pour l’utilisateur ou le processus ciblé, reproduire une seule fois, puis arrêter immédiatement la trace. Filtrer sur le programme et classer les opérations par durée et nombre d’exécutions.

### 18.H.3 Étape 3 — Identifier la cause dominante

Distinguer requête lente unique, requête rapide répétée dans une boucle, volume retourné excessif et prédicat non sélectif. Examiner texte SQL, lignes examinées/retournées et plan d’accès disponible.

### 18.H.4 Étape 4 — Corriger une cause à la fois

Réduire colonnes ou lignes, regrouper les lectures, déplacer jointure/agrégation en base ou supprimer le `SELECT` de boucle. Ne créer un index qu’après preuve que le prédicat et la sélectivité le justifient.

### 18.H.5 Étape 5 — Mesurer avec le même contexte

Répéter exactement l’étape 2, comparer durée, exécutions et volumes puis vérifier le résultat fonctionnel. La correction est validée uniquement si le coût diminue sans changer les données ni contourner l’API métier.

## 18.I VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 18.J ERREURS FRÉQUENTES

- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode[^terme-methode] réutilisable sans contrat explicite.

## 18.K TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 18.L RÉFÉRENCES OFFICIELLES SAP

- [ABAP Performance and Tuning — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [Statements and Operations Measured by SQL Monitor — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/a24970c68fcf4770a64bf9a78e3719e2/abad64f273364c86b4cc9c9e18762f7f.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Deepening Your ABAP Programming Knowledge — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge)


---

[Chapitre suivant — LIRE UNE CDS PROTÉGÉE ET UTILISER WITH PRIVILEGED ACCESS](<./19 └── LIRE UNE CDS PROTEGEE ET UTILISER WITH PRIVILEGED ACCESS.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-index-secondaire]: **INDEX SECONDAIRE.** Structure de base de données supplémentaire accélérant certains accès au prix d’un coût de stockage et de maintenance. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#index-secondaire>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).

[^outil-st05]: **ST05.** Performance Trace utilisée notamment pour enregistrer et analyser les accès SQL. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/08 ├── ANALYSER LES ACCES SQL AVEC ST05.md>).
[^outil-st12]: **ST12.** Outil d’analyse ciblée combinant des traces ABAP et SQL pour un scénario reproduit. Voir [le chapitre associé](<../🧩 11 ├── DEBUG ET ANALYSE/16 ├── ANALYSE CIBLEE AVEC ST12.md>).
[^outil-sat]: **SAT.** Runtime Analysis utilisée pour mesurer et analyser le temps d’exécution ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/07 ├── MESURER LE TEMPS D EXECUTION AVEC SAT.md>).
[^outil-sqlm]: **SQLM.** SQL Monitor utilisé pour agréger l’usage des instructions SQL pendant une période d’enregistrement. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/09 ├── SURVEILLER LES ACCES SQL AVEC SQLM.md>).
[^outil-swlt]: **SWLT.** SQL Performance Tuning Worklist utilisée pour rapprocher usage productif et résultats de contrôles statiques. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/10 ├── PRIORISER AVEC SWLT.md>).
[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/13 ├── CODE INSPECTOR AVEC SCI.md>).
