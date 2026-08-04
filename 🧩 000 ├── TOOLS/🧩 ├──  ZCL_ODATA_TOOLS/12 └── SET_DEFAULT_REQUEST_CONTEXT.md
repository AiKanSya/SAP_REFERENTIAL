# SET_DEFAULT_REQUEST_CONTEXT

## RÉSULTAT ATTENDU

Mémoriser une référence objet[^reference-objet] vers le contexte de requête OData[^contexte-requete] afin que les autres méthodes de `ZCL_ODATA_TOOLS` puissent l’utiliser lorsque leur paramètre de contexte n’est pas fourni.

## SIGNATURE UTILE

```abap
CLASS-METHODS set_default_request_context
  IMPORTING
    request_context TYPE REF TO /iwbep/cl_mgw_request OPTIONAL.
```

Le paramètre est optionnel. Un appel sans valeur affecte une référence initiale et efface donc le contexte précédemment mémorisé.

## APPEL

Fragment à placer dans un traitement qui possède déjà une référence compatible avec `/IWBEP/CL_MGW_REQUEST` :

```abap
" IO_REQUEST_CONTEXT est fourni par le traitement Gateway appelant.
zcl_odata_tools=>set_default_request_context(
  request_context = io_request_context ).
```

Pour supprimer explicitement la valeur par défaut :

```abap
zcl_odata_tools=>set_default_request_context( ).
```

## PROCESS

### Étape 1 — Contrôler le type de la référence

Vérifier dans le débogueur ou dans la signature de l’appelant que la référence est compatible avec `/IWBEP/CL_MGW_REQUEST`. Une interface de contexte différente ne peut pas être transmise sans conversion compatible.

### Étape 2 — Enregistrer le contexte

Appeler la méthode au début de la chaîne technique, avant toute méthode qui doit calculer des propriétés ou une cible de message sans recevoir son propre contexte.

### Étape 3 — Exécuter les méthodes consommatrices

Les méthodes `ADD_MESSAGES_FROM_BAPI` et `RAISE_BUSI_EXCEPTION_FROM_BAPI` peuvent reprendre cette référence lorsque leur paramètre `IO_REQUEST_CONTEXT` est initial ou absent.

### Étape 4 — Limiter la durée d’utilisation

Ne pas traiter cette valeur comme une configuration permanente. La référence est stockée dans l’attribut statique[^attribut-statique] `_DEFAULT_REQUEST_CONTEXT`. La vider à la fin si la même session interne peut exécuter une autre chaîne sans contexte explicite.

## RÉSULTAT

La méthode ne retourne aucune valeur. Après l’appel, `_DEFAULT_REQUEST_CONTEXT` contient exactement la référence transmise. Aucun contrôle de validité ni copie du contexte n’est effectué.

## CONTRÔLE

Placer un point d’arrêt dans `ADD_MESSAGES_FROM_BAPI` et vérifier que `LO_REQUEST_CONTEXT` devient lié après le repli sur `_DEFAULT_REQUEST_CONTEXT`. Si la référence reste initiale, les métadonnées et le chemin absolu de l’entité ne pourront pas être déterminés.

## POINTS D’ATTENTION

- Préférer le passage explicite de `IO_REQUEST_CONTEXT` lorsqu’il est disponible.
- L’appel sans paramètre efface la valeur précédente ; il ne récupère pas automatiquement le contexte du runtime.
- La méthode ne vérifie pas que le contexte appartient encore à la requête en cours.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L652>)

[^contexte-requete]: **CONTEXTE DE REQUÊTE.** Objet Gateway contenant les informations techniques de la requête courante : entité cible, clés, navigation, en-têtes et options de requête.
[^attribut-statique]: **ATTRIBUT STATIQUE.** Donnée portée par la classe et non par une instance ; sa valeur subsiste entre les appels réalisés dans la même session interne ABAP.
[^reference-objet]: **RÉFÉRENCE OBJET.** Variable ABAP qui désigne une instance ; elle est dite liée lorsque `IS BOUND` est vrai et initiale lorsqu’elle ne désigne aucun objet.
