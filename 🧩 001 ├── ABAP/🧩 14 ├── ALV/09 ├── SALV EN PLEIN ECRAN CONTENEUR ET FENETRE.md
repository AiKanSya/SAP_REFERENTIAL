# 9. SALV EN PLEIN ÉCRAN, CONTENEUR ET FENÊTRE

## 9.A RÉSULTAT ATTENDU

- Distinguer les modes d’affichage SALV[^terme-acro-salv]
- Afficher un SALV dans un conteneur
- Créer une fenêtre de dialogue simple

## 9.B PLEIN ÉCRAN

Sans conteneur fourni à `FACTORY`, `CL_SALV_TABLE` produit généralement un affichage plein écran adapté aux rapports simples.

## 9.C CONTENEUR

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_salv      TYPE REF TO cl_salv_table.

go_container = NEW cl_gui_custom_container(
  container_name = 'CC_ALV' ).

cl_salv_table=>factory(
  EXPORTING
    r_container  = go_container
  IMPORTING
    r_salv_table = go_salv
  CHANGING
    t_table      = gt_flights ).

go_salv->display( ).
```

Le Dynpro[^terme-dynpro] doit contenir un Custom Control nommé `CC_ALV`. Les références doivent rester vivantes pendant toute la durée d’affichage de l’écran.

## 9.D FENÊTRE DE DIALOGUE

```abap
go_salv->set_screen_popup(
  start_column = 10
  end_column   = 120
  start_line   = 3
  end_line     = 25 ).
```

La fenêtre convient à une consultation courte. Elle ne doit pas être utilisée pour remplacer un écran métier complexe.

## 9.E CHOIX DU MODE

| Mode        | Usage                          |
| ----------- | ------------------------------ |
| Plein écran | Rapport autonome               |
| Conteneur   | Zone ALV[^terme-alv] intégrée à un Dynpro  |
| Fenêtre     | Consultation secondaire courte |

## 9.F PROCESS

### 9.F.1 Étape 1 — Choisir le mode d’affichage

Utiliser le plein écran pour un rapport autonome, un conteneur pour intégrer l’ALV dans un dynpro et une fenêtre de dialogue pour une consultation courte qui ne remplace pas l’écran courant.

### 9.F.2 Étape 2 — Préparer l’écran lorsque le mode utilise un conteneur

Créer le dynpro, le Custom Control et la logique PBO/PAI avant l’instance SALV. Le nom du conteneur ABAP[^terme-abap] doit correspondre exactement au contrôle défini dans Screen Painter.

### 9.F.3 Étape 3 — Créer le conteneur avec une durée de vie suffisante

Conserver les références du conteneur et du SALV dans des attributs ou données globales de l’écran. Ne pas les recréer à chaque passage PBO.

### 9.F.4 Étape 4 — Appeler `FACTORY` avec le contexte choisi

Transmettre la table de sortie et, pour une intégration dans un écran, le conteneur prévu. Configurer ensuite les colonnes, fonctions et événements avant l’affichage.

### 9.F.5 Étape 5 — Régler la fenêtre de dialogue si elle est utilisée

Définir une taille et une position compatibles avec le contenu. Prévoir une commande de fermeture claire et restituer correctement le contrôle à l’écran appelant.

### 9.F.6 Étape 6 — Tester le cycle écran complet

Vérifier le premier affichage, le retour PBO, la navigation arrière, la fermeture et la réouverture. Contrôler qu’aucun conteneur orphelin ni gestionnaire dupliqué n’est créé.

## 9.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 9.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 9.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA:
  go_container TYPE REF TO cl_gui_custom_container,
  go_salv      TYPE REF TO cl_salv_table.

go_container = NEW cl_gui_custom_container(
  container_name = 'CC_ALV' ).

cl_salv_table=>factory(
  EXPORTING
    r_container  = go_container
  IMPORTING
    r_salv_table = go_salv
  CHANGING
    t_table      = gt_flights ).

go_salv->display( ).
```

## 9.J TERMES DU LEXIQUE

- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 9.K RÉFÉRENCES OFFICIELLES SAP

- [ALV Output Display in a Dialog Box — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec24e9e107868bae10000000a42189e.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)

---

[Chapitre suivant — PRINCIPES DE CL_GUI_ALV_GRID](<./10 ├── PRINCIPES DE CL_GUI_ALV_GRID.md>)

[^terme-acro-salv]: **SALV.** Simple ALV / famille de classes `CL_SALV_*`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
