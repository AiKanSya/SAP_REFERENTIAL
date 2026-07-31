# 🌸 AFFICHAGE, MISE EN FORME ET LAYOUT SALV

## 🌺 OBJECTIFS

- Configurer les paramètres d’affichage
- Activer les variantes utilisateur
- Ajouter un titre et des réglages visuels

## 🌺 PARAMÈTRES D’AFFICHAGE

```abap
DATA lo_display TYPE REF TO cl_salv_display_settings.

lo_display = go_alv->get_display_settings( ).
lo_display->set_striped_pattern( abap_true ).
lo_display->set_list_header( 'Liste des vols' ).
```

## 🌺 VARIANTES DE MISE EN PAGE

```abap
DATA:
  lo_layout TYPE REF TO cl_salv_layout,
  ls_key    TYPE salv_s_layout_key.

ls_key-report = sy-repid.

lo_layout = go_alv->get_layout( ).
lo_layout->set_key( ls_key ).
lo_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
lo_layout->set_default( abap_true ).
```

La clé de layout identifie le contexte de sauvegarde. Elle doit rester stable entre deux exécutions du même rapport.

## 🌺 SÉLECTION DES LIGNES

```abap
DATA lo_selections TYPE REF TO cl_salv_selections.

lo_selections = go_alv->get_selections( ).
lo_selections->set_selection_mode( if_salv_c_selection_mode=>row_column ).
```

Le programme doit toujours relire la sélection au moment de l’action. Ne pas conserver des numéros de lignes si la liste peut être triée ou filtrée entre-temps.

## 🌺 PRINCIPES DE PRÉSENTATION

- Préférer les textes issus du DDIC.
- Ne pas surcharger les couleurs.
- Positionner les clés et identifiants à gauche.
- Afficher les montants avec devise et les quantités avec unité.
- Ne pas utiliser une variante pour contourner un défaut de conception du catalogue.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)
- [Columns (General) — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1e9df087c2b91e10000000a42189d.html)

---

➡️ [Chapitre suivant — ÉVÉNEMENTS ET INTERACTIONS SALV](<./08 - 🍧 EVENEMENTS ET INTERACTIONS SALV.md>)
