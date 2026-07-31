# 🌸 FONCTIONS STANDARD DU SALV

## 🌺 OBJECTIFS

- Activer les fonctions standards
- Comprendre l’objet `CL_SALV_FUNCTIONS_LIST`
- Distinguer fonctions génériques et fonctions personnalisées

## 🌺 ACTIVER LES FONCTIONS

```abap
DATA lo_functions TYPE REF TO cl_salv_functions_list.

lo_functions = go_alv->get_functions( ).
lo_functions->set_all( abap_true ).
```

Cette configuration rend disponibles les fonctions génériques autorisées par le mode d’affichage, par exemple le tri, le filtre, l’export ou la gestion de mise en page.

## 🌺 ACTIVATION CIBLÉE

Lorsqu’un besoin impose une interface réduite, activer seulement les fonctions utiles plutôt que toutes les fonctions. La disponibilité exacte dépend de la version et du mode d’affichage.

## 🌺 FONCTIONS PERSONNALISÉES

Le mécanisme diffère selon le contexte :

- en conteneur, une fonction peut être ajoutée à l’objet de fonctions ;
- en plein écran, les fonctions personnalisées reposent généralement sur un statut GUI et `SET_SCREEN_STATUS`.

Une fonction personnalisée doit être associée à un gestionnaire de l’événement `ADDED_FUNCTION`.

## 🌺 EXEMPLE DE STRUCTURE

```abap
DATA lo_events TYPE REF TO cl_salv_events_table.

lo_events = go_alv->get_event( ).
SET HANDLER lcl_handler=>on_added_function FOR lo_events.
```

Ne pas ajouter un bouton sans définir précisément :

- son code fonction ;
- les lignes auxquelles il s’applique ;
- les contrôles d’autorisation ;
- le comportement en cas de sélection vide.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur métier doit analyser une liste tabulaire, trier, filtrer et éventuellement interagir avec les lignes, le besoin consiste à **mettre en œuvre fonctions standard du salv dans un affichage ALV borné et adapté aux interactions attendues**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
DATA lo_functions TYPE REF TO cl_salv_functions_list.

lo_functions = go_alv->get_functions( ).
lo_functions->set_all( abap_true ).
```

## 🌺 TERMES DU LEXIQUE

- [SALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-salv>)
- [ALV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **mettre en œuvre fonctions standard du salv dans un affichage ALV borné et adapté aux interactions attendues**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Using Self-Defined, Application-Specific Functions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec39dbb88d22b90e10000000a42189d.html)
- [Main ALV Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1f117076868b8e10000000a42189e.html)


---

➡️ [Chapitre suivant — COLONNES ET ENTÊTES DU SALV](<./05 - 🍧 COLONNES ET ENTETES DU SALV.md>)
