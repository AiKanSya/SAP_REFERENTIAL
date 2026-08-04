# 4. CHAMPS, ALIAS ET EXPRESSIONS SQL

## 4.A RÉSULTAT ATTENDU

- Sélectionner uniquement les colonnes utiles
- Renommer une colonne avec `AS`
- Utiliser des littéraux et variables hôte
- Effectuer des calculs simples dans la requête
- Comprendre le typage des expressions SQL

## 4.B LISTE DE CHAMPS

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname, currcode
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

L’ordre des composants du résultat suit l’ordre de la liste de sélection, sauf affectation par nom avec une variante `CORRESPONDING FIELDS`.

## 4.C ALIAS DE COLONNE

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## 4.D VARIABLES HÔTE ET CONSTANTES

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
CONSTANTS lc_currency TYPE scarr-currcode VALUE 'EUR'.

SELECT carrid, carrname, @lc_currency AS requested_currency
  FROM scarr
  WHERE currcode = @lc_currency
  INTO TABLE @DATA(lt_carriers).
```

Le préfixe `@` indique une donnée fournie par le programme ABAP.

## 4.E EXPRESSIONS ARITHMÉTIQUES

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid,
       connid,
       distance,
       distance * 2 AS round_trip_distance
  FROM spfli
  INTO TABLE @DATA(lt_connections).
```

Exécuter le calcul en base évite de transférer les lignes puis de recalculer chaque valeur en ABAP.

## 4.F EXPRESSIONS CONDITIONNELLES

Selon la version, ABAP SQL permet notamment des expressions `CASE`.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## 4.G FONCTIONS SQL

ABAP SQL propose des fonctions de chaînes, numériques, dates et conversions. Leur disponibilité dépend de la version ABAP.

> [!IMPORTANT]
> Vérifier la documentation correspondant à la release du système avant d’utiliser une fonction récente.

## 4.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 4.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 4.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## 4.K TERMES DU LEXIQUE

- [Expression](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 4.L MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 4.M RÉFÉRENCES OFFICIELLES SAP

- [FIELDS Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFIELDS_CLAUSE.html)
- [Working with Expressions in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/working-with-expressions-in-abap-sql_aeb5768f-325a-45d0-8f86-97e121d6efb6)
- [Performing Calculations and String Processing in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/performing-calculations-and-string-processing-in-abap-sql_a158cbc9-7ada-422d-8759-eadb13078a13)


---

[Chapitre suivant — CONDITIONS WHERE ET VARIABLES HÔTE](<./05 ├── CONDITIONS WHERE ET VARIABLES HOTE.md>)
