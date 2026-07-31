# 🌸 VALEURS NULL ET CONVERSIONS SQL

## 🌺 OBJECTIFS

- Comprendre la valeur `NULL` en base de données
- Distinguer `NULL` et valeur initiale ABAP
- Identifier les sources de valeurs nulles
- Utiliser les fonctions de remplacement et conversion disponibles
- Éviter les interprétations erronées dans les jointures externes

## 🌺 NULL ET VALEUR INITIALE

`NULL` signifie qu’aucune valeur n’est présente au niveau de la base de données. Une valeur initiale ABAP est une valeur réelle dépendant du type : espace, zéro, date initiale, etc.

Ces deux notions ne sont pas équivalentes.

## 🌺 ORIGINES COURANTES

Une valeur nulle peut provenir :

- d’une colonne autorisant `NULL` ;
- du côté non correspondant d’une jointure externe ;
- d’une expression SQL ;
- d’une source externe ou d’une vue.

```mermaid
flowchart LR
    A["LEFT OUTER JOIN sans correspondance"] --> B["Colonnes droites à NULL en base"]
    B --> C["Gestion et conversion par ABAP SQL"]
```

## 🌺 TEST IS NULL

```abap
SELECT a~carrid,
       c~connid
  FROM scarr AS a
  LEFT OUTER JOIN spfli AS c
    ON c~carrid = a~carrid
  WHERE c~connid IS NULL
  INTO TABLE @DATA(lt_without_connection).
```

Cette requête recherche les transporteurs sans connexion correspondante.

## 🌺 COALESCE

Sur les versions qui le prennent en charge, `COALESCE` retourne la première expression non nulle.

```abap
SELECT a~carrid,
       coalesce( c~cityfrom, 'AUCUNE' ) AS departure_city
  FROM scarr AS a
  LEFT OUTER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_result).
```

## 🌺 CAST ET CONV SQL

ABAP SQL propose des expressions de conversion, dont `CAST`, avec des règles spécifiques. Les types cibles disponibles dépendent du contexte et de la version.

Ne pas confondre :

- `CONV` en langage ABAP ;
- `CAST` et fonctions de conversion dans ABAP SQL.

## 🌺 DATES ET HORODATAGES

Les types DDIC historiques `DATS`, `TIMS`, `TIMESTAMP` et les types natifs plus récents ont des comportements de stockage et de conversion différents.

Utiliser les fonctions SQL officielles adaptées plutôt qu’une manipulation manuelle de chaînes lorsque le calcul doit être exécuté en base.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Null Values in ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_NULL_VALUES.html)
- [Using Special Built-In Functions in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-special-built-in-functions-in-abap-sql_b9611c6a-756c-43b9-a2ff-0db681000e7d)
- [Working with Expressions in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/working-with-expressions-in-abap-sql_aeb5768f-325a-45d0-8f86-97e121d6efb6)

---

➡️ [Chapitre suivant — AJOUTER DES DONNEES AVEC INSERT](<./13 - 🍧 AJOUTER DES DONNEES AVEC INSERT.md>)
