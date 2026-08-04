# JSON AVEC LA BIBLIOTHÈQUE SXML

## RÉSULTAT ATTENDU

- Produire ou consommer du JSON avec les API ABAP documentées
- Comprendre la représentation asJSON
- Identifier les dépendances de version

## ÉCRITURE JSON

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

Le résultat suit la liaison JSON documentée par SAP. La forme exacte dépend des noms ABAP et des règles de la transformation utilisée.

## LECTURE JSON

Un lecteur JSON sXML peut être fourni comme source XML à `CALL TRANSFORMATION`. Les signatures de création et les types disponibles doivent être contrôlés dans `SE24` sur la release cible.

## ASJSON ET CONTRAT MÉTIER

La transformation identité ne garantit pas un JSON conforme au contrat d’une API externe. Pour maîtriser :

- le nom des propriétés ;
- les tableaux ;
- la gestion des valeurs nulles ;
- la casse ;
- les formats date et nombre ;

utiliser une transformation adaptée et valider le document produit.

## VERSION

Le support JSON de `CALL TRANSFORMATION` et de la bibliothèque sXML dépend de la version ABAP. Vérifier les classes `CL_SXML_*`, l’interface `IF_SXML` et la documentation locale du système.

## PROCESS

### ÉTAPE 1 — DÉFINIR LE CONTRAT JSON

Lister les propriétés, leur casse, leur type, leur caractère obligatoire et la représentation des valeurs initiales. Définir séparément les objets, tableaux et valeurs scalaires. Ne pas laisser le nom technique d’un composant ABAP décider implicitement du contrat externe.

### ÉTAPE 2 — PRÉPARER DES DONNÉES ABAP TYPÉES

Construire une structure ou une table dont chaque composant correspond à une donnée maîtrisée. Convertir explicitement les dates, heures, identifiants et nombres lorsque leur représentation JSON est contractuelle. Écarter les données non destinées au consommateur avant la sérialisation.

### ÉTAPE 3 — CRÉER LE WRITER JSON

Créer un writer SXML en mode JSON avec l’API disponible sur la release cible. Conserver sa référence pendant toute la production du document. Vérifier dans `SE24` la signature exacte des méthodes utilisées, car les possibilités de création et de récupération du résultat dépendent du niveau de composant logiciel.

### ÉTAPE 4 — ÉCRIRE UNE STRUCTURE JSON VALIDE

Produire les ouvertures et fermetures d’objets ou de tableaux dans un ordre strictement équilibré. Écrire chaque nom de propriété immédiatement avant sa valeur. Utiliser les méthodes du writer pour l’échappement ; ne pas concaténer manuellement des guillemets, barres obliques ou caractères de contrôle.

### ÉTAPE 5 — RÉCUPÉRER ET CONVERTIR LE RÉSULTAT

Récupérer le résultat binaire du writer, puis le convertir en texte uniquement si l’appelant exige une `STRING`. Conserver l’encodage UTF-8 lors d’un transfert de fichier ou HTTP. Ne pas appliquer une seconde conversion qui modifierait les octets produits.

### ÉTAPE 6 — VALIDER PAR LECTURE INVERSÉE

Faire analyser le JSON produit par un parseur indépendant ou par le reader SXML. Vérifier les caractères accentués, guillemets, barres obliques, valeurs initiales, tableaux vides et volumes représentatifs. Comparer ensuite le document à un exemple contractuel, pas seulement à son apparence dans l’éditeur.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## TERMES DU LEXIQUE

- [JSON](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#json>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [Transformations for JSON — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_JSON_TRAFOS.html)
- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Identity Transformation with JSON Writer — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENJSON_TRAFO_ID_ABEXA.html)

---

[Chapitre suivant — COMPRESSION ZIP AVEC `CL_ABAP_ZIP`](<./21 ├── COMPRESSION ZIP AVEC CL_ABAP_ZIP.md>)
