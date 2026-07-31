# 🌸 LAYOUT ET VARIANTES DU GRID

## 🌺 OBJECTIFS

- Configurer `LVC_S_LAYO`
- Activer la sauvegarde des variantes
- Distinguer layout applicatif et variante utilisateur

## 🌺 LAYOUT

```abap
DATA gs_layout TYPE lvc_s_layo.

gs_layout-zebra      = abap_true.
gs_layout-cwidth_opt = abap_true.
gs_layout-sel_mode   = 'A'.
```

Propriétés fréquentes :

| Champ        | Usage                               |
| ------------ | ----------------------------------- |
| `ZEBRA`      | Alternance visuelle des lignes      |
| `CWIDTH_OPT` | Optimisation des largeurs           |
| `SEL_MODE`   | Mode de sélection                   |
| `EDIT`       | Activation générale de l’édition    |
| `STYLEFNAME` | Table de styles au niveau ligne     |
| `CTAB_FNAME` | Table de couleurs au niveau cellule |
| `INFO_FNAME` | Couleur de ligne                    |

## 🌺 VARIANTE

```abap
DATA gs_variant TYPE disvariant.

gs_variant-report = sy-repid.
```

Lors de l’affichage :

```abap
CALL METHOD go_grid->set_table_for_first_display
  EXPORTING
    is_variant      = gs_variant
    i_save          = 'A'
    is_layout       = gs_layout
  CHANGING
    it_outtab       = gt_output
    it_fieldcatalog = gt_fieldcat.
```

`I_SAVE = 'A'` autorise généralement les variantes utilisateur et globales, sous réserve des autorisations et du comportement de la version utilisée.

## 🌺 BONNES PRATIQUES

- Toujours renseigner `DISVARIANT-REPORT`.
- Ne pas modifier la clé de variante entre deux exécutions équivalentes.
- Ne pas rendre une colonne technique accessible via une variante.
- Tester l’impact d’une évolution de structure sur les variantes déjà sauvegardées.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre layout et variantes du grid dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
DATA gs_variant TYPE disvariant.

gs_variant-report = sy-repid.
```

## 🌺 TERMES DU LEXIQUE

- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre layout et variantes du grid dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)


---

➡️ [Chapitre suivant — PREMIER AFFICHAGE AVEC SET_TABLE_FOR_FIRST_DISPLAY](<./14 - 🍧 PREMIER AFFICHAGE AVEC SET_TABLE_FOR_FIRST_DISPLAY.md>)
