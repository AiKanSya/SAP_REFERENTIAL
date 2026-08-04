# SALV EN PLEIN ÉCRAN, CONTENEUR ET FENÊTRE

## OBJECTIFS

- Distinguer les modes d’affichage SALV
- Afficher un SALV dans un conteneur
- Créer une fenêtre de dialogue simple

## PLEIN ÉCRAN

Sans conteneur fourni à `FACTORY`, `CL_SALV_TABLE` produit généralement un affichage plein écran adapté aux rapports simples.

## CONTENEUR

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

## FENÊTRE DE DIALOGUE

```abap
go_salv->set_screen_popup(
  start_column = 10
  end_column   = 120
  start_line   = 3
  end_line     = 25 ).
```

La fenêtre convient à une consultation courte. Elle ne doit pas être utilisée pour remplacer un écran métier complexe.

## CHOIX DU MODE

| Mode        | Usage                          |
| ----------- | ------------------------------ |
| Plein écran | Rapport autonome               |
| Conteneur   | Zone ALV intégrée à un Dynpro  |
| Fenêtre     | Consultation secondaire courte |

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## TERMES DU LEXIQUE

- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [ALV Output Display in a Dialog Box — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec24e9e107868bae10000000a42189e.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)


---

[Chapitre suivant — PRINCIPES DE CL_GUI_ALV_GRID](<./10 ├── PRINCIPES DE CL_GUI_ALV_GRID.md>)
