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

## 🌺 VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)


---

➡️ [Chapitre suivant — FICHIERS À LARGEUR FIXE](<./18 - 🍧 FICHIERS A LARGEUR FIXE.md>)
