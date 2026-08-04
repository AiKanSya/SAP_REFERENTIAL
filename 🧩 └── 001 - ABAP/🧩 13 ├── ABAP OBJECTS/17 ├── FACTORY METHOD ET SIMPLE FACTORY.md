# 17. FACTORY METHOD ET SIMPLE FACTORY

## 17.A RÉSULTAT ATTENDU

- Contrôler la création d’objets.
- Centraliser le choix d’une implémentation.
- Utiliser `CREATE PRIVATE` lorsqu’un appel direct à `NEW` doit être interdit.

## 17.B CAS D’USAGE

Un export doit sélectionner une implémentation CSV ou JSON. Les reports ne doivent pas connaître les constructeurs ni les dépendances de chaque classe.

## 17.C FACTORY METHOD

Une méthode de classe retourne une instance. Elle peut valider les paramètres, sélectionner une sous-classe ou gérer un cache.

## 17.D PROCESS

### 17.D.1 Étape 1 — Définir le produit abstrait

Créer l’interface commune avec uniquement les opérations dont l’appelant a besoin. Activer puis implémenter au moins deux classes concrètes conformes.

### 17.D.2 Étape 2 — Définir la règle de sélection

Identifier la donnée qui choisit l’implémentation : type métier, configuration ou paramètre. Valider sa liste de valeurs et décider du comportement pour une valeur inconnue.

### 17.D.3 Étape 3 — Créer la factory

Créer une classe fabrique ou une méthode de classe `CREATE`. Ajouter le sélecteur en `IMPORTING`, une référence d’interface en `RETURNING` et une exception en `RAISING`.

### 17.D.4 Étape 4 — Instancier sans exposer le concret

Dans la factory, choisir la classe, exécuter `NEW` et retourner via l’interface. Ne faire sortir aucun type propre à une implémentation.

### 17.D.5 Étape 5 — Tester toutes les branches

Tester chaque valeur reconnue et une valeur inconnue. Vérifier type dynamique, contrat et exception. La factory est validée lorsque l’appelant n’utilise aucun nom de classe concrète.

## 17.E CODE SIMPLE FACTORY À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
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

## 17.F CREATE PRIVATE

Si aucune création directe ne doit être possible, configurer l’instanciation privée dans les propriétés `SE24`. La méthode de fabrique reste alors le seul point de création externe.

## 17.G CONTRÔLE

- Le consommateur ne contient aucun `NEW` des implémentations concrètes.
- La valeur inconnue produit une exception explicite.
- Le type de retour est l’interface lorsque plusieurs implémentations sont possibles.

## 17.H ERREURS FRÉQUENTES

- Placer de la logique métier dans la fabrique.
- Retourner `REF TO object` sans contrat précis.
- Créer une fabrique pour une classe triviale sans variation ni contrainte de création.

## 17.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 17.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Instance Constructor — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINSTANCE_CONSTRUCTOR_GUIDL.html)

---

[Chapitre suivant — SINGLETON](<./18 ├── SINGLETON.md>)
