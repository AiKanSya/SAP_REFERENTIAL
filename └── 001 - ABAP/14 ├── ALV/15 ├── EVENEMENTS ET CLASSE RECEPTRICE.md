# ÉVÉNEMENTS ET CLASSE RÉCEPTRICE

## OBJECTIFS

- Créer une classe de gestion des événements
- Enregistrer les handlers avant l’affichage
- Organiser le traitement des interactions

## DÉFINITION

```abap
CLASS lcl_event_receiver DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row e_column es_row_no.

    METHODS handle_user_command
      FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING e_ucomm.
ENDCLASS.
```

## IMPLÉMENTATION

```abap
CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
    IF sy-subrc = 0.
      MESSAGE |Ligne { es_row_no-row_id }| TYPE 'S'.
    ENDIF.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'ZREFRESH'.
        PERFORM reload_data.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
```

## ENREGISTREMENT

```abap
DATA(go_receiver) = NEW lcl_event_receiver( ).
SET HANDLER go_receiver->handle_double_click FOR go_grid.
SET HANDLER go_receiver->handle_user_command FOR go_grid.
```

Conserver la référence `GO_RECEIVER`. Une instance locale détruite à la fin d’une procédure ne doit pas être utilisée comme gestionnaire permanent.

## ORGANISATION

Le handler doit :

1. interpréter l’événement ;
2. valider la sélection ;
3. déléguer la règle métier à une procédure ou une classe dédiée ;
4. actualiser l’affichage si nécessaire.

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
CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
    IF sy-subrc = 0.
      MESSAGE |Ligne { es_row_no-row_id }| TYPE 'S'.
    ENDIF.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'ZREFRESH'.
        PERFORM reload_data.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
```

## TERMES DU LEXIQUE

- [Classe](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)


---

[Chapitre suivant — BARRE D’OUTILS ET COMMANDES PERSONNALISÉES](<./16 ├── BARRE D OUTILS ET COMMANDES PERSONNALISEES.md>)
