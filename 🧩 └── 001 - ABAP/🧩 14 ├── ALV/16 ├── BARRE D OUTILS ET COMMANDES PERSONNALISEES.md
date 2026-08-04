# BARRE D’OUTILS ET COMMANDES PERSONNALISÉES

## RÉSULTAT ATTENDU

- Ajouter un bouton à la toolbar
- Traiter une commande utilisateur
- Exclure des fonctions standard

## ÉVÉNEMENT TOOLBAR

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

## TRAITER LA COMMANDE

```abap
METHOD handle_user_command.
  CASE e_ucomm.
    WHEN 'ZSAVE'.
      go_grid->check_changed_data( ).
      PERFORM save_changes.
  ENDCASE.
ENDMETHOD.
```

## EXCLURE DES FONCTIONS

La table `IT_TOOLBAR_EXCLUDING` de `SET_TABLE_FOR_FIRST_DISPLAY` permet de masquer certaines fonctions standard. Utiliser les constantes de `CL_GUI_ALV_GRID` lorsque disponibles plutôt que des codes littéraux.

## RÈGLES

- Utiliser un code fonction spécifique au développement client.
- Éviter de réutiliser un code standard existant.
- Désactiver ou masquer une action impossible dans le contexte courant.
- Afficher une confirmation avant une action destructive.
- Vérifier les autorisations dans le backend, pas uniquement dans la toolbar.

## PROCESS

### Étape 1 — Déclarer les deux gestionnaires nécessaires

Déclarer une méthode pour l’événement `TOOLBAR` et une méthode pour `USER_COMMAND`, avec les signatures exactes de `CL_GUI_ALV_GRID`.

### Étape 2 — Ajouter le bouton dans `TOOLBAR`

Créer une entrée de bouton avec un code fonction unique, un texte, une info-bulle et une icône standard si elle apporte une information utile. Ajouter un séparateur uniquement lorsqu’il clarifie le groupe de commandes.

### Étape 3 — Enregistrer les gestionnaires une seule fois

Instancier la classe réceptrice, exécuter `SET HANDLER` pour les deux événements puis déclencher l’affichage initial. Conserver la référence du gestionnaire.

### Étape 4 — Traiter une liste fermée de commandes

Dans `USER_COMMAND`, utiliser `CASE E_UCOMM`. Ignorer ou journaliser les codes inconnus ; ne jamais transformer directement un code reçu en nom de programme ou de fonction dynamique.

### Étape 5 — Protéger l’action métier

Vérifier la sélection, relire la clé métier, exécuter les contrôles d’autorisation et demander une confirmation pour une action destructive.

### Étape 6 — Tester la barre d’outils

Contrôler le bouton actif, inactif, sans sélection et avec plusieurs sélections. Vérifier que les fonctions standard exclues ne restent pas accessibles par un autre chemin non prévu.

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

## TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)

---

[Chapitre suivant — HOTSPOTS, DOUBLE-CLIC ET BOUTONS](<./17 ├── HOTSPOTS DOUBLE CLIC ET BOUTONS.md>)
