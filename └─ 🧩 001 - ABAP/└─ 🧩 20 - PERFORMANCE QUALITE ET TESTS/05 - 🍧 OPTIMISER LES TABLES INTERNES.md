# 🍧 OPTIMISER LES TABLES INTERNES

## 🎯 Objectif

Choisir la catégorie de table et la clé adaptées au profil d’accès réel.

## 🗂️ Choix principal

| Besoin dominant                          | Catégorie recommandée |
| ---------------------------------------- | --------------------- |
| Ajouts séquentiels et parcours complet   | table standard        |
| Accès par clé et parcours ordonné        | table triée           |
| Accès exact très fréquent par clé unique | table hachée          |

```abap
DATA lt_carriers TYPE HASHED TABLE OF scarr
                 WITH UNIQUE KEY carrid.

SELECT *
  FROM scarr
  INTO TABLE @lt_carriers.

READ TABLE lt_carriers
  WITH TABLE KEY carrid = 'LH'
  INTO DATA(ls_carrier).
```

## 🔑 Exploiter les clés

Une table triée ou hachée n’apporte un bénéfice que si l’accès utilise sa clé. Un accès générique ou un parcours complet reste coûteux. Les clés secondaires peuvent accélérer plusieurs profils d’accès, mais augmentent le coût des insertions et modifications.

## 🔁 Réduire les copies

Pour modifier une ligne existante, `ASSIGNING` évite la copie vers une zone de travail puis la réécriture :

```abap
LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
  <ls_item>-amount = <ls_item>-quantity * <ls_item>-price.
ENDLOOP.
```

## ⚠️ Optimisations à mesurer

- `BINARY SEARCH` exige un tri compatible et reste fragile si la clé change.
- Une table hachée consomme davantage de mémoire qu’une table standard.
- Trier à chaque lecture peut coûter plus cher que le gain attendu.
- Les expressions de table peuvent lever une exception si la ligne est absente.

## ✅ Démarche

Décrire les opérations dominantes, choisir la clé, mesurer sur un volume représentatif, puis vérifier que la structure reste lisible et cohérente avec le modèle métier.

## 🔗 Références SAP officielles

- [ABAP Keyword Documentation — Internal Tables Performance Notes](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenitab_perfo.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

---

➡️ [Chapitre suivant : MAITRISER MEMOIRE COPIES ET VOLUMES](<06 - 🍧 MAITRISER MEMOIRE COPIES ET VOLUMES.md>)
