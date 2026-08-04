# PERFORMANCE, ANALYSE ET BONNES PRATIQUES

## RÉSULTAT ATTENDU

- Réduire les accès inutiles à la base
- Limiter le volume transféré
- Choisir entre jointure, agrégation et traitement ABAP
- Utiliser les outils SAP GUI d’analyse SQL
- Appliquer une checklist avant livraison

## RÈGLES PRIORITAIRES

1. Sélectionner uniquement les colonnes nécessaires.
2. Restreindre les lignes avec une condition sélective.
3. Éviter les `SELECT` dans les boucles.
4. Regrouper les lectures lorsque cela est possible.
5. Effectuer les jointures et agrégations en base.
6. Ne pas dépendre d’un ordre sans `ORDER BY`.
7. Contrôler la table pilote avant `FOR ALL ENTRIES`.
8. Utiliser les API métier pour modifier les données SAP.

## SELECT DANS UNE BOUCLE

```mermaid
flowchart LR
    A["Boucle de 1 000 lignes"] --> B["1 000 SELECT individuels"]
    B --> C["Nombreux allers-retours base"]
```

Remplacer ce schéma par :

- une jointure ;
- un `FOR ALL ENTRIES` maîtrisé ;
- une condition `IN` ;
- une lecture groupée suivie d’un accès efficace en table interne.

## FILTRER ET AGRÉGER EN BASE

Éviter de lire un ensemble massif uniquement pour :

- éliminer ensuite la majorité des lignes ;
- calculer une somme ;
- compter les lignes ;
- rechercher un minimum ou un maximum ;
- joindre manuellement deux collections.

## INDEX ET SÉLECTIVITÉ

Une condition n’utilise pas automatiquement un index. Le choix dépend notamment :

- des colonnes filtrées ;
- de l’ordre des colonnes de l’index ;
- de la sélectivité ;
- des statistiques de base ;
- du volume ;
- du système de base de données.

Ne pas créer un index secondaire sans mesure et sans analyse de son coût sur les écritures.

## OUTILS SAP GUI

| Outil         | Usage principal                                         |
| ------------- | ------------------------------------------------------- |
| `ST05`        | Trace SQL détaillée d’un scénario ciblé                 |
| `ST12`        | Analyse combinée ABAP et SQL selon disponibilité        |
| `SAT`         | Analyse du temps d’exécution ABAP                       |
| `SQLM`        | Collecte agrégée des instructions SQL exécutées         |
| `SWLT`        | Combinaison d’analyses statiques et données SQL Monitor |
| `ATC` / `SCI` | Contrôles statiques et règles de qualité                |

Les autorisations et transactions disponibles dépendent du système.

## CHECKLIST

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

## PROCESS

### Étape 1 — Reproduire le scénario lent

Fixer programme ou transaction, utilisateur, sélection et volume. Exécuter une fois et relever le temps observable. Sans données identiques, les mesures avant/après ne sont pas comparables.

### Étape 2 — Tracer les accès SQL

Lancer `ST05` pour l’utilisateur ou le processus ciblé, reproduire une seule fois, puis arrêter immédiatement la trace. Filtrer sur le programme et classer les opérations par durée et nombre d’exécutions.

### Étape 3 — Identifier la cause dominante

Distinguer requête lente unique, requête rapide répétée dans une boucle, volume retourné excessif et prédicat non sélectif. Examiner texte SQL, lignes examinées/retournées et plan d’accès disponible.

### Étape 4 — Corriger une cause à la fois

Réduire colonnes ou lignes, regrouper les lectures, déplacer jointure/agrégation en base ou supprimer le `SELECT` de boucle. Ne créer un index qu’après preuve que le prédicat et la sélectivité le justifient.

### Étape 5 — Mesurer avec le même contexte

Répéter exactement l’étape 2, comparer durée, exécutions et volumes puis vérifier le résultat fonctionnel. La correction est validée uniquement si le coût diminue sans changer les données ni contourner l’API métier.

## VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## ERREURS FRÉQUENTES

- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Performance and Tuning — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [Statements and Operations Measured by SQL Monitor — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/a24970c68fcf4770a64bf9a78e3719e2/abad64f273364c86b4cc9c9e18762f7f.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Deepening Your ABAP Programming Knowledge — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge)


---

[Chapitre suivant — LIRE UNE CDS PROTÉGÉE ET UTILISER WITH PRIVILEGED ACCESS](<./19 └── LIRE UNE CDS PROTEGEE ET UTILISER WITH PRIVILEGED ACCESS.md>)
