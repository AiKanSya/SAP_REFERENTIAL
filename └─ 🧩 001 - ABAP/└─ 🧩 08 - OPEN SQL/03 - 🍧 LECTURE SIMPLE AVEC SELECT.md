# 🌸 LECTURE SIMPLE AVEC SELECT

## 🌺 OBJECTIFS

- Écrire une instruction `SELECT` simple
- Lire plusieurs lignes dans une table interne
- Lire une ligne dans une structure
- Utiliser la syntaxe moderne avec variables hôte
- Interpréter le résultat de la lecture

## 🌺 STRUCTURE GÉNÉRALE

Une lecture contient au minimum :

- une liste de colonnes ;
- une source après `FROM` ;
- une cible après `INTO` ;
- généralement une restriction `WHERE`.

```abap
SELECT carrid, carrname, currcode
  FROM scarr
  WHERE currcode = @p_curr
  INTO TABLE @DATA(lt_carriers).
```

La syntaxe avec `@` distingue explicitement les variables ABAP des colonnes SQL.

## 🌺 LECTURE DE PLUSIEURS LIGNES

```abap
PARAMETERS p_curr TYPE scarr-currcode DEFAULT 'EUR'.

SELECT carrid, carrname, currcode
  FROM scarr
  WHERE currcode = @p_curr
  INTO TABLE @DATA(lt_carriers).
```

`INTO TABLE` remplace le contenu actuel de la table interne cible.

Pour ajouter au contenu existant, certaines variantes utilisent `APPENDING TABLE`. Cette forme doit rester intentionnelle afin d’éviter les doublons ou les résultats mélangés.

## 🌺 LECTURE D’UNE LIGNE

```abap
PARAMETERS p_carrid TYPE scarr-carrid.

SELECT SINGLE carrid, carrname, currcode
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(ls_carrier).
```

Après l’instruction :

- `sy-subrc = 0` si une ligne a été fournie ;
- `sy-subrc <> 0` si aucune ligne n’a été trouvée.

## 🌺 NE PAS LIRE PLUS QUE NÉCESSAIRE

Éviter :

```abap
SELECT *
  FROM scarr
  INTO TABLE @DATA(lt_all_fields).
```

Préférer une liste explicite :

```abap
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_names).
```

La liste explicite :

- réduit les données transférées ;
- documente le besoin ;
- limite l’impact d’une extension de table ;
- facilite le typage du résultat.

## 🌺 SELECT DANS UNE BOUCLE

La forme `SELECT ... ENDSELECT` traite les lignes l’une après l’autre.

```abap
SELECT carrid, carrname
  FROM scarr
  INTO @DATA(ls_carrier).

  WRITE: / ls_carrier-carrid, ls_carrier-carrname.
ENDSELECT.
```

Elle reste valide, mais une lecture en masse dans une table interne est généralement plus claire et plus facile à réutiliser.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)
- [SELECT List — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_LIST.html)

---

➡️ [Chapitre suivant — CHAMPS ALIAS ET EXPRESSIONS SQL](<./04 - 🍧 CHAMPS ALIAS ET EXPRESSIONS SQL.md>)
