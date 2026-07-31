# 🌸 CHAMPS, ALIAS ET EXPRESSIONS SQL

## 🌺 OBJECTIFS

- Sélectionner uniquement les colonnes utiles
- Renommer une colonne avec `AS`
- Utiliser des littéraux et variables hôte
- Effectuer des calculs simples dans la requête
- Comprendre le typage des expressions SQL

## 🌺 LISTE DE CHAMPS

```abap
SELECT carrid, carrname, currcode
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

L’ordre des composants du résultat suit l’ordre de la liste de sélection, sauf affectation par nom avec une variante `CORRESPONDING FIELDS`.

## 🌺 ALIAS DE COLONNE

```abap
SELECT carrid   AS carrier_id,
       carrname AS carrier_name
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

Un alias est utile pour :

- lever une ambiguïté dans une jointure ;
- adapter le nom au type cible ;
- nommer une expression calculée ;
- rendre le résultat plus lisible.

## 🌺 VARIABLES HÔTE ET CONSTANTES

```abap
CONSTANTS lc_currency TYPE scarr-currcode VALUE 'EUR'.

SELECT carrid, carrname, @lc_currency AS requested_currency
  FROM scarr
  WHERE currcode = @lc_currency
  INTO TABLE @DATA(lt_carriers).
```

Le préfixe `@` indique une donnée fournie par le programme ABAP.

## 🌺 EXPRESSIONS ARITHMÉTIQUES

```abap
SELECT carrid,
       connid,
       distance,
       distance * 2 AS round_trip_distance
  FROM spfli
  INTO TABLE @DATA(lt_connections).
```

Exécuter le calcul en base évite de transférer les lignes puis de recalculer chaque valeur en ABAP.

## 🌺 EXPRESSIONS CONDITIONNELLES

Selon la version, ABAP SQL permet notamment des expressions `CASE`.

```abap
SELECT carrid,
       connid,
       CASE
         WHEN distance < 500  THEN 'COURT'
         WHEN distance < 2000 THEN 'MOYEN'
         ELSE 'LONG'
       END AS distance_category
  FROM spfli
  INTO TABLE @DATA(lt_connections).
```

## 🌺 FONCTIONS SQL

ABAP SQL propose des fonctions de chaînes, numériques, dates et conversions. Leur disponibilité dépend de la version ABAP.

> [!IMPORTANT]
> Vérifier la documentation correspondant à la release du système avant d’utiliser une fonction récente.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire et vérifier une instruction ABAP SQL utilisant champs, alias et expressions sql sur un jeu de données maîtrisé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SELECT carrid,
       connid,
       CASE
         WHEN distance < 500  THEN 'COURT'
         WHEN distance < 2000 THEN 'MOYEN'
         ELSE 'LONG'
       END AS distance_category
  FROM spfli
  INTO TABLE @DATA(lt_connections).
```

## 🌺 TERMES DU LEXIQUE

- [Expression](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire et vérifier une instruction ABAP SQL utilisant champs, alias et expressions sql sur un jeu de données maîtrisé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [FIELDS Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFIELDS_CLAUSE.html)
- [Working with Expressions in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/working-with-expressions-in-abap-sql_aeb5768f-325a-45d0-8f86-97e121d6efb6)
- [Performing Calculations and String Processing in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/performing-calculations-and-string-processing-in-abap-sql_a158cbc9-7ada-422d-8759-eadb13078a13)


---

➡️ [Chapitre suivant — CONDITIONS WHERE ET VARIABLES HÔTE](<./05 - 🍧 CONDITIONS WHERE ET VARIABLES HOTE.md>)
