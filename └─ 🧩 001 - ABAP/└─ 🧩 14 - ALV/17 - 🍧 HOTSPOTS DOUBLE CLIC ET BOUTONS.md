# 🌸 HOTSPOTS, DOUBLE-CLIC ET BOUTONS

## 🌺 OBJECTIFS

- Rendre une colonne cliquable
- Traiter un double-clic
- Afficher des boutons au niveau cellule

## 🌺 HOTSPOT

Dans le catalogue :

```abap
gs_fieldcat-fieldname = 'VBELN'.
gs_fieldcat-coltext   = 'Commande'.
gs_fieldcat-hotspot   = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

Gestionnaire :

```abap
METHOD handle_hotspot_click.
  READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
  CHECK sy-subrc = 0.

  SET PARAMETER ID 'AUN' FIELD ls_output-vbeln.
  CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
ENDMETHOD.
```

Avant tout `CALL TRANSACTION`, vérifier le contexte, la valeur et les autorisations nécessaires.

## 🌺 DOUBLE-CLIC

Le double-clic est utile pour une navigation générale sur la ligne. Un hotspot est préférable lorsqu’une colonne précise représente explicitement une navigation.

## 🌺 BOUTON DE CELLULE

Une cellule peut être configurée avec un style bouton. Le traitement repose ensuite sur l’événement correspondant et sur l’identification de la ligne et de la colonne.

## 🌺 CHOIX

| Interaction | Utilisation                                |
| ----------- | ------------------------------------------ |
| Hotspot     | Navigation associée à une valeur précise   |
| Double-clic | Action principale sur une ligne            |
| Bouton      | Action explicite visible dans chaque ligne |

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Displaying Interactive Elements — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1afd0087c2b91e10000000a42189d.html)
- [Handling Single and Double Clicks — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ebc7038f39c68bbe10000000a42189e.html)

---

➡️ [Chapitre suivant — ÉDITION DES CELLULES](<./18 - 🍧 EDITION DES CELLULES.md>)
