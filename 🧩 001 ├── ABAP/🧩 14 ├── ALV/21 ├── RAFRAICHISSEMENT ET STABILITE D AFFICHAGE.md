# 21. RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE

## 21.A RÉSULTAT ATTENDU

- Actualiser les données sans recréer la grille
- Conserver la position de défilement
- Comprendre le rafraîchissement logiciel

## 21.B RAFRAÎCHIR

```abap
DATA ls_stable TYPE lvc_s_stbl.

ls_stable-row = abap_true.
ls_stable-col = abap_true.

go_grid->refresh_table_display(
  EXPORTING
    is_stable      = ls_stable
    i_soft_refresh = abap_false ).
```

`IS_STABLE` demande au contrôle de conserver autant que possible la position des lignes et colonnes.

## 21.C SOFT REFRESH

Un rafraîchissement logiciel conserve certains réglages frontend[^terme-frontend] comme les tris, filtres et totalisations. L’utiliser seulement lorsque les changements apportés sont compatibles avec la conservation de cet état.

## 21.D CHARGER DE NOUVELLES DONNÉES

```abap
PERFORM select_data CHANGING gt_output.
go_grid->refresh_table_display( is_stable = ls_stable ).
```

Ne pas rappeler `SET_TABLE_FOR_FIRST_DISPLAY` pour chaque rechargement standard.

## 21.E FLUSH

Le Control Framework gère normalement les échanges frontend. `CL_GUI_CFW=>FLUSH` peut être nécessaire dans certains scénarios documentés ou pour faire remonter immédiatement une erreur frontend, mais ne doit pas être appelé sans raison à chaque instruction.

## 21.F ERREURS FRÉQUENTES

- remplacer la table interne[^terme-table-interne] par une nouvelle référence incompatible ;
- modifier la structure du catalogue sans réinitialisation adaptée ;
- rafraîchir avant `CHECK_CHANGED_DATA` sur une grille éditable ;
- perdre la sélection utilisateur après reconstruction complète du contrôle.

## 21.G PROCESS

### 21.G.1 Étape 1 — Mettre à jour la table déjà liée à la grille

Modifier ou recharger la table de sortie transmise lors du premier affichage. Ne pas remplacer sans nécessité son contrat de structure.

### 21.G.2 Étape 2 — Finaliser une saisie active

Pour une grille éditable, appeler `CHECK_CHANGED_DATA` avant de relire ou remplacer les données. Arrêter le rafraîchissement si la validation signale une erreur bloquante.

### 21.G.3 Étape 3 — Préparer la stabilité de l’affichage

Remplir `LVC_S_STBL` pour conserver la ligne et la colonne visibles lorsque le scénario l’exige. La stabilité visuelle ne garantit pas que la sélection métier reste valide après rechargement.

### 21.G.4 Étape 4 — Appeler `REFRESH_TABLE_DISPLAY`

Transmettre la structure de stabilité. Utiliser le rafraîchissement léger uniquement lorsque la structure et le catalogue ne changent pas.

### 21.G.5 Étape 5 — Synchroniser le frontend si nécessaire

Appeler `CL_GUI_CFW=>FLUSH` uniquement lorsqu’une synchronisation explicite du Control Framework est requise par le scénario. Traiter les exceptions au lieu de multiplier les appels systématiques.

### 21.G.6 Étape 6 — Tester la conservation du contexte

Vérifier le curseur, le défilement, la sélection, les filtres et les tris après ajout, suppression et modification de lignes.

## 21.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 21.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_stable TYPE lvc_s_stbl.

ls_stable-row = abap_true.
ls_stable-col = abap_true.

go_grid->refresh_table_display(
  EXPORTING
    is_stable      = ls_stable
    i_soft_refresh = abap_false ).
```

## 21.J TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 21.K RÉFÉRENCES OFFICIELLES SAP

- [refresh_table_display — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/0ab5531ed30911d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)

---

[Chapitre suivant — FONCTIONS CLASSIQUES REUSE ALV](<./22 ├── FONCTIONS CLASSIQUES REUSE ALV.md>)

[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
