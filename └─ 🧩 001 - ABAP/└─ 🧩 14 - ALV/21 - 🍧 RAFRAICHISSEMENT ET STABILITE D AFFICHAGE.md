# 🌸 RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE

## 🌺 OBJECTIFS

- Actualiser les données sans recréer la grille
- Conserver la position de défilement
- Comprendre le rafraîchissement logiciel

## 🌺 RAFRAÎCHIR

```abap
DATA ls_stable TYPE lvc_s_stbl.

ls_stable-row = abap_true.
ls_stable-col = abap_true.

go_grid->refresh_table_display(
  EXPORTING
    is_stable      = ls_stable
    i_soft_refresh = abap_false ).
```

`IS_STABLE` demande au contrôle de conserver autant que possible la position des lignes et colonnes.

## 🌺 SOFT REFRESH

Un rafraîchissement logiciel conserve certains réglages frontend comme les tris, filtres et totalisations. L’utiliser seulement lorsque les changements apportés sont compatibles avec la conservation de cet état.

## 🌺 CHARGER DE NOUVELLES DONNÉES

```abap
PERFORM select_data CHANGING gt_output.
go_grid->refresh_table_display( is_stable = ls_stable ).
```

Ne pas rappeler `SET_TABLE_FOR_FIRST_DISPLAY` pour chaque rechargement standard.

## 🌺 FLUSH

Le Control Framework gère normalement les échanges frontend. `CL_GUI_CFW=>FLUSH` peut être nécessaire dans certains scénarios documentés ou pour faire remonter immédiatement une erreur frontend, mais ne doit pas être appelé sans raison à chaque instruction.

## 🌺 ERREURS FRÉQUENTES

- remplacer la table interne par une nouvelle référence incompatible ;
- modifier la structure du catalogue sans réinitialisation adaptée ;
- rafraîchir avant `CHECK_CHANGED_DATA` sur une grille éditable ;
- perdre la sélection utilisateur après reconstruction complète du contrôle.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [refresh_table_display — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/0ab5531ed30911d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)

---

➡️ [Chapitre suivant — FONCTIONS CLASSIQUES REUSE ALV](<./22 - 🍧 FONCTIONS CLASSIQUES REUSE ALV.md>)
