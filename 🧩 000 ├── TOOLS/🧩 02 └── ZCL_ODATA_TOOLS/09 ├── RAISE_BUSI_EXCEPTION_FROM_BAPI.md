# RAISE_BUSI_EXCEPTION_FROM_BAPI

## RÉSULTAT ATTENDU

Ajouter une table de messages `BAPIRET2_T`[^bapiret2] au conteneur Gateway[^conteneur-messages] puis interrompre le traitement en levant `/IWBEP/CX_MGW_BUSI_EXCEPTION`[^exception-metier].

## APPEL

```abap
DATA(lo_message_container) =
  me->/iwbep/if_mgw_core_srv_runtime~mo_context->get_message_container( ).

IF line_exists( lt_return[ type = 'E' ] )
   OR line_exists( lt_return[ type = 'A' ] ).
  zcl_odata_tools=>raise_busi_exception_from_bapi(
    it_bapi_messages     = lt_return
    io_message_container = lo_message_container
    io_request_context   = io_request_context ).
ENDIF.
```

La méthode appelante doit autoriser la propagation de `/IWBEP/CX_MGW_BUSI_EXCEPTION` dans sa signature ou la traiter dans un bloc `TRY...CATCH` adapté.

## PROCESS

### Étape 1 — Décider si l’appel doit échouer

Examiner `BAPIRET2-TYPE` avant l’appel. Cette méthode lève toujours l’exception, même lorsque la table est vide ou ne contient que des messages de succès. L’appelant doit donc définir la règle métier, généralement la présence d’un type `E` ou `A`.

### Étape 2 — Obtenir un conteneur valide

Transmettre le conteneur de la requête. Si `IO_MESSAGE_CONTAINER` est absent ou initial, la méthode utilise `_DEFAULT_MESSAGE_CONTAINER`. Aucun contrôle explicite ne garantit ensuite que la référence effective est liée.

### Étape 3 — Ajouter les messages

La méthode délègue intégralement à `ADD_MESSAGES_FROM_BAPI`, avec `IV_ADD_TO_RESPONSE_HEADER = ABAP_TRUE` par défaut. Les cibles et la catégorie sont calculées de la même manière que dans ce chapitre associé.

### Étape 4 — Lever l’exception Gateway

Après le retour de l’ajout, `/IWBEP/CX_MGW_BUSI_EXCEPTION` est instanciée avec le conteneur. Le runtime Gateway utilise alors le message principal et les détails pour produire la réponse d’erreur OData.

### Étape 5 — Contrôler la réponse

Exécuter un cas métier invalide depuis `/IWFND/GW_CLIENT` ou un client HTTP. Vérifier le statut HTTP, le message principal et la collection de détails. Le test est incomplet si seule l’exception ABAP est observée sans vérifier la réponse sérialisée.

## RÉSULTAT

Le flot normal ne continue pas après l’appel. Le consommateur reçoit une erreur OData construite par Gateway. Lorsque le conteneur contient plusieurs messages, son message principal alimente le texte principal et les autres messages alimentent les détails selon le protocole Gateway.

## CONTRÔLE NÉGATIF

Ne pas appeler cette méthode pour une table ne contenant que `S`, `I` ou `W` si la requête doit rester réussie. Utiliser alors `ADD_MESSAGES_FROM_BAPI` et choisir explicitement l’ajout à l’en-tête.

## POINTS D’ATTENTION

- La méthode lève l’exception sans analyser le type des messages.
- Un conteneur initial peut conduire à une exception sans détails exploitables.
- L’indicateur de message principal est transmis à chaque ligne par la méthode appelée.

## SOURCES

- [Implémentation analysée](<./zcl_odata_tools.abap#L555>)
- [SAP Gateway Foundation — `/IWBEP/CX_MGW_BUSI_EXCEPTION`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/f2a126519eff236ee10000000a445394.html)

[^exception-metier]: **EXCEPTION MÉTIER GATEWAY.** Exception signalant qu’une règle fonctionnelle empêche l’opération OData, contrairement à une erreur technique du runtime.
[^bapiret2]: **BAPIRET2.** Structure standard SAP contenant les éléments techniques et textuels d’un message retourné par une API métier.
[^conteneur-messages]: **CONTENEUR DE MESSAGES.** Objet Gateway qui regroupe les messages utilisés pour construire le message principal et les détails de la réponse OData.
