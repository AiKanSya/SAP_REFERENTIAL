# STYLES, COULEURS, ICÔNES ET CELLULES

## OBJECTIFS

- Adapter la présentation par ligne ou cellule
- Désactiver certaines cellules
- Afficher des icônes et des couleurs avec modération

## STYLES DE CELLULE

Ajouter une table de styles à la structure de sortie :

```abap
TYPES:
  BEGIN OF ty_output,
    carrid  TYPE sflight-carrid,
    status  TYPE icon_d,
    celltab TYPE lvc_t_styl,
  END OF ty_output.
```

Configurer le layout :

```abap
gs_layout-stylefname = 'CELLTAB'.
```

Désactiver une cellule :

```abap
DATA ls_style TYPE lvc_s_styl.

ls_style-fieldname = 'CARRID'.
ls_style-style = cl_gui_alv_grid=>mc_style_disabled.
APPEND ls_style TO gs_output-celltab.
```

## COULEURS

Les couleurs peuvent être définies au niveau colonne, ligne ou cellule selon les propriétés du catalogue, du layout et de la structure de sortie. Une couleur doit transmettre une information stable, pas décorer l’écran.

## ICÔNES

Pour une colonne contenant un identifiant d’icône :

```abap
gs_fieldcat-fieldname = 'STATUS'.
gs_fieldcat-icon      = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

Associer un texte explicatif ou une info-bulle lorsque l’icône seule n’est pas suffisante.

## ACCESSIBILITÉ

Ne jamais transmettre une information uniquement par la couleur. Combiner couleur, texte, icône ou statut afin que le résultat reste compréhensible dans différents contextes d’affichage.

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
TYPES:
  BEGIN OF ty_output,
    carrid  TYPE sflight-carrid,
    status  TYPE icon_d,
    celltab TYPE lvc_t_styl,
  END OF ty_output.
```

## TERMES DU LEXIQUE

- [ALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## RÉFÉRENCES OFFICIELLES SAP

- [The Field Catalog — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaa38d251e56a4e10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)


---

[Chapitre suivant — RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE](<./21 ├── RAFRAICHISSEMENT ET STABILITE D AFFICHAGE.md>)
