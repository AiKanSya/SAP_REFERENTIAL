# 🌸 STYLES, COULEURS, ICÔNES ET CELLULES

## 🌺 OBJECTIFS

- Adapter la présentation par ligne ou cellule
- Désactiver certaines cellules
- Afficher des icônes et des couleurs avec modération

## 🌺 STYLES DE CELLULE

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

## 🌺 COULEURS

Les couleurs peuvent être définies au niveau colonne, ligne ou cellule selon les propriétés du catalogue, du layout et de la structure de sortie. Une couleur doit transmettre une information stable, pas décorer l’écran.

## 🌺 ICÔNES

Pour une colonne contenant un identifiant d’icône :

```abap
gs_fieldcat-fieldname = 'STATUS'.
gs_fieldcat-icon      = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

Associer un texte explicatif ou une info-bulle lorsque l’icône seule n’est pas suffisante.

## 🌺 ACCESSIBILITÉ

Ne jamais transmettre une information uniquement par la couleur. Combiner couleur, texte, icône ou statut afin que le résultat reste compréhensible dans différents contextes d’affichage.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [The Field Catalog — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaa38d251e56a4e10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)

---

➡️ [Chapitre suivant — RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE](<./21 - 🍧 RAFRAICHISSEMENT ET STABILITE D AFFICHAGE.md>)
