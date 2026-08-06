# APPLY_SORTERS

## RÉSULTAT ATTENDU

Trier une table interne[^table-interne] selon les critères `$orderby` OData[^orderby] déjà extraits de la requête.

## SIGNATURE UTILE

```abap
CLASS-METHODS apply_sorters
  IMPORTING
    it_order           TYPE /iwbep/t_mgw_sorting_order
    io_request_context TYPE REF TO /iwbep/cl_mgw_request OPTIONAL
    iv_auto_convert    TYPE boolean DEFAULT abap_true
  CHANGING
    et_entityset       TYPE table.
```

## APPEL

```abap
zcl_odata_tools=>apply_sorters(
  EXPORTING
    it_order           = lt_order
    io_request_context = io_request_context
    iv_auto_convert    = abap_true
  CHANGING
    et_entityset       = et_entityset ).
```

## PROCESS

### Étape 1 — Obtenir les critères de tri

Lire la table `/IWBEP/T_MGW_SORTING_ORDER` depuis le contexte de la requête. Chaque ligne porte le nom de propriété et le sens ascendant ou descendant attendu.

### Étape 2 — Vérifier la structure à trier

Les composants de `ET_ENTITYSET` doivent correspondre aux noms techniques ABAP des propriétés. La méthode travaille sur la table déjà chargée ; elle ne modifie pas le `ORDER BY` du `SELECT`.

### Étape 3 — Choisir la conversion des noms

Conserver `IV_AUTO_CONVERT = ABAP_TRUE` lorsque `IT_ORDER-PROPERTY` contient les noms externes OData. Fournir alors un contexte lié. Utiliser `ABAP_FALSE` lorsque les critères contiennent déjà les noms techniques.

### Étape 4 — Exécuter le tri

La classe délègue le tri à `/IWBEP/CL_MGW_DATA_UTIL=>ORDERBY`. Les critères sont appliqués dans l’ordre reçu ; le premier critère est le tri principal.

### Étape 5 — Contrôler les premières lignes

Vérifier les valeurs des deux premières lignes et les ruptures entre valeurs identiques. Pour un tri descendant, la valeur la plus grande selon le type ABAP doit apparaître en premier.

## RÉSULTAT

`ET_ENTITYSET` contient les mêmes lignes dans l’ordre demandé. Une table de critères vide laisse la table sans tri utile. La méthode ne retourne aucun indicateur.

## POINTS D’ATTENTION

- Avec la conversion automatique et un contexte initial, aucun nom n’est converti.
- Une propriété externe non trouvée reste inchangée avant l’appel de l’utilitaire SAP.
- Trier après pagination[^pagination] peut produire un résultat fonctionnel différent d’un tri global suivi de `$skip` et `$top`.
- Pour un gros volume, trier en base avec `ORDER BY` réduit généralement le travail en mémoire.

## SOURCES

- [Implémentation analysée](<./zcl_odata_tools.abap#L273>)
- [SAP Gateway Foundation — option `$orderby`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/611917768e1d47949d166a75f4535d9d.html)

[^orderby]: **`$ORDERBY`.** Option système OData qui définit les propriétés et les sens utilisés pour ordonner les entités retournées.
[^table-interne]: **TABLE INTERNE.** Collection de lignes traitée dans la mémoire de la session ABAP.
[^pagination]: **PAGINATION.** Découpage d’un ensemble de résultats en portions, notamment au moyen de `$skip` et `$top` en OData V2.
