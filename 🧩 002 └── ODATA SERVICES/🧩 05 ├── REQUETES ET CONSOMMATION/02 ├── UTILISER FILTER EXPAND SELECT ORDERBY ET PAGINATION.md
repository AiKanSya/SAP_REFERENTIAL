# 2. UTILISER FILTER, EXPAND, SELECT, ORDERBY ET PAGINATION

## 2.A RÉSULTAT ATTENDU

Construire des lectures bornées avec les options de requête[^terme-query-option], puis vérifier leur prise en charge réelle par le backend.

## 2.B PRÉREQUIS

- Capacités et propriétés confirmées dans `$metadata`.
- Jeu de données permettant de contrôler filtre, tri et pagination.
- Accès au code DPC_EXT pour vérifier la prise en charge.

## 2.C EXEMPLES

```http
GET SalesOrderSet?$filter=CompanyCode eq '1000'&$select=SalesOrder,NetAmount
GET SalesOrderSet?$orderby=CreatedAt desc&$top=50&$skip=0
GET SalesOrderSet('500000001')?$expand=Items
```

Les espaces et caractères réservés doivent être encodés par le client HTTP.

## 2.D RÈGLES

- `$filter` réduit les lignes ; l’implémentation doit le pousser vers la base lorsque possible.
- `$select` réduit le contrat retourné ; il ne remplace pas une autorisation sur les champs.
- `$expand` peut multiplier le volume et les lectures de navigation[^terme-navigation] ; borner la profondeur et les cardinalités.
- `$orderby` doit être déterministe pour paginer sans doublon ni omission.
- `$top` ne dispense pas d’une condition sélective.

## 2.E IMPLÉMENTATION BACKEND

Dans `GET_ENTITYSET`, lire les options via le contexte technique généré. Transformer uniquement les filtres pris en charge en prédicats sûrs et typés. Appliquer filtre, tri et limite au niveau SQL ou de l’API lorsque celle-ci les accepte. Ne concaténer aucun nom ni valeur libre dans une requête dynamique.

Fragment de pagination à adapter :

```abap
DATA(lv_top)  = io_tech_request_context->get_top( ).
DATA(lv_skip) = io_tech_request_context->get_skip( ).

IF lv_top IS INITIAL OR lv_top > 100.
  lv_top = 100.
ENDIF.

SELECT productid,
       name,
       category
  FROM zi_product_api
  ORDER BY productid
  INTO TABLE @DATA(lt_products)
  UP TO @lv_top ROWS
  OFFSET @lv_skip.

et_entityset = CORRESPONDING #( lt_products ).
```

`OFFSET` et les expressions utilisables dépendent de la version ABAP SQL. Sur une release ne prenant pas cette syntaxe en charge, appliquer une stratégie de pagination compatible et mesurée. Un ordre unique et stable reste obligatoire.

## 2.F PROCESS

### 2.F.1 ÉTAPE 1 — ÉTABLIR LE RÉSULTAT SANS OPTION

Exécuter une lecture bornée et relever les clés.

### 2.F.2 ÉTAPE 2 — AJOUTER UNE OPTION

Ajouter une seule option, exécuter puis comparer le résultat. Ne combiner qu’après validation individuelle.

### 2.F.3 ÉTAPE 3 — PROUVER LE TRAITEMENT BACKEND

1. Exécuter la requête avec un petit jeu de données connu.
2. Placer un point d’arrêt externe dans `DPC_EXT` pour confirmer les options reçues.
3. Mesurer les accès SQL avec `ST05` si le volume ou le temps est anormal.

### 2.F.4 ÉTAPE 4 — TESTER LES LIMITES

4. Vérifier que la pagination conserve un ordre stable.
5. Tester un filtre non pris en charge : le service doit le refuser ou le traiter conformément au contrat, jamais l’ignorer silencieusement.

## 2.G CONTRÔLE

- `$select` ne retourne que les propriétés attendues selon le runtime.
- `$filter` exclut un enregistrement témoin connu.
- Deux pages consécutives sous un ordre stable ne contiennent ni doublon ni omission.
- `$expand` retourne uniquement la relation autorisée.
- Une option inconnue ou non prise en charge n’est pas ignorée silencieusement.

## 2.H ERREURS FRÉQUENTES

- Charger toute la table puis appliquer `$filter` en ABAP.
- Implémenter `$skip` sans ordre stable.
- Autoriser un `$expand` non borné sur des collections volumineuses.

| Symptôme | Cause | Correction |
|---|---|---|
| Timeout | Filtre appliqué après lecture | Pousser le prédicat vers la source |
| Pages instables | Tri absent ou non unique | Ajouter un ordre déterministe |
| Trop d’appels SQL | Navigation N+1 | Regrouper les lectures et mesurer |
| Filtre sans effet | Option ignorée | Implémenter ou rejeter explicitement |

## 2.I COMPATIBILITÉ S/4HANA

La syntaxe et les capacités des options doivent être vérifiées pour OData V2 ou V4. Ce chapitre vise d’abord le runtime V2 SEGW.

## 2.J RÉFÉRENCES OFFICIELLES SAP

- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)
- [Gateway Client — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079611.html)

[^terme-query-option]: **OPTION DE REQUÊTE.** Paramètre OData tel que `$filter`, `$select`, `$expand`, `$orderby`, `$top` ou `$skip`. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#query-option>).
[^terme-navigation]: **NAVIGATION PROPERTY.** Propriété permettant d’accéder aux entités liées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#navigation-property>).
