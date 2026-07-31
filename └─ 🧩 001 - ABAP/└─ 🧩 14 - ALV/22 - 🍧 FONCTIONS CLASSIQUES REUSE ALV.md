# 🌸 FONCTIONS CLASSIQUES REUSE ALV

## 🌺 OBJECTIFS

- Lire et maintenir un ALV basé sur `REUSE_ALV_*`
- Identifier les structures `SLIS`
- Éviter d’étendre une architecture historique inutilement

## 🌺 EXEMPLE HISTORIQUE

```abap
TYPE-POOLS slis.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

gs_layout-zebra             = abap_true.
gs_layout-colwidth_optimize  = abap_true.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program = sy-repid
    is_layout          = gs_layout
    it_fieldcat        = gt_fieldcat
    i_save             = 'A'
  TABLES
    t_outtab           = gt_output
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
```

## 🌺 OBJETS COURANTS

| Élément    | Type historique       |
| ---------- | --------------------- |
| Catalogue  | `SLIS_T_FIELDCAT_ALV` |
| Layout     | `SLIS_LAYOUT_ALV`     |
| Tri        | `SLIS_T_SORTINFO_ALV` |
| Événements | `SLIS_T_EVENT`        |
| Variante   | `DISVARIANT`          |

## 🌺 STRATÉGIE DE MAINTENANCE

- Corriger le programme dans sa technologie existante lorsque le besoin est limité.
- Ne pas mélanger `SLIS` et `LVC` sans raison précise.
- En cas de refonte complète, choisir SALV ou `CL_GUI_ALV_GRID` selon les exigences.
- Tester les variantes existantes avant toute migration.

## 🌺 LIMITES

Les fonctions `REUSE_ALV_*` restent très présentes dans le patrimoine ABAP, mais elles reposent sur un modèle procédural et des callbacks. Pour un nouveau développement, privilégier une API orientée objet.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Modules Related to ALV Grid — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524193.html)
- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)

---

➡️ [Chapitre suivant — PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES](<./23 - 🍧 PERFORMANCE DIAGNOSTIC ET BONNES PRATIQUES.md>)
