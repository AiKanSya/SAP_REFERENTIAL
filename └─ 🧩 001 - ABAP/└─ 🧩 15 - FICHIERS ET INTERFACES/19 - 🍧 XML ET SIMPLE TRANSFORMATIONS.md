# 🌸 XML ET SIMPLE TRANSFORMATIONS

## 🌺 OBJECTIFS

- Sérialiser des données ABAP en XML
- Distinguer transformation identité et format métier
- Utiliser `STRANS` dans SAP GUI

## 🌺 `CALL TRANSFORMATION`

```abap
DATA ls_product TYPE zdev_product.
DATA lv_xml     TYPE xstring.

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lv_xml.
```

La transformation prédéfinie `ID` produit la représentation canonique SAP appelée **asXML**. Elle est utile pour des échanges techniques contrôlés, mais ne correspond pas automatiquement au schéma XML demandé par un partenaire.

## 🌺 SIMPLE TRANSFORMATION

Une **Simple Transformation** créée dans `STRANS` permet de définir un document métier.

```abap
CALL TRANSFORMATION zdev_product_xml
  SOURCE product = ls_product
  RESULT XML lv_xml.
```

```mermaid
flowchart LR
    A["Structure ABAP"] --> B["Simple Transformation"]
    B --> C["XML métier"]
    C --> D["Validation du contrat"]
```

## 🌺 IMPORT XML

```abap
CALL TRANSFORMATION zdev_product_xml
  SOURCE XML lv_xml
  RESULT product = ls_product.
```

Les erreurs de syntaxe XML, de transformation ou de mapping doivent être capturées avec les classes d’exception appropriées, notamment dans la hiérarchie `CX_TRANSFORMATION_ERROR`.

## 🌺 BONNES PRATIQUES

- Versionner le schéma et la transformation.
- Contrôler les namespaces.
- Limiter la taille du document chargé en mémoire.
- Refuser les éléments inattendus selon le niveau de contrôle attendu.
- Tester les valeurs vides, caractères spéciaux et listes répétées.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Simple Transformations — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENST.html)
- [Canonical XML Representation — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_XMLS.html)

---

➡️ [Chapitre suivant — JSON AVEC LA BIBLIOTHEQUE SXML](<./20 - 🍧 JSON AVEC LA BIBLIOTHEQUE SXML.md>)
