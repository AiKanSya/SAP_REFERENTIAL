# ZCL_ODATA_TOOLS

## OBJECTIF

`ZCL_ODATA_TOOLS` est une classe utilitaire personnalisée destinée aux services OData[^odata] classiques construits avec SAP Gateway[^sap-gateway]. Elle centralise quatre besoins : lire les métadonnées de l’entité courante, appliquer en mémoire les options `$filter` et `$orderby`, construire les cibles de messages et convertir des messages `BAPIRET2` en réponse Gateway.

Cette classe n’est pas une API standard SAP. Le fichier [zcl_odata_tools.abap](./zcl_odata_tools.abap) constitue la source analysée et doit correspondre à la version activée dans le système SAP.

## PÉRIMÈTRE TECHNIQUE

- Modèle : SAP Gateway OData V2 classique, classes et interfaces `/IWBEP/*`.
- Type de classe : classe globale statique, sans instanciation nécessaire.
- État conservé : contexte de requête, conteneur de messages et chemins de créations enregistrés dans des attributs `CLASS-DATA`[^class-data].
- Hors périmètre : RAP, service binding OData V4 et traitement automatique des requêtes en base de données.

## ORDRE D’UTILISATION RECOMMANDÉ

1. Récupérer le contexte de requête et le conteneur de messages fournis par le runtime Gateway.
2. Transmettre ces références directement à chaque méthode lorsque la signature le permet.
3. N’utiliser `SET_DEFAULT_REQUEST_CONTEXT` et `SET_DEFAULT_MESSAGE_CONTAINER` que pour une chaîne d’appels exécutée dans la même requête.
4. Lire les filtres et tris du contexte puis les appliquer uniquement si les données ont déjà été chargées en mémoire.
5. Après un appel métier retournant `BAPIRET2_T`, ajouter les messages ou lever l’exception métier.
6. Pour une création dans un batch, enregistrer le chemin de l’entité avant de construire des cibles de messages à partir du `CONTENT_ID`.

## CHAPITRES PAR MÉTHODE

| Besoin                                      | Méthode                          | Chapitre                                                              |
| ------------------------------------------- | -------------------------------- | --------------------------------------------------------------------- |
| Mémoriser le contexte courant               | `SET_DEFAULT_REQUEST_CONTEXT`    | [SET_DEFAULT_REQUEST_CONTEXT](./SET_DEFAULT_REQUEST_CONTEXT.md)       |
| Mémoriser le conteneur courant              | `SET_DEFAULT_MESSAGE_CONTAINER`  | [SET_DEFAULT_MESSAGE_CONTAINER](./SET_DEFAULT_MESSAGE_CONTAINER.md)   |
| Lire les propriétés de l’entité             | `GET_ENTITY_PROPERTIES`          | [GET_ENTITY_PROPERTIES](./GET_ENTITY_PROPERTIES.md)                   |
| Extraire les clés d’une structure           | `BUILD_KEY_FROM_REQ_DATA`        | [BUILD_KEY_FROM_REQ_DATA](./BUILD_KEY_FROM_REQ_DATA.md)               |
| Injecter les clés dans une structure        | `FILL_KEY_FIELDS`                | [FILL_KEY_FIELDS](./FILL_KEY_FIELDS.md)                               |
| Construire le chemin de l’entité demandée   | `GET_ENTITY_KEY_FROM_CONTEXT`    | [GET_ENTITY_KEY_FROM_CONTEXT](./GET_ENTITY_KEY_FROM_CONTEXT.md)       |
| Filtrer une table en mémoire                | `APPLY_FILTERS`                  | [APPLY_FILTERS](./APPLY_FILTERS.md)                                   |
| Trier une table en mémoire                  | `APPLY_SORTERS`                  | [APPLY_SORTERS](./APPLY_SORTERS.md)                                   |
| Ajouter les messages d’une BAPI             | `ADD_MESSAGES_FROM_BAPI`         | [ADD_MESSAGES_FROM_BAPI](./ADD_MESSAGES_FROM_BAPI.md)                 |
| Ajouter les messages puis lever l’exception | `RAISE_BUSI_EXCEPTION_FROM_BAPI` | [RAISE_BUSI_EXCEPTION_FROM_BAPI](./RAISE_BUSI_EXCEPTION_FROM_BAPI.md) |
| Enregistrer le chemin d’une création batch  | `REGISTER_CREATE_ENTITY_PATH`    | [REGISTER_CREATE_ENTITY_PATH](./REGISTER_CREATE_ENTITY_PATH.md)       |
| Relire le chemin d’une création batch       | `GET_CREATE_ENTITY_PATH`         | [GET_CREATE_ENTITY_PATH](./GET_CREATE_ENTITY_PATH.md)                 |

## LIMITES TRANSVERSES

- `APPLY_FILTERS` et `APPLY_SORTERS` interviennent après la lecture des données. Ils ne réduisent ni le volume lu en base ni le coût du `SELECT`.
- Les valeurs de clé issues d’une requête sont affectées aux composants ABAP par conversion implicite. Le type de la structure cible doit être compatible.
- `GET_ENTITY_KEY_FROM_CONTEXT` analyse le texte de l’URI et ne décode que `%3D` et `%2C`.
- `REGISTER_CREATE_ENTITY_PATH` utilise une table hachée à clé unique. Un second `INSERT` avec le même `CONTENT_ID` ne remplace pas le premier chemin.
- Les méthodes de paramétrage par défaut modifient un état statique. Une référence explicite évite de réutiliser involontairement le contexte d’un traitement précédent dans la même session interne.

## RÉFÉRENCES OFFICIELLES SAP

- [SAP Gateway Foundation — Message Container](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/df2dfe50645c741ae10000000a423f68.html)
- [SAP Gateway Foundation — options de requête `$filter`](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/281073c88d184ec48bc5b69f8e390097.html)
- [SAP Gateway Foundation — fonctionnalités OData](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/68bf513362174d54b58cddec28794093/97422751c639276ee10000000a445394.html)

[^odata]: **OData.** Protocole HTTP normalisé permettant d’exposer et de manipuler des ressources décrites par un modèle de données.

[^sap-gateway]: **SAP GATEWAY.** Composant SAP qui exécute les services OData classiques et relie les requêtes HTTP à leur implémentation ABAP.

[^class-data]: **CLASS-DATA.** Attribut appartenant à la classe elle-même et partagé par tous ses appels dans la même session interne ABAP.
