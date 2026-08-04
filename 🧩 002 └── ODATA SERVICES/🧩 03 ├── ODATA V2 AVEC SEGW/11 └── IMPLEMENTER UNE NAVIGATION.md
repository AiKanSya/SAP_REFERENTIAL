# 11. IMPLÉMENTER UNE NAVIGATION

## 11.A RÉSULTAT ATTENDU

Traiter `BusinessPartnerSet('<ID>')/ToProducts` dans la méthode `PRODUCTSET_GET_ENTITYSET` en distinguant une lecture directe d’une lecture par navigation[^terme-navigation].

## 11.B PRÉREQUIS

- Association, association set et navigation property actifs dans SEGW.
- Cardinalité source `1` vers cible `n`.
- Méthode cible `GET_ENTITYSET` redéfinie dans `DPC_EXT`.
- API acceptant un critère permettant de relier la cible à la source.

## 11.C COMPORTEMENT DU RUNTIME

Pour une navigation dont la cible a une multiplicité `n`, Gateway appelle la méthode `<CIBLE>_GET_ENTITYSET`. Pour une cible de multiplicité `1`, il appelle `<CIBLE>_GET_ENTITY`. Le contexte fournit le nom de l’entity set source et ses clés.

## 11.D CODE PRÊT À ADAPTER

```abap
METHOD productset_get_entityset.
  DATA lt_products TYPE TABLE OF bapi_epm_product_header.
  DATA lt_return   TYPE TABLE OF bapiret2.
  DATA lt_ranges   TYPE TABLE OF bapi_epm_product_id_range.

  DATA(lv_source_entity_set) = io_tech_request_context->get_source_entity_set_name( ).

  IF lv_source_entity_set = 'BusinessPartnerSet'.
    DATA(lt_source_keys) = io_tech_request_context->get_source_keys( ).

    READ TABLE lt_source_keys
      WITH KEY name = 'BusinessPartnerID'
      INTO DATA(ls_source_key).

    IF sy-subrc <> 0 OR ls_source_key-value IS INITIAL.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid  = /iwbep/cx_mgw_busi_exception=>business_error
          message = 'Clé BusinessPartnerID absente'.
    ENDIF.

    " Adapter au paramètre de sélection offert par l’API métier.
    APPEND VALUE #(
      sign   = 'I'
      option = 'EQ'
      low    = ls_source_key-value ) TO lt_ranges.
  ENDIF.

  CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_LIST'
    TABLES
      product_id_range = lt_ranges
      headerdata       = lt_products
      return           = lt_return.

  IF line_exists( lt_return[ type = 'E' ] )
  OR line_exists( lt_return[ type = 'A' ] ).
    mo_context->get_message_container( )->add_messages_from_bapi(
      it_bapi_messages = lt_return ).
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid            = /iwbep/cx_mgw_busi_exception=>business_error
        message_container = mo_context->get_message_container( ).
  ENDIF.

  et_entityset = CORRESPONDING #( lt_products ).
ENDMETHOD.
```

Le paramètre `PRODUCT_ID_RANGE` est illustratif. SAP Learning adapte les critères de la BAPI au lien métier de son exemple. Examiner la signature réelle et ne pas supposer qu’un identifiant de partenaire est un identifiant de produit.

## 11.E VARIANTE SQL TYPIQUE

```abap
IF lv_source_entity_set = 'BusinessPartnerSet'.
  SELECT productid,
         name,
         category
    FROM zi_partner_products
    WHERE businesspartnerid = @ls_source_key-value
    ORDER BY productid
    INTO CORRESPONDING FIELDS OF TABLE @et_entityset.
ENDIF.
```

`ZI_PARTNER_PRODUCTS` doit être une source autorisée garantissant l’autorisation et le lien fonctionnel.

## 11.F POINTS À REMPLACER

- Entity set source et navigation property.
- Nom et type de la clé source.
- API ou vue reliant source et cible.
- Mapping vers `ET_ENTITYSET`.
- Contrôles d’autorisation sur la source et la cible.

## 11.G CONTRÔLE

```http
GET /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')/ToProducts
GET /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('INCONNU')/ToProducts
```

Comparer la collection retournée aux relations métier attendues. Une clé inconnue ne doit jamais permettre une lecture non filtrée de tous les produits.

## 11.H ERREURS FRÉQUENTES

- Ignorer `GET_SOURCE_ENTITY_SET_NAME` et retourner toute la collection.
- Confondre clé source et clé cible.
- Appliquer l’autorisation uniquement sur l’entity set cible.
- Produire une lecture SQL par ligne au lieu d’une requête regroupée.

## 11.I COMPATIBILITÉ S/4HANA

Ce chapitre concerne les associations et navigations OData V2 SEGW. Le modèle V4 n’utilise pas les association sets de la même manière.

## 11.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)

[^terme-navigation]: **NAVIGATION PROPERTY.** Propriété permettant de suivre une relation vers des entités liées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#navigation-property>).
