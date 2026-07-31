# 🌸 COMPRESSION ZIP AVEC `CL_ABAP_ZIP`

## 🌺 OBJECTIFS

- Regrouper plusieurs contenus dans une archive ZIP
- Manipuler l’archive en mémoire
- Séparer compression et transport du fichier

## 🌺 CRÉATION

```abap
DATA lo_zip     TYPE REF TO cl_abap_zip.
DATA lv_content TYPE xstring.
DATA lv_archive TYPE xstring.

CREATE OBJECT lo_zip.

lo_zip->add(
  name    = 'products.csv'
  content = lv_content ).

lv_archive = lo_zip->save( ).
```

Le contenu ajouté doit être binaire (`xstring`). Un texte doit donc être converti dans l’encodage prévu avant compression.

## 🌺 LECTURE

```abap
CREATE OBJECT lo_zip.
lo_zip->load( zip = lv_archive ).

DATA(lv_file_content) = lo_zip->get( name = 'products.csv' ).
```

Les signatures doivent être vérifiées dans `SE24` selon la version.

## 🌺 TRANSPORT

`CL_ABAP_ZIP` crée ou lit l’archive en mémoire. Il faut ensuite :

- écrire le `xstring` sur le serveur en mode binaire ;
- ou le télécharger avec `GUI_DOWNLOAD` en mode binaire ;
- ou le transmettre à une API adaptée.

## 🌺 SÉCURITÉ

Lors de l’extraction :

- contrôler les noms internes ;
- refuser les chemins absolus et `../` ;
- limiter la taille et le nombre d’entrées ;
- ne pas extraire automatiquement vers un chemin construit depuis l’archive.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CL_ABAP_ZIP Example — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524363.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)

---

➡️ [Chapitre suivant — CONCEVOIR UNE INTERFACE D IMPORT](<./22 - 🍧 CONCEVOIR UNE INTERFACE D IMPORT.md>)
