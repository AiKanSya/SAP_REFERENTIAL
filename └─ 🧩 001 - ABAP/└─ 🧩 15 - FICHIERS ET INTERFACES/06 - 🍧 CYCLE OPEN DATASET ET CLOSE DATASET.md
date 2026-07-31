# 🌸 CYCLE `OPEN DATASET` ET `CLOSE DATASET`

## 🌺 OBJECTIFS

- Maîtriser le cycle d’ouverture et de fermeture
- Choisir un mode d’accès cohérent
- Garantir la fermeture en cas d’erreur

## 🌺 CYCLE

```mermaid
flowchart LR
    A["Résoudre le nom"] --> B["OPEN DATASET"]
    B --> C["Lire ou écrire"]
    C --> D["Contrôler les erreurs"]
    D --> E["CLOSE DATASET"]
```

`OPEN DATASET` ouvre un fichier sur le serveur d’application. Le mode choisi conditionne les opérations suivantes.

| Accès           | Usage                                   |
| --------------- | --------------------------------------- |
| `FOR INPUT`     | Lecture                                 |
| `FOR OUTPUT`    | Création ou remplacement                |
| `FOR APPENDING` | Ajout en fin de fichier                 |
| `FOR UPDATE`    | Lecture et écriture avec positionnement |

## 🌺 EXEMPLE

```abap
DATA lv_file TYPE string VALUE '/interface/in/products.csv'.
DATA lv_line TYPE string.

TRY.
    OPEN DATASET lv_file
      FOR INPUT
      IN TEXT MODE
      ENCODING UTF-8.

    DO.
      READ DATASET lv_file INTO lv_line.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      " Traitement de la ligne
    ENDDO.

    CLOSE DATASET lv_file.
  CATCH cx_sy_file_open
        cx_sy_file_authority
        cx_sy_file_io INTO DATA(lx_file).
    CLOSE DATASET lv_file.
    MESSAGE lx_file->get_text( ) TYPE 'E'.
ENDTRY.
```

La liste exacte des exceptions dépend de l’instruction et du mode. Elle doit être contrôlée dans la documentation de la version cible.

## 🌺 FERMETURE

Fermer explicitement chaque fichier dès que son utilisation est terminée. Une structure locale de traitement ou une méthode dédiée limite les chemins de sortie qui oublient `CLOSE DATASET`.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)
- [Error Handling for OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_ERROR_HANDLING.html)

---

➡️ [Chapitre suivant — FICHIERS TEXTE ET MODES D ACCES](<./07 - 🍧 FICHIERS TEXTE ET MODES D ACCES.md>)
