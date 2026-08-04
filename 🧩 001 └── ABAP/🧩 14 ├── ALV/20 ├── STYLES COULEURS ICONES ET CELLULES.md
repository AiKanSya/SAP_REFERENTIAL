# 20. STYLES, COULEURS, ICÔNES ET CELLULES

## 20.A RÉSULTAT ATTENDU

- Adapter la présentation par ligne ou cellule
- Désactiver certaines cellules
- Afficher des icônes et des couleurs avec modération

## 20.B STYLES DE CELLULE

Ajouter une table de styles à la structure de sortie :

```abap
TYPES:
  BEGIN OF ty_output,
    carrid  TYPE sflight-carrid,
    status  TYPE icon_d,
    celltab TYPE lvc_t_styl,
  END OF ty_output.
```

Configurer le layout :

```abap
gs_layout-stylefname = 'CELLTAB'.
```

Désactiver une cellule :

```abap
DATA ls_style TYPE lvc_s_styl.

ls_style-fieldname = 'CARRID'.
ls_style-style = cl_gui_alv_grid=>mc_style_disabled.
APPEND ls_style TO gs_output-celltab.
```

## 20.C COULEURS

Les couleurs peuvent être définies au niveau colonne, ligne ou cellule selon les propriétés du catalogue, du layout et de la structure de sortie. Une couleur doit transmettre une information stable, pas décorer l’écran.

## 20.D ICÔNES

Pour une colonne contenant un identifiant d’icône :

```abap
gs_fieldcat-fieldname = 'STATUS'.
gs_fieldcat-icon      = abap_true.
APPEND gs_fieldcat TO gt_fieldcat.
```

Associer un texte explicatif ou une info-bulle lorsque l’icône seule n’est pas suffisante.

## 20.E ACCESSIBILITÉ

Ne jamais transmettre une information uniquement par la couleur. Combiner couleur, texte, icône ou statut afin que le résultat reste compréhensible dans différents contextes d’affichage.

## 20.F PROCESS

### 20.F.1 Étape 1 — Ajouter les composants techniques à la sortie

Prévoir dans la structure de ligne les tables ou champs nécessaires aux styles, couleurs et icônes. Ces composants doivent rester distincts des données métier affichées.

### 20.F.2 Étape 2 — Remplir les propriétés par ligne ou cellule

Construire les entrées de style et de couleur à partir d’un état métier déjà calculé. Ne pas effectuer d’accès base de données dans la boucle de présentation.

### 20.F.3 Étape 3 — Relier les composants au layout

Renseigner dans `LVC_S_LAYO` les noms des composants techniques concernés. Les noms doivent correspondre exactement aux composants de la table de sortie.

### 20.F.4 Étape 4 — Configurer les colonnes d’icônes et d’interaction

Déclarer la propriété d’icône, de hotspot ou de bouton dans le catalogue de champs selon le besoin. Ajouter un texte ou une info-bulle compréhensible.

### 20.F.5 Étape 5 — Conserver une information accessible sans couleur

Accompagner toute couleur d’un statut textuel, d’une icône expliquée ou d’une autre information indépendante de la perception des couleurs.

### 20.F.6 Étape 6 — Tester tous les états

Vérifier les lignes normales, bloquées, en erreur et sélectionnées. Tester aussi l’impression, l’export et une variante qui masque certaines colonnes.

## 20.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 20.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV[^terme-alv].
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 20.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TYPES:
  BEGIN OF ty_output,
    carrid  TYPE sflight-carrid,
    status  TYPE icon_d,
    celltab TYPE lvc_t_styl,
  END OF ty_output.
```

## 20.J TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 20.K MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP[^terme-acro-sap] et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 20.L RÉFÉRENCES OFFICIELLES SAP

- [The Field Catalog — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaa38d251e56a4e10000000a421937.html)
- [Working with the ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebd16291041389ee10000000a421937.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)

---

[Chapitre suivant — RAFRAÎCHISSEMENT ET STABILITÉ D’AFFICHAGE](<./21 ├── RAFRAICHISSEMENT ET STABILITE D AFFICHAGE.md>)

[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
