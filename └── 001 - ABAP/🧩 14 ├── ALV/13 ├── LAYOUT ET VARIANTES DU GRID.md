# LAYOUT ET VARIANTES DU GRID

## OBJECTIFS

- Configurer `LVC_S_LAYO`
- Activer la sauvegarde des variantes
- Distinguer layout applicatif et variante utilisateur

## LAYOUT

```abap
DATA gs_layout TYPE lvc_s_layo.

gs_layout-zebra      = abap_true.
gs_layout-cwidth_opt = abap_true.
gs_layout-sel_mode   = 'A'.
```

Propriétés fréquentes :

| Champ        | Usage                               |
| ------------ | ----------------------------------- |
| `ZEBRA`      | Alternance visuelle des lignes      |
| `CWIDTH_OPT` | Optimisation des largeurs           |
| `SEL_MODE`   | Mode de sélection                   |
| `EDIT`       | Activation générale de l’édition    |
| `STYLEFNAME` | Table de styles au niveau ligne     |
| `CTAB_FNAME` | Table de couleurs au niveau cellule |
| `INFO_FNAME` | Couleur de ligne                    |

## VARIANTE

```abap
DATA gs_variant TYPE disvariant.

gs_variant-report = sy-repid.
```

Lors de l’affichage :

```abap
go_grid->set_table_for_first_display(
  EXPORTING
    is_variant      = gs_variant
    i_save          = 'A'
    is_layout       = gs_layout
  CHANGING
    it_outtab       = gt_output
    it_fieldcatalog = gt_fieldcat ).
```

`I_SAVE = 'A'` autorise généralement les variantes utilisateur et globales, sous réserve des autorisations et du comportement de la version utilisée.

## BONNES PRATIQUES

- Toujours renseigner `DISVARIANT-REPORT`.
- Ne pas modifier la clé de variante entre deux exécutions équivalentes.
- Ne pas rendre une colonne technique accessible via une variante.
- Tester l’impact d’une évolution de structure sur les variantes déjà sauvegardées.

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
DATA gs_variant TYPE disvariant.

gs_variant-report = sy-repid.
```

## TERMES DU LEXIQUE

- [Variante](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)


---

[Chapitre suivant — PREMIER AFFICHAGE AVEC SET_TABLE_FOR_FIRST_DISPLAY](<./14 ├── PREMIER AFFICHAGE AVEC SET_TABLE_FOR_FIRST_DISPLAY.md>)
