# 5. IMPLÉMENTER CRUD ET DEEP INSERT

## 5.A RÉSULTAT ATTENDU

Associer chaque opération HTTP à un traitement métier transactionnel explicite, y compris un deep insert[^terme-deep-insert] lorsque le contrat l’impose.

## 5.B PRÉREQUIS

- Opérations autorisées validées par ressource.
- API métier et responsabilité du commit identifiées.
- Modèle d’erreur et contrôles d’autorisation définis.
- Payloads nominaux et invalides disponibles.

## 5.C MAPPAGE

| HTTP | Intention | Contrôle minimal |
|---|---|---|
| GET | Lire | Autorisation et existence |
| POST | Créer | Validation, API métier, transaction |
| PUT/PATCH | Remplacer/modifier | Clé, concurrence, champs autorisés |
| DELETE | Supprimer | Autorisation, existence, dépendances |

## 5.D TRANSACTION ET CONCURRENCE

Une requête de mutation doit former une unité fonctionnelle cohérente. Le fournisseur de données appelle l’API métier, collecte les messages, retourne une erreur contrôlée en cas d’échec et respecte la stratégie transactionnelle du framework. Pour une modification concurrente, utiliser les ETags[^terme-etag] et préconditions si le service les expose ; ne pas écraser silencieusement une version plus récente.

## 5.E PROCESS

### 5.E.1 ÉTAPE 1 — LIRE LE PAYLOAD

1. Lire et désérialiser la requête avec l’API Gateway fournie.

### 5.E.2 ÉTAPE 2 — VALIDER

2. Rejeter les champs ou volumes hors contrat.
3. Exécuter les `AUTHORITY-CHECK` métier.

### 5.E.3 ÉTAPE 3 — EXÉCUTER L’API

4. Appeler l’API métier sans accès direct aux tables applicatives.
5. Décider la frontière transactionnelle une seule fois.

### 5.E.4 ÉTAPE 4 — CONSTRUIRE LA RÉPONSE

6. Retourner la ressource créée ou modifiée selon le contrat.

### 5.E.5 ÉTAPE 5 — TRAITER UN ENSEMBLE

7. Pour un deep insert, valider l’en-tête et toutes les positions avant la validation transactionnelle.

## 5.F PAYLOAD À ADAPTER

```http
POST /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet
Content-Type: application/json
X-CSRF-Token: <TOKEN>

{
  "CompanyCode": "1000",
  "DocumentDate": "2026-08-04T00:00:00",
  "Currency": "EUR"
}
```

## 5.G SQUELETTE `CREATE_DEEP_ENTITY`

Le type profond doit être déclaré dans `DPC_EXT` avec des composants dont les noms correspondent aux navigation properties du payload.

```abap
TYPES: BEGIN OF ty_sales_order_deep,
         INCLUDE TYPE zcl_zsales_mpc=>ts_salesorder,
         toitems TYPE STANDARD TABLE OF
           zcl_zsales_mpc=>ts_salesorderitem WITH DEFAULT KEY,
       END OF ty_sales_order_deep.

METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.
  DATA ls_deep_request  TYPE ty_sales_order_deep.
  DATA ls_deep_response TYPE ty_sales_order_deep.

  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_deep_request ).

  IF ls_deep_request-toitems IS INITIAL.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'Au moins une position est obligatoire'.
  ENDIF.

  " Appeler ici une API métier atomique créant en-tête et positions.
  ls_deep_response = ls_deep_request.

  copy_data_to_ref(
    EXPORTING
      is_data = ls_deep_response
    CHANGING
      cr_data = er_deep_entity ).
ENDMETHOD.
```

Ce fragment montre le contrat technique. Il n’implémente pas la persistance. Remplacer le commentaire par une API métier atomique et retourner les clés générées.

## 5.H POINTS À REMPLACER

- Service, entity set et propriétés selon `$metadata`.
- Format des dates selon OData V2 et le runtime utilisé.
- Jeton CSRF et cookies obtenus dans la même session.
- API métier et messages selon le domaine.

## 5.I TESTS

- Création nominale.
- Clé inexistante et clé dupliquée.
- Champ obligatoire absent.
- Utilisateur sans autorisation.
- Erreur sur une position d’un deep insert : aucun sous-ensemble ne doit rester validé sans contrat explicite.

## 5.J ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| `403` sur POST | Jeton CSRF/cookie absent ou autorisation | Fetch puis rejouer dans la session ; tracer les droits |
| Création partielle | Transaction mal délimitée | Déplacer l’atomicité dans l’API métier |
| Valeurs ignorées | Propriétés non lues ou non mappées | Comparer payload, metadata et structure d’entrée |
| Mise à jour perdue | ETag/précondition absente | Implémenter le contrôle de concurrence |

## 5.K COMPATIBILITÉ S/4HANA

Statut : SAP Gateway OData V2 classique. Pour un nouveau service transactionnel, évaluer RAP et OData V4 avant de choisir SEGW.

Deep insert et changesets répondent à des contrats différents. Ne pas les substituer sans examiner l’atomicité, les Content-ID et les capacités du consommateur.

## 5.L RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Explaining the SAP Gateway — SAP Learning](https://learning.sap.com/courses/implementing-sap-service-and-asset-manager/explaining-the-sap-gateway)
- [Getting Started with the Service Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_1909/68bf513362174d54b58cddec28794093/36742c510e87fa50e10000000a441470.html)

[^terme-deep-insert]: **DEEP INSERT.** Création d’une structure d’entités liées dans une requête. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#deep-insert>).
[^terme-etag]: **ETAG.** Valeur de version HTTP utilisable pour contrôler les modifications concurrentes. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#etag>).
