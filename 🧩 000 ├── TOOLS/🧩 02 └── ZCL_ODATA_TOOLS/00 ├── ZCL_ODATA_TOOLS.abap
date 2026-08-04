class ZCL_ODATA_TOOLS definition
  public
  create public .

public section.

  types:
    BEGIN OF tys_creation_entity_path,
        content_id TYPE string,
        entity_path TYPE string,
      END OF tys_creation_entity_path .
  types:
    tyh_creation_entity_paths TYPE HASHED TABLE OF tys_creation_entity_path WITH UNIQUE KEY content_id .

  class-methods GET_ENTITY_KEY_FROM_CONTEXT
    importing
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST
    returning
      value(ENTITY_KEY) type STRING .
  class-methods GET_ENTITY_PROPERTIES
    importing
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST
      !ONLY_KEY type BOOLEAN default ABAP_FALSE
    returning
      value(PROPERTIES) type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_T_MGW_ODATA_PROPERTIES .
  class-methods BUILD_KEY_FROM_REQ_DATA
    importing
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST
      !DATA type ANY
    returning
      value(RT_KEY_TAB) type /IWBEP/T_MGW_NAME_VALUE_PAIR .
  class-methods ADD_MESSAGES_FROM_BAPI
    importing
      !IT_BAPI_MESSAGES type BAPIRET2_T
      !IV_ERROR_CATEGORY type /IWBEP/IF_MESSAGE_CONTAINER=>TY_ERROR_CATEGORY default /IWBEP/IF_MESSAGE_CONTAINER=>GCS_ERROR_CATEGORY-PROCESSING
      !IV_ENTITY_TYPE type STRING optional
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
      !IV_ADD_TO_RESPONSE_HEADER type /IWBEP/SUP_MC_ADD_TO_RESPONSE default ABAP_FALSE
      !IV_IS_LEADING_MESSAGE type BOOLEAN default ABAP_TRUE
      !IO_MESSAGE_CONTAINER type ref to /IWBEP/IF_MESSAGE_CONTAINER
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST optional
      !IV_RELATIVE_PATH type BOOLEAN default ABAP_FALSE
      !IV_TRANSIENT type BOOLEAN default ABAP_TRUE .
  class-methods RAISE_BUSI_EXCEPTION_FROM_BAPI
    importing
      !IT_BAPI_MESSAGES type BAPIRET2_T
      !IV_ERROR_CATEGORY type /IWBEP/IF_MESSAGE_CONTAINER=>TY_ERROR_CATEGORY default /IWBEP/IF_MESSAGE_CONTAINER=>GCS_ERROR_CATEGORY-PROCESSING
      !IV_ENTITY_TYPE type STRING optional
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
      !IV_ADD_TO_RESPONSE_HEADER type /IWBEP/SUP_MC_ADD_TO_RESPONSE default ABAP_TRUE
      !IV_IS_LEADING_MESSAGE type BOOLEAN default ABAP_TRUE
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST optional
      !IO_MESSAGE_CONTAINER type ref to /IWBEP/IF_MESSAGE_CONTAINER optional
      !IV_RELATIVE_PATH type BOOLEAN default ABAP_FALSE
      !IV_TRANSIENT type BOOLEAN default ABAP_TRUE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION .
  class-methods APPLY_SORTERS
    importing
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST optional
      !IV_AUTO_CONVERT type BOOLEAN default ABAP_TRUE
    changing
      !ET_ENTITYSET type TABLE .
  class-methods APPLY_FILTERS
    importing
      !IT_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST
      !IV_AUTO_CONVERT type BOOLEAN default ABAP_TRUE
    changing
      !CT_DATA type STANDARD TABLE .
  class-methods SET_DEFAULT_REQUEST_CONTEXT
    importing
      !REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST optional .
  class-methods SET_DEFAULT_MESSAGE_CONTAINER
    importing
      !MESSAGE_CONTAINER type ref to /IWBEP/IF_MESSAGE_CONTAINER .
  class-methods FILL_KEY_FIELDS
    importing
      !IO_REQUEST_CONTEXT type ref to /IWBEP/CL_MGW_REQUEST
      !ALTERNATE_KEYS type /IWBEP/T_MGW_NAME_VALUE_PAIR optional
    changing
      !CT_ENTITY type DATA .
  class-methods REGISTER_CREATE_ENTITY_PATH
    importing
      !CONTENT_ID type STRING
      !ENTITY_PATH type STRING .
  class-methods GET_CREATE_ENTITY_PATH
    importing
      !CONTENT_ID type STRING
    returning
      value(ENTITY_PATH) type STRING .
protected section.
PRIVATE SECTION.

  CLASS-DATA _default_request_context TYPE REF TO /iwbep/cl_mgw_request .
  CLASS-DATA _default_message_container TYPE REF TO /iwbep/if_message_container .
  CLASS-DATA _creation_entities TYPE tyh_creation_entity_paths .
ENDCLASS.



CLASS ZCL_ODATA_TOOLS IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>ADD_MESSAGES_FROM_BAPI
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_BAPI_MESSAGES               TYPE        BAPIRET2_T
* | [--->] IV_ERROR_CATEGORY              TYPE        /IWBEP/IF_MESSAGE_CONTAINER=>TY_ERROR_CATEGORY (default =/IWBEP/IF_MESSAGE_CONTAINER=>GCS_ERROR_CATEGORY-PROCESSING)
* | [--->] IV_ENTITY_TYPE                 TYPE        STRING(optional)
* | [--->] IT_KEY_TAB                     TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR(optional)
* | [--->] IV_ADD_TO_RESPONSE_HEADER      TYPE        /IWBEP/SUP_MC_ADD_TO_RESPONSE (default =ABAP_FALSE)
* | [--->] IV_IS_LEADING_MESSAGE          TYPE        BOOLEAN (default =ABAP_TRUE)
* | [--->] IO_MESSAGE_CONTAINER           TYPE REF TO /IWBEP/IF_MESSAGE_CONTAINER
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST(optional)
* | [--->] IV_RELATIVE_PATH               TYPE        BOOLEAN (default =ABAP_FALSE)
* | [--->] IV_TRANSIENT                   TYPE        BOOLEAN (default =ABAP_TRUE)
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD add_messages_from_bapi.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_MESSAGE_MANAGER=====CM001
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 15:46:41  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Add messages to message container from a list of BAPIRET2 messages
*                 calculating the message target
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lv_message_target TYPE string.

  DATA(lo_message_container) = io_message_container.
  IF lo_message_container IS NOT BOUND.
    lo_message_container = _default_message_container.
  ENDIF.

  DATA(lo_request_context) = io_request_context.
  IF lo_request_context IS NOT BOUND.
    lo_request_context = _default_request_context.
  ENDIF.

  "CHECK lo_request_context IS BOUND.
  CHECK lo_message_container IS BOUND.

  DATA(lt_entity_properties) = get_entity_properties( lo_request_context ).

  LOOP AT it_bapi_messages[] ASSIGNING FIELD-SYMBOL(<bapi_message>).
    "Calculate the target if Field property is filled

    CLEAR lv_message_target.
    DATA(lv_field) = to_upper( <bapi_message>-field ).
    ASSIGN lt_entity_properties[ name = lv_field ] TO FIELD-SYMBOL(<entity_property>). "Get the oData property corresponding to the ABAP technical field
    IF sy-subrc = 0.
      lv_message_target = <entity_property>-external_name.
    ENDIF.

    "Absolute path if context provided
    IF lo_request_context IS BOUND AND iv_relative_path = abap_false.
      DATA(ls_request_details) = lo_request_context->get_request_details( ).
      IF ls_request_details-operation = 'create' OR ls_request_details-operation = 'service operation'. "Special case creation request or function import
        "Get the entity using content_id
        DATA(lv_entity_key) = get_create_entity_path( ls_request_details-technical_request-batch_info-content_id ).
      ELSE.
        lv_entity_key = get_entity_key_from_context( lo_request_context ).
      ENDIF.
      lv_message_target = lv_entity_key && '/' && lv_message_target.
    ENDIF.

*    DATA(lv_is_leading_message) = iv_is_leading_message.
*    "By default, first message of container is the leading message
*    IF iv_is_leading_message IS NOT SUPPLIED AND lo_message_container->get_messages( ) IS INITIAL.
*      lv_is_leading_message = abap_true.
*    ENDIF.

*    IF iv_transient = abap_true.
*      lv_message_target = '/#TRANSIENT#' && lv_message_target.   "Same effect as setting parameter iv_is_transition_message to ABAP_TRUE in more recent versions
*    ENDIF.

    lo_message_container->add_message(
        iv_msg_type               = <bapi_message>-type
        iv_msg_id                 = <bapi_message>-id
        iv_msg_number             = <bapi_message>-number
        iv_msg_text               = <bapi_message>-message
        iv_msg_v1                 = <bapi_message>-message_v1
        iv_msg_v2                 = <bapi_message>-message_v2
        iv_msg_v3                 = <bapi_message>-message_v3
        iv_msg_v4                 = <bapi_message>-message_v4
        iv_is_leading_message     = iv_is_leading_message
        iv_add_to_response_header = iv_add_to_response_header
        iv_entity_type            = iv_entity_type
        it_key_tab                = it_key_tab[]
        iv_error_category         = iv_error_category
        iv_message_target         = lv_message_target
        iv_is_transition_message  = iv_transient
    ).

  ENDLOOP.



ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>APPLY_FILTERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_SELECT_OPTIONS              TYPE        /IWBEP/T_MGW_SELECT_OPTION
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST
* | [--->] IV_AUTO_CONVERT                TYPE        BOOLEAN (default =ABAP_TRUE)
* | [<-->] CT_DATA                        TYPE        STANDARD TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD apply_filters.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: APPLY_FILTERS
*______________________________________________________________________________________*
* Date of creation: 01.11.2023 20:51:11  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Apply filters
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: ls_select_options LIKE LINE OF it_select_options.
  FIELD-SYMBOLS: <fs_data> TYPE any,
                 <fs_fval> TYPE any.
  DATA: lv_index TYPE sy-tabix.

  DATA(lt_select_options) = it_select_options[].

  "Replace names by technical names
  IF iv_auto_convert = abap_true.
    DATA(lt_entity_properties) = get_entity_properties( io_request_context ).
    LOOP AT lt_select_options[] ASSIGNING FIELD-SYMBOL(<sel_option>).
      ASSIGN lt_entity_properties[ external_name = <sel_option>-property ] TO FIELD-SYMBOL(<property>).
      CHECK sy-subrc = 0.
      <sel_option>-property = <property>-name.
    ENDLOOP.
  ENDIF.

  LOOP AT lt_select_options INTO ls_select_options.
    TRANSLATE ls_select_options-property TO UPPER CASE.  "#EC TRANSLANG
    LOOP AT ct_data ASSIGNING <fs_data>.
      lv_index = sy-tabix.
      ASSIGN COMPONENT ls_select_options-property OF STRUCTURE <fs_data> TO <fs_fval>.
      CHECK sy-subrc EQ 0.
      IF <fs_fval> NOT IN ls_select_options-select_options.
        DELETE ct_data INDEX lv_index.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>APPLY_SORTERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_ORDER                       TYPE        /IWBEP/T_MGW_SORTING_ORDER
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST(optional)
* | [--->] IV_AUTO_CONVERT                TYPE        BOOLEAN (default =ABAP_TRUE)
* | [<-->] ET_ENTITYSET                   TYPE        TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD apply_sorters.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM005
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 16:17:57  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Apply sorters on entities
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  " **** Apply sorters ****
  DATA(lt_order) = it_order[].

  "Replace names by technical names
  IF iv_auto_convert = abap_true.
    DATA(lt_entity_properties) = get_entity_properties( io_request_context ).
    LOOP AT lt_order[] ASSIGNING FIELD-SYMBOL(<order>).
      ASSIGN lt_entity_properties[ external_name = <order>-property ] TO FIELD-SYMBOL(<property>).
      CHECK sy-subrc = 0.
      <order>-property = <property>-name.
    ENDLOOP.
  ENDIF.

  "Applique les tris
  CALL METHOD /iwbep/cl_mgw_data_util=>orderby
    EXPORTING
      it_order = lt_order[]
    CHANGING
      ct_data  = et_entityset[].

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>BUILD_KEY_FROM_REQ_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST
* | [--->] DATA                           TYPE        ANY
* | [<-()] RT_KEY_TAB                     TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD build_key_from_req_data.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM00C
*______________________________________________________________________________________*
* Date of creation: 11.09.2023 12:09:54  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Build key[] table from request data
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  CHECK io_request_context IS BOUND.

  "Get list of the key components of the request entity
  DATA(lt_key_properties) = get_entity_properties( io_request_context = io_request_context
                                                   only_key           = abap_true ).
  CHECK lt_key_properties[] IS NOT INITIAL.

  LOOP AT lt_key_properties[] ASSIGNING FIELD-SYMBOL(<key_property>).

    DATA(lv_field_name) = |DATA-{ <key_property>-name }|.
    ASSIGN (lv_field_name) TO FIELD-SYMBOL(<field_value>).
    IF <field_value> IS ASSIGNED.
      APPEND INITIAL LINE TO rt_key_tab[] ASSIGNING FIELD-SYMBOL(<key>).
      <key>-name = <key_property>-external_name.
      <key>-value = <field_value>.
    ENDIF.

    UNASSIGN <field_value>.
  ENDLOOP.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>FILL_KEY_FIELDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST
* | [--->] ALTERNATE_KEYS                 TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR(optional)
* | [<-->] CT_ENTITY                      TYPE        DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD fill_key_fields.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM00B
*______________________________________________________________________________________*
* Date of creation: 23.08.2023 15:33:52  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Fill key fields into an entity structure from key_tab[]
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  CHECK io_request_context IS BOUND.

  IF alternate_keys[] IS NOT INITIAL.
    DATA(lt_keys) = alternate_keys[].
  ELSE.
    lt_keys[] = io_request_context->get_request_details( )-key_tab[]. "Get keys from request context
  ENDIF.

  CHECK lt_keys[] IS NOT INITIAL.

  DATA(lt_properties) = get_entity_properties( io_request_context ). "Get all OData properties names allong with technical names
  CHECK lt_properties[] IS NOT INITIAL.

  LOOP AT lt_keys[] ASSIGNING FIELD-SYMBOL(<key>).
    ASSIGN lt_properties[ external_name = <key>-name ] TO FIELD-SYMBOL(<property>). "Get technical name of a key field
    CHECK sy-subrc = 0.

    DATA(lv_field_name) = |CT_ENTITY-{ <property>-name }|.
    ASSIGN (lv_field_name) TO FIELD-SYMBOL(<field_value>).
    IF <field_value> IS ASSIGNED.
      <field_value> = <key>-value.
    ENDIF.

    UNASSIGN <field_value>.
  ENDLOOP.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>GET_CREATE_ENTITY_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONTENT_ID                     TYPE        STRING
* | [<-()] ENTITY_PATH                    TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD GET_CREATE_ENTITY_PATH.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM00C
*______________________________________________________________________________________*
* Date of creation: 29.11.2023 17:26:37  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Retrieve the registered entity key from content id
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  READ TABLE _creation_entities[]
    ASSIGNING FIELD-SYMBOL(<entry>)
    WITH TABLE KEY content_id = content_id.

  IF sy-subrc = 0.
    entity_path = <entry>-entity_path.
  ENDIF.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>GET_ENTITY_KEY_FROM_CONTEXT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST
* | [<-()] ENTITY_KEY                     TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD GET_ENTITY_KEY_FROM_CONTEXT.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: GET_ENTITI_KEY
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 16:54:17  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :
*                 Return the entity key for a given request
*                 This method could be used to calculate the targets for OData exception messages
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA(lv_target_entity_set_name) = io_request_context->get_request_details( )-target_entity_set. "ex: PurchaseOrderSet

  DATA(lt_request_header) = io_request_context->get_request_details( )-technical_request-request_header[].
  ASSIGN lt_request_header[ name = '~request_uri' ] TO FIELD-SYMBOL(<uri>). "ex: /sap/opu/odata/SAP/ZMM_PO_GOOD_RECEIPT/PurchaseOrderSet(PurchaseOrderNumber='0000000279')
  IF sy-subrc = 0.
    SPLIT <uri>-value AT lv_target_entity_set_name INTO DATA(lv_str1) entity_key. "ex: (PurchaseOrderNumber='0000000279')
    SPLIT entity_key AT '?' INTO entity_key lv_str1. "Enlève les paramètres URL après ? si ils existent
    entity_key = '/' && lv_target_entity_set_name && entity_key. "ex: /PurchaseOrderSet(PurchaseOrderNumber='0000000279')
  ENDIF.

  REPLACE ALL OCCURRENCES OF '%3D' IN entity_key WITH '='.
  REPLACE ALL OCCURRENCES OF '%2C' IN entity_key WITH ','.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>GET_ENTITY_PROPERTIES
* +-------------------------------------------------------------------------------------------------+
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST
* | [--->] ONLY_KEY                       TYPE        BOOLEAN (default =ABAP_FALSE)
* | [<-()] PROPERTIES                     TYPE        /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_T_MGW_ODATA_PROPERTIES
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_entity_properties.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: GET_ENTITY_PROPERTIES
*______________________________________________________________________________________*
* Date of creation: 24.03.2023 16:58:02  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Return the list of properties for an entity in a given OData request
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lo_key_converter TYPE REF TO /iwbep/cl_mgw_req_key_convert.
  DATA: lo_property TYPE REF TO /iwbep/cl_mgw_odata_property.
  DATA: lt_prop_keys LIKE properties[].

  CHECK io_request_context IS BOUND.
  lo_key_converter ?= io_request_context->get_request_details( )-technical_request-key_converter.

  "Check if navigation -> take the key converter of the target entity
  DATA(lt_navigation_path) = io_request_context->get_request_details( )-technical_request-navigation_path[].
  ASSIGN lt_navigation_path[ 1 ] TO FIELD-SYMBOL(<navigation_path>).
  IF sy-subrc = 0.
    lo_key_converter ?= <navigation_path>-key_converter.
  ENDIF.

  CHECK lo_key_converter IS BOUND.

  DATA(lo_entity_type) = lo_key_converter->/iwbep/if_mgw_req_key_convert~get_entity_type( ).
  CHECK lo_entity_type IS BOUND.

  TRY .

      properties[] = lo_entity_type->/iwbep/if_mgw_odata_entity_typ~get_properties( ).

      IF only_key = abap_true.
        LOOP AT properties[] ASSIGNING FIELD-SYMBOL(<property>).
          lo_property ?= <property>-property.
          IF lo_property->/iwbep/if_mgw_odata_re_prop~is_key( ) = abap_true.
            APPEND <property> TO lt_prop_keys[].
          ENDIF.
        ENDLOOP.
        properties[] = lt_prop_keys[].
      ENDIF.

    CATCH /iwbep/cx_mgw_med_exception.

  ENDTRY.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>RAISE_BUSI_EXCEPTION_FROM_BAPI
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_BAPI_MESSAGES               TYPE        BAPIRET2_T
* | [--->] IV_ERROR_CATEGORY              TYPE        /IWBEP/IF_MESSAGE_CONTAINER=>TY_ERROR_CATEGORY (default =/IWBEP/IF_MESSAGE_CONTAINER=>GCS_ERROR_CATEGORY-PROCESSING)
* | [--->] IV_ENTITY_TYPE                 TYPE        STRING(optional)
* | [--->] IT_KEY_TAB                     TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR(optional)
* | [--->] IV_ADD_TO_RESPONSE_HEADER      TYPE        /IWBEP/SUP_MC_ADD_TO_RESPONSE (default =ABAP_TRUE)
* | [--->] IV_IS_LEADING_MESSAGE          TYPE        BOOLEAN (default =ABAP_TRUE)
* | [--->] IO_REQUEST_CONTEXT             TYPE REF TO /IWBEP/CL_MGW_REQUEST(optional)
* | [--->] IO_MESSAGE_CONTAINER           TYPE REF TO /IWBEP/IF_MESSAGE_CONTAINER(optional)
* | [--->] IV_RELATIVE_PATH               TYPE        BOOLEAN (default =ABAP_FALSE)
* | [--->] IV_TRANSIENT                   TYPE        BOOLEAN (default =ABAP_TRUE)
* | [!CX!] /IWBEP/CX_MGW_BUSI_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD RAISE_BUSI_EXCEPTION_FROM_BAPI.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_MESSAGE_MANAGER=====CM005
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 15:52:08  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Raise an exception from BAPI messages
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA(lo_message_container) = io_message_container.
  IF lo_message_container IS NOT BOUND.
    lo_message_container = _default_message_container.
  ENDIF.

  add_messages_from_bapi( it_bapi_messages = it_bapi_messages[]
                          iv_entity_type = iv_entity_type
                          it_key_tab = it_key_tab[]
                          iv_error_category = iv_error_category
                          iv_add_to_response_header = iv_add_to_response_header
                          iv_is_leading_message = iv_is_leading_message
                          io_message_container = lo_message_container
                          io_request_context = io_request_context
                          iv_relative_path = iv_relative_path
                          iv_transient = iv_transient ).

  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
    EXPORTING
      message_container = lo_message_container.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>REGISTER_CREATE_ENTITY_PATH
* +-------------------------------------------------------------------------------------------------+
* | [--->] CONTENT_ID                     TYPE        STRING
* | [--->] ENTITY_PATH                    TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD REGISTER_CREATE_ENTITY_PATH.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM00B
*______________________________________________________________________________________*
* Date of creation: 29.11.2023 17:23:13  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Register an entity key for creation. This is used to calculate the message targets
*                in case of creation
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  INSERT
   VALUE #( content_id = content_id
            entity_path = entity_path ) INTO TABLE _creation_entities[].

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>SET_DEFAULT_MESSAGE_CONTAINER
* +-------------------------------------------------------------------------------------------------+
* | [--->] MESSAGE_CONTAINER              TYPE REF TO /IWBEP/IF_MESSAGE_CONTAINER
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD set_default_message_container.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM009
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 18:17:53  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Set default message container
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  _default_message_container = message_container.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_ODATA_TOOLS=>SET_DEFAULT_REQUEST_CONTEXT
* +-------------------------------------------------------------------------------------------------+
* | [--->] REQUEST_CONTEXT                TYPE REF TO /IWBEP/CL_MGW_REQUEST(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD SET_DEFAULT_REQUEST_CONTEXT.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ODATA_TOOLS===============CM007
*______________________________________________________________________________________*
* Date of creation: 18.08.2023 18:03:11  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Set defaukt request context
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  _default_request_context = request_context.

ENDMETHOD.
ENDCLASS.