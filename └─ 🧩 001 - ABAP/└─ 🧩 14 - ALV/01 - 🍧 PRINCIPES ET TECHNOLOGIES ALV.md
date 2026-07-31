# 🌸 PRINCIPES ET TECHNOLOGIES ALV

## 🌺 OBJECTIFS

- Comprendre le rôle de l’ALV dans SAP GUI
- Identifier les principales technologies ALV
- Distinguer affichage, interaction et édition
- Choisir une solution adaptée au besoin

## 🌺 DÉFINITION

**ALV** signifie **SAP List Viewer**. Il fournit des composants standard pour présenter des données tabulaires avec des fonctions déjà disponibles : tri, filtre, changement de colonnes, totalisation, export et variantes de mise en page.

L’ALV ne récupère pas les données métier. Le programme ABAP reste responsable de la sélection, des contrôles et de la construction de la table interne affichée.

```mermaid
flowchart LR
    A["Sélection des données"] --> B["Table interne de sortie"]
    B --> C["Configuration ALV"]
    C --> D["Affichage dans SAP GUI"]
    D --> E["Actions utilisateur"]
```

## 🌺 TECHNOLOGIES PRINCIPALES

| Technologie          | Objet principal                     | Usage dominant                                    |
| -------------------- | ----------------------------------- | ------------------------------------------------- |
| SALV                 | `CL_SALV_TABLE`                     | Affichage rapide, principalement en lecture seule |
| ALV Grid Control     | `CL_GUI_ALV_GRID`                   | Contrôle fin, événements, cellules éditables      |
| Fonctions classiques | `REUSE_ALV_GRID_DISPLAY` et famille | Maintenance de programmes historiques             |

## 🌺 RESPONSABILITÉS

Un développement ALV sépare normalement :

1. la récupération des données ;
2. la transformation dans une structure de sortie ;
3. la configuration visuelle ;
4. la gestion des événements ;
5. la sauvegarde éventuelle des modifications.

Cette séparation évite de placer des accès base de données ou des règles métier directement dans les gestionnaires d’événements de l’écran.

## 🌺 LIMITES

- Un ALV n’est pas un écran métier complet.
- Un ALV ne remplace pas les contrôles d’autorisation.
- Un ALV éditable ne sauvegarde rien automatiquement.
- Les fonctions disponibles varient selon le type d’ALV et le mode d’affichage.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre principes et technologies alv dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 🌺 ERREURS FRÉQUENTES

- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 🌺 TERMES DU LEXIQUE

- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre principes et technologies alv dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)
- [Instance for ALV Grid Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/4ebaebe1251356a2e10000000a421937.html)


---

➡️ [Chapitre suivant — CHOISIR ENTRE SALV, ALV GRID ET FONCTIONS CLASSIQUES](<./02 - 🍧 CHOISIR ENTRE SALV ALV GRID ET FONCTIONS CLASSIQUES.md>)
