# GET_ENTITY_PROPERTIES

## RÉSULTAT ATTENDU

Obtenir les propriétés OData[^propriete-odata] de l’entité visée par la requête, avec leur nom technique ABAP et leur nom externe. L’option `ONLY_KEY` limite le résultat aux propriétés déclarées comme clés dans les métadonnées[^metadonnees].

## SIGNATURE UTILE

```abap
CLASS-METHODS get_entity_properties
  IMPORTING
    io_request_context TYPE REF TO /iwbep/cl_mgw_request
    only_key           TYPE boolean DEFAULT abap_false
  RETURNING
    VALUE(properties)
      TYPE /iwbep/if_mgw_med_odata_types=>ty_t_mgw_odata_properties.
```

## APPEL

```abap
" Fragment : IO_REQUEST_CONTEXT doit provenir du traitement Gateway courant.
DATA(lt_properties) = zcl_odata_tools=>get_entity_properties(
  io_request_context = io_request_context
  only_key           = abap_false ).
```

Pour ne récupérer que les clés :

```abap
DATA(lt_key_properties) = zcl_odata_tools=>get_entity_properties(
  io_request_context = io_request_context
  only_key           = abap_true ).
```

## PROCESS

### Étape 1 — Fournir un contexte lié

Contrôler `io_request_context IS BOUND`. Si la référence est initiale, la méthode quitte immédiatement et retourne une table vide.

### Étape 2 — Identifier l’entité réellement ciblée

La méthode récupère le convertisseur de clés[^convertisseur-cles] de la requête. Si un chemin de navigation existe, elle utilise le convertisseur du premier élément de ce chemin. Ce choix détermine les métadonnées retournées.

### Étape 3 — Lire les propriétés

Le type d’entité est obtenu depuis le convertisseur, puis `GET_PROPERTIES` fournit les propriétés. Chaque ligne permet notamment de relier `NAME`, nom du composant ABAP, à `EXTERNAL_NAME`, nom exposé par le service.

### Étape 4 — Appliquer le filtre de clés

Avec `ONLY_KEY = ABAP_TRUE`, chaque propriété est interrogée via `IS_KEY`. Seules les propriétés marquées comme clés restent dans le résultat.

### Étape 5 — Contrôler le résultat

Comparer les noms obtenus au modèle du service dans SEGW ou dans le document `$metadata`. Une table vide signifie soit que le contexte ou le convertisseur est absent, soit que la lecture des métadonnées a échoué.

## RÉSULTAT

La table retournée contient toutes les propriétés ou uniquement les clés. La méthode capture `/IWBEP/CX_MGW_MED_EXCEPTION` sans la propager ; en cas d’échec correspondant, le résultat reste vide et aucun diagnostic n’est fourni à l’appelant.

## EXEMPLE D’EXPLOITATION

```abap
LOOP AT lt_properties ASSIGNING FIELD-SYMBOL(<property>).
  " NAME : composant ABAP ; EXTERNAL_NAME : propriété publiée.
  WRITE: / <property>-name, <property>-external_name.
ENDLOOP.
```

## POINTS D’ATTENTION

- Une table vide n’est pas une preuve d’absence de propriétés.
- La méthode dépend des classes SAP Gateway classiques `/IWBEP/*`.
- Le traitement silencieux de l’exception de métadonnées complique le diagnostic ; contrôler le contexte au débogueur.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L485>)

[^propriete-odata]: **PROPRIÉTÉ ODATA.** Champ publié dans le modèle d’une entité OData ; son nom externe peut différer du composant ABAP qui porte sa valeur.
[^convertisseur-cles]: **CONVERTISSEUR DE CLÉS.** Objet interne Gateway reliant les clés de l’URI, les métadonnées de l’entité et leurs représentations ABAP.
[^metadonnees]: **MÉTADONNÉES ODATA.** Description technique des entités, propriétés, clés, associations et types publiés par le service, consultable via `$metadata`.
