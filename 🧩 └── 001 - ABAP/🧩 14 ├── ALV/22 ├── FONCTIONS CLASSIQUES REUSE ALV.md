# FONCTIONS CLASSIQUES REUSE ALV

## RÉSULTAT ATTENDU

- Lire et maintenir un ALV basé sur `REUSE_ALV_*`
- Identifier les structures `SLIS`
- Éviter d’étendre une architecture historique inutilement

## EXEMPLE HISTORIQUE

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

## OBJETS COURANTS

| Élément    | Type historique       |
| ---------- | --------------------- |
| Catalogue  | `SLIS_T_FIELDCAT_ALV` |
| Layout     | `SLIS_LAYOUT_ALV`     |
| Tri        | `SLIS_T_SORTINFO_ALV` |
| Événements | `SLIS_T_EVENT`        |
| Variante   | `DISVARIANT`          |

## STRATÉGIE DE MAINTENANCE

- Corriger le programme dans sa technologie existante lorsque le besoin est limité.
- Ne pas mélanger `SLIS` et `LVC` sans raison précise.
- En cas de refonte complète, choisir SALV ou `CL_GUI_ALV_GRID` selon les exigences.
- Tester les variantes existantes avant toute migration.

## LIMITES

Les fonctions `REUSE_ALV_*` restent très présentes dans le patrimoine ABAP, mais elles reposent sur un modèle procédural et des callbacks. Pour un nouveau développement, privilégier une API orientée objet.

## PROCESS

### Étape 1 — Confirmer le maintien de l’API historique

Utiliser `REUSE_ALV_*` pour maintenir un programme existant ou respecter une contrainte documentée. Pour un nouveau développement, comparer d’abord SALV et `CL_GUI_ALV_GRID`.

### Étape 2 — Stabiliser la table et le catalogue SLIS

Définir une table de sortie typée et construire le catalogue `SLIS_T_FIELDCAT_ALV` avec des noms de champs correspondant exactement à cette table.

### Étape 3 — Déclarer les callbacks attendus

Créer les routines appelées par le module fonction avec les noms et signatures documentés. Éviter les dépendances implicites à des données globales non nécessaires.

### Étape 4 — Appeler le module fonction

Transmettre la table, le catalogue, le layout, les variantes et les callbacks requis. Traiter `SY-SUBRC` et les exceptions immédiatement après l’appel.

### Étape 5 — Encapsuler les adaptations

Limiter les nouvelles règles métier ajoutées dans les callbacks. Déléguer les lectures, validations et sauvegardes à des unités testables lorsqu’une correction élargit le programme historique.

### Étape 6 — Exécuter les tests de non-régression

Vérifier l’affichage, les variantes existantes, les tris, les totaux, les exports et chaque callback. Comparer le comportement avant et après modification sur un jeu de données identique.

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

## TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## RÉFÉRENCES OFFICIELLES SAP

- [Function Modules Related to ALV Grid — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524193.html)
- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)

---

[Chapitre suivant — PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES](<./23 └── PERFORMANCE DIAGNOSTIC ET BONNES PRATIQUES.md>)
