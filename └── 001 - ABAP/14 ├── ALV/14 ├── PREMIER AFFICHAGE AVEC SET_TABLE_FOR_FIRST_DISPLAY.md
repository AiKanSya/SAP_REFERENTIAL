# PREMIER AFFICHAGE AVEC SET_TABLE_FOR_FIRST_DISPLAY

## OBJECTIFS

- Appeler correctement la méthode d’affichage initial
- Distinguer premier affichage et rafraîchissement
- Traiter les erreurs du Control Framework

## APPEL COMPLET

```abap
FORM display_grid.
  DATA ls_variant TYPE disvariant.

  ls_variant-report = sy-repid.

  CALL METHOD go_grid->set_table_for_first_display
    EXPORTING
      is_variant      = ls_variant
      i_save          = 'A'
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_output
      it_fieldcatalog = gt_fieldcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

  IF sy-subrc <> 0.
    MESSAGE 'Impossible d afficher l ALV' TYPE 'E'.
  ENDIF.
ENDFORM.
```

## STRUCTURE DDIC OU CATALOGUE

Deux modèles principaux :

```abap
" Structure DDIC
EXPORTING i_structure_name = 'ZDEV_S_ALV_OUTPUT'
```

ou :

```abap
" Catalogue explicite
CHANGING it_fieldcatalog = gt_fieldcat
```

Éviter de mélanger des définitions contradictoires.

## PREMIER AFFICHAGE

`SET_TABLE_FOR_FIRST_DISPLAY` doit être appelé pour initialiser le contrôle. Pour les modifications ultérieures de données, utiliser `REFRESH_TABLE_DISPLAY`.

```mermaid
flowchart TD
    A["Grille non initialisée"] --> B["SET_TABLE_FOR_FIRST_DISPLAY"]
    B --> C["Grille affichée"]
    C --> D["Données modifiées"]
    D --> E["REFRESH_TABLE_DISPLAY"]
```

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
FORM display_grid.
  DATA ls_variant TYPE disvariant.

  ls_variant-report = sy-repid.

  CALL METHOD go_grid->set_table_for_first_display
    EXPORTING
      is_variant      = ls_variant
      i_save          = 'A'
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_output
      it_fieldcatalog = gt_fieldcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

  IF sy-subrc <> 0.
    MESSAGE 'Impossible d afficher l ALV' TYPE 'E'.
  ENDIF.
ENDFORM.
```

## TERMES DU LEXIQUE

- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)
- [Getting Started with ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4eba23f5250f568be10000000a421937.html)


---

[Chapitre suivant — ÉVÉNEMENTS ET CLASSE RÉCEPTRICE](<./15 ├── EVENEMENTS ET CLASSE RECEPTRICE.md>)
