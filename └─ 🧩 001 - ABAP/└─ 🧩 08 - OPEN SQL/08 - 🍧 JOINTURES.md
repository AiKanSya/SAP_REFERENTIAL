# 🌸 JOINTURES

## 🌺 OBJECTIFS

- Combiner plusieurs sources dans une seule requête
- Utiliser `INNER JOIN` et `LEFT OUTER JOIN`
- Écrire une condition `ON`
- Employer des alias de sources
- Éviter les lectures imbriquées inutiles

## 🌺 INNER JOIN

Un `INNER JOIN` conserve seulement les combinaisons pour lesquelles la condition `ON` est satisfaite des deux côtés.

```abap
SELECT a~carrid,
       a~carrname,
       c~connid,
       c~cityfrom,
       c~cityto
  FROM scarr AS a
  INNER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_connections).
```

Le séparateur entre alias de source et colonne est `~` en ABAP SQL.

## 🌺 LEFT OUTER JOIN

Un `LEFT OUTER JOIN` conserve toutes les lignes de la source gauche, même lorsqu’aucune ligne correspondante n’existe à droite.

```abap
SELECT a~carrid,
       a~carrname,
       c~connid
  FROM scarr AS a
  LEFT OUTER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_carriers_connections).
```

Pour une ligne gauche sans correspondance, les colonnes provenant de la droite résultent de valeurs nulles en base, ensuite converties ou gérées selon la cible ABAP SQL.

## 🌺 ALIAS DE SOURCES

Les alias :

- raccourcissent les noms ;
- rendent les colonnes non ambiguës ;
- sont obligatoires pour distinguer deux utilisations de la même source.

## 🌺 AUTO-JOINTURE

```abap
SELECT first~carrid,
       first~connid AS first_connection,
       next~connid  AS next_connection
  FROM spfli AS first
  INNER JOIN spfli AS next
    ON next~cityfrom = first~cityto
  INTO TABLE @DATA(lt_routes).
```

## 🌺 JOINTURE OU SELECT DANS UNE BOUCLE

Éviter :

```abap
LOOP AT lt_carriers INTO DATA(ls_carrier).
  SELECT * FROM spfli
    WHERE carrid = @ls_carrier-carrid
    INTO TABLE @DATA(lt_connections).
ENDLOOP.
```

Préférer une jointure ou une lecture groupée afin de réduire le nombre d’allers-retours vers la base.

## 🌺 CONDITION ON ET FILTRE WHERE

- `ON` définit la relation entre les sources ;
- `WHERE` filtre le résultat produit par cette relation.

Dans une jointure externe, déplacer une condition de `ON` vers `WHERE` peut supprimer les lignes sans correspondance et modifier le résultat métier.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Joins — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-joins_a053e03d-f11e-4bee-8f63-5129b0590029)
- [FROM Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFROM_CLAUSE.html)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)

---

➡️ [Chapitre suivant — AGREGATIONS GROUP BY ET HAVING](<./09 - 🍧 AGREGATIONS GROUP BY ET HAVING.md>)
