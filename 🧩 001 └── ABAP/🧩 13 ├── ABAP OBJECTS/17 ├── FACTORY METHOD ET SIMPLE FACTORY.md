# 17. FACTORY METHOD ET SIMPLE FACTORY

## 17.A RÉSULTAT ATTENDU

- Contrôler la création d’objets.
- Centraliser le choix d’une implémentation.
- Utiliser `CREATE PRIVATE` lorsqu’un appel direct à `NEW` doit être interdit.

## 17.B CAS D’USAGE

Un export doit sélectionner une implémentation CSV[^terme-csv] ou JSON[^terme-json]. Les reports ne doivent pas connaître les constructeurs ni les dépendances de chaque classe[^terme-classe].

## 17.C FACTORY METHOD

Une méthode[^terme-methode] de classe retourne une instance. Elle peut valider les paramètres, sélectionner une sous-classe ou gérer un cache.

## 17.D PROCESS

### 17.D.1 Étape 1 — Définir le produit abstrait

Créer l’interface commune avec uniquement les opérations dont l’appelant a besoin. Activer puis implémenter au moins deux classes concrètes conformes.

### 17.D.2 Étape 2 — Définir la règle de sélection

Identifier la donnée qui choisit l’implémentation : type métier, configuration ou paramètre. Valider sa liste de valeurs et décider du comportement pour une valeur inconnue.

### 17.D.3 Étape 3 — Créer la factory

Créer une classe fabrique ou une méthode de classe `CREATE`. Ajouter le sélecteur en `IMPORTING`, une référence d’interface en `RETURNING` et une exception[^terme-exception] en `RAISING`.

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

Si aucune création directe ne doit être possible, configurer l’instanciation privée dans les propriétés `SE24`[^terme-class-builder-se24]. La méthode de fabrique reste alors le seul point de création externe.

## 17.G CONTRÔLE

- Le consommateur ne contient aucun `NEW` des implémentations concrètes.
- La valeur inconnue produit une exception explicite.
- Le type de retour est l’interface lorsque plusieurs implémentations sont possibles.

## 17.H ERREURS FRÉQUENTES

- Placer de la logique métier dans la fabrique.
- Retourner `REF TO object` sans contrat précis.
- Créer une fabrique pour une classe triviale sans variation ni contrainte de création.

## 17.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 17.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Instance Constructor — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINSTANCE_CONSTRUCTOR_GUIDL.html)

---

[Chapitre suivant — SINGLETON](<./18 ├── SINGLETON.md>)

[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-json]: **JSON.** Format texte structuré utilisant objets, tableaux, chaînes, nombres, booléens et valeur null. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#json>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
