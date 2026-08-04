# 22. FONCTIONS CLASSIQUES REUSE ALV

## 22.A RÉSULTAT ATTENDU

- Lire et maintenir un ALV[^terme-alv] basé sur `REUSE_ALV_*`
- Identifier les structures `SLIS`
- Éviter d’étendre une architecture historique inutilement

## 22.B EXEMPLE HISTORIQUE

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

## 22.C OBJETS COURANTS

| Élément    | Type historique       |
| ---------- | --------------------- |
| Catalogue  | `SLIS_T_FIELDCAT_ALV` |
| Layout     | `SLIS_LAYOUT_ALV`     |
| Tri        | `SLIS_T_SORTINFO_ALV` |
| Événements | `SLIS_T_EVENT`        |
| Variante   | `DISVARIANT`          |

## 22.D STRATÉGIE DE MAINTENANCE

- Corriger le programme dans sa technologie existante lorsque le besoin est limité.
- Ne pas mélanger `SLIS` et `LVC` sans raison précise.
- En cas de refonte complète, choisir SALV[^terme-acro-salv] ou `CL_GUI_ALV_GRID` selon les exigences.
- Tester les variantes existantes avant toute migration.

## 22.E LIMITES

Les fonctions `REUSE_ALV_*` restent très présentes dans le patrimoine ABAP[^terme-abap], mais elles reposent sur un modèle procédural et des callbacks. Pour un nouveau développement, privilégier une API[^terme-api] orientée objet.

## 22.F PROCESS

### 22.F.1 Étape 1 — Confirmer le maintien de l’API historique

Utiliser `REUSE_ALV_*` pour maintenir un programme existant ou respecter une contrainte documentée. Pour un nouveau développement, comparer d’abord SALV et `CL_GUI_ALV_GRID`.

### 22.F.2 Étape 2 — Stabiliser la table et le catalogue SLIS

Définir une table de sortie typée et construire le catalogue `SLIS_T_FIELDCAT_ALV` avec des noms de champs correspondant exactement à cette table.

### 22.F.3 Étape 3 — Déclarer les callbacks attendus

Créer les routines appelées par le module fonction[^terme-module-fonction] avec les noms et signatures documentés. Éviter les dépendances implicites à des données globales non nécessaires.

### 22.F.4 Étape 4 — Appeler le module fonction

Transmettre la table, le catalogue, le layout, les variantes et les callbacks requis. Traiter `SY-SUBRC` et les exceptions immédiatement après l’appel.

### 22.F.5 Étape 5 — Encapsuler les adaptations

Limiter les nouvelles règles métier ajoutées dans les callbacks. Déléguer les lectures, validations et sauvegardes à des unités testables lorsqu’une correction élargit le programme historique.

### 22.F.6 Étape 6 — Exécuter les tests de non-régression

Vérifier l’affichage, les variantes existantes, les tris, les totaux, les exports et chaque callback. Comparer le comportement avant et après modification sur un jeu de données identique.

## 22.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 22.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 22.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 22.J TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 22.K RÉFÉRENCES OFFICIELLES SAP

- [Function Modules Related to ALV Grid — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524193.html)
- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)

---

[Chapitre suivant — PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES](<./23 └── PERFORMANCE DIAGNOSTIC ET BONNES PRATIQUES.md>)

[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-acro-salv]: **SALV.** Simple ALV / famille de classes `CL_SALV_*`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
