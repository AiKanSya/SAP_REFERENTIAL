# 11. ÉCRAN DYNPRO ET CUSTOM CONTAINER

## 11.A RÉSULTAT ATTENDU

- Préparer un Dynpro[^terme-dynpro] pour l’ALV[^terme-alv] Grid
- Créer le conteneur et la grille
- Gérer le cycle PBO et PAI

## 11.B PROCESS

### 11.B.1 Étape 1 — Créer le dynpro 0100

Ouvrir le programme ou module pool[^terme-module-pool] dans `SE80`[^outil-se80], développer **Écrans**, créer `0100` et conserver le type d’écran normal. Renseigner une description et vérifier qu’aucun écran du programme n’utilise déjà ce numéro.

### 11.B.2 Étape 2 — Ajouter le Custom Control

Ouvrir le Layout dans Screen Painter, sélectionner **Custom Control**, tracer sa zone puis saisir `CC_ALV` comme nom technique. Enregistrer et vérifier dans la liste des éléments que le nom ne contient ni espace ni variante de casse.

### 11.B.3 Étape 3 — Définir la logique de flux

Dans la flow logic, ajouter `MODULE status_0100 OUTPUT` sous `PROCESS BEFORE OUTPUT` et `MODULE user_command_0100 INPUT` sous `PROCESS AFTER INPUT`. Créer les modules dans les includes PBO/PAI prévus par le programme.

### 11.B.4 Étape 4 — Créer le statut GUI

Créer `STATUS_0100` dans Menu Painter. Ajouter au minimum `BACK`, `EXIT` et `CANC`, puis affecter les touches standards correspondantes. Créer aussi le titre si le programme l’utilise.

### 11.B.5 Étape 5 — Relier le champ OK_CODE

Déclarer `GV_OKCODE TYPE SY-UCOMM`, puis affecter ce nom dans les attributs de l’écran lorsque le dynpro requiert un champ OK_CODE explicite. Le code reçu doit être copié ou traité puis vidé dans le PAI.

## 11.C DONNÉES GLOBALES

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_grid      TYPE REF TO cl_gui_alv_grid,
  gv_okcode    TYPE sy-ucomm.
```

## 11.D PBO

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

## 11.E PAI

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

## 11.F ERREURS FRÉQUENTES

- nom du Custom Control différent de `CONTAINER_NAME` ;
- références déclarées localement puis détruites ;
- création de la grille à chaque PBO ;
- appel d’affichage avant l’instanciation du conteneur ;
- statut GUI[^terme-acro-gui] absent ou code fonction non traité.

## 11.G PROCESS

### 11.G.1 Étape 1 — Déclarer les références avec une durée suffisante

Placer `GO_CONTAINER`, `GO_GRID` et `GV_OKCODE` dans les données globales du programme ou de l’instance contrôleur qui survit aux cycles PBO/PAI. Des variables locales au PBO seraient détruites après le module.

### 11.G.2 Étape 2 — Instancier une seule fois dans le PBO

Dans `STATUS_0100`, exécuter `SET PF-STATUS`, puis tester `GO_CONTAINER IS NOT BOUND`. Créer `CL_GUI_CUSTOM_CONTAINER` avec `CONTAINER_NAME = 'CC_ALV'`, exactement identique au nom du Screen Painter.

### 11.G.3 Étape 3 — Créer la grille et afficher les données

Instancier `CL_GUI_ALV_GRID` avec `I_PARENT = GO_CONTAINER`, puis appeler la routine d’affichage seulement après la création. Lors des PBO suivants, ne recréer ni container ni grille ; utiliser les méthodes de rafraîchissement prévues.

### 11.G.4 Étape 4 — Traiter la navigation dans le PAI

Pour `BACK`, `EXIT` et `CANC`, quitter l’écran avec la séquence adaptée au programme. Vider `GV_OKCODE` après traitement afin d’éviter la répétition de la commande au cycle suivant.

### 11.G.5 Étape 5 — Activer dans l’ordre

Contrôler puis activer programme, includes, écran, statut GUI et titre. Si le dynpro reste inactif, ouvrir son journal et corriger le premier sous-objet signalé.

### 11.G.6 Étape 6 — Tester le cycle complet

Ouvrir `0100`, vérifier l’affichage, provoquer un second PBO et confirmer que les références restent identiques. Tester les trois commandes de sortie. La mise en place est validée lorsque l’ALV apparaît une seule fois et que l’écran se ferme sans dump ni contrôle orphelin.

## 11.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 11.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 11.J TERMES DU LEXIQUE

- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 11.K RÉFÉRENCES OFFICIELLES SAP

- [Getting Started with ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4eba23f5250f568be10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

[Chapitre suivant — TABLE DE SORTIE ET CATALOGUE DE CHAMPS](<./12 ├── TABLE DE SORTIE ET CATALOGUE DE CHAMPS.md>)

[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-module-pool]: **MODULE POOL.** Programme ABAP classique pilotant des dynpros au moyen de modules PBO et PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-pool>).
[^terme-acro-gui]: **GUI.** Graphical User Interface. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-gui>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
