# 🌸 FONCTIONS CLASSIQUES REUSE ALV

## 🌺 OBJECTIFS

- Lire et maintenir un ALV basé sur `REUSE_ALV_*`
- Identifier les structures `SLIS`
- Éviter d’étendre une architecture historique inutilement

## 🌺 EXEMPLE HISTORIQUE

```abap
TYPE-POOLS slis.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

gs_layout-zebra             = abap_true.
gs_layout-colwidth_optimize  = abap_true.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program = sy-repid
    is_layout          = gs_layout
    it_fieldcat        = gt_fieldcat
    i_save             = 'A'
  TABLES
    t_outtab           = gt_output
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
```

## 🌺 OBJETS COURANTS

| Élément    | Type historique       |
| ---------- | --------------------- |
| Catalogue  | `SLIS_T_FIELDCAT_ALV` |
| Layout     | `SLIS_LAYOUT_ALV`     |
| Tri        | `SLIS_T_SORTINFO_ALV` |
| Événements | `SLIS_T_EVENT`        |
| Variante   | `DISVARIANT`          |

## 🌺 STRATÉGIE DE MAINTENANCE

- Corriger le programme dans sa technologie existante lorsque le besoin est limité.
- Ne pas mélanger `SLIS` et `LVC` sans raison précise.
- En cas de refonte complète, choisir SALV ou `CL_GUI_ALV_GRID` selon les exigences.
- Tester les variantes existantes avant toute migration.

## 🌺 LIMITES

Les fonctions `REUSE_ALV_*` restent très présentes dans le patrimoine ABAP, mais elles reposent sur un modèle procédural et des callbacks. Pour un nouveau développement, privilégier une API orientée objet.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre fonctions classiques reuse alv dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TYPE-POOLS slis.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

gs_layout-zebra             = abap_true.
gs_layout-colwidth_optimize  = abap_true.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program = sy-repid
    is_layout          = gs_layout
    it_fieldcat        = gt_fieldcat
    i_save             = 'A'
  TABLES
    t_outtab           = gt_output
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre fonctions classiques reuse alv dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Modules Related to ALV Grid — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524193.html)
- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)


---

➡️ [Chapitre suivant — PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES](<./23 - 🍧 PERFORMANCE DIAGNOSTIC ET BONNES PRATIQUES.md>)
