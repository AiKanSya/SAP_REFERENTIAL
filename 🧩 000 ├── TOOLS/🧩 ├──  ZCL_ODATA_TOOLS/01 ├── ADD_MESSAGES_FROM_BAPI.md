# ADD_MESSAGES_FROM_BAPI

## RÉSULTAT ATTENDU

Convertir chaque ligne d’une table `BAPIRET2_T`[^bapiret2] en message Gateway, calculer si possible la cible du message[^cible-message], puis ajouter le message au conteneur de messages[^conteneur-messages] de la requête sans lever d’exception.

## APPEL MINIMAL

```abap
DATA(lo_message_container) =
  me->/iwbep/if_mgw_core_srv_runtime~mo_context->get_message_container( ).

zcl_odata_tools=>add_messages_from_bapi(
  it_bapi_messages     = lt_return
  io_message_container = lo_message_container
  io_request_context   = io_request_context ).
```

`LT_RETURN` doit être de type `BAPIRET2_T`. Le fragment suppose que `MO_CONTEXT` et `IO_REQUEST_CONTEXT` sont disponibles dans le traitement Gateway courant.

## APPEL AVEC OPTIONS EXPLICITES

```abap
zcl_odata_tools=>add_messages_from_bapi(
  it_bapi_messages          = lt_return
  iv_error_category         = /iwbep/if_message_container=>gcs_error_category-processing
  iv_entity_type            = 'SalesOrder'
  it_key_tab                = lt_key_tab
  iv_add_to_response_header = abap_false
  iv_is_leading_message     = abap_true
  io_message_container      = lo_message_container
  io_request_context        = io_request_context
  iv_relative_path          = abap_false
  iv_transient              = abap_true ).
```

## PROCESS

### Étape 1 — Préparer les messages BAPI

Conserver les champs `TYPE`, `ID`, `NUMBER`, `MESSAGE`, `MESSAGE_V1` à `MESSAGE_V4` et `FIELD`. La méthode ajoute toutes les lignes reçues ; elle ne filtre pas automatiquement les succès, avertissements ou erreurs.

### Étape 2 — Fournir un conteneur lié

`IO_MESSAGE_CONTAINER` est obligatoire dans la signature, mais une référence initiale reste possible. Dans ce cas, la méthode essaie `_DEFAULT_MESSAGE_CONTAINER`. Si les deux références sont initiales, elle quitte sans ajouter de message.

### Étape 3 — Résoudre le contexte

Si `IO_REQUEST_CONTEXT` est initial, la méthode essaie `_DEFAULT_REQUEST_CONTEXT`. Un contexte absent n’empêche pas l’ajout, mais limite le calcul de la cible.

### Étape 4 — Convertir le champ BAPI en propriété

`BAPIRET2-FIELD` est converti en majuscules puis recherché dans le nom technique des propriétés. En cas de correspondance, le nom externe devient la cible du message, par exemple `Quantity`.

### Étape 5 — Construire une cible absolue ou relative

Avec `IV_RELATIVE_PATH = ABAP_FALSE` et un contexte lié, la méthode préfixe la propriété par le chemin de l’entité. Pour une création ou une opération de service, elle utilise le chemin enregistré pour le `CONTENT_ID`[^content-id] ; sinon elle appelle `GET_ENTITY_KEY_FROM_CONTEXT`.

### Étape 6 — Ajouter chaque message

La méthode appelle `ADD_MESSAGE` avec les champs BAPI, la catégorie, la cible, les clés, les indicateurs de message principal, d’en-tête et de transition.

## RÉSULTAT

Le conteneur reçoit une entrée par ligne de `IT_BAPI_MESSAGES`. La méthode ne modifie pas la table source, ne retourne aucune valeur et ne lève pas elle-même `/IWBEP/CX_MGW_BUSI_EXCEPTION`.

Exemple de cible calculée :

```text
/SalesOrderSet('0000004711')/Quantity
```

## CONTRÔLE

```abap
DATA(lt_messages) = lo_message_container->get_messages( ).
ASSERT lines( lt_messages ) >= lines( lt_return ).
```

Le conteneur peut déjà contenir des messages ; comparer également les identifiants et numéros ajoutés.

## POINTS D’ATTENTION

- `IV_IS_LEADING_MESSAGE = ABAP_TRUE` est transmis à chaque message ; chaque ajout peut donc redéfinir le message principal selon le comportement de la release.
- `IV_ADD_TO_RESPONSE_HEADER` n’a d’effet visible sur une réponse réussie que selon la gestion Gateway du conteneur.
- Une cible absolue peut devenir `/` ou se terminer par `/` si ni chemin ni propriété ne sont résolus.
- Le nom de champ BAPI doit correspondre au nom technique de la propriété.

## SOURCES

- [Implémentation analysée](<./zcl_odata_tools.abap#L120>)
- [SAP Gateway Foundation — `/IWBEP/IF_MESSAGE_CONTAINER`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/01a226519eff236ee10000000a445394.html)

[^bapiret2]: **BAPIRET2.** Structure standard SAP transportant le type, la classe, le numéro, le texte, les variables et le champ associés à un message d’API métier.
[^cible-message]: **CIBLE DE MESSAGE.** Chemin OData indiquant au client l’entité ou la propriété concernée par un message de validation.
[^conteneur-messages]: **CONTENEUR DE MESSAGES.** Objet Gateway qui collecte les messages applicatifs avant leur conversion dans la réponse HTTP.
[^content-id]: **CONTENT-ID.** Identifiant d’une opération à l’intérieur d’une requête batch ou d’un change set.
