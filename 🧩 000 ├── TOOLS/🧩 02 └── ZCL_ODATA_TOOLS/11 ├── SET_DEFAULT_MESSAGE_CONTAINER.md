# SET_DEFAULT_MESSAGE_CONTAINER

## RÉSULTAT ATTENDU

Mémoriser le conteneur de messages Gateway[^conteneur-messages] qui recevra les messages `BAPIRET2` lorsque les méthodes de la classe ne reçoivent pas de conteneur exploitable.

## SIGNATURE UTILE

```abap
CLASS-METHODS set_default_message_container
  IMPORTING
    message_container TYPE REF TO /iwbep/if_message_container.
```

## APPEL

Fragment à utiliser après avoir obtenu le conteneur du contexte runtime :

```abap
DATA(lo_message_container) =
  me->/iwbep/if_mgw_core_srv_runtime~mo_context->get_message_container( ).

zcl_odata_tools=>set_default_message_container(
  message_container = lo_message_container ).
```

Le fragment s'exécute dans une méthode d'instance de la classe DPC[^dpc]. Adapter l'accès si la classe appelante n'expose pas ce contexte de runtime.

## PROCESS

### Étape 1 — Obtenir le conteneur de la requête

Utiliser le conteneur fourni par le runtime Gateway. Ne pas créer une implémentation arbitraire : le runtime doit pouvoir convertir son contenu dans la réponse OData.

### Étape 2 — Vérifier que la référence est liée

Contrôler `lo_message_container IS BOUND`. La méthode accepte techniquement une référence initiale, mais celle-ci rendra inopérants les ajouts reposant sur la valeur par défaut.

### Étape 3 — Enregistrer le conteneur

Appeler `SET_DEFAULT_MESSAGE_CONTAINER` avant `ADD_MESSAGES_FROM_BAPI` ou `RAISE_BUSI_EXCEPTION_FROM_BAPI` lorsque ces méthodes ne recevront pas explicitement le même conteneur.

### Étape 4 — Contrôler les messages produits

Après l’ajout, appeler `GET_MESSAGES` dans le débogueur ou analyser la réponse HTTP. Une requête en erreur doit exposer les détails dans le corps OData ; une requête réussie n’expose dans l’en-tête que les messages ajoutés avec l’indicateur prévu.

## RÉSULTAT

La méthode affecte directement la référence à `_DEFAULT_MESSAGE_CONTAINER`. Elle n’ajoute aucun message et ne retourne aucune valeur.

## CONTRÔLE

Après l’appel, vérifier que `_DEFAULT_MESSAGE_CONTAINER` et `LO_MESSAGE_CONTAINER` désignent le même objet. Le test est concluant lorsqu’un appel ultérieur à `ADD_MESSAGES_FROM_BAPI` ajoute les lignes attendues dans ce conteneur.

## POINTS D’ATTENTION

- Le conteneur doit appartenir à la requête en cours.
- La valeur est statique ; ne pas l’utiliser comme configuration globale durable.
- Passer le conteneur directement aux méthodes métier reste plus explicite.

## SOURCES

- [Implémentation analysée](<./zcl_odata_tools.abap#L627>)
- [SAP Gateway Foundation — `/IWBEP/IF_MESSAGE_CONTAINER`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/01a226519eff236ee10000000a445394.html)

[^conteneur-messages]: **CONTENEUR DE MESSAGES.** Objet Gateway qui collecte les messages applicatifs avant leur transformation en détails d’erreur ou en en-tête HTTP.
[^dpc]: **DPC — DATA PROVIDER CLASS.** Classe ABAP générée pour implémenter les opérations de lecture et de modification d’un service SAP Gateway.
