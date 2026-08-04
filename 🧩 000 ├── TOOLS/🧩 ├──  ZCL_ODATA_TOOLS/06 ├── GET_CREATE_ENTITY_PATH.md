# GET_CREATE_ENTITY_PATH

## RÉSULTAT ATTENDU

Retrouver le chemin d’entité précédemment associé à un `CONTENT_ID`[^content-id] par `REGISTER_CREATE_ENTITY_PATH`.

## SIGNATURE UTILE

```abap
CLASS-METHODS get_create_entity_path
  IMPORTING
    content_id TYPE string
  RETURNING
    VALUE(entity_path) TYPE string.
```

## APPEL

```abap
DATA(lv_entity_path) = zcl_odata_tools=>get_create_entity_path(
  content_id = lv_content_id ).
```

## PROCESS

### Étape 1 — Identifier l’opération de création

Utiliser exactement le `CONTENT_ID` lu pour l’opération batch et transmis lors de l’enregistrement. La recherche est une égalité sur la chaîne complète.

### Étape 2 — Appeler la méthode

La méthode effectue une lecture par clé de la table hachée[^table-hachee] `_CREATION_ENTITIES`. La recherche ne parcourt pas les URI et ne consulte ni la base ni le contexte Gateway.

### Étape 3 — Interpréter le retour

Une chaîne non initiale correspond au chemin enregistré. Une chaîne vide signifie qu’aucune entrée n’a été trouvée ou qu’un chemin vide avait été enregistré ; l’API ne permet pas de distinguer ces deux cas.

### Étape 4 — Décider de la suite

Si le chemin est présent, il peut préfixer une cible de message de création. S’il est vide, ne pas construire silencieusement une cible absolue invalide : conserver une cible relative ou journaliser le `CONTENT_ID` manquant selon le contrat de l’appelant.

## RÉSULTAT

Exemple :

```text
CONTENT_ID  = 2
ENTITY_PATH = /SalesOrderSet('0000004711')
```

La méthode ne modifie pas l’entrée et ne la supprime pas après lecture.

## CONTRÔLE

```abap
IF lv_entity_path IS INITIAL.
  " Aucune association exploitable : ne pas prétendre avoir une cible absolue.
ENDIF.
```

Tester également un identifiant inconnu pour confirmer que le résultat reste initial.

## POINTS D’ATTENTION

- La valeur dépend d’un appel préalable à `REGISTER_CREATE_ENTITY_PATH` dans la même session interne.
- La casse, les espaces et les zéros du `CONTENT_ID` font partie de la chaîne recherchée.
- Aucune exception n’est levée lorsqu’une entrée manque.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L413>)

[^content-id]: **CONTENT-ID.** Identifiant d’une opération dans une requête batch ou un change set, utilisé ici comme clé de recherche du chemin créé.
[^table-hachee]: **TABLE HACHÉE.** Table interne ABAP dont les lignes sont recherchées directement par une clé de hachage unique.
