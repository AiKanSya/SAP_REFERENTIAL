# 🌸 CONSTRUIRE ET LIRE DES FICHIERS CSV

## 🌺 OBJECTIFS

- Comprendre les règles d’échappement
- Produire un format non ambigu
- Éviter les découpages naïfs

## 🌺 CONTRAT CSV

CSV n’impose pas un séparateur unique dans tous les usages. Le contrat doit préciser :

- séparateur `,`, `;` ou tabulation ;
- caractère de citation, généralement `"` ;
- échappement des citations par doublement ;
- encodage ;
- présence d’un en-tête ;
- format des dates et nombres ;
- représentation des valeurs vides.

## 🌺 ÉCHAPPEMENT

```abap
CLASS lcl_csv DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS escape
      IMPORTING iv_value        TYPE string
      RETURNING VALUE(rv_value) TYPE string.
ENDCLASS.

CLASS lcl_csv IMPLEMENTATION.
  METHOD escape.
    rv_value = iv_value.
    REPLACE ALL OCCURRENCES OF '"' IN rv_value WITH '""'.

    IF rv_value CS ';'
       OR rv_value CS '"'
       OR rv_value CS cl_abap_char_utilities=>newline.
      rv_value = |"{ rv_value }"|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
```

Une valeur `Produit; spécial` devient `"Produit; spécial"`. Une citation interne est doublée.

## 🌺 LECTURE

`SPLIT line AT ';'` est insuffisant dès qu’un champ cité contient le séparateur ou une fin de ligne. Pour un CSV complet :

- utiliser un parseur validé ;
- ou implémenter une machine à états tenant compte des citations ;
- ou imposer contractuellement un format plus simple sans champs multiligne.

## 🌺 DONNÉES MÉTIER

Écrire les nombres avec un séparateur décimal invariant et les dates dans un format non ambigu, par exemple `YYYY-MM-DD`. Ne pas utiliser directement la présentation locale de l’utilisateur.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)

---

➡️ [Chapitre suivant — FICHIERS A LARGEUR FIXE](<./18 - 🍧 FICHIERS A LARGEUR FIXE.md>)
