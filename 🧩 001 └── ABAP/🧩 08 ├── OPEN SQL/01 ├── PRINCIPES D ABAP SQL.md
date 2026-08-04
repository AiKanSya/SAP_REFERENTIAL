# 1. PRINCIPES D’ABAP SQL

## 1.A RÉSULTAT ATTENDU

- Comprendre le rôle d’ABAP[^terme-abap] SQL[^terme-acro-sql]
- Distinguer ABAP SQL, SQL natif et traitements ABAP
- Comprendre le passage par l’interface de base de données
- Identifier les opérations de lecture et de modification
- Délimiter le périmètre du dossier

## 1.B DÉFINITION

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
- la gestion implicite du mandant[^terme-mandant] pour les sources concernées ;
- l’utilisation éventuelle du buffer de tables ABAP.

## 1.C PRINCIPALES INSTRUCTIONS

| Instruction | Fonction                                        |
| ----------- | ----------------------------------------------- |
| `SELECT`    | Lire des données                                |
| `INSERT`    | Ajouter de nouvelles lignes                     |
| `UPDATE`    | Modifier des lignes existantes                  |
| `MODIFY`    | Insérer ou modifier selon l’existence de la clé |
| `DELETE`    | Supprimer des lignes                            |

## 1.D ABAP SQL ET SQL NATIF

| ABAP SQL                                     | SQL natif                                     |
| -------------------------------------------- | --------------------------------------------- |
| Syntaxe intégrée au langage ABAP             | Syntaxe propre au système de base de données  |
| Indépendance plus forte vis-à-vis de la base | Dépendance au moteur de base de données       |
| Gestion ABAP du mandant et du buffer         | Accès direct sans ces mécanismes ABAP         |
| Contrôle de syntaxe avec les objets DDIC[^terme-acro-ddic]     | Contrôle dépendant de la technologie utilisée |

Utiliser ABAP SQL par défaut pour les accès classiques depuis un programme ABAP. Le SQL natif, ADBC, AMDP et les CDS[^terme-acro-cds] seront traités dans des dossiers spécialisés.

## 1.E CODE PUSH-DOWN

Une opération réalisable efficacement dans l’instruction SQL doit généralement être exécutée par la base de données plutôt qu’après transfert massif des données vers le serveur ABAP.

```mermaid
flowchart LR
    A["Filtrer, joindre et agréger en base"] --> B["Résultat utile seulement"]
    B --> C["Transfert réduit vers le serveur ABAP"]
```

Cela ne signifie pas qu’il faut placer toute la logique métier dans SQL. La règle consiste à confier à la base les opérations ensemblistes pour lesquelles elle est conçue.

## 1.F TABLES DE DÉMONSTRATION

Les exemples de lecture utilisent principalement `SCARR`, `SPFLI` et `SFLIGHT`, tables de démonstration historiques du modèle de vols SAP[^terme-acro-sap].

> [!NOTE]
> Leur disponibilité dépend du système. Adapter les exemples à une table de démonstration ou à un objet client présent dans l’environnement[^terme-environnement].

Les exemples d’écriture utilisent une table fictive `ZDEV_PRODUCT`. Ils ne doivent pas être exécutés sur une table applicative SAP standard.

## 1.G PROCESS

### 1.G.1 Étape 1 — Définir le résultat de la requête

Lister les colonnes attendues, les filtres obligatoires, l’unicité éventuelle et l’ordre réellement nécessaire. Déterminer si l’opération est une lecture ou une modification et identifier l’API[^terme-api] métier qui pourrait devoir être utilisée à la place d’un accès direct.

### 1.G.2 Étape 2 — Examiner la source

Afficher la table ou vue dans `SE11`[^outil-se11]. Relever clé, dépendance au mandant, types, références devise/unité, bufferisation et volume estimé. Pour un objet SAP, vérifier que la lecture directe est autorisée par le modèle applicatif.

### 1.G.3 Étape 3 — Écrire la requête minimale

Sélectionner uniquement les colonnes nécessaires, utiliser les variables hôtes avec `@` et appliquer une condition sélective. Ne pas ajouter `ORDER BY` si l’ordre n’est pas utilisé ; ne jamais supposer un ordre implicite.

### 1.G.4 Étape 4 — Traiter tous les résultats

Pour une lecture unique, traiter `SY-SUBRC = 0` et l’absence de ligne. Pour une lecture multiple, distinguer table vide et contenu valide. Pour une modification, contrôler `SY-SUBRC`, `SY-DBCNT` et la responsabilité transactionnelle.

### 1.G.5 Étape 5 — Vérifier avec des données connues

Exécuter un cas trouvé, un cas absent et une limite de volume. Comparer le résultat avec les données sources autorisées. La requête est validée lorsque le résultat est déterministe, le mandant correct et chaque absence ou erreur traitée explicitement.

## 1.H VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 1.I ERREURS FRÉQUENTES

- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode[^terme-methode] réutilisable sans contrat explicite.

## 1.J TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 1.K MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 1.L RÉFÉRENCES OFFICIELLES SAP

- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)

---

[Chapitre suivant — SOURCES DE DONNÉES, MANDANT ET BUFFER](<./02 ├── SOURCES DE DONNEES MANDANT ET BUFFER.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-acro-cds]: **CDS.** Core Data Services, langage de modélisation de vues et entités de données. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-cds>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-environnement]: **ENVIRONNEMENT.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#environnement>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).

[^outil-se11]: **SE11.** Transaction de l’ABAP Dictionary utilisée pour analyser et maintenir les objets DDIC. Voir [le chapitre associé](<../🧩 07 ├── DICTIONNAIRE ABAP/02 ├── NAVIGATION ET ANALYSE AVEC SE11.md>).
