# 10. REDÉFINIR DELETE_ENTITY

## 10.A RÉSULTAT ATTENDU

Lire la clé convertie dans la DPC[^terme-dpc], contrôler l’autorisation et supprimer une entité au moyen de l’API métier.

## 10.B PRÉREQUIS

- Entity set marqué deletable.
- API de suppression documentée.
- Entité de test créée pour ce scénario.
- Effets sur les dépendances et règles d’archivage validés.

## 10.C CODE PRÊT À ADAPTER

```abap
METHOD businesspartner_delete_entity.
  DATA ls_key     TYPE zcl_zbp_mpc=>ts_businesspartner.
  DATA ls_bp_id   TYPE bapi_epm_bp_id.
  DATA lt_return  TYPE TABLE OF bapiret2.

  io_tech_request_context->get_converted_keys(
    IMPORTING
      es_key_values = ls_key ).

  IF ls_key-businesspartnerid IS INITIAL.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid  = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'Clé BusinessPartnerID absente'.
  ENDIF.

  ls_bp_id-bp_id = ls_key-businesspartnerid.

  CALL FUNCTION 'BAPI_EPM_BP_DELETE'
    EXPORTING
      bp_id  = ls_bp_id
    TABLES
      return = lt_return.

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

## 10.D POINTS À REMPLACER

| Exemple | Remplacement |
|---|---|
| `BUSINESSPARTNER_DELETE_ENTITY` | Méthode générée |
| Type MPC | Type de l’entity type |
| BAPI EPM | API de suppression officielle du domaine |
| Autorisation | Objet et valeurs organisationnelles |
| Messages | Classe de messages et message container |

## 10.E PROCESS

1. Ouvrir `Delete` depuis `Service Implementation`.
2. Choisir **Redefine** dans `DPC_EXT`.
3. Lire la clé avec `GET_CONVERTED_KEYS`.
4. Relire l’objet si l’autorisation dépend de ses attributs.
5. Exécuter `AUTHORITY-CHECK`.
6. Appeler l’API de suppression.
7. Convertir les messages en exception Gateway.
8. Relire la clé après suppression pour prouver son absence.

## 10.F REQUÊTE DE TEST

```http
DELETE /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')
X-CSRF-Token: <TOKEN>
```

Le résultat nominal de l’exemple SAP Learning est `204 No Content`. Un `GET` ultérieur doit confirmer que la ressource n’existe plus.

## 10.G CONTRÔLE NÉGATIF

- Supprimer une clé inexistante.
- Supprimer sans activité métier.
- Supprimer une entité possédant des dépendances bloquantes.
- Rejouer la même suppression et vérifier le contrat d’idempotence attendu.

## 10.H ERREURS FRÉQUENTES

- Tester sur un objet partagé ou productif.
- Exécuter un `DELETE` SQL direct sur une table SAP.
- Ignorer les dépendances métier.
- Retourner `204` alors que l’API a produit une erreur.

## 10.I COMPATIBILITÉ S/4HANA

L’API EPM est une démonstration. La suppression réelle d’un objet S/4HANA doit passer par son API métier autorisée.

## 10.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Change Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-change-operations)

[^terme-dpc]: **DPC.** Data Provider Class fournissant les opérations de données d’un service Gateway. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#dpc>).
