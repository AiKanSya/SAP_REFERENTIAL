# 🌸 PRINCIPES D’ABAP SQL

## 🌺 OBJECTIFS

- Comprendre le rôle d’ABAP SQL
- Distinguer ABAP SQL, SQL natif et traitements ABAP
- Comprendre le passage par l’interface de base de données
- Identifier les opérations de lecture et de modification
- Délimiter le périmètre du dossier

## 🌺 DÉFINITION

**ABAP SQL** est le langage SQL intégré à ABAP pour accéder aux sources de données gérées par le système ABAP.

Le nom historique **Open SQL** reste très utilisé dans les projets et dans certaines transactions. La documentation récente emploie principalement le nom **ABAP SQL**.

```mermaid
flowchart LR
    A["Programme ABAP"] --> B["Instruction ABAP SQL"]
    B --> C["Interface de base de données ABAP"]
    C --> D["SQL adapté au système de base de données"]
    D --> E["Base de données"]
```

L’interface de base de données assure notamment :

- l’adaptation au système de base de données utilisé ;
- la conversion entre types ABAP et types de base de données ;
- la gestion implicite du mandant pour les sources concernées ;
- l’utilisation éventuelle du buffer de tables ABAP.

## 🌺 PRINCIPALES INSTRUCTIONS

| Instruction | Fonction                                        |
| ----------- | ----------------------------------------------- |
| `SELECT`    | Lire des données                                |
| `INSERT`    | Ajouter de nouvelles lignes                     |
| `UPDATE`    | Modifier des lignes existantes                  |
| `MODIFY`    | Insérer ou modifier selon l’existence de la clé |
| `DELETE`    | Supprimer des lignes                            |

## 🌺 ABAP SQL ET SQL NATIF

| ABAP SQL                                     | SQL natif                                     |
| -------------------------------------------- | --------------------------------------------- |
| Syntaxe intégrée au langage ABAP             | Syntaxe propre au système de base de données  |
| Indépendance plus forte vis-à-vis de la base | Dépendance au moteur de base de données       |
| Gestion ABAP du mandant et du buffer         | Accès direct sans ces mécanismes ABAP         |
| Contrôle de syntaxe avec les objets DDIC     | Contrôle dépendant de la technologie utilisée |

Utiliser ABAP SQL par défaut pour les accès classiques depuis un programme ABAP. Le SQL natif, ADBC, AMDP et les CDS seront traités dans des dossiers spécialisés.

## 🌺 CODE PUSH-DOWN

Une opération réalisable efficacement dans l’instruction SQL doit généralement être exécutée par la base de données plutôt qu’après transfert massif des données vers le serveur ABAP.

```mermaid
flowchart LR
    A["Filtrer, joindre et agréger en base"] --> B["Résultat utile seulement"]
    B --> C["Transfert réduit vers le serveur ABAP"]
```

Cela ne signifie pas qu’il faut placer toute la logique métier dans SQL. La règle consiste à confier à la base les opérations ensemblistes pour lesquelles elle est conçue.

## 🌺 TABLES DE DÉMONSTRATION

Les exemples de lecture utilisent principalement `SCARR`, `SPFLI` et `SFLIGHT`, tables de démonstration historiques du modèle de vols SAP.

> [!NOTE]
> Leur disponibilité dépend du système. Adapter les exemples à une table de démonstration ou à un objet client présent dans l’environnement.

Les exemples d’écriture utilisent une table fictive `ZDEV_PRODUCT`. Ils ne doivent pas être exécutés sur une table applicative SAP standard.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire et vérifier une instruction ABAP SQL utilisant principes d’abap sql sur un jeu de données maîtrisé**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

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

- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire et vérifier une instruction ABAP SQL utilisant principes d’abap sql sur un jeu de données maîtrisé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)


---

➡️ [Chapitre suivant — SOURCES DE DONNÉES, MANDANT ET BUFFER](<./02 - 🍧 SOURCES DE DONNEES MANDANT ET BUFFER.md>)
