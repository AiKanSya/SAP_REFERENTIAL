# BUILD_KEY_FROM_REQ_DATA

## RÉSULTAT ATTENDU

Construire une table de couples nom-valeur[^nom-valeur] `/IWBEP/T_MGW_NAME_VALUE_PAIR` à partir des champs clés d’une structure ABAP[^structure-abap] et des métadonnées de l’entité courante.

## SIGNATURE UTILE

```abap
CLASS-METHODS build_key_from_req_data
  IMPORTING
    io_request_context TYPE REF TO /iwbep/cl_mgw_request
    data               TYPE any
  RETURNING
    VALUE(rt_key_tab) TYPE /iwbep/t_mgw_name_value_pair.
```

## APPEL

```abap
" LS_ENTITY doit contenir les composants techniques des clés de l’entité.
DATA(lt_key_tab) = zcl_odata_tools=>build_key_from_req_data(
  io_request_context = io_request_context
  data               = ls_entity ).
```

## PROCESS

### Étape 1 — Préparer la structure source

Utiliser la structure ABAP correspondant à l’entité. Ses composants clés doivent porter les noms techniques retournés par `GET_ENTITY_PROPERTIES`, par exemple `SALESORDER` même si la propriété publiée se nomme `SalesOrder`.

### Étape 2 — Fournir le contexte

Le contexte doit être lié et permettre la lecture des métadonnées. La méthode appelle `GET_ENTITY_PROPERTIES` avec `ONLY_KEY = ABAP_TRUE`. Si aucune propriété clé n’est retournée, elle quitte avec une table vide.

### Étape 3 — Résoudre chaque composant dynamiquement

Pour chaque clé, l’implémentation construit le nom dynamique `DATA-<nom technique>` puis exécute `ASSIGN`. Un composant absent est ignoré ; aucune exception métier n’est levée.

### Étape 4 — Construire les couples externes

Lorsqu’un composant existe, une ligne est ajoutée avec le nom externe de la propriété dans `NAME` et sa valeur dans `VALUE`. Cette table peut ensuite être transmise au conteneur de messages pour identifier l’entité concernée.

### Étape 5 — Vérifier l’exhaustivité

Comparer le nombre de lignes de `LT_KEY_TAB` au nombre de propriétés clés du modèle. Pour une clé composée de deux propriétés, deux lignes doivent être présentes, y compris si l’une des valeurs est initiale.

## RÉSULTAT

Exemple logique pour une entité dont la clé externe est `SalesOrder` :

| NAME | VALUE |
|---|---|
| `SalesOrder` | `0000004711` |

Une structure de type incorrect produit un résultat partiel ou vide, car les composants introuvables sont simplement ignorés.

## CONTRÔLE

```abap
ASSERT line_exists( lt_key_tab[ name = 'SalesOrder'
                                value = '0000004711' ] ).
```

Adapter les deux littéraux au modèle et aux conversions du service.

## POINTS D’ATTENTION

- `DATA TYPE ANY` ne garantit pas à la compilation que la valeur reçue est une structure.
- La conversion vers `VALUE` dépend du type défini par `/IWBEP/T_MGW_NAME_VALUE_PAIR`.
- Les noms utilisés pour l’accès dynamique sont les noms techniques, pas les noms externes.

## SOURCE

- [Implémentation analysée](<./zcl_odata_tools.abap#L318>)

[^nom-valeur]: **COUPLE NOM-VALEUR.** Structure générique associant un identifiant textuel à sa valeur, utilisée ici pour représenter les clés d’une entité.
[^structure-abap]: **STRUCTURE ABAP.** Variable composée de plusieurs champs nommés et typés, regroupés dans une seule ligne logique.
