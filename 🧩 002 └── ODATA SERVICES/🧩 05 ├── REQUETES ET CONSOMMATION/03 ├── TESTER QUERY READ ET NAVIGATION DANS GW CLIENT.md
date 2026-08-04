# 3. TESTER QUERY, READ ET NAVIGATION DANS GW_CLIENT

## 3.A RÉSULTAT ATTENDU

Valider dans Gateway Client[^terme-gateway-client] les méthodes `GET_ENTITYSET`, `GET_ENTITY` et la navigation sans dépendre d’une application SAPUI5.

## 3.B PRÉREQUIS

- Service actif dans `/IWFND/MAINT_SERVICE`.
- Entity sets et navigation confirmés dans `$metadata`.
- Clé existante et clé inconnue.
- Utilisateur autorisé à lire les données de test.
- Breakpoints externes placés dans les méthodes DPC_EXT si le code doit être suivi.

## 3.C OUVRIR LE SERVICE DANS GATEWAY CLIENT

### 3.C.1 ÉTAPE 1 — PARTIR DE LA MAINTENANCE

1. Ouvrir `/IWFND/MAINT_SERVICE`.
2. Rechercher et sélectionner le service.
3. Choisir **SAP Gateway Client** dans la zone ICF Nodes.
4. Contrôler que la racine `/sap/opu/odata/sap/<SERVICE>/` est préremplie.

Partir de la maintenance limite les erreurs de chemin, de nom technique et de version.

### 3.C.2 ÉTAPE 2 — TESTER LE SERVICE DOCUMENT

- Méthode : `GET`.
- URI : racine du service.
- Corps : vide.
- Résultat : `200` et liste des collections exposées.

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/
Accept: application/json
```

### 3.C.3 ÉTAPE 3 — TESTER LE METADATA

Choisir **Add URI Option**, puis `$metadata`, ou saisir directement :

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/$metadata
```

Le résultat doit contenir `ProductSet`, sa clé et la navigation attendue.

## 3.D TESTER GET_ENTITYSET

1. Choisir **Entity Sets**.
2. Sélectionner `ProductSet`.
3. Conserver `GET`.
4. Ajouter `$top=5` pour borner le test.
5. Choisir **Execute** ou `F8`.

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet?$top=5&$orderby=ProductId
Accept: application/json
```

### 3.D.1 CONTRÔLE BACKEND

- Le breakpoint dans `PRODUCTSET_GET_ENTITYSET` est atteint.
- `ET_ENTITYSET` contient les lignes avant la sortie de la méthode.
- L’ordre et le nombre de lignes correspondent à la requête.
- Les propriétés sensibles non exposées ne figurent pas dans la réponse.

## 3.E TESTER GET_ENTITY

1. Copier une clé réelle de la collection.
2. Ajouter la clé à l’URI avec le littéral conforme au metadata.
3. Exécuter une fois avec la clé réelle, puis avec une clé inconnue.

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet('HT-1000')
Accept: application/json
```

Contrôler `LS_KEY` après `GET_CONVERTED_KEYS` et `ER_ENTITY` avant la fin de `PRODUCTSET_GET_ENTITY`.

## 3.F TESTER SELECT ET VALUE

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet('HT-1000')?$select=ProductId,Name,Category
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet('HT-1000')/Name/$value
```

Le premier appel limite la représentation. Le second retourne la valeur brute de la propriété lorsque le runtime et le service la prennent en charge.

## 3.G TESTER UNE NAVIGATION

1. Lire une entité source.
2. Relever le lien de navigation dans la réponse ou le nom dans `$metadata`.
3. Ajouter la navigation à l’URI.
4. Contrôler la source et les clés dans `IO_TECH_REQUEST_CONTEXT`.

```http
GET /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')/ToProducts
```

Le résultat doit contenir uniquement les produits du partenaire demandé. Si tous les produits sont retournés, la méthode cible ignore le contexte de navigation.

## 3.H MATRICE DE RÉSULTATS

| Test | Statut attendu | Méthode backend |
|---|---|---|
| Collection | `200` | `<SET>_GET_ENTITYSET` |
| Clé existante | `200` | `<SET>_GET_ENTITY` |
| Clé inconnue | Erreur métier conforme au service | `<SET>_GET_ENTITY` |
| Navigation vers `n` | `200` | `<CIBLE>_GET_ENTITYSET` |
| Navigation vers `1` | `200` ou absence conforme | `<CIBLE>_GET_ENTITY` |

## 3.I ERREURS FRÉQUENTES

| Symptôme | Contrôle |
|---|---|
| `404` | Nom technique, version, ICF, entity set et syntaxe de clé |
| Breakpoint ignoré | Utilisateur, breakpoint externe, alias et backend |
| `200` vide | `ER_ENTITY`/`ET_ENTITYSET`, mapping et autorisation |
| Navigation non filtrée | Source entity set et source keys |
| `500` | `/IWFND/ERROR_LOG`, puis `/IWBEP/ERROR_LOG` |

## 3.J COMPATIBILITÉ S/4HANA

La procédure vise SAP Gateway OData V2. Les URI, en-têtes et statuts doivent être adaptés au contrat réel.

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Implementing Reading Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-reading-operations)
- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)
- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)

[^terme-gateway-client]: **GATEWAY CLIENT.** Outil `/IWFND/GW_CLIENT` permettant d’exécuter et analyser les requêtes OData. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#gateway-client>).
