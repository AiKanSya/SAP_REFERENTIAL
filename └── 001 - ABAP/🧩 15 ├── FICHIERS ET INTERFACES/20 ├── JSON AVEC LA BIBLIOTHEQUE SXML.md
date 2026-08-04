# JSON AVEC LA BIBLIOTHÈQUE SXML

## OBJECTIFS

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

## PROCÉDURE PAS À PAS

1. Saisir `/nSE24`.
2. Entrer le nom d’une classe globale Z puis choisir **Créer**, ou afficher une classe existante.
3. Maintenir définition, visibilité, types, attributs et méthodes dans les onglets appropriés.
4. Implémenter les méthodes dans l’éditeur.
5. Contrôler et activer la classe complète.
6. Utiliser la fonction de test ou un report Z appelant pour vérifier le comportement.

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

- [JSON](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#json>)
- [Interface](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [Transformations for JSON — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_JSON_TRAFOS.html)
- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Identity Transformation with JSON Writer — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENJSON_TRAFO_ID_ABEXA.html)


---

[Chapitre suivant — COMPRESSION ZIP AVEC `CL_ABAP_ZIP`](<./21 ├── COMPRESSION ZIP AVEC CL_ABAP_ZIP.md>)
