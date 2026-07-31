# 🌸 EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR

## 🌺 OBJECTIFS

- Télécharger des données vers le poste
- Maîtriser le format produit
- Gérer la destination et les erreurs

## 🌺 EXPORT TEXTE

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

lt_lines = VALUE #(
  ( `ARTICLE;QUANTITE;UNITE` )
  ( `MAT-001;10;PC` ) ).

CALL METHOD cl_gui_frontend_services=>gui_download
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_write_error        = 1
    no_batch                = 2
    gui_refuse_filetransfer = 3
    OTHERS                  = 4.

IF sy-subrc <> 0.
  MESSAGE e004(zdev_file) WITH sy-subrc.
ENDIF.
```

## 🌺 NOM ET EXTENSION

Le dialogue de sauvegarde choisit le chemin. `GUI_DOWNLOAD` écrit le contenu. L’extension ne convertit pas les données : nommer un fichier `.xlsx` ne crée pas un classeur Excel.

## 🌺 CSV ET EXCEL

Un CSV reste un fichier texte. Son ouverture correcte dans Excel dépend notamment :

- du séparateur ;
- de l’encodage ;
- du format régional ;
- des guillemets ;
- des conversions automatiques de dates ou zéros initiaux.

Pour un vrai fichier Office Open XML, utiliser une technologie explicitement prévue pour ce format et disponible dans le système.

## 🌺 SÉCURITÉ

Ne lancer aucune application locale automatiquement après téléchargement sans besoin justifié. Pour afficher un document temporaire, SAP fournit des services frontend spécifiques plus sûrs que l’enchaînement historique téléchargement puis exécution.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)
- [SHOW_DOCUMENT — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/5a005e044eef436f8b27bbd3f73a3cfc/b174a19731f9424db1692ac6260a68c9.html)

---

➡️ [Chapitre suivant — CONSTRUIRE ET LIRE DES FICHIERS CSV](<./17 - 🍧 CONSTRUIRE ET LIRE DES FICHIERS CSV.md>)
