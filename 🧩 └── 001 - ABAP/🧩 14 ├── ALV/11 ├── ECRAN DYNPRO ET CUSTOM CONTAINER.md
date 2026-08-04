# ÉCRAN DYNPRO ET CUSTOM CONTAINER

## RÉSULTAT ATTENDU

- Préparer un Dynpro pour l’ALV Grid
- Créer le conteneur et la grille
- Gérer le cycle PBO et PAI

## PROCESS

### Étape 1 — Créer le dynpro 0100

Ouvrir le programme ou module pool dans `SE80`, développer **Écrans**, créer `0100` et conserver le type d’écran normal. Renseigner une description et vérifier qu’aucun écran du programme n’utilise déjà ce numéro.

### Étape 2 — Ajouter le Custom Control

Ouvrir le Layout dans Screen Painter, sélectionner **Custom Control**, tracer sa zone puis saisir `CC_ALV` comme nom technique. Enregistrer et vérifier dans la liste des éléments que le nom ne contient ni espace ni variante de casse.

### Étape 3 — Définir la logique de flux

Dans la flow logic, ajouter `MODULE status_0100 OUTPUT` sous `PROCESS BEFORE OUTPUT` et `MODULE user_command_0100 INPUT` sous `PROCESS AFTER INPUT`. Créer les modules dans les includes PBO/PAI prévus par le programme.

### Étape 4 — Créer le statut GUI

Créer `STATUS_0100` dans Menu Painter. Ajouter au minimum `BACK`, `EXIT` et `CANC`, puis affecter les touches standards correspondantes. Créer aussi le titre si le programme l’utilise.

### Étape 5 — Relier le champ OK_CODE

Déclarer `GV_OKCODE TYPE SY-UCOMM`, puis affecter ce nom dans les attributs de l’écran lorsque le dynpro requiert un champ OK_CODE explicite. Le code reçu doit être copié ou traité puis vidé dans le PAI.

## DONNÉES GLOBALES

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_grid      TYPE REF TO cl_gui_alv_grid,
  gv_okcode    TYPE sy-ucomm.
```

## PBO

```abap
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.

  IF go_container IS NOT BOUND.
    go_container = NEW cl_gui_custom_container(
      container_name = 'CC_ALV' ).

    go_grid = NEW cl_gui_alv_grid(
      i_parent = go_container ).

    PERFORM display_grid.
  ENDIF.
ENDMODULE.
```

## PAI

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

## ERREURS FRÉQUENTES

- nom du Custom Control différent de `CONTAINER_NAME` ;
- références déclarées localement puis détruites ;
- création de la grille à chaque PBO ;
- appel d’affichage avant l’instanciation du conteneur ;
- statut GUI absent ou code fonction non traité.

## PROCESS

### Étape 1 — Déclarer les références avec une durée suffisante

Placer `GO_CONTAINER`, `GO_GRID` et `GV_OKCODE` dans les données globales du programme ou de l’instance contrôleur qui survit aux cycles PBO/PAI. Des variables locales au PBO seraient détruites après le module.

### Étape 2 — Instancier une seule fois dans le PBO

Dans `STATUS_0100`, exécuter `SET PF-STATUS`, puis tester `GO_CONTAINER IS NOT BOUND`. Créer `CL_GUI_CUSTOM_CONTAINER` avec `CONTAINER_NAME = 'CC_ALV'`, exactement identique au nom du Screen Painter.

### Étape 3 — Créer la grille et afficher les données

Instancier `CL_GUI_ALV_GRID` avec `I_PARENT = GO_CONTAINER`, puis appeler la routine d’affichage seulement après la création. Lors des PBO suivants, ne recréer ni container ni grille ; utiliser les méthodes de rafraîchissement prévues.

### Étape 4 — Traiter la navigation dans le PAI

Pour `BACK`, `EXIT` et `CANC`, quitter l’écran avec la séquence adaptée au programme. Vider `GV_OKCODE` après traitement afin d’éviter la répétition de la commande au cycle suivant.

### Étape 5 — Activer dans l’ordre

Contrôler puis activer programme, includes, écran, statut GUI et titre. Si le dynpro reste inactif, ouvrir son journal et corriger le premier sous-objet signalé.

### Étape 6 — Tester le cycle complet

Ouvrir `0100`, vérifier l’affichage, provoquer un second PBO et confirmer que les références restent identiques. Tester les trois commandes de sortie. La mise en place est validée lorsque l’ALV apparaît une seule fois et que l’écran se ferme sans dump ni contrôle orphelin.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.

  IF go_container IS NOT BOUND.
    go_container = NEW cl_gui_custom_container(
      container_name = 'CC_ALV' ).

    go_grid = NEW cl_gui_alv_grid(
      i_parent = go_container ).

    PERFORM display_grid.
  ENDIF.
ENDMODULE.
```

## TERMES DU LEXIQUE

- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Getting Started with ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4eba23f5250f568be10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

[Chapitre suivant — TABLE DE SORTIE ET CATALOGUE DE CHAMPS](<./12 ├── TABLE DE SORTIE ET CATALOGUE DE CHAMPS.md>)
