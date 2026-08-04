# 15. ÉVÉNEMENTS ET CLASSE RÉCEPTRICE

## 15.A RÉSULTAT ATTENDU

- Créer une classe[^terme-classe] de gestion des événements
- Enregistrer les handlers avant l’affichage
- Organiser le traitement des interactions

## 15.B DÉFINITION

```abap
CLASS lcl_event_receiver DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row e_column es_row_no.

    METHODS handle_user_command
      FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING e_ucomm.
ENDCLASS.
```

## 15.C IMPLÉMENTATION

```abap
CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
    IF sy-subrc = 0.
      MESSAGE |Ligne { es_row_no-row_id }| TYPE 'S'.
    ENDIF.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'ZREFRESH'.
        PERFORM reload_data.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
```

## 15.D ENREGISTREMENT

```abap
DATA(go_receiver) = NEW lcl_event_receiver( ).
SET HANDLER go_receiver->handle_double_click FOR go_grid.
SET HANDLER go_receiver->handle_user_command FOR go_grid.
```

Conserver la référence `GO_RECEIVER`. Une instance locale détruite à la fin d’une procédure ne doit pas être utilisée comme gestionnaire permanent.

## 15.E ORGANISATION

Le handler doit :

1. interpréter l’événement ;
2. valider la sélection ;
3. déléguer la règle métier[^terme-regle-metier] à une procédure ou une classe dédiée ;
4. actualiser l’affichage si nécessaire.

## 15.F PROCESS

### 15.F.1 Étape 1 — Sélectionner les événements nécessaires

Lister les interactions réellement gérées : double-clic, hotspot, commande, modification de données ou menu contextuel. Ne pas enregistrer un événement sans traitement fonctionnel défini.

### 15.F.2 Étape 2 — Déclarer la classe réceptrice

Pour chaque événement, déclarer une méthode[^terme-methode] `FOR EVENT ... OF CL_GUI_ALV_GRID` avec sa signature exacte. Conserver les règles métier hors de cette méthode lorsque le traitement devient complexe.

### 15.F.3 Étape 3 — Implémenter les validations d’entrée

Contrôler les indices de ligne et de colonne reçus avant de lire la table. Résoudre ensuite la clé métier et vérifier les autorisations avant l’action.

### 15.F.4 Étape 4 — Instancier la classe avec une durée de vie suffisante

Stocker la référence du gestionnaire avec les références du conteneur et de la grille. Une instance locale détruite à la fin du PBO ne doit pas porter les événements de l’écran.

### 15.F.5 Étape 5 — Enregistrer les méthodes avant l’affichage

Exécuter `SET HANDLER ... FOR go_grid` après la création de la grille et avant l’interaction utilisateur. Ne pas répéter cet enregistrement à chaque PBO.

### 15.F.6 Étape 6 — Tester chaque événement isolément

Tester les lignes valides, une table vide, les commandes inconnues et les interactions après tri ou filtre. Vérifier qu’une action n’est déclenchée qu’une seule fois.

## 15.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 15.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV[^terme-alv].
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 15.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_double_click.
    READ TABLE gt_output INDEX es_row_no-row_id INTO DATA(ls_output).
    IF sy-subrc = 0.
      MESSAGE |Ligne { es_row_no-row_id }| TYPE 'S'.
    ENDIF.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'ZREFRESH'.
        PERFORM reload_data.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
```

## 15.J TERMES DU LEXIQUE

- [Classe](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 15.K RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)

---

[Chapitre suivant — BARRE D’OUTILS ET COMMANDES PERSONNALISÉES](<./16 ├── BARRE D OUTILS ET COMMANDES PERSONNALISEES.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-regle-metier]: **RÈGLE MÉTIER.** Condition ou calcul imposé par le processus fonctionnel. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#regle-metier>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
