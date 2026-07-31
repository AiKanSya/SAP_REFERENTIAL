# 🌸 ÉCRAN DYNPRO ET CUSTOM CONTAINER

## 🌺 OBJECTIFS

- Préparer un Dynpro pour l’ALV Grid
- Créer le conteneur et la grille
- Gérer le cycle PBO et PAI

## 🌺 CRÉER L’ÉCRAN

Dans `SE51` ou depuis `SE80` :

1. créer l’écran `0100` ;
2. ajouter un Custom Control ;
3. lui attribuer le nom `CC_ALV` ;
4. définir un statut GUI avec une fonction de retour ;
5. créer les modules PBO et PAI.

## 🌺 DONNÉES GLOBALES

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_grid      TYPE REF TO cl_gui_alv_grid,
  gv_okcode    TYPE sy-ucomm.
```

## 🌺 PBO

```abap
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.

  IF go_container IS NOT BOUND.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_container.

    PERFORM display_grid.
  ENDIF.
ENDMODULE.
```

## 🌺 PAI

```abap
MODULE user_command_0100 INPUT.
  CASE gv_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.
  ENDCASE.

  CLEAR gv_okcode.
ENDMODULE.
```

Lorsque l’application utilise les événements du Control Framework, intégrer la distribution prévue par le framework dans le PAI selon le modèle de l’application.

## 🌺 ERREURS FRÉQUENTES

- nom du Custom Control différent de `CONTAINER_NAME` ;
- références déclarées localement puis détruites ;
- création de la grille à chaque PBO ;
- appel d’affichage avant l’instanciation du conteneur ;
- statut GUI absent ou code fonction non traité.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Getting Started with ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4eba23f5250f568be10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

➡️ [Chapitre suivant — TABLE DE SORTIE ET CATALOGUE DE CHAMPS](<./12 - 🍧 TABLE DE SORTIE ET CATALOGUE DE CHAMPS.md>)
