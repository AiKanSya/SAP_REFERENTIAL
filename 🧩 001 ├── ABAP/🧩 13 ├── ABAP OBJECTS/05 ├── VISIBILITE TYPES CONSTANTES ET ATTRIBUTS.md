# 5. VISIBILITÉ, TYPES, CONSTANTES ET ATTRIBUTS

## 5.A RÉSULTAT ATTENDU

- Choisir entre visibilité[^terme-visibilite] publique, protégée et privée.
- Déclarer les types, constantes et attributs au bon niveau.
- Éviter l’exposition directe d’un état modifiable.

## 5.B VISIBILITÉS

| Visibilité  | Accessible depuis                                                    |
| ----------- | -------------------------------------------------------------------- |
| `PUBLIC`    | Tous les consommateurs autorisés à utiliser la classe[^terme-classe] |
| `PROTECTED` | La classe et ses sous-classes                                        |
| `PRIVATE`   | La classe elle-même et, selon le cas, ses amis                       |

L’API publique[^terme-api-publique] doit rester minimale. Un attribut[^terme-attribut] interne est normalement privé. Une valeur destinée aux consommateurs peut être exposée par une méthode[^terme-methode] de lecture ou une constante publique.

## 5.C PROCESS

### 5.C.1 Étape 1 — Classer chaque composant

Avant `SE24`[^terme-class-builder-se24], décider si le composant appartient au contrat public, aux sous-classes ou uniquement à l’implémentation. Utiliser public, protected ou private selon ce consommateur réel.

### 5.C.2 Étape 2 — Créer un type

Dans **Types**, ajouter le nom et le type référencé, puis choisir la visibilité. Un type public devient une dépendance pour les appelants ; ne l’exposer que s’il fait partie de la signature externe.

### 5.C.3 Étape 3 — Créer la constante

Dans **Attributs**, créer une constante de niveau classe, lui affecter un type explicite et une valeur compatible. Choisir une visibilité publique uniquement si les consommateurs doivent partager cette valeur contractuelle.

### 5.C.4 Étape 4 — Créer l’état d’instance

Ajouter les attributs privés nécessaires. Initialiser dans la déclaration ou le constructeur, puis créer des méthodes publiques orientées métier plutôt que des setters permettant n’importe quel état.

### 5.C.5 Étape 5 — Tester les frontières

Depuis un report externe, vérifier que les composants publics sont accessibles et que les privés provoquent une erreur syntaxique. Tester ensuite que les méthodes publiques maintiennent les invariants. La visibilité est validée lorsque aucun appelant ne dépend de l’implémentation interne.

## 5.D CAS D’USAGE

Une classe représentant une limite de crédit doit empêcher un montant négatif. Si `MV_LIMIT` est public, tout appelant peut contourner la règle. L’attribut doit être privé et modifié uniquement par `SET_LIMIT`.

## 5.E CODE À ADAPTER

```abap
CLASS zcl_zewm_support_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_ground_pallet_context
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      CHANGING
        !cs_context      TYPE zcl_zewm_support_mpc=>ts_groundpalletcontext
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS get_processing_context
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      CHANGING
        !cs_context      TYPE zcl_zewm_support_mpc=>ts_processingcontext
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS get_shipped_support_context
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      CHANGING
        !cs_context      TYPE zcl_zewm_support_mpc=>ts_shippedsupportcontext
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS get_shipped_support_items
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      EXPORTING
        !et_items        TYPE zewm_t_shipped_support_item
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS get_received_support_context
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      CHANGING
        !cs_context      TYPE zcl_zewm_support_mpc=>ts_receivedsupportcontext
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS get_received_support_items
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
      EXPORTING
        !et_items        TYPE zewm_t_received_support_item
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS update_ground_pallet_quantity
      IMPORTING
        !iv_tor_id            TYPE /scmtms/tor_id
        !iv_delivery          TYPE /scdl/dl_docno
        !iv_ground_pallet_qty TYPE /scdl/db_proch_o-zz_pal_sol
      RETURNING
        VALUE(rt_return)      TYPE bapiret2_tab .
    METHODS update_shipped_supports
      IMPORTING
        !iv_tor_id       TYPE /scmtms/tor_id
        !iv_delivery     TYPE /scdl/dl_docno
        !it_items        TYPE zewm_t_shipped_support_item
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
    METHODS update_received_supports
      IMPORTING
        !is_header       TYPE zewm_s_received_supp_decl
        !it_items        TYPE zewm_t_received_support_item
      RETURNING
        VALUE(rt_return) TYPE bapiret2_tab .
  PROTECTED SECTION.
private section.

  types:
    tt_bapi_goodsmvt_item TYPE STANDARD TABLE OF bapi2017_gm_item_create WITH EMPTY KEY .
  types:
    BEGIN OF ty_receipt_scenario,
        is_supplier_receipt TYPE abap_bool,
        is_transfer_receipt TYPE abap_bool,
        inbound_delivery    TYPE likp-vbeln,
        outbound_delivery   TYPE likp-vbeln,
      END OF ty_receipt_scenario .
  types:
    BEGIN OF ty_goods_movement_context,
        declaration_type TYPE zewm_de_declaration_type,
        movement_type    TYPE bwart,
        gm_code          TYPE bapi2017_gm_code-gm_code,
        plant            TYPE werks_d,
        storage_location TYPE lgort_d,
        customer         TYPE kunnr,
        special_stock    TYPE sobkz,
        convert_to_pce   TYPE abap_bool,
      END OF ty_goods_movement_context .
  types:
    tt_goods_movement_context
          TYPE STANDARD TABLE OF ty_goods_movement_context WITH EMPTY KEY .
  types:
    BEGIN OF ty_existing_support_movement,
        source                 TYPE c LENGTH 1,
        log_posnr              TYPE zewm_supp_log_it-posnr,
        material               TYPE matnr,
        movement_type          TYPE bwart,
        plant                  TYPE werks_d,
        storage_location       TYPE lgort_d,
        customer               TYPE kunnr,
        special_stock          TYPE sobkz,
        material_document      TYPE zewm_supp_log_it-mblnr,
        material_document_year TYPE zewm_supp_log_it-mjahr,
        material_document_item TYPE zewm_supp_log_it-zeile,
        quantity               TYPE zewm_supp_log_it-quantity,
        unit                   TYPE zewm_supp_log_it-unit,
      END OF ty_existing_support_movement .
  types:
    tt_existing_support_movement
        TYPE STANDARD TABLE OF ty_existing_support_movement
        WITH EMPTY KEY .

  constants:
    BEGIN OF gc_message,
        transport_required           TYPE symsgno VALUE '001',
        delivery_required            TYPE symsgno VALUE '002',
        transport_not_found          TYPE symsgno VALUE '003',
        delivery_not_found           TYPE symsgno VALUE '004',
        link_not_found               TYPE symsgno VALUE '005',
        unsupported_scenario         TYPE symsgno VALUE '008',
        success_inbound              TYPE symsgno VALUE '010',
        success_outbound_customer    TYPE symsgno VALUE '011',
        success_outbound_transfer    TYPE symsgno VALUE '012',
        inbound_gr_not_completed     TYPE symsgno VALUE '013',
        outbound_gi_completed        TYPE symsgno VALUE '014',
        delivery_not_available_ewm   TYPE symsgno VALUE '015',
        recipient_not_found          TYPE symsgno VALUE '016',
        recipient_address_not_found  TYPE symsgno VALUE '017',
        recipient_name_not_found     TYPE symsgno VALUE '018',
        invalid_ground_pallet_qty    TYPE symsgno VALUE '019',
        delivery_lock_failed         TYPE symsgno VALUE '020',
        ground_pallet_update_failed  TYPE symsgno VALUE '021',
        delivery_save_failed         TYPE symsgno VALUE '022',
        ground_pallet_update_success TYPE symsgno VALUE '023',
        user_warehouse_missing       TYPE symsgno VALUE '024',
        user_store_missing           TYPE symsgno VALUE '025',
        delivery_store_not_found     TYPE symsgno VALUE '026',
        store_mapping_not_found      TYPE symsgno VALUE '027',
        user_delivery_store_mismatch TYPE symsgno VALUE '028',
        supports_config_not_found    TYPE symsgno VALUE '029',
        support_material_missing     TYPE symsgno VALUE '030',
        support_material_not_found   TYPE symsgno VALUE '031',
        support_description_missing  TYPE symsgno VALUE '032',
        no_usable_support_config     TYPE symsgno VALUE '033',
        delivery_hu_read_failed      TYPE symsgno VALUE '034',
        delivery_hu_not_found        TYPE symsgno VALUE '035',
        invalid_support_quantity     TYPE symsgno VALUE '036',
        hu_read_failed               TYPE symsgno VALUE '037',
        packaging_mat_not_found      TYPE symsgno VALUE '038',
        packaging_not_configured     TYPE symsgno VALUE '039',
        support_not_configured       TYPE symsgno VALUE '040',
        duplicate_support            TYPE symsgno VALUE '041',
        declaration_already_exists   TYPE symsgno VALUE '042',
        unit_conversion_missing      TYPE symsgno VALUE '043',
        unit_conversion_failed       TYPE symsgno VALUE '044',
        declaration_log_failed       TYPE symsgno VALUE '045',
        success                      TYPE symsgno VALUE '046',
        dsh_update_failed            TYPE symsgno VALUE '047',
        dsh_update_not_implemented   TYPE symsgno VALUE '048',
        warehouse_required           TYPE symsgno VALUE '049',
        no_support_to_process        TYPE symsgno VALUE '050',
        material_required            TYPE symsgno VALUE '051',
        movement_qty_invalid         TYPE symsgno VALUE '052',
        deep_no_item                 TYPE symsgno VALUE '053',
        deep_header_item_mismatch    TYPE symsgno VALUE '054',
        deep_material_required       TYPE symsgno VALUE '055',
        deep_quantity_invalid        TYPE symsgno VALUE '056',
        deep_unit_required           TYPE symsgno VALUE '057',
        deep_packaging_required      TYPE symsgno VALUE '058',
        deep_success                 TYPE symsgno VALUE '059',
        dsh_parameters_missing       TYPE symsgno VALUE '060',
        dsh_update_success           TYPE symsgno VALUE '061',
        dsh_already_set              TYPE symsgno VALUE '062',
        dsh_not_changeable           TYPE symsgno VALUE '063',
        dsh_status_not_set           TYPE symsgno VALUE '064',
        dsh_result_undetermined      TYPE symsgno VALUE '065',
        goods_movement_pending       TYPE symsgno VALUE '066',
        unit_required                TYPE symsgno VALUE '067',
        tm_transport_required        TYPE symsgno VALUE '068',
        tm_warehouse_required        TYPE symsgno VALUE '069',
        tm_deliveries_pending        TYPE symsgno VALUE '070',
        tm_update_pending            TYPE symsgno VALUE '071',
        tm_state_failed              TYPE symsgno VALUE '072',
        sender_not_found             TYPE symsgno VALUE '073',
        sender_address_not_found     TYPE symsgno VALUE '074',
        sender_name_not_found        TYPE symsgno VALUE '075',
        invalid_warehouse            TYPE symsgno VALUE '076',
        invalid_declaration_type     TYPE symsgno VALUE '077',
        goods_movement_build_failed  TYPE symsgno VALUE '078',
        tm_charge_root_not_found     TYPE symsgno VALUE '079',
        tm_zbase_not_found           TYPE symsgno VALUE '080',
        tm_calc_basis_not_found      TYPE symsgno VALUE '081',
        tm_charge_update_failed      TYPE symsgno VALUE '082',
        tm_charge_update_success     TYPE symsgno VALUE '083',
        tm_charge_update_not_needed  TYPE symsgno VALUE '084',
        no_tm_charge_item_found      TYPE symsgno VALUE '085',
      END OF gc_message .
  constants:
    BEGIN OF gc_scenario,
        inbound           TYPE zewm_de_sup_scenario VALUE 'INBOUND',
        outbound_customer TYPE zewm_de_sup_scenario VALUE 'OUT_CUST',
        outbound_transfer TYPE zewm_de_sup_scenario VALUE 'OUT_TRANS',
      END OF gc_scenario .
  constants:
    BEGIN OF gc_doctype,
        inbound           TYPE /scdl/dl_doctype VALUE 'INB',
        outbound_customer TYPE /scdl/dl_doctype VALUE 'ZOUT',
        outbound_transfer TYPE /scdl/dl_doctype VALUE 'ZTRA',
      END OF gc_doctype .
  constants:
    BEGIN OF gc_status,
        goods_receipt TYPE /scdl/db_status-status_type VALUE 'DGR',
        goods_issue   TYPE /scdl/db_status-status_type VALUE 'DGI',
        completed     TYPE /scdl/db_status-status_value VALUE '9',
      END OF gc_status .
  constants:
    BEGIN OF gc_movement_type,
        non_consigned          TYPE bwart VALUE '201',
        consigned              TYPE bwart VALUE '631',
        supplier_receipt       TYPE bwart VALUE '501',
        consignment_return     TYPE bwart VALUE '632',
        transfer_goods_issue   TYPE bwart VALUE '201',
        transfer_goods_receipt TYPE bwart VALUE '501',
      END OF gc_movement_type .
  constants:
    BEGIN OF gc_doccat,
        outbound TYPE /scdl/dl_doccat VALUE /scdl/if_dl_doc_c=>sc_doccat_out_prd,
        inbound  TYPE /scdl/dl_doccat VALUE /scdl/if_dl_doc_c=>sc_doccat_inb_prd,
      END OF gc_doccat .
  constants:
    BEGIN OF gc_declaration_type,
        shipped  TYPE zewm_de_declaration_type VALUE 'SHIPPED',
        received TYPE zewm_de_declaration_type VALUE 'RECEIVED',
      END OF gc_declaration_type .
  constants GC_REFERENCE_TYPE type CHAR2 value '73' ##NO_TEXT.
  constants GC_TOR_CATEGORY type /SCMTMS/D_TORROT-TOR_CAT value 'TO' ##NO_TEXT.
  constants GC_PARTY_ROLE_RECIPIENT type /SCDL/DB_BPLOC-PARTY_ROLE value 'STPRT' ##NO_TEXT.
  constants GC_ERP_STORAGE_LOCATION type LGORT_D value 'M502' ##NO_TEXT.
  constants GC_MSGID type SYMSGID value 'ZEWM_SUPPORT' ##NO_TEXT.
  constants GC_PARTY_ROLE_SENDER type /SCDL/DB_BPLOC-PARTY_ROLE value 'SFPRT' ##NO_TEXT.

  methods APPEND_BOPF_MESSAGES
    importing
      !IO_MESSAGE type ref to /BOBF/IF_FRW_MESSAGE
    changing
      !CT_RETURN type BAPIRET2_TAB .
  methods BUILD_GOODS_MOVEMENT_DATA
    importing
      !IS_CONTEXT type TY_GOODS_MOVEMENT_CONTEXT
      !IS_ITEM type ZEWM_S_SUPPORT_MOVEMENT_ITEM
    exporting
      !ES_GOODSMVT_HEADER type BAPI2017_GM_HEAD_01
      !ES_GOODSMVT_CODE type BAPI2017_GM_CODE
      !ET_GOODSMVT_ITEM type TT_BAPI_GOODSMVT_ITEM
    returning
      value(RT_RETURN) type BAPIRET2_T .
  methods CALCULATE_HALF_LPR_QUANTITY
    importing
      !IV_DOCID type /SCDL/DL_DOCID
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !EV_QUANTITY type MENGE_D
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_DELIVERY_EXISTENCE
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_DELIVERY_STATUS
    importing
      !IV_DOCID type /SCDL/DL_DOCID
      !IV_SCENARIO type ZEWM_DE_SUP_SCENARIO
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_DELIVERY_STORE
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_USER_LGNUM type /SCWM/LGNUM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_EXISTING_DECLARATION
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_SHIPPED_SUPPORT_QUANT
    importing
      !IT_ITEMS type ZEWM_T_SHIPPED_SUPPORT_ITEM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods CHECK_TRANSPORT_DELIVERY_LINK
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
      !IV_DELIVERY type /SCDL/DL_DOCNO
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods DETERMINE_RECEIPT_PLANTS
    importing
      !IS_SCENARIO type TY_RECEIPT_SCENARIO
    exporting
      !EV_ISSUING_PLANT type WERKS_D
      !EV_RECEIVING_PLANT type WERKS_D
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods DETERMINE_RECEIPT_SCENARIO
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
    exporting
      !ES_SCENARIO type TY_RECEIPT_SCENARIO
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods EXECUTE_GOODS_MOVEMENT
    importing
      !IS_GOODSMVT_HEADER type BAPI2017_GM_HEAD_01
      !IS_GOODSMVT_CODE type BAPI2017_GM_CODE
      !IT_GOODSMVT_ITEM type TT_BAPI_GOODSMVT_ITEM
    exporting
      !EV_MATERIALDOCUMENT type BAPI2017_GM_HEAD_RET-MAT_DOC
      !EV_MATDOCUMENTYEAR type BAPI2017_GM_HEAD_RET-DOC_YEAR
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods FILL_PACKAGING_SUPPORT_QUANT
    importing
      !IV_DOCID type /SCDL/DL_DOCID
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_LGNUM type /SCWM/LGNUM
      !IV_DOCCAT type /SCDL/DL_DOCCAT
    changing
      !CT_ITEMS type ZEWM_T_SHIPPED_SUPPORT_ITEM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods FIND_EXISTING_SUPPORT_MOVEMENT
    importing
      !IT_MOVEMENTS type TT_EXISTING_SUPPORT_MOVEMENT
      !IV_MATERIAL type MATNR
      !IS_CONTEXT type TY_GOODS_MOVEMENT_CONTEXT
    exporting
      !ES_MOVEMENT type TY_EXISTING_SUPPORT_MOVEMENT
    returning
      value(RV_FOUND) type ABAP_BOOL .
  methods GET_CONFIGURED_SUPPORTS
    importing
      !IV_LGNUM type /SCWM/LGNUM
      !IV_TOR_ID type /SCMTMS/TOR_ID
      !IV_DELIVERY type /SCDL/DL_DOCNO
    exporting
      !ET_ITEMS type ZEWM_T_SHIPPED_SUPPORT_ITEM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_DELIVERY_HUS
    importing
      !IV_DOCID type /SCDL/DL_DOCID
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_DOCCAT type /SCDL/DL_DOCCAT
    exporting
      !ET_HUHDR type /SCWM/TT_HUHDR_INT
      !ET_HUITM type /SCWM/TT_HUITM_INT
      !ET_HUTREE type /SCWM/TT_HUTREE
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_DELIVERY_RECIPIENT
    importing
      !IV_DOCID type /SCDL/DL_DOCID
    exporting
      !EV_PARTNER type BU_PARTNER
      !EV_PARTNER_NAME type AD_NAME1
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_DELIVERY_SENDER
    importing
      !IV_DOCID type /SCDL/DL_DOCID
    exporting
      !EV_PARTNER type BU_PARTNER
      !EV_PARTNER_NAME type AD_NAME1
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_EXISTING_SUPPORT_MOVEMENTS
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_DECLARATION_TYPE type ZEWM_DE_DECLARATION_TYPE
    exporting
      !ET_MOVEMENTS type TT_EXISTING_SUPPORT_MOVEMENT
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_GROUND_PALLET_STATE
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
    exporting
      !EV_ALL_DELIVERIES_TREATED type ABAP_BOOL
      !EV_TOTAL_GROUND_PALLETS type /SCDL/DB_PROCH_O-ZZ_PAL_SOL
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_INBOUND_DELIVERY_DATA
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
    exporting
      !EV_DOCID type /SCDL/DL_DOCID
      !EV_DOCTYPE type /SCDL/DL_DOCTYPE
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_MATERIAL_FROM_MATID
    importing
      !IV_MATID type /SAPAPO/MATID
    returning
      value(RV_MATNR) type MATNR .
  methods GET_OUTBOUND_DELIVERY_DATA
    importing
      !IV_DELIVERY type /SCDL/DL_DOCNO
    exporting
      !EV_DOCID type /SCDL/DL_DOCID
      !EV_DOCTYPE type /SCDL/DL_DOCTYPE
      !EV_GROUND_PALLET_QTY type /SCDL/DB_PROCH_O-ZZ_PAL_SOL
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods GET_USER_STORE_CONTEXT
    exporting
      !EV_LGNUM type /SCWM/LGNUM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods IS_HALF_LPR_MATERIAL
    importing
      !IV_MATERIAL type MATNR
    returning
      value(RV_IS_HALF_LPR) type ABAP_BOOL .
  methods LOCK_DECLARATION
    importing
      !IV_DELIVERY type ZEWM_SUPP_LOG-DELIVERY
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods POST_GOODS_MOVEMENT
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
      !IV_LGNUM type /SCWM/LGNUM
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_DECLARATION_TYPE type ZEWM_DE_DECLARATION_TYPE
      !IT_ITEMS type ZEWM_T_SUPPORT_MOVEMENT_ITEM
    exporting
      !ET_LOG_ITEMS type ZEWM_T_SUPP_LOG_IT
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods SAVE_DECLARATION_LOG
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
      !IV_DELIVERY type /SCDL/DL_DOCNO
      !IV_DECLARATION_TYPE type ZEWM_SUPP_LOG-DECLARATION_TYPE
      !IV_STATUS type ZEWM_SUPP_STATUS
      !IV_MESSAGE type BAPI_MSG optional
      !IT_LOG_ITEMS type ZEWM_T_SUPP_LOG_IT
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods UNLOCK_DECLARATION
    importing
      !IV_DELIVERY type ZEWM_SUPP_LOG-DELIVERY .
  methods UPDATE_DSH_STATUS
    importing
      !IV_DOCID type /SCDL/DL_DOCID
      !IV_LGNUM type /SCWM/LGNUM
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods UPDATE_TM_CHARGE_ITEM
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
      !IV_TOTAL_GROUND_PALLETS type ZEWM_DE_PAL_SOL
    exporting
      !EV_UPDATE_PERFORMED type BOOLE_D
    returning
      value(RT_RETURN) type BAPIRET2_TAB .
  methods UPDATE_TM_ZBASE_QUANTITY
    importing
      !IV_TOR_ID type /SCMTMS/TOR_ID
    exporting
      !EV_ALL_DELIVERIES_TREATED type ABAP_BOOL
      !EV_TOTAL_GROUND_PALLETS type ZEWM_DE_PAL_SOL
    returning
      value(RT_RETURN) type BAPIRET2_T .
ENDCLASS.
```

## 5.F RÈGLES PRATIQUES

- Un type public fait partie du contrat et devient plus difficile à modifier.
- Une constante publique est adaptée à une valeur stable du contrat.
- Un attribut public modifiable crée un couplage fort et affaiblit les contrôles.
- Un attribut statique conserve une valeur partagée pour la session interne : l’utiliser uniquement si ce partage est intentionnel.

## 5.G CONTRÔLE

Tenter d’accéder à l’attribut privé depuis un report doit produire une erreur de syntaxe. La valeur doit être accessible uniquement via la méthode prévue.

## 5.H ERREURS FRÉQUENTES

- Utiliser `PUBLIC` par facilité.
- Déclarer des types publics qui ne servent qu’à l’implémentation.
- Employer un attribut statique pour stocker un état utilisateur sans maîtriser sa durée de vie.

## 5.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 5.J RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — MÉTHODES D’INSTANCE ET PARAMÈTRES](<./06 ├── METHODES D INSTANCE ET PARAMETRES.md>)

[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).

[^terme-api-publique]: **API PUBLIQUE.** Ensemble des composants publics qu’une classe expose à ses consommateurs : méthodes, événements, types, constantes et attributs publics. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#api-publique>).

[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).

[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).

[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).

[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).

[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).

[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).

[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
