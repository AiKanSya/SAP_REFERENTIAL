# 🌸 SOUS-REQUÊTES ET OPÉRATIONS D’ENSEMBLE

## 🌺 OBJECTIFS

- Utiliser une sous-requête pour filtrer un résultat
- Employer `EXISTS` pour tester une existence
- Comprendre `UNION` et `UNION ALL`
- Connaître les contraintes de compatibilité des colonnes
- Choisir une construction lisible et performante

## 🌺 SOUS-REQUÊTE AVEC IN

```abap
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN (
    SELECT carrid
      FROM spfli
      WHERE cityfrom = @p_city )
  INTO TABLE @DATA(lt_carriers).
```

La sous-requête produit un ensemble utilisé par la requête principale.

## 🌺 TEST D’EXISTENCE

```abap
SELECT carrid, carrname
  FROM scarr AS a
  WHERE EXISTS (
    SELECT carrid
      FROM spfli AS c
      WHERE c~carrid = a~carrid )
  INTO TABLE @DATA(lt_carriers).
```

`EXISTS` est adapté lorsque seule l’existence d’au moins une ligne correspondante importe.

## 🌺 UNION ET UNION ALL

`UNION` combine plusieurs résultats et élimine les doublons complets. `UNION ALL` conserve les doublons.

```abap
SELECT cityfrom AS city
  FROM spfli
  UNION
SELECT cityto AS city
  FROM spfli
  INTO TABLE @DATA(lt_cities).
```

Conditions principales :

- même nombre de colonnes dans chaque branche ;
- types compatibles pour les colonnes de même position ;
- ordre et clauses finales conformes à la syntaxe de la release.

## 🌺 CHOIX ENTRE JOIN ET SOUS-REQUÊTE

- une jointure est adaptée lorsqu’il faut retourner des colonnes des deux sources ;
- `EXISTS` est adapté pour un test d’existence ;
- une sous-requête scalaire peut produire une valeur ;
- la lisibilité et le plan d’exécution doivent être vérifiés sur le cas réel.

## 🌺 COMPATIBILITÉ DE VERSION

Les opérations `INTERSECT`, `EXCEPT`, les expressions de table communes et certaines formes avancées dépendent de la version ABAP.

> [!IMPORTANT]
> Vérifier la documentation de la release et le contrôle de syntaxe SAP GUI avant intégration.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Subqueries — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSUBQUERY_SHORTREF.html)
- [UNION, INTERSECT and EXCEPT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPUNION.html)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)

---

➡️ [Chapitre suivant — SELECT FOR ALL ENTRIES](<./11 - 🍧 SELECT FOR ALL ENTRIES.md>)
