# 🌸 SELECT FOR ALL ENTRIES

## 🌺 OBJECTIFS

- Comprendre le rôle de `FOR ALL ENTRIES`
- Lire des données à partir d’une table interne pilote
- Éviter le cas critique de la table pilote vide
- Supprimer les doublons inutiles
- Choisir entre jointure, `IN` et `FOR ALL ENTRIES`

## 🌺 PRINCIPE

`FOR ALL ENTRIES` construit une condition à partir des lignes d’une table interne.

```abap
IF lt_carriers IS NOT INITIAL.
  SELECT carrid, connid, cityfrom, cityto
    FROM spfli
    FOR ALL ENTRIES IN @lt_carriers
    WHERE carrid = @lt_carriers-carrid
    INTO TABLE @DATA(lt_connections).
ENDIF.
```

## 🌺 TABLE PILOTE VIDE

Si la table utilisée après `FOR ALL ENTRIES IN` est vide, la condition issue de cette table est ignorée et la requête peut lire l’ensemble des lignes satisfaisant les autres conditions.

> [!CAUTION]
> Toujours contrôler que la table pilote n’est pas vide avant la requête.

```mermaid
flowchart LR
    A["Table pilote"] --> B["Contrôle IS NOT INITIAL"]
    B --> C["SELECT FOR ALL ENTRIES"]
    C --> D["Résultat limité aux clés utiles"]
```

## 🌺 DOUBLONS DANS LA TABLE PILOTE

Des clés répétées augmentent inutilement le travail de préparation et peuvent complexifier l’exécution.

```abap
SORT lt_carriers BY carrid.
DELETE ADJACENT DUPLICATES FROM lt_carriers COMPARING carrid.
```

Effectuer cette préparation seulement si le volume et le type de table la rendent utile.

## 🌺 DOUBLONS DANS LE RÉSULTAT

La sémantique de `FOR ALL ENTRIES` élimine les doublons complets du résultat comme pour une union d’ensembles. Ne pas l’utiliser pour un traitement qui dépend du nombre d’occurrences de la table pilote.

## 🌺 JOINTURE OU FOR ALL ENTRIES

Une jointure est souvent préférable lorsque :

- toutes les sources sont des objets de base de données ;
- une seule requête peut exprimer la relation ;
- les colonnes des deux sources sont requises.

`FOR ALL ENTRIES` reste utile lorsque :

- les clés proviennent déjà d’un traitement ABAP ;
- la table pilote ne peut pas être intégrée simplement dans une jointure compatible ;
- le volume et le plan d’exécution ont été contrôlés.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [FOR ALL ENTRIES — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENWHERE_ALL_ENTRIES.html)
- [FOR ALL ENTRIES — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353526117.html)
- [ABAP Performance and Tuning — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

---

➡️ [Chapitre suivant — VALEURS NULL ET CONVERSIONS SQL](<./12 - 🍧 VALEURS NULL ET CONVERSIONS SQL.md>)
