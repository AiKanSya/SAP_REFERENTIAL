# 7. REDÉFINIR GET_ENTITY POUR UNE READ

## 7.A RÉSULTAT ATTENDU

Lire une entité par sa clé dans la DPC[^terme-dpc] en utilisant `GET_CONVERTED_KEYS` et remplir `ER_ENTITY`.

## 7.B PRÉREQUIS

- Entity type avec une clé correctement définie.
- Méthode `<ENTITYSET>_GET_ENTITY` générée.
- API retournant une entité et des messages.
- Clé existante et clé inconnue pour les tests.

## 7.C PROCESS

1. Dans `Service Implementation`, ouvrir `GetEntity (Read)`.
2. Accéder à la classe `DPC_EXT`.
3. Choisir **Redefine** sur la méthode générée.
4. Lire les clés converties depuis `IO_TECH_REQUEST_CONTEXT`.
5. Appeler l’API métier.
6. Convertir les erreurs dans le message container.
7. Mapper le résultat dans `ER_ENTITY`.

## 7.D CODE PRÊT À ADAPTER

```abap
METHOD productset_get_entity.
  DATA ls_key      TYPE zcl_zproduct_mpc=>ts_product.
  DATA ls_product  TYPE bapi_epm_product_header.
  DATA lt_return   TYPE TABLE OF bapiret2.

  io_tech_request_context->get_converted_keys(
    IMPORTING
      es_key_values = ls_key ).

  IF ls_key-productid IS INITIAL.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'Clé ProductId absente'.
  ENDIF.

  CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_DETAIL'
    EXPORTING
      product_id = CONV bapi_epm_product_id( ls_key-productid )
    IMPORTING
      headerdata = ls_product
    TABLES
      return     = lt_return.

  IF line_exists( lt_return[ type = 'E' ] )
  OR line_exists( lt_return[ type = 'A' ] ).
    mo_context->get_message_container( )->add_messages_from_bapi(
      it_bapi_messages = lt_return ).
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid            = /iwbep/cx_mgw_busi_exception=>business_error
        message_container = mo_context->get_message_container( ).
  ENDIF.

  er_entity = CORRESPONDING #( ls_product ).
ENDMETHOD.
```

Le type de `LS_KEY` doit correspondre au type d’entité généré dans la MPC. La signature exacte de la BAPI doit être vérifiée dans `SE37`.

## 7.E POINTS À REMPLACER

- Classe MPC et type `TS_PRODUCT`.
- Nom `PRODUCTID` identique au metadata.
- API métier et son type de clé.
- Mapping de la structure backend vers `ER_ENTITY`.
- Message texte par une classe de messages du projet.

## 7.F CONTRÔLE

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet('HT-1000')
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet('INCONNU')
```

Le premier appel doit retourner l’entité. Le second doit produire une erreur métier contrôlée, pas une structure vide avec `200`.

## 7.G ERREURS FRÉQUENTES

- Lire manuellement `IT_KEY_TAB` alors que `GET_CONVERTED_KEYS` fournit une structure typée.
- Ne pas contrôler la clé initiale.
- Retourner `200` avec une structure vide pour une ressource absente.
- Utiliser un type de clé incompatible avec le domaine backend.

## 7.H COMPATIBILITÉ S/4HANA

Technique Gateway V2. La signature des interfaces `/IWBEP/IF_MGW_REQ_*` et des BAPI doit être lue dans le système cible.

## 7.I RÉFÉRENCES OFFICIELLES SAP

- [Implementing Reading Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-reading-operations)

[^terme-dpc]: **DPC.** Data Provider Class fournissant les opérations de données d’un service Gateway. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#dpc>).
