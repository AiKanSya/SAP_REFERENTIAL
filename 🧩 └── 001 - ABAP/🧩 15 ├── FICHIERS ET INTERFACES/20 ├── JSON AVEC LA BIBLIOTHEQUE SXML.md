# 20. JSON AVEC LA BIBLIOTHÈQUE SXML

## 20.A RÉSULTAT ATTENDU

- Produire ou consommer du JSON[^terme-json] avec les API[^terme-api] ABAP[^terme-abap] documentées
- Comprendre la représentation asJSON
- Identifier les dépendances de version

## 20.B ÉCRITURE JSON

La bibliothèque sXML fournit des lecteurs et écrivains utilisés avec `CALL TRANSFORMATION`.

```abap
DATA ls_product TYPE zdev_product.
DATA lo_writer  TYPE REF TO cl_sxml_string_writer.
DATA lv_json    TYPE xstring.

lo_writer = cl_sxml_string_writer=>create(
  type = if_sxml=>co_xt_json ).

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lo_writer.

lv_json = lo_writer->get_output( ).
```

Le résultat suit la liaison JSON documentée par SAP[^terme-acro-sap]. La forme exacte dépend des noms ABAP et des règles de la transformation utilisée.

## 20.C LECTURE JSON

Un lecteur JSON sXML peut être fourni comme source XML[^terme-xml] à `CALL TRANSFORMATION`. Les signatures de création et les types disponibles doivent être contrôlés dans `SE24`[^terme-class-builder-se24] sur la release cible.

## 20.D ASJSON ET CONTRAT MÉTIER

La transformation identité ne garantit pas un JSON conforme au contrat d’une API externe. Pour maîtriser :

- le nom des propriétés ;
- les tableaux ;
- la gestion des valeurs nulles ;
- la casse ;
- les formats date et nombre ;

utiliser une transformation adaptée et valider le document produit.

## 20.E VERSION

Le support JSON de `CALL TRANSFORMATION` et de la bibliothèque sXML dépend de la version ABAP. Vérifier les classes `CL_SXML_*`, l’interface `IF_SXML` et la documentation locale du système.

## 20.F PROCESS

### 20.F.1 ÉTAPE 1 — DÉFINIR LE CONTRAT JSON

Lister les propriétés, leur casse, leur type, leur caractère obligatoire et la représentation des valeurs initiales. Définir séparément les objets, tableaux et valeurs scalaires. Ne pas laisser le nom technique d’un composant ABAP décider implicitement du contrat externe.

### 20.F.2 ÉTAPE 2 — PRÉPARER DES DONNÉES ABAP TYPÉES

Construire une structure ou une table dont chaque composant correspond à une donnée maîtrisée. Convertir explicitement les dates, heures, identifiants et nombres lorsque leur représentation JSON est contractuelle. Écarter les données non destinées au consommateur avant la sérialisation.

### 20.F.3 ÉTAPE 3 — CRÉER LE WRITER JSON

Créer un writer SXML en mode JSON avec l’API disponible sur la release cible. Conserver sa référence pendant toute la production du document. Vérifier dans `SE24` la signature exacte des méthodes utilisées, car les possibilités de création et de récupération du résultat dépendent du niveau de composant logiciel.

### 20.F.4 ÉTAPE 4 — ÉCRIRE UNE STRUCTURE JSON VALIDE

Produire les ouvertures et fermetures d’objets ou de tableaux dans un ordre strictement équilibré. Écrire chaque nom de propriété immédiatement avant sa valeur. Utiliser les méthodes du writer pour l’échappement ; ne pas concaténer manuellement des guillemets, barres obliques ou caractères de contrôle.

### 20.F.5 ÉTAPE 5 — RÉCUPÉRER ET CONVERTIR LE RÉSULTAT

Récupérer le résultat binaire du writer, puis le convertir en texte uniquement si l’appelant exige une `STRING`. Conserver l’encodage[^terme-encodage] UTF-8 lors d’un transfert de fichier ou HTTP. Ne pas appliquer une seconde conversion qui modifierait les octets produits.

### 20.F.6 ÉTAPE 6 — VALIDER PAR LECTURE INVERSÉE

Faire analyser le JSON produit par un parseur indépendant ou par le reader SXML. Vérifier les caractères accentués, guillemets, barres obliques, valeurs initiales, tableaux vides et volumes représentatifs. Comparer ensuite le document à un exemple contractuel, pas seulement à son apparence dans l’éditeur.

## 20.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 20.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 20.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_product TYPE zdev_product.
DATA lo_writer  TYPE REF TO cl_sxml_string_writer.
DATA lv_json    TYPE xstring.

lo_writer = cl_sxml_string_writer=>create(
  type = if_sxml=>co_xt_json ).

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lo_writer.

lv_json = lo_writer->get_output( ).
```

## 20.J TERMES DU LEXIQUE

- [JSON](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#json>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## 20.K RÉFÉRENCES OFFICIELLES SAP

- [Transformations for JSON — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_JSON_TRAFOS.html)
- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Identity Transformation with JSON Writer — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENJSON_TRAFO_ID_ABEXA.html)

---

[Chapitre suivant — COMPRESSION ZIP AVEC `CL_ABAP_ZIP`](<./21 ├── COMPRESSION ZIP AVEC CL_ABAP_ZIP.md>)

[^terme-json]: **JSON.** Format texte structuré utilisant objets, tableaux, chaînes, nombres, booléens et valeur null. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#json>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-xml]: **XML.** Format texte hiérarchique basé sur des balises. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#xml>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
