# 🌸 IMPORTER UN FICHIER DU POSTE UTILISATEUR

## 🌺 OBJECTIFS

- Charger un fichier local dans une table interne
- Choisir le type de fichier adapté
- Contrôler les erreurs de frontend

## 🌺 IMPORT TEXTE

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

CALL METHOD cl_gui_frontend_services=>gui_upload
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    OTHERS                  = 5.

IF sy-subrc <> 0.
  MESSAGE e003(zdev_file) WITH sy-subrc.
ENDIF.
```

Les exceptions exactes et les paramètres doivent être contrôlés dans `SE24`, car ils peuvent différer selon le niveau de composant.

## 🌺 TYPES DE FICHIER

| Type  | Usage                                                   |
| ----- | ------------------------------------------------------- |
| `ASC` | Texte                                                   |
| `BIN` | Contenu binaire                                         |
| `DAT` | Format texte avec séparateurs selon le service frontend |

Pour un contrat d’interface strict, importer des lignes texte puis effectuer soi-même le parsing évite de dépendre de comportements implicites.

## 🌺 LIMITES

- Impossible en arrière-plan.
- Le fichier traverse la connexion frontend vers le serveur ABAP.
- Le volume doit rester compatible avec une interaction utilisateur.
- La sélection locale ne dispense pas des contrôles métier.

## 🌺 ARCHITECTURE

La méthode d’import doit retourner un contenu brut ou une table de lignes. Une méthode distincte transforme ce contenu en données métier. Le test du parsing devient alors indépendant de SAP GUI.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [GUI_UPLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/ff557c806c5510149761a0c32c810458/1dac0155370648569fe843170e07c4da.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)

---

➡️ [Chapitre suivant — EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR](<./16 - 🍧 EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR.md>)
