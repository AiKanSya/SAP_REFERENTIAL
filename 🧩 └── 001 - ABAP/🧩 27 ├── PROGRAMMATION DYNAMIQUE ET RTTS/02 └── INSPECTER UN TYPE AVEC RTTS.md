# 2. INSPECTER UN TYPE AVEC RTTS

## 2.A RÉSULTAT ATTENDU

Déterminer à l’exécution si une donnée est une structure et obtenir la description de ses composants.

## 2.B PROCESS

### 2.B.1 ÉTAPE 1 — IDENTIFIER LE BESOIN D’INSPECTION

Utiliser RTTS pour une API[^terme-api] générique qui ne connaît pas statiquement le type reçu. Si le contrat est stable, déclarer une interface typée plutôt que reconstruire cette interface à l’exécution.

### 2.B.2 ÉTAPE 2 — OBTENIR LE DESCRIPTEUR

Appeler `CL_ABAP_TYPEDESCR=>DESCRIBE_BY_DATA` avec la donnée réelle. Conserver la référence retournée comme descripteur générique tant que sa catégorie n’est pas vérifiée.

### 2.B.3 ÉTAPE 3 — TESTER LA CATÉGORIE DU TYPE

Comparer `KIND` à `CL_ABAP_TYPEDESCR=>KIND_STRUCT`. Prévoir le traitement attendu pour une table, un type élémentaire ou une référence au lieu d’exécuter un cast descendant systématique.

### 2.B.4 ÉTAPE 4 — EFFECTUER LE CAST CONTRÔLÉ

Après le test de catégorie, convertir la référence avec `CAST CL_ABAP_STRUCTDESCR`. Le cast devient alors cohérent avec la catégorie observée.

### 2.B.5 ÉTAPE 5 — PARCOURIR LES COMPOSANTS

Lire `COMPONENTS` et relever pour chaque entrée le nom et le descripteur de type. Ne pas supposer que `ABSOLUTE_NAME` est renseigné de la même manière pour un type local, anonyme et DDIC[^terme-acro-ddic].

### 2.B.6 ÉTAPE 6 — TESTER PLUSIEURS FORMES DE TYPES

Exécuter le code avec une structure DDIC[^terme-structure-abap], une structure locale, un type élémentaire et une table interne[^terme-table-interne]. Vérifier que seuls les types structures atteignent le cast et la boucle.

## 2.C CODE PRÊT À ADAPTER

```abap
DATA ls_data TYPE zdemo_structure.
DATA(lo_type) = cl_abap_typedescr=>describe_by_data( ls_data ).

IF lo_type->kind = cl_abap_typedescr=>kind_struct.
  DATA(lo_structure) = CAST cl_abap_structdescr( lo_type ).

  LOOP AT lo_structure->components INTO DATA(ls_component).
    WRITE: / ls_component-name, ls_component-type->absolute_name.
  ENDLOOP.
ENDIF.
```

## 2.D CONTRÔLE

- Tester la catégorie avant tout cast descendant.
- Ne pas utiliser RTTS pour remplacer une interface ou un type DDIC stable.

[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-structure-abap]: **STRUCTURE.** Objet ou type composé de plusieurs composants nommés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
