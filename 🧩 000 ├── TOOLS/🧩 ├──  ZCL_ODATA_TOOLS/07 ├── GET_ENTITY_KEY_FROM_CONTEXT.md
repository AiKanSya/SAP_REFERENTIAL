# GET_ENTITY_KEY_FROM_CONTEXT

## RÉSULTAT ATTENDU

Construire un chemin d’entité OData[^chemin-entite] tel que `/PurchaseOrderSet(PurchaseOrderNumber='0000000279')` à partir de l’URI[^uri] brute conservée dans le contexte de requête.

## SIGNATURE UTILE

```abap
CLASS-METHODS get_entity_key_from_context
  IMPORTING
    io_request_context TYPE REF TO /iwbep/cl_mgw_request
  RETURNING
    VALUE(entity_key) TYPE string.
```

## APPEL

```abap
" Fragment : le contexte doit correspondre à la requête en cours.
DATA(lv_entity_path) = zcl_odata_tools=>get_entity_key_from_context(
  io_request_context = io_request_context ).
```

## PROCESS

### Étape 1 — Vérifier le contexte avant l’appel

La méthode déréférence immédiatement `IO_REQUEST_CONTEXT`. Contrôler `io_request_context IS BOUND` dans l’appelant. Une référence initiale provoque une erreur d’exécution au lieu de retourner une chaîne vide.

### Étape 2 — Lire l’ensemble d’entités cible

L’implémentation lit `TARGET_ENTITY_SET`, par exemple `PurchaseOrderSet`. Cette valeur sert de séparateur dans l’URI et de préfixe dans le chemin retourné.

### Étape 3 — Retrouver l’URI technique

La méthode cherche l’en-tête interne `~request_uri` dans `TECHNICAL_REQUEST-REQUEST_HEADER`. Si cet en-tête est absent, aucun chemin n’est construit.

### Étape 4 — Extraire la clé

L’URI est découpée après le nom de l’ensemble d’entités. La partie située après `?` est supprimée afin d’écarter les options de requête. Le résultat est préfixé par `/` et le nom de l’ensemble.

### Étape 5 — Appliquer le décodage prévu

Seules les séquences `%3D` et `%2C` sont remplacées respectivement par `=` et `,`. Contrôler le résultat lorsque l’URI contient d’autres caractères encodés.

## RÉSULTAT

Pour l’URI :

```text
/sap/opu/odata/SAP/ZMM_SERVICE/PurchaseOrderSet(PurchaseOrderNumber%3D'0000000279')?$format=json
```

la méthode vise le résultat :

```text
/PurchaseOrderSet(PurchaseOrderNumber='0000000279')
```

Si `~request_uri` est absent ou si le nom de l’ensemble n’est pas trouvé, `ENTITY_KEY` reste vide ou incomplet.

## UTILISATION DANS LA CLASSE

`ADD_MESSAGES_FROM_BAPI` utilise ce chemin pour préfixer la cible d’une propriété et produire une cible absolue, par exemple `/PurchaseOrderSet(...)/Quantity`.

## POINTS D’ATTENTION

- Il s’agit d’une analyse textuelle de l’URI, pas d’une reconstruction complète depuis les métadonnées.
- Le décodage n’est pas générique.
- Une URI contenant le nom de l’ensemble à un emplacement inattendu peut produire un découpage incorrect.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L445>)

[^chemin-entite]: **CHEMIN D’ENTITÉ.** Partie d’une URI OData qui désigne un ensemble et, le cas échéant, les valeurs de clé d’une entité précise.
[^uri]: **URI — UNIFORM RESOURCE IDENTIFIER.** Chaîne normalisée qui identifie une ressource ; dans OData, elle contient le service, l’ensemble d’entités, les clés et éventuellement les options de requête.
