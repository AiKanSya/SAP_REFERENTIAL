# 🌸 SALV EN PLEIN ÉCRAN, CONTENEUR ET FENÊTRE

## 🌺 OBJECTIFS

- Distinguer les modes d’affichage SALV
- Afficher un SALV dans un conteneur
- Créer une fenêtre de dialogue simple

## 🌺 PLEIN ÉCRAN

Sans conteneur fourni à `FACTORY`, `CL_SALV_TABLE` produit généralement un affichage plein écran adapté aux rapports simples.

## 🌺 CONTENEUR

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_salv      TYPE REF TO cl_salv_table.

CREATE OBJECT go_container
  EXPORTING
    container_name = 'CC_ALV'.

cl_salv_table=>factory(
  EXPORTING
    r_container  = go_container
  IMPORTING
    r_salv_table = go_salv
  CHANGING
    t_table      = gt_flights ).

go_salv->display( ).
```

Le Dynpro doit contenir un Custom Control nommé `CC_ALV`. Les références doivent rester vivantes pendant toute la durée d’affichage de l’écran.

## 🌺 FENÊTRE DE DIALOGUE

```abap
go_salv->set_screen_popup(
  start_column = 10
  end_column   = 120
  start_line   = 3
  end_line     = 25 ).
```

La fenêtre convient à une consultation courte. Elle ne doit pas être utilisée pour remplacer un écran métier complexe.

## 🌺 CHOIX DU MODE

| Mode        | Usage                          |
| ----------- | ------------------------------ |
| Plein écran | Rapport autonome               |
| Conteneur   | Zone ALV intégrée à un Dynpro  |
| Fenêtre     | Consultation secondaire courte |

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ALV Output Display in a Dialog Box — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec24e9e107868bae10000000a42189e.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)

---

➡️ [Chapitre suivant — PRINCIPES DE CL_GUI_ALV_GRID](<./10 - 🍧 PRINCIPES DE CL_GUI_ALV_GRID.md>)
