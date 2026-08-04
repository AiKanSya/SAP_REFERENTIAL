# APPLY_FILTERS

## RÉSULTAT ATTENDU

Supprimer d’une table interne standard[^table-interne] les lignes qui ne respectent pas les options de sélection issues d’un `$filter` OData[^filter-odata]. Le traitement est exécuté en mémoire après le chargement des données.

## SIGNATURE UTILE

```abap
CLASS-METHODS apply_filters
  IMPORTING
    it_select_options  TYPE /iwbep/t_mgw_select_option
    io_request_context TYPE REF TO /iwbep/cl_mgw_request
    iv_auto_convert    TYPE boolean DEFAULT abap_true
  CHANGING
    ct_data            TYPE standard table.
```

## APPEL

Fragment dans lequel `LT_SELECT_OPTIONS` a déjà été obtenu depuis le contexte technique Gateway :

```abap
zcl_odata_tools=>apply_filters(
  EXPORTING
    it_select_options  = lt_select_options
    io_request_context = io_request_context
    iv_auto_convert    = abap_true
  CHANGING
    ct_data            = et_entityset ).
```

## PROCESS

### Étape 1 — Charger les données candidates

Remplir `ET_ENTITYSET` avec une table standard dont les composants correspondent aux noms techniques du modèle. Cette méthode ne réalise aucun `SELECT` et n’accède pas à la base.

### Étape 2 — Fournir les options de sélection

Chaque ligne de `IT_SELECT_OPTIONS` doit contenir une propriété et une table de plages[^table-plages]. Plusieurs lignes de propriétés sont appliquées successivement ; une ligne doit donc satisfaire toutes les propriétés pour rester dans la table.

### Étape 3 — Convertir les noms si nécessaire

Avec `IV_AUTO_CONVERT = ABAP_TRUE`, la méthode appelle `GET_ENTITY_PROPERTIES` puis remplace chaque nom externe par son nom technique ABAP. Si l’appelant fournit déjà des noms de composants ABAP, utiliser `ABAP_FALSE`.

### Étape 4 — Appliquer chaque filtre

Pour chaque propriété, la méthode parcourt la table, accède dynamiquement au composant et supprime la ligne lorsque sa valeur n’appartient pas aux plages reçues.

### Étape 5 — Vérifier le résultat

Comparer le nombre de lignes avant et après l’appel, puis contrôler au moins une ligne conservée et une ligne exclue. Une propriété qui ne correspond à aucun composant est ignorée pour chaque ligne ; elle ne vide pas la table et ne lève pas d’erreur.

## EXEMPLE AUTONOME DU RÉSULTAT

```abap
TYPES: BEGIN OF ty_order,
         salesorder TYPE char10,
         status     TYPE char1,
       END OF ty_order.
TYPES ty_orders TYPE STANDARD TABLE OF ty_order WITH EMPTY KEY.

DATA(lt_orders) = VALUE ty_orders(
  ( salesorder = '0000000001' status = 'O' )
  ( salesorder = '0000000002' status = 'C' ) ).

DATA(lt_filters) = VALUE /iwbep/t_mgw_select_option(
  ( property = 'STATUS'
    select_options = VALUE #( ( sign   = 'I'
                                option = 'EQ'
                                low    = 'O' ) ) ) ).

" Référence initiale autorisée ici : IV_AUTO_CONVERT désactive son utilisation.
DATA lo_request_context TYPE REF TO /iwbep/cl_mgw_request.

zcl_odata_tools=>apply_filters(
  EXPORTING
    it_select_options  = lt_filters
    io_request_context = lo_request_context
    iv_auto_convert    = abap_false
  CHANGING
    ct_data            = lt_orders ).

" LT_ORDERS ne contient plus que la commande au statut O.
```

## RÉSULTAT

`CT_DATA` est modifiée sur place. L’ordre des lignes conservées ne change pas. Avec plusieurs filtres, le résultat correspond à une combinaison logique `AND` entre les propriétés ; les inclusions et exclusions à l’intérieur d’une plage suivent la sémantique ABAP des ranges.

## POINTS D’ATTENTION

- Complexité approximative : nombre de filtres multiplié par nombre de lignes, avec suppressions dans la table.
- Un filtrage en base avec Open SQL[^open-sql] est préférable pour un volume important lorsque le filtre peut être traduit sans perte.
- La signature accepte uniquement une table standard.
- Une propriété inconnue est silencieusement ignorée.

## SOURCES

- [Implémentation analysée](<./zcl_odata_tools.abap#L218>)
- [SAP Gateway Foundation — API de `$filter`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/281073c88d184ec48bc5b69f8e390097.html)

[^filter-odata]: **`$FILTER`.** Option système OData qui demande au service de ne retourner que les entités satisfaisant une expression.
[^table-plages]: **TABLE DE PLAGES.** Table ABAP comportant `SIGN`, `OPTION`, `LOW` et `HIGH`, utilisée par les opérateurs `IN` et `NOT IN`.
[^table-interne]: **TABLE INTERNE.** Collection de lignes conservée dans la mémoire de la session ABAP, distincte d’une table persistée en base de données.
[^open-sql]: **OPEN SQL.** Sous-ensemble SQL intégré à ABAP et indépendant du moteur de base, utilisé pour lire et modifier les données persistées autorisées.
