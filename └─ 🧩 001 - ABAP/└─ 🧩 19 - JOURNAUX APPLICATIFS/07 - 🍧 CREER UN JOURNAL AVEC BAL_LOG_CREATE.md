# 🌸 CRÉER UN JOURNAL AVEC BAL_LOG_CREATE

## 🌺 OBJECTIFS

- Créer un journal en mémoire
- Récupérer son handle
- Contrôler les erreurs de configuration

## 🌺 EXEMPLE

```abap
DATA:
  ls_log        TYPE bal_s_log,
  lv_log_handle TYPE balloghndl.

ls_log-object    = 'ZDEV_LOG'.
ls_log-subobject = 'IMPORT'.
ls_log-extnumber = |RUN_{ sy-datum }_{ sy-uzeit }|.
ls_log-alprog     = sy-repid.

CALL FUNCTION 'BAL_LOG_CREATE'
  EXPORTING
    i_s_log                 = ls_log
  IMPORTING
    e_log_handle            = lv_log_handle
  EXCEPTIONS
    log_header_inconsistent = 1
    OTHERS                  = 2.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
```

## 🌺 HANDLE

Le type `BALLOGHNDL` identifie le journal créé. Il doit être conservé par le composant de journalisation et transmis à chaque ajout de message, affichage ou sauvegarde ciblée.

```mermaid
flowchart LR
    A["BAL_LOG_CREATE"] --> B["Log handle"]
    B --> C["BAL_LOG_MSG_ADD"]
    B --> D["BAL_DSP_LOG_DISPLAY"]
    B --> E["BAL_DB_SAVE"]
```

## 🌺 ERREURS DE CRÉATION

La création échoue notamment lorsque :

- l’objet ou le sous-objet n’existe pas ;
- la combinaison objet/sous-objet est invalide ;
- l’en-tête contient des données incohérentes.

Ne pas ignorer `sy-subrc`. Sans handle valide, les appels suivants ne produisent pas de journal exploitable.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)

---

➡️ [Chapitre suivant — AJOUTER DES MESSAGES T100](<./08 - 🍧 AJOUTER DES MESSAGES T100.md>)
