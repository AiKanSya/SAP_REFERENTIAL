# REGISTER_CREATE_ENTITY_PATH

## RÉSULTAT ATTENDU

Associer un `CONTENT_ID`[^content-id] de requête batch[^batch] au chemin de l’entité créée afin que les messages ultérieurs puissent cibler cette entité.

## SIGNATURE UTILE

```abap
CLASS-METHODS register_create_entity_path
  IMPORTING
    content_id  TYPE string
    entity_path TYPE string.
```

## APPEL

```abap
DATA(ls_request_details) = io_request_context->get_request_details( ).
DATA(lv_content_id) =
  ls_request_details-technical_request-batch_info-content_id.

DATA(lv_entity_path) =
  |/SalesOrderSet('{ ls_entity-salesorder }')|.

zcl_odata_tools=>register_create_entity_path(
  content_id  = lv_content_id
  entity_path = lv_entity_path ).
```

## PROCESS

### Étape 1 — Exécuter la création

Créer l’entité et obtenir sa clé définitive. Ne pas enregistrer un chemin avant que la clé métier ou technique soit connue.

### Étape 2 — Lire le `CONTENT_ID`

Dans une requête batch, récupérer la valeur depuis `TECHNICAL_REQUEST-BATCH_INFO-CONTENT_ID`. Vérifier qu’elle n’est pas initiale ; une clé initiale ne décrit pas correctement l’opération source.

### Étape 3 — Construire le chemin publié

Former le chemin avec le nom externe de l’ensemble d’entités et la syntaxe de clé exposée par le service. Pour une clé composée, inclure chaque nom et chaque valeur dans l’ordre attendu par le modèle.

### Étape 4 — Enregistrer l’association

La méthode exécute un `INSERT` dans la table hachée[^table-hachee] statique `_CREATION_ENTITIES`, dont la clé unique est `CONTENT_ID`.

### Étape 5 — Vérifier immédiatement

Appeler `GET_CREATE_ENTITY_PATH` avec le même identifiant et comparer la valeur retournée au chemin construit. Cette relecture est nécessaire parce que la méthode ne retourne pas `SY-SUBRC`.

## RÉSULTAT

Au premier enregistrement d’un identifiant, le chemin est conservé en mémoire dans la classe. Un second appel avec le même `CONTENT_ID` échoue au niveau de l’`INSERT` avec `SY-SUBRC <> 0`, mais l’implémentation ne traite pas ce code : le premier chemin reste enregistré.

## CONTRÔLE

```abap
DATA(lv_registered_path) = zcl_odata_tools=>get_create_entity_path(
  content_id = lv_content_id ).

ASSERT lv_registered_path = lv_entity_path.
```

## POINTS D’ATTENTION

- La méthode n’effectue ni remplacement ni suppression.
- La table statique n’est pas vidée par la classe.
- L’association ne constitue pas une persistance ; elle ne doit servir que dans la portée technique du traitement courant.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L599>)

[^content-id]: **CONTENT-ID.** Identifiant d’une opération à l’intérieur d’une requête batch ou d’un change set, utilisé pour relier des opérations et leurs résultats.
[^batch]: **REQUÊTE BATCH.** Requête HTTP OData qui regroupe plusieurs opérations individuelles dans une seule enveloppe.
[^table-hachee]: **TABLE HACHÉE.** Table interne ABAP accessible par une clé unique au moyen d’un calcul de hachage, sans index numérique stable.
