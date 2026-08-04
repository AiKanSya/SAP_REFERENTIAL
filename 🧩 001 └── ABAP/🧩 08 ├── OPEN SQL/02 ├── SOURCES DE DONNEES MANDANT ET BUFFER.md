# 2. SOURCES DE DONNÉES, MANDANT ET BUFFER

## 2.A RÉSULTAT ATTENDU

- Identifier les sources utilisables dans ABAP[^terme-abap] SQL[^terme-acro-sql]
- Comprendre la gestion implicite du mandant[^terme-mandant]
- Comprendre l’influence du buffer de tables
- Éviter les accès inter-mandants[^terme-inter-mandants] non maîtrisés
- Distinguer données persistantes et résultats calculés

## 2.B SOURCES DE DONNÉES

Une instruction `SELECT` peut lire notamment :

- une table transparente[^terme-table-transparente] du Dictionary ABAP ;
- une vue classique du Dictionary ;
- une entité CDS[^terme-acro-cds] exploitable par ABAP SQL ;
- certaines sources supplémentaires selon la version ABAP.

Dans ce dossier SAP GUI[^terme-sap-gui], les exemples restent centrés sur les tables et vues classiques. La création de CDS relève du futur dossier ADT[^terme-acro-adt].

## 2.C GESTION IMPLICITE DU MANDANT

Une table dépendante du mandant possède normalement le champ `MANDT`[^terme-mandt] comme premier champ de clé, avec le type `CLNT`.

Pour les accès standards, ABAP SQL limite automatiquement la lecture au mandant courant.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

Si `SCARR` est dépendante du mandant dans le système, le filtrage correspondant est géré par l’interface de base de données. Il n’est pas nécessaire d’ajouter manuellement :

```abap
WHERE mandt = @sy-mandt
```

> [!WARNING]
> Un accès inter-mandants est une opération sensible. Ne pas utiliser les additions dédiées sans besoin explicite, autorisation et analyse de sécurité.

## 2.D TABLES INDÉPENDANTES DU MANDANT

Une table sans champ client est lue de la même manière dans tous les mandants du système.

Exemples possibles :

- données techniques globales ;
- données de customizing[^terme-customizing] explicitement indépendantes du mandant ;
- référentiels communs à l’ensemble du système.

La dépendance au mandant est définie dans le Dictionary et doit être comprise avant toute lecture ou écriture.

## 2.E BUFFER DE TABLES

Certaines tables DDIC[^terme-acro-ddic] peuvent être bufferisées sur les serveurs d’application ABAP.

```mermaid
flowchart LR
    A["SELECT ABAP SQL"] --> B["Donnée disponible dans le buffer ?"]
    B --> C["Lecture depuis le buffer ABAP"]
    B --> D["Lecture depuis la base de données"]
```

Le buffer peut améliorer les lectures répétées de petites tables peu modifiées. Il n’est pas adapté aux tables transactionnelles fréquemment modifiées.

Certaines constructions SQL contournent le buffer ou empêchent son utilisation. Ne pas déduire qu’un `SELECT` est sans accès base uniquement parce que la table est déclarée bufferisée.

## 2.F RÈGLE DE CONCEPTION

Avant d’écrire une requête, vérifier :

1. la nature de la source ;
2. sa dépendance au mandant ;
3. son volume ;
4. sa stratégie de bufferisation ;
5. son API[^terme-api] métier éventuelle.

## 2.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 2.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode[^terme-methode] réutilisable sans contrat explicite.

## 2.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

## 2.J TERMES DU LEXIQUE

- [Mandant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>)
- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 2.K MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 2.L RÉFÉRENCES OFFICIELLES SAP

- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Client Handling and Table Buffering — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-integration-connectivity/client-handling-and-table-buffering)
- [FROM Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFROM_CLAUSE.html)


---

[Chapitre suivant — LECTURE SIMPLE AVEC SELECT](<./03 ├── LECTURE SIMPLE AVEC SELECT.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-inter-mandants]: **INTER-MANDANTS.** Qualifie une donnée ou une action commune à tous les mandants d’un même système. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#inter-mandants>).
[^terme-table-transparente]: **TABLE TRANSPARENTE.** Table DDIC correspondant directement à une table physique de la base de données. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>).
[^terme-acro-cds]: **CDS.** Core Data Services, langage de modélisation de vues et entités de données. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-cds>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-acro-adt]: **ADT.** ABAP Development Tools, environnement de développement ABAP intégré à Eclipse. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-adt>).
[^terme-mandt]: **MANDT.** Champ technique de type mandant, généralement placé en première position de clé dans les tables dépendantes du mandant. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>).
[^terme-customizing]: **CUSTOMIZING.** Paramétrage permettant d’adapter le comportement standard SAP à l’organisation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#customizing>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
