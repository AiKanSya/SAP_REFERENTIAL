# 🌸 FACTORY METHOD ET SIMPLE FACTORY

## 🌺 RÉSULTAT ATTENDU

- Contrôler la création d’objets.
- Centraliser le choix d’une implémentation.
- Utiliser `CREATE PRIVATE` lorsqu’un appel direct à `NEW` doit être interdit.

## 🌺 CAS D’USAGE

Un export doit sélectionner une implémentation CSV ou JSON. Les reports ne doivent pas connaître les constructeurs ni les dépendances de chaque classe.

## 🌺 FACTORY METHOD

Une méthode de classe retourne une instance. Elle peut valider les paramètres, sélectionner une sous-classe ou gérer un cache.

## 🌺 PROCÉDURE DANS SE24

1. Définir l’interface commune.
2. Créer les classes concrètes.
3. Créer une classe fabrique, ou une méthode de classe sur la classe concernée.
4. Définir une méthode statique `CREATE` ou `GET_INSTANCE` avec un paramètre de sélection.
5. Retourner une référence typée par l’interface.
6. Lever une exception pour une configuration inconnue.
7. Tester chaque branche.

## 🌺 CODE SIMPLE FACTORY À ADAPTER

```abap
CLASS-METHODS create
  IMPORTING iv_format TYPE string
  RETURNING VALUE(ro_exporter) TYPE REF TO zif_dev_exporter
  RAISING   zcx_dev_unsupported_format.

METHOD create.
  CASE to_upper( iv_format ).
    WHEN 'CSV'.
      ro_exporter = NEW zcl_dev_csv_exporter( ).
    WHEN 'JSON'.
      ro_exporter = NEW zcl_dev_json_exporter( ).
    WHEN OTHERS.
      RAISE EXCEPTION TYPE zcx_dev_unsupported_format.
  ENDCASE.
ENDMETHOD.
```

Consommateur :

```abap
DATA(lo_exporter) = zcl_dev_exporter_factory=>create( p_format ).
DATA(lv_payload) = lo_exporter->serialize( lt_data ).
```

## 🌺 CREATE PRIVATE

Si aucune création directe ne doit être possible, configurer l’instanciation privée dans les propriétés `SE24`. La méthode de fabrique reste alors le seul point de création externe.

## 🌺 CONTRÔLE

- Le consommateur ne contient aucun `NEW` des implémentations concrètes.
- La valeur inconnue produit une exception explicite.
- Le type de retour est l’interface lorsque plusieurs implémentations sont possibles.

## 🌺 ERREURS FRÉQUENTES

- Placer de la logique métier dans la fabrique.
- Retourner `REF TO object` sans contrat précis.
- Créer une fabrique pour une classe triviale sans variation ni contrainte de création.

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Instance Constructor — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINSTANCE_CONSTRUCTOR_GUIDL.html)

---

➡️ [Chapitre suivant — SINGLETON](<./18 - 🍧 SINGLETON.md>)
