# 9. REDÉFINIR UPDATE_ENTITY

## 9.A RÉSULTAT ATTENDU

Lire la clé depuis l’URI, lire le payload avec `READ_ENTRY_DATA` et transmettre les champs modifiables à l’API de mise à jour.

## 9.B PRÉREQUIS

- Entity set et propriétés marqués updatable.
- API de modification avec structure de valeurs et, si nécessaire, structure `X`.
- Stratégie ETag[^terme-etag] ou verrouillage définie.
- Entité de test créée par l’utilisateur du test.

## 9.C CODE PRÊT À ADAPTER

```abap
METHOD businesspartner_update_entity.
  DATA ls_key      TYPE zcl_zbp_mpc=>ts_businesspartner.
  DATA ls_request  TYPE zcl_zbp_mpc=>ts_businesspartner.
  DATA ls_bp_id    TYPE bapi_epm_bp_id.
  DATA ls_header   TYPE bapi_epm_bp_header.
  DATA ls_headerx  TYPE bapi_epm_bp_headerx.
  DATA lt_return   TYPE TABLE OF bapiret2.

  io_tech_request_context->get_converted_keys(
    IMPORTING
      es_key_values = ls_key ).

  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_request ).

  ls_bp_id-bp_id = ls_key-businesspartnerid.
  ls_header = CORRESPONDING #( ls_request ).

  ls_headerx-email_address = abap_true.
  ls_headerx-company_name  = abap_true.
  ls_headerx-city          = abap_true.
  ls_headerx-street        = abap_true.
  ls_headerx-country       = abap_true.

  CALL FUNCTION 'BAPI_EPM_BP_CHANGE'
    EXPORTING
      bp_id       = ls_bp_id
      headerdata  = ls_header
      headerdatax = ls_headerx
    TABLES
      return      = lt_return.

  IF line_exists( lt_return[ type = 'E' ] )
  OR line_exists( lt_return[ type = 'A' ] ).
    mo_context->get_message_container( )->add_messages_from_bapi(
      it_bapi_messages = lt_return ).
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid            = /iwbep/cx_mgw_busi_exception=>business_error
        message_container = mo_context->get_message_container( ).
  ENDIF.
ENDMETHOD.
```

Pour un `PATCH`, ne marquer dans la structure `X` que les propriétés réellement fournies et autorisées. La détection des propriétés présentes dépend de la signature et du runtime ; ne recopier pas une liste fixe sans l’adapter.

## 9.D POINTS À REMPLACER

- Type généré MPC.
- Clé et structure de l’API.
- Champs updatable et indicateurs `X`.
- Contrôle d’autorisation et concurrence.
- Responsabilité du commit.

## 9.E REQUÊTE DE TEST

```http
PUT /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')
Content-Type: application/json
X-CSRF-Token: <TOKEN>

{
  "EmailAddress": "changed@example.invalid",
  "CompanyName": "TEST ODATA",
  "City": "Lyon",
  "Country": "FR"
}
```

SAP Learning indique `204 No Content` pour une mise à jour V2 réussie dans cet exemple. Relire ensuite l’entité pour prouver la modification.

## 9.F CONTRÔLE NÉGATIF

- Clé inexistante.
- Champ non modifiable envoyé.
- ETag obsolète lorsque le service l’exige.
- Utilisateur autorisé à lire mais pas à modifier.

## 9.G ERREURS FRÉQUENTES

- Utiliser la clé du payload au lieu de celle de l’URI sans contrôle.
- Marquer tous les indicateurs `X` sur un `PATCH` partiel.
- Attendre que `ER_ENTITY` soit retourné en V2 : SAP Learning précise qu’il est ignoré pour cette opération.
- Ne pas relire l’objet après le test.

## 9.H COMPATIBILITÉ S/4HANA

Le comportement de la réponse diffère entre l’exemple OData V2 et OData V4. Vérifier le contrat du service consommé.

## 9.I RÉFÉRENCES OFFICIELLES SAP

- [Implementing Change Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-change-operations)

[^terme-etag]: **ETAG.** Valeur de version HTTP utilisable pour contrôler les mises à jour concurrentes. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#etag>).
