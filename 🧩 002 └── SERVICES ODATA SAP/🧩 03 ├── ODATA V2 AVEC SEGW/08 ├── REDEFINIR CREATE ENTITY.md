# 8. REDÉFINIR CREATE_ENTITY

## 8.A RÉSULTAT ATTENDU

Lire le payload d’un `POST` avec `IO_DATA_PROVIDER->READ_ENTRY_DATA`, appeler l’API de création et retourner l’entité créée dans `ER_ENTITY`.

## 8.B PRÉREQUIS

- Entity set déclaré creatable dans le modèle.
- Propriétés creatable configurées.
- API métier de création et stratégie de commit documentées.
- Jeton CSRF[^terme-csrf] et utilisateur autorisé pour le test.

## 8.C PROCESS

1. Ouvrir `Service Implementation > <EntitySet> > Create`.
2. Aller à l’ABAP Workbench et choisir **Redefine**.
3. Lire le corps avec `READ_ENTRY_DATA`.
4. Valider les champs obligatoires et exécuter les autorisations.
5. Mapper vers l’interface de l’API métier.
6. Traiter uniquement les messages d’erreur ou d’abandon comme échec.
7. Retourner la clé générée et les valeurs effectivement persistées.

## 8.D CODE PRÊT À ADAPTER

```abap
METHOD businesspartner_create_entity.
  DATA ls_request TYPE zcl_zbp_mpc=>ts_businesspartner.
  DATA ls_header  TYPE bapi_epm_bp_header.
  DATA ls_bp_id   TYPE bapi_epm_bp_id.
  DATA lt_return  TYPE TABLE OF bapiret2.

  io_data_provider->read_entry_data(
    IMPORTING
      es_data = ls_request ).

  IF ls_request-emailaddress IS INITIAL.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'EmailAddress obligatoire'.
  ENDIF.

  ls_header = CORRESPONDING #( ls_request ).

  CALL FUNCTION 'BAPI_EPM_BP_CREATE'
    EXPORTING
      headerdata        = ls_header
    IMPORTING
      businesspartnerid = ls_bp_id
    TABLES
      return            = lt_return.

  IF line_exists( lt_return[ type = 'E' ] )
  OR line_exists( lt_return[ type = 'A' ] ).
    mo_context->get_message_container( )->add_messages_from_bapi(
      it_bapi_messages = lt_return ).
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid            = /iwbep/cx_mgw_busi_exception=>business_error
        message_container = mo_context->get_message_container( ).
  ENDIF.

  er_entity = CORRESPONDING #( ls_request ).
  er_entity-businesspartnerid = ls_bp_id-bp_id.
ENDMETHOD.
```

## 8.E POINTS À REMPLACER

- Type MPC de l’entité.
- Validation fonctionnelle et `AUTHORITY-CHECK`.
- BAPI EPM par l’API métier réelle.
- Gestion du commit selon le contrat de cette API.
- Mapping de la clé retournée.

## 8.F REQUÊTE DE TEST

```http
POST /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet
Content-Type: application/json
X-CSRF-Token: <TOKEN>

{
  "BusinessPartnerRole": "01",
  "EmailAddress": "odata.test@example.invalid",
  "CompanyName": "TEST ODATA",
  "CurrencyCode": "EUR",
  "City": "Paris",
  "Country": "FR"
}
```

Le statut nominal documenté par SAP Learning est `201 Created`, avec l’entité créée et sa clé dans la réponse.

## 8.G ERREURS FRÉQUENTES

- Placer une clé dans l’URI du `POST` de création.
- Oublier de retourner la clé générée.
- Considérer tout message BAPI comme une erreur sans examiner son type.
- Effectuer un commit supplémentaire sans connaître le contrat de l’API.

## 8.H COMPATIBILITÉ S/4HANA

Les BAPI EPM sont des exemples SAP Learning. Utiliser une API disponible et autorisée dans le système cible.

## 8.I RÉFÉRENCES OFFICIELLES SAP

- [Implementing Change Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-change-operations)

[^terme-csrf]: **JETON CSRF.** Jeton de session protégeant les requêtes de modification. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/01 ├── PROTOCOLE HTTP ET ODATA.md#csrf-token>).
