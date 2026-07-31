# 🌸 ÉDITION DES CELLULES

## 🌺 OBJECTIFS

- Rendre une colonne modifiable
- Activer le mode de saisie
- Synchroniser les données saisies avec la table ABAP

## 🌺 CATALOGUE ÉDITABLE

```abap
gs_fieldcat-fieldname = 'QUANTITY'.
gs_fieldcat-coltext   = 'Quantité'.
gs_fieldcat-edit      = abap_true.
gs_fieldcat-qfieldname = 'UNIT'.
APPEND gs_fieldcat TO gt_fieldcat.
```

Le layout peut également activer l’édition de manière générale :

```abap
gs_layout-edit = abap_true.
```

Le contrôle précis doit rester dans le catalogue ou dans les styles de cellule.

## 🌺 ENREGISTRER LES ÉVÉNEMENTS D’ÉDITION

```abap
CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_modified.

CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_enter.
```

## 🌺 RÉCUPÉRER LES MODIFICATIONS

Avant une sauvegarde ou un traitement dépendant des saisies :

```abap
go_grid->check_changed_data( ).
```

Cette méthode demande au contrôle de transférer les valeurs en cours d’édition et de déclencher les validations associées.

## 🌺 RESPONSABILITÉ DE SAUVEGARDE

Rendre une cellule éditable ne met pas à jour la base. Le programme doit :

1. valider la valeur ;
2. contrôler les autorisations ;
3. détecter les conflits éventuels ;
4. appeler l’API métier appropriée ;
5. exécuter ou déléguer la gestion transactionnelle ;
6. informer l’utilisateur.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Making ALV React to Changed Data — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353523611.html)
- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)

---

➡️ [Chapitre suivant — VALIDATION AVEC DATA_CHANGED](<./19 - 🍧 VALIDATION AVEC DATA_CHANGED.md>)
