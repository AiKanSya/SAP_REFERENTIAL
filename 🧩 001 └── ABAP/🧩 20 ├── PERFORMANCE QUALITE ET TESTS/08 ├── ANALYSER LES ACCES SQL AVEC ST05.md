# 8. ANALYSER LES ACCES SQL AVEC ST05

## 8.A RÉSULTAT ATTENDU

Tracer précisément les accès SQL[^terme-acro-sql] exécutés pendant un scénario court et reproductible.

## 8.B PROCESS

### 8.B.1 ÉTAPE 1 — PRÉPARER DEUX SESSIONS

Dans la première, ouvrir `ST05`[^outil-st05]; dans la seconde, préparer l’application juste avant l’action lente. Relever utilisateur, mandant[^terme-mandant], données et heure. Utiliser un utilisateur dédié lorsque possible pour réduire le bruit.

### 8.B.2 ÉTAPE 2 — CONFIGURER LA TRACE SQL

Sélectionner la trace[^terme-trace] SQL et limiter le périmètre à l’utilisateur ou au contexte autorisé. Vérifier qu’aucune trace concurrente incompatible n’est active. Ne pas lancer une trace globale prolongée sans coordination Basis.

### 8.B.3 ÉTAPE 3 — ACTIVER, EXÉCUTER, DÉSACTIVER

Activer immédiatement avant l’action, reproduire une seule fois puis désactiver sans attendre. Noter l’horodatage. Si le scénario échoue, conserver l’état fonctionnel exact qui correspond à la trace.

### 8.B.4 ÉTAPE 4 — FILTRER ET REGROUPER

Afficher la trace, limiter à l’intervalle et regrouper les instructions identiques. Trier par temps cumulé, temps moyen, exécutions et lignes. Identifier la source ABAP[^terme-abap] des entrées dominantes.

### 8.B.5 ÉTAPE 5 — ANALYSER L’ACCÈS

Examiner prédicats, valeurs, cardinalité et plan lorsque disponible. Rechercher SQL en boucle, sélection trop large, conversion empêchant un accès efficace ou index inadapté. Ne pas conclure sur le seul temps d’une exécution isolée.

### 8.B.6 ÉTAPE 6 — REJOUER APRÈS CORRECTION

Tracer le même scénario avec le même volume. Comparer nombre d’instructions, lignes et temps cumulé. Supprimer les traces inutiles selon les règles du système et conserver uniquement les preuves nécessaires.

## 8.C Informations à examiner

- durée totale et moyenne ;
- nombre d’exécutions ;
- lignes retournées ;
- paramètres transmis ;
- source ABAP appelante ;
- plan d’exécution lorsque disponible.

## 8.D Signaux fréquents

| Signal                           | Hypothèse                      |
| -------------------------------- | ------------------------------ |
| même requête répétée             | SQL dans une boucle            |
| beaucoup de lignes retournées    | filtre insuffisant             |
| temps moyen élevé                | plan d’accès ou volumétrie     |
| nombreuses requêtes très courtes | coût cumulé des allers-retours |

```mermaid
flowchart LR
    A["Activer ST05"] --> B["Exécuter un scénario court"]
    B --> C["Désactiver la trace"]
    C --> D["Regrouper et analyser"]
```

## 8.E Discipline d’utilisation

La trace peut capturer des données techniques sensibles et produire un volume important. Cibler l’utilisateur, limiter la durée et désactiver la trace immédiatement après le scénario. Ne pas lancer une trace globale prolongée sans coordination avec l’administration.

## 8.F Après correction

Répéter exactement le même scénario et comparer le nombre d’accès, le temps cumulé et le volume retourné.

## 8.G Références SAP officielles

- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

## 8.H VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 8.I ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 8.J FICHE DE CONTRÔLE À COPIER

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

## 8.K TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).

[^outil-st05]: **ST05.** Performance Trace utilisée notamment pour enregistrer et analyser les accès SQL. Voir [le chapitre associé](<08 ├── ANALYSER LES ACCES SQL AVEC ST05.md>).
