# 7. AFFICHAGE, MISE EN FORME ET LAYOUT SALV

## 7.A RÉSULTAT ATTENDU

- Configurer les paramètres d’affichage
- Activer les variantes utilisateur
- Ajouter un titre et des réglages visuels

## 7.B PARAMÈTRES D’AFFICHAGE

```abap
DATA lo_display TYPE REF TO cl_salv_display_settings.

lo_display = go_alv->get_display_settings( ).
lo_display->set_striped_pattern( abap_true ).
lo_display->set_list_header( 'Liste des vols' ).
```

## 7.C VARIANTES DE MISE EN PAGE

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

## 7.D SÉLECTION DES LIGNES

```abap
DATA lo_selections TYPE REF TO cl_salv_selections.

lo_selections = go_alv->get_selections( ).
lo_selections->set_selection_mode( if_salv_c_selection_mode=>row_column ).
```

Le programme doit toujours relire la sélection au moment de l’action. Ne pas conserver des numéros de lignes si la liste peut être triée ou filtrée entre-temps.

## 7.E PRINCIPES DE PRÉSENTATION

- Préférer les textes issus du DDIC.
- Ne pas surcharger les couleurs.
- Positionner les clés et identifiants à gauche.
- Afficher les montants avec devise et les quantités avec unité.
- Ne pas utiliser une variante pour contourner un défaut de conception du catalogue.

## 7.F PROCESS

### 7.F.1 Étape 1 — Configurer les paramètres d’affichage

Récupérer `GET_DISPLAY_SETTINGS`. Définir uniquement les options utiles, par exemple les lignes alternées et l’en-tête de liste.

### 7.F.2 Étape 2 — Définir une clé de layout stable

Récupérer `GET_LAYOUT`, remplir une clé stable — généralement fondée sur le programme — puis transmettre cette clé avec `SET_KEY`. La même clé doit désigner le même affichage entre deux exécutions.

### 7.F.3 Étape 3 — Régler la sauvegarde des variantes

Appliquer la restriction de sauvegarde conforme au projet. Distinguer les variantes utilisateur des variantes globales et vérifier les autorisations associées.

### 7.F.4 Étape 4 — Choisir le mode de sélection

Récupérer `GET_SELECTIONS` et définir le mode correspondant aux actions disponibles : aucune sélection, cellule, ligne simple ou lignes multiples.

### 7.F.5 Étape 5 — Tester la persistance et l’accessibilité

Créer, recharger et supprimer une variante avec un utilisateur autorisé. Vérifier aussi qu’une information portée par une couleur reste compréhensible par un texte, une icône ou une colonne de statut.

## 7.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 7.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 7.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 7.J TERMES DU LEXIQUE

- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 7.K RÉFÉRENCES OFFICIELLES SAP

- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)
- [Columns (General) — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1e9df087c2b91e10000000a42189d.html)

---

[Chapitre suivant — ÉVÉNEMENTS ET INTERACTIONS SALV](<./08 ├── EVENEMENTS ET INTERACTIONS SALV.md>)
