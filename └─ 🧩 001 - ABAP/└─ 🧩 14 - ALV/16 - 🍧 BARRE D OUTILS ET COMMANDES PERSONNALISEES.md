# 🌸 BARRE D’OUTILS ET COMMANDES PERSONNALISÉES

## 🌺 OBJECTIFS

- Ajouter un bouton à la toolbar
- Traiter une commande utilisateur
- Exclure des fonctions standard

## 🌺 ÉVÉNEMENT TOOLBAR

```abap
METHOD handle_toolbar.
  DATA ls_button TYPE stb_button.

  CLEAR ls_button.
  ls_button-function  = 'ZSAVE'.
  ls_button-icon      = icon_system_save.
  ls_button-quickinfo = 'Enregistrer'.
  ls_button-text      = 'Enregistrer'.
  APPEND ls_button TO e_object->mt_toolbar.
ENDMETHOD.
```

La méthode doit être déclarée pour l’événement `TOOLBAR` de `CL_GUI_ALV_GRID` avec les paramètres `E_OBJECT` et `E_INTERACTIVE`.

## 🌺 TRAITER LA COMMANDE

```abap
METHOD handle_user_command.
  CASE e_ucomm.
    WHEN 'ZSAVE'.
      go_grid->check_changed_data( ).
      PERFORM save_changes.
  ENDCASE.
ENDMETHOD.
```

## 🌺 EXCLURE DES FONCTIONS

La table `IT_TOOLBAR_EXCLUDING` de `SET_TABLE_FOR_FIRST_DISPLAY` permet de masquer certaines fonctions standard. Utiliser les constantes de `CL_GUI_ALV_GRID` lorsque disponibles plutôt que des codes littéraux.

## 🌺 RÈGLES

- Utiliser un code fonction spécifique au développement client.
- Éviter de réutiliser un code standard existant.
- Désactiver ou masquer une action impossible dans le contexte courant.
- Afficher une confirmation avant une action destructive.
- Vérifier les autorisations dans le backend, pas uniquement dans la toolbar.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)

---

➡️ [Chapitre suivant — HOTSPOTS, DOUBLE-CLIC ET BOUTONS](<./17 - 🍧 HOTSPOTS DOUBLE CLIC ET BOUTONS.md>)
