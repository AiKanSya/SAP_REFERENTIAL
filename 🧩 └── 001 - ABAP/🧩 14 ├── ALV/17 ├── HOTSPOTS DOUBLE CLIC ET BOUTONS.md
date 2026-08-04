# HOTSPOTS, DOUBLE-CLIC ET BOUTONS

## RÉSULTAT ATTENDU

- Rendre une colonne cliquable
- Traiter un double-clic
- Afficher des boutons au niveau cellule

## HOTSPOT

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

## DOUBLE-CLIC

Le double-clic est utile pour une navigation générale sur la ligne. Un hotspot est préférable lorsqu’une colonne précise représente explicitement une navigation.

## BOUTON DE CELLULE

Une cellule peut être configurée avec un style bouton. Le traitement repose ensuite sur l’événement correspondant et sur l’identification de la ligne et de la colonne.

## CHOIX

| Interaction | Utilisation                                |
| ----------- | ------------------------------------------ |
| Hotspot     | Navigation associée à une valeur précise   |
| Double-clic | Action principale sur une ligne            |
| Bouton      | Action explicite visible dans chaque ligne |

## PROCESS

### Étape 1 — Choisir l’interaction la moins ambiguë

Utiliser un hotspot pour une navigation liée à une colonne, le double-clic pour une action sur la ligne et un bouton de cellule pour une commande explicitement visible.

### Étape 2 — Configurer la colonne

Activer `HOTSPOT` dans le catalogue pour un lien. Pour un bouton, fournir le style de cellule attendu dans la table de sortie et relier le champ de styles au layout.

### Étape 3 — Déclarer les gestionnaires exacts

Déclarer les méthodes d’événement avec les paramètres de ligne et de colonne fournis par la grille, puis les enregistrer sur l’instance `CL_GUI_ALV_GRID`.

### Étape 4 — Valider la position reçue

Refuser un indice initial ou hors limites. Lire la ligne correspondante dans la table affichée, puis utiliser sa clé métier plutôt que la valeur formatée de la cellule.

### Étape 5 — Exécuter l’action protégée

Contrôler les autorisations et l’état courant de l’objet avant de naviguer ou de modifier. Une cellule interactive ne constitue pas un contrôle d’accès.

### Étape 6 — Tester chaque mode d’interaction

Tester une ligne valide, une table vide, un clic sur une autre colonne et l’affichage après tri ou filtre. Vérifier l’absence de double déclenchement entre hotspot et double-clic.

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
METHOD handle_hotspot_click.
  READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
  CHECK sy-subrc = 0.

  SET PARAMETER ID 'AUN' FIELD ls_output-vbeln.
  CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
ENDMETHOD.
```

## TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Displaying Interactive Elements — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1afd0087c2b91e10000000a42189d.html)
- [Handling Single and Double Clicks — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ebc7038f39c68bbe10000000a42189e.html)

---

[Chapitre suivant — ÉDITION DES CELLULES](<./18 ├── EDITION DES CELLULES.md>)
