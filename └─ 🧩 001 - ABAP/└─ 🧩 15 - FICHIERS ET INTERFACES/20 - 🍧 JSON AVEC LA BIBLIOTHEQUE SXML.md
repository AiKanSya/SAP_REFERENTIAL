# 🌸 JSON AVEC LA BIBLIOTHÈQUE SXML

## 🌺 OBJECTIFS

- Produire ou consommer du JSON avec les API ABAP documentées
- Comprendre la représentation asJSON
- Identifier les dépendances de version

## 🌺 ÉCRITURE JSON

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

## 🌺 LECTURE JSON

Un lecteur JSON sXML peut être fourni comme source XML à `CALL TRANSFORMATION`. Les signatures de création et les types disponibles doivent être contrôlés dans `SE24` sur la release cible.

## 🌺 ASJSON ET CONTRAT MÉTIER

La transformation identité ne garantit pas un JSON conforme au contrat d’une API externe. Pour maîtriser :

- le nom des propriétés ;
- les tableaux ;
- la gestion des valeurs nulles ;
- la casse ;
- les formats date et nombre ;

utiliser une transformation adaptée et valider le document produit.

## 🌺 VERSION

Le support JSON de `CALL TRANSFORMATION` et de la bibliothèque sXML dépend de la version ABAP. Vérifier les classes `CL_SXML_*`, l’interface `IF_SXML` et la documentation locale du système.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Transformations for JSON — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_JSON_TRAFOS.html)
- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Identity Transformation with JSON Writer — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENJSON_TRAFO_ID_ABEXA.html)

---

➡️ [Chapitre suivant — COMPRESSION ZIP AVEC CL_ABAP_ZIP](<./21 - 🍧 COMPRESSION ZIP AVEC CL_ABAP_ZIP.md>)
