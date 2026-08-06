# FILL_KEY_FIELDS

## RÉSULTAT ATTENDU

Renseigner dans une structure d’entité ABAP[^structure-entite] les valeurs de clés reçues dans l’URI OData[^cle-uri] ou fournies explicitement dans `ALTERNATE_KEYS`.

## SIGNATURE UTILE

```abap
CLASS-METHODS fill_key_fields
  IMPORTING
    io_request_context TYPE REF TO /iwbep/cl_mgw_request
    alternate_keys     TYPE /iwbep/t_mgw_name_value_pair OPTIONAL
  CHANGING
    ct_entity          TYPE data.
```

Malgré son préfixe `CT_`, `CT_ENTITY` est typé `DATA` et représente une structure unique, pas une table interne.

## APPEL

Avec les clés de la requête :

```abap
DATA ls_entity TYPE zcl_my_service_mpc=>ts_salesorder.

zcl_odata_tools=>fill_key_fields(
  EXPORTING
    io_request_context = io_request_context
  CHANGING
    ct_entity          = ls_entity ).
```

Avec une table de clés imposée par l’appelant :

```abap
DATA(lt_alternate_keys) = VALUE /iwbep/t_mgw_name_value_pair(
  ( name = 'SalesOrder' value = '0000004711' ) ).

zcl_odata_tools=>fill_key_fields(
  EXPORTING
    io_request_context = io_request_context
    alternate_keys     = lt_alternate_keys
  CHANGING
    ct_entity          = ls_entity ).
```

## PROCESS

### Étape 1 — Choisir la source des clés

Si `ALTERNATE_KEYS` contient au moins une ligne, la méthode l’utilise intégralement. Sinon elle lit `KEY_TAB` dans les détails de la requête. Il n’existe pas de fusion entre les deux sources.

### Étape 2 — Charger la correspondance des propriétés

La méthode récupère toutes les propriétés de l’entité afin de convertir chaque nom externe reçu, tel que `SalesOrder`, vers le composant ABAP correspondant, tel que `SALESORDER`.

### Étape 3 — Affecter les composants

Pour chaque clé, elle construit dynamiquement `CT_ENTITY-<nom technique>`. Si le composant existe, la valeur textuelle est affectée avec la conversion ABAP implicite du type cible.

### Étape 4 — Contrôler chaque clé

Vérifier après l’appel que tous les composants attendus sont renseignés. Une propriété inconnue, une structure incompatible ou des métadonnées absentes sont ignorées sans exception.

## RÉSULTAT

`LS_ENTITY` est modifiée directement. Les composants non concernés restent inchangés. La méthode ne retourne ni indicateur de succès ni liste des clés non affectées.

## CONTRÔLE

```abap
ASSERT ls_entity-salesorder = '0000004711'.
```

Ajouter une assertion par composant lorsque la clé est composée.

## POINTS D’ATTENTION

- Une erreur de conversion, par exemple une valeur non numérique vers un composant numérique, peut provoquer une exception d’exécution ABAP.
- Le nom fourni dans `ALTERNATE_KEYS-NAME` doit être le nom externe publié par le service.
- La méthode exige un contexte même lorsque des clés alternatives sont fournies, car elle utilise ses métadonnées.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L363>)

[^cle-uri]: **CLÉ D’URI.** Valeur placée dans le chemin d’une ressource OData pour identifier une entité, par exemple `SalesOrderSet('0000004711')`.
[^structure-entite]: **STRUCTURE D’ENTITÉ.** Structure ABAP dont les composants portent les valeurs d’une entité exposée par le service OData.
