# 🌸 CONDITIONS WHERE ET VARIABLES HÔTE

## 🌺 OBJECTIFS

- Restreindre les lignes avec `WHERE`
- Utiliser des comparaisons et opérateurs logiques
- Filtrer avec plages, motifs et listes de valeurs
- Utiliser les variables hôte avec `@`
- Construire des conditions sûres et lisibles

## 🌺 COMPARAISONS

```abap
SELECT carrid, connid, cityfrom, cityto
  FROM spfli
  WHERE carrid = @p_carrid
    AND cityfrom <> @p_city_excluded
  INTO TABLE @DATA(lt_connections).
```

Opérateurs courants :

- `=` ou `EQ` ;
- `<>` ou `NE` ;
- `<`, `>`, `<=`, `>=` ;
- `BETWEEN` ;
- `LIKE` ;
- `IN` ;
- `IS NULL` selon la source et la construction.

## 🌺 OPÉRATEURS LOGIQUES

```abap
SELECT carrid, connid, cityfrom, cityto
  FROM spfli
  WHERE carrid = @p_carrid
    AND ( cityfrom = @p_city_a OR cityfrom = @p_city_b )
  INTO TABLE @DATA(lt_connections).
```

Utiliser des parenthèses dès qu’une combinaison de `AND`, `OR` et `NOT` pourrait être mal interprétée.

## 🌺 PLAGE DE VALEURS

Une table de sélection créée avec `SELECT-OPTIONS` peut être utilisée après `IN`.

```abap
SELECT-OPTIONS s_carrid FOR scarr-carrid.

SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN @s_carrid
  INTO TABLE @DATA(lt_carriers).
```

La table de sélection porte les composants `SIGN`, `OPTION`, `LOW` et `HIGH`.

## 🌺 RECHERCHE PAR MOTIF

```abap
PARAMETERS p_pattern TYPE c LENGTH 20 DEFAULT 'A%'.

SELECT carrid, carrname
  FROM scarr
  WHERE carrname LIKE @p_pattern
  INTO TABLE @DATA(lt_carriers).
```

Dans un motif SQL :

- `%` représente une suite de caractères ;
- `_` représente un caractère.

## 🌺 CONDITION DYNAMIQUE

ABAP SQL propose des variantes dynamiques, mais elles augmentent les risques de syntaxe invalide, d’erreur de sécurité et de perte de contrôle sur les performances.

Préférer des conditions statiques et des paramètres liés. Ne jamais concaténer directement une saisie utilisateur dans une condition SQL dynamique sans validation stricte.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [WHERE Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/ABAPWHERE.html)
- [Host Variables — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_HOST_VARIABLES.html)
- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)

---

➡️ [Chapitre suivant — SELECT SINGLE UP TO N ROWS ET ORDER BY](<./06 - 🍧 SELECT SINGLE UP TO N ROWS ET ORDER BY.md>)
