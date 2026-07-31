# 🌸 RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE

## 🌺 OBJECTIFS

- Actualiser les données sans recréer la grille
- Conserver la position de défilement
- Comprendre le rafraîchissement logiciel

## 🌺 RAFRAÎCHIR

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

## 🌺 SOFT REFRESH

Un rafraîchissement logiciel conserve certains réglages frontend comme les tris, filtres et totalisations. L’utiliser seulement lorsque les changements apportés sont compatibles avec la conservation de cet état.

## 🌺 CHARGER DE NOUVELLES DONNÉES

```abap
PERFORM select_data CHANGING gt_output.
go_grid->refresh_table_display( is_stable = ls_stable ).
```

Ne pas rappeler `SET_TABLE_FOR_FIRST_DISPLAY` pour chaque rechargement standard.

## 🌺 FLUSH

Le Control Framework gère normalement les échanges frontend. `CL_GUI_CFW=>FLUSH` peut être nécessaire dans certains scénarios documentés ou pour faire remonter immédiatement une erreur frontend, mais ne doit pas être appelé sans raison à chaque instruction.

## 🌺 ERREURS FRÉQUENTES

- remplacer la table interne par une nouvelle référence incompatible ;
- modifier la structure du catalogue sans réinitialisation adaptée ;
- rafraîchir avant `CHECK_CHANGED_DATA` sur une grille éditable ;
- perdre la sélection utilisateur après reconstruction complète du contrôle.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre rafraîchissement et stabilité d’affichage dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_stable TYPE lvc_s_stbl.

ls_stable-row = abap_true.
ls_stable-col = abap_true.

go_grid->refresh_table_display(
  EXPORTING
    is_stable      = ls_stable
    i_soft_refresh = abap_false ).
```

## 🌺 TERMES DU LEXIQUE

- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre rafraîchissement et stabilité d’affichage dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [refresh_table_display — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/0ab5531ed30911d2b467006094192fe3.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)


---

➡️ [Chapitre suivant — FONCTIONS CLASSIQUES REUSE ALV](<./22 - 🍧 FONCTIONS CLASSIQUES REUSE ALV.md>)
