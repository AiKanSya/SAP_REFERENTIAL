# 🌸 ÉDITION DES CELLULES

## 🌺 OBJECTIFS

- Rendre une colonne modifiable
- Activer le mode de saisie
- Synchroniser les données saisies avec la table ABAP

## 🌺 CATALOGUE ÉDITABLE

```abap
gs_fieldcat-fieldname = 'QUANTITY'.
gs_fieldcat-coltext   = 'Quantité'.
gs_fieldcat-edit      = abap_true.
gs_fieldcat-qfieldname = 'UNIT'.
APPEND gs_fieldcat TO gt_fieldcat.
```

Le layout peut également activer l’édition de manière générale :

```abap
gs_layout-edit = abap_true.
```

Le contrôle précis doit rester dans le catalogue ou dans les styles de cellule.

## 🌺 ENREGISTRER LES ÉVÉNEMENTS D’ÉDITION

```abap
CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_modified.

CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_enter.
```

## 🌺 RÉCUPÉRER LES MODIFICATIONS

Avant une sauvegarde ou un traitement dépendant des saisies :

```abap
go_grid->check_changed_data( ).
```

Cette méthode demande au contrôle de transférer les valeurs en cours d’édition et de déclencher les validations associées.

## 🌺 RESPONSABILITÉ DE SAUVEGARDE

Rendre une cellule éditable ne met pas à jour la base. Le programme doit :

1. valider la valeur ;
2. contrôler les autorisations ;
3. détecter les conflits éventuels ;
4. appeler l’API métier appropriée ;
5. exécuter ou déléguer la gestion transactionnelle ;
6. informer l’utilisateur.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre édition des cellules dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_modified.

CALL METHOD go_grid->register_edit_event
  EXPORTING
    i_event_id = cl_gui_alv_grid=>mc_evt_enter.
```

## 🌺 TERMES DU LEXIQUE

- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre édition des cellules dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Making ALV React to Changed Data — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353523611.html)
- [Events of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5f5d2fe11d2b467006094192fe3.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)


---

➡️ [Chapitre suivant — VALIDATION AVEC DATA_CHANGED](<./19 - 🍧 VALIDATION AVEC DATA_CHANGED.md>)
