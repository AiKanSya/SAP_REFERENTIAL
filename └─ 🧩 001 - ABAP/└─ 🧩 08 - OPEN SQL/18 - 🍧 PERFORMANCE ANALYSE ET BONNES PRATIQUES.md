# 🌸 PERFORMANCE, ANALYSE ET BONNES PRATIQUES

## 🌺 OBJECTIFS

- Réduire les accès inutiles à la base
- Limiter le volume transféré
- Choisir entre jointure, agrégation et traitement ABAP
- Utiliser les outils SAP GUI d’analyse SQL
- Appliquer une checklist avant livraison

## 🌺 RÈGLES PRIORITAIRES

1. Sélectionner uniquement les colonnes nécessaires.
2. Restreindre les lignes avec une condition sélective.
3. Éviter les `SELECT` dans les boucles.
4. Regrouper les lectures lorsque cela est possible.
5. Effectuer les jointures et agrégations en base.
6. Ne pas dépendre d’un ordre sans `ORDER BY`.
7. Contrôler la table pilote avant `FOR ALL ENTRIES`.
8. Utiliser les API métier pour modifier les données SAP.

## 🌺 SELECT DANS UNE BOUCLE

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

## 🌺 FILTRER ET AGRÉGER EN BASE

Éviter de lire un ensemble massif uniquement pour :

- éliminer ensuite la majorité des lignes ;
- calculer une somme ;
- compter les lignes ;
- rechercher un minimum ou un maximum ;
- joindre manuellement deux collections.

## 🌺 INDEX ET SÉLECTIVITÉ

Une condition n’utilise pas automatiquement un index. Le choix dépend notamment :

- des colonnes filtrées ;
- de l’ordre des colonnes de l’index ;
- de la sélectivité ;
- des statistiques de base ;
- du volume ;
- du système de base de données.

Ne pas créer un index secondaire sans mesure et sans analyse de son coût sur les écritures.

## 🌺 OUTILS SAP GUI

| Outil         | Usage principal                                         |
| ------------- | ------------------------------------------------------- |
| `ST05`        | Trace SQL détaillée d’un scénario ciblé                 |
| `ST12`        | Analyse combinée ABAP et SQL selon disponibilité        |
| `SAT`         | Analyse du temps d’exécution ABAP                       |
| `SQLM`        | Collecte agrégée des instructions SQL exécutées         |
| `SWLT`        | Combinaison d’analyses statiques et données SQL Monitor |
| `ATC` / `SCI` | Contrôles statiques et règles de qualité                |

Les autorisations et transactions disponibles dépendent du système.

## 🌺 CHECKLIST

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

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**. Cette notion est pertinente lorsque le volume ou le temps de réponse justifie une mesure et un choix fondé sur des données.

## 🌺 PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## 🌺 VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 🌺 ERREURS FRÉQUENTES

- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Performance and Tuning — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [Statements and Operations Measured by SQL Monitor — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/a24970c68fcf4770a64bf9a78e3719e2/abad64f273364c86b4cc9c9e18762f7f.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Deepening Your ABAP Programming Knowledge — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge)
