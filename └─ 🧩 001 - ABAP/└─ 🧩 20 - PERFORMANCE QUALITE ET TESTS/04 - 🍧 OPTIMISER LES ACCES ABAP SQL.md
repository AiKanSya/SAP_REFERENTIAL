# 🍧 OPTIMISER LES ACCES ABAP SQL

## 🎯 Objectif

Réduire le nombre d’accès, le volume transféré et le travail inutile demandé à la base de données.

## ✅ Règles prioritaires

- Lire uniquement les colonnes nécessaires.
- Filtrer le plus tôt possible avec `WHERE`.
- Éviter les `SELECT` unitaires répétés dans une boucle.
- Utiliser les jointures et agrégations lorsque la base peut effectuer le travail.
- Définir un ordre explicite uniquement lorsqu’il est fonctionnellement requis.
- Vérifier les résultats avec `ST05` ou `SQLM`.

```abap
SELECT carrid,
       connid,
       fldate,
       seatsocc
  FROM sflight
  WHERE carrid = @p_carrid
    AND fldate BETWEEN @p_date_low AND @p_date_high
  INTO TABLE @DATA(lt_flights).
```

## ❌ Anti-pattern : accès dans une boucle

```abap
LOOP AT lt_keys INTO DATA(ls_key).
  SELECT SINGLE carrname
    FROM scarr
    WHERE carrid = @ls_key-carrid
    INTO @DATA(lv_name).
ENDLOOP.
```

Une alternative consiste à lire l’ensemble nécessaire en une fois, puis à utiliser une table interne avec une clé adaptée.

## 📦 Volume et sémantique

`SELECT SINGLE` exprime la lecture d’une ligne selon la condition fournie. `UP TO 1 ROWS` avec `ORDER BY` exprime la sélection de la première ligne selon un ordre défini. Ils ne sont pas interchangeables par simple préférence de style.

## ⚠️ Optimisations dépendantes du contexte

Les index, buffers et plans d’accès dépendent des tables, de la base et de la distribution des données. Ne pas proposer un nouvel index sans trace, volumétrie et validation avec l’équipe responsable de la base.

## 🔬 Validation

Après modification, comparer : nombre d’exécutions, temps cumulé, lignes examinées, lignes transférées et résultat fonctionnel.

## 🔗 Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)
- [SAP Help Portal — SQL Monitor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/a24970c68fcf4770a64bf9a78e3719e2/1ec2329419b64f3992a9c342437d3a0f.html)

---

➡️ [Chapitre suivant : OPTIMISER LES TABLES INTERNES](<05 - 🍧 OPTIMISER LES TABLES INTERNES.md>)
