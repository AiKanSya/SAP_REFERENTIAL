# 16. BARRE D’OUTILS ET COMMANDES PERSONNALISÉES

## 16.A RÉSULTAT ATTENDU

- Ajouter un bouton à la toolbar
- Traiter une commande utilisateur
- Exclure des fonctions standard

## 16.B ÉVÉNEMENT TOOLBAR

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

La méthode[^terme-methode] doit être déclarée pour l’événement `TOOLBAR` de `CL_GUI_ALV_GRID` avec les paramètres `E_OBJECT` et `E_INTERACTIVE`.

## 16.C TRAITER LA COMMANDE

```abap
METHOD handle_user_command.
  CASE e_ucomm.
    WHEN 'ZSAVE'.
      go_grid->check_changed_data( ).
      PERFORM save_changes.
  ENDCASE.
ENDMETHOD.
```

## 16.D EXCLURE DES FONCTIONS

La table `IT_TOOLBAR_EXCLUDING` de `SET_TABLE_FOR_FIRST_DISPLAY` permet de masquer certaines fonctions standard. Utiliser les constantes de `CL_GUI_ALV_GRID` lorsque disponibles plutôt que des codes littéraux.

## 16.E RÈGLES

- Utiliser un code fonction spécifique au développement client.
- Éviter de réutiliser un code standard existant.
- Désactiver ou masquer une action impossible dans le contexte courant.
- Afficher une confirmation avant une action destructive.
- Vérifier les autorisations dans le backend[^terme-backend], pas uniquement dans la toolbar.

## 16.F PROCESS

### 16.F.1 Étape 1 — Déclarer les deux gestionnaires nécessaires

Déclarer une méthode pour l’événement `TOOLBAR` et une méthode pour `USER_COMMAND`, avec les signatures exactes de `CL_GUI_ALV_GRID`.

### 16.F.2 Étape 2 — Ajouter le bouton dans `TOOLBAR`

Créer une entrée de bouton avec un code fonction unique, un texte, une info-bulle et une icône standard si elle apporte une information utile. Ajouter un séparateur uniquement lorsqu’il clarifie le groupe de commandes.

### 16.F.3 Étape 3 — Enregistrer les gestionnaires une seule fois

Instancier la classe[^terme-classe] réceptrice, exécuter `SET HANDLER` pour les deux événements puis déclencher l’affichage initial. Conserver la référence du gestionnaire.

### 16.F.4 Étape 4 — Traiter une liste fermée de commandes

Dans `USER_COMMAND`, utiliser `CASE E_UCOMM`. Ignorer ou journaliser les codes inconnus ; ne jamais transformer directement un code reçu en nom de programme ou de fonction dynamique.

### 16.F.5 Étape 5 — Protéger l’action métier

Vérifier la sélection, relire la clé métier, exécuter les contrôles d’autorisation et demander une confirmation pour une action destructive.

### 16.F.6 Étape 6 — Tester la barre d’outils

Contrôler le bouton actif, inactif, sans sélection et avec plusieurs sélections. Vérifier que les fonctions standard exclues ne restent pas accessibles par un autre chemin non prévu.

## 16.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 16.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV[^terme-alv].
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 16.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 16.J TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 16.K RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)

---

[Chapitre suivant — HOTSPOTS, DOUBLE-CLIC ET BOUTONS](<./17 ├── HOTSPOTS DOUBLE CLIC ET BOUTONS.md>)

[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-backend]: **BACKEND.** Système serveur qui exécute la logique ABAP et accède aux données. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#backend>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
