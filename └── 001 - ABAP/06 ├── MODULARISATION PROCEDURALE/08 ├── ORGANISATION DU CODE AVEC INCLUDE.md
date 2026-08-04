# ORGANISATION DU CODE AVEC INCLUDE

## OBJECTIFS

- Comprendre le rôle d’un include ABAP
- Séparer un programme volumineux en unités source
- Identifier les conséquences sur la portée des données
- Utiliser des conventions de nommage cohérentes
- Éviter de confondre include et procédure

## DÉFINITION

Un include ABAP est un programme include dont le contenu source est intégré au programme qui utilise l’instruction `INCLUDE`.

```abap
INCLUDE z_demo_modular_top.
INCLUDE z_demo_modular_f01.
```

Lors de la génération du programme principal, le contenu des includes est pris en compte comme une partie de ce programme.

```mermaid
flowchart LR
    A["Programme principal"] --> B["INCLUDE ..._TOP"]
    A --> C["INCLUDE ..._F01"]
    B --> D["Source généré du programme"]
    C --> D
```

## CE QU’UN INCLUDE NE FAIT PAS

Un include :

- ne crée pas une interface typée ;
- n’encapsule pas automatiquement les données ;
- ne rend pas le code indépendant ;
- n’est pas exécuté par un appel comparable à `PERFORM` ;
- dépend du contexte du programme qui l’inclut.

Il s’agit d’un mécanisme d’organisation du code source.

## ORGANISATION CLASSIQUE

Pour un programme procédural volumineux, une convention fréquente est :

| Suffixe | Contenu habituel                           |
| ------- | ------------------------------------------ |
| `_TOP`  | Déclarations globales, types et constantes |
| `_F01`  | Sous-programmes `FORM`                     |
| `_I01`  | Modules PAI d’un module pool               |
| `_O01`  | Modules PBO d’un module pool               |

Ces suffixes sont des conventions, pas des obligations du langage.

Exemple :

```abap
REPORT z_demo_modular.

INCLUDE z_demo_modular_top.
INCLUDE z_demo_modular_sel.
INCLUDE z_demo_modular_f01.

START-OF-SELECTION.
  PERFORM execute_process.
```

## ORDRE DES INCLUDES

L’ordre des instructions `INCLUDE` influence la visibilité source et la structure résultante.

Une organisation habituelle place :

1. les déclarations globales ;
2. les définitions d’écran de sélection ;
3. les blocs d’événements du programme principal ;
4. les sous-programmes ou modules.

Le contrôle de syntaxe doit porter sur l’ensemble généré, pas uniquement sur un fichier isolé.

## CRÉATION DANS SAP GUI

Les includes peuvent être créés et ouverts depuis :

- l’éditeur ABAP `SE38` ;
- l’Object Navigator `SE80` ;
- la navigation depuis une instruction `INCLUDE` selon les fonctions disponibles du système.

Ils appartiennent à un package et doivent être transportés avec les autres objets du programme.

## RISQUES

- dépendance excessive aux globales déclarées dans `_TOP` ;
- ordre d’inclusion fragile ;
- cycles ou organisation difficile à suivre ;
- multiplication de petits includes sans cohérence ;
- même include réutilisé dans des contextes incompatibles ;
- activation oubliée d’un include modifié.

## BONNES PRATIQUES

- un include doit correspondre à une catégorie claire de code ;
- conserver des noms liés au programme principal ;
- éviter de découper une instruction ou une construction logique entre plusieurs includes ;
- préférer les procédures ou classes pour créer une vraie abstraction ;
- vérifier les usages avant de modifier un include partagé.

## POINTS À RETENIR

- `INCLUDE` organise le code source sans fournir d’encapsulation.
- Le contenu de l’include est intégré au programme utilisant l’instruction.
- Les données globales restent partagées dans le contexte du programme.
- L’ordre des includes doit être cohérent.
- Un include ne remplace pas une interface de procédure.

## PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT z_demo_modular.

INCLUDE z_demo_modular_top.
INCLUDE z_demo_modular_sel.
INCLUDE z_demo_modular_f01.

START-OF-SELECTION.
  PERFORM execute_process.
```

## TERMES DU LEXIQUE

- [Programme exécutable](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## RÉFÉRENCES OFFICIELLES SAP

- [include program — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINCLUDE_PROGRAM_GLOSRY.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)


---

[Chapitre suivant — MACROS AVEC DEFINE](<./09 ├── MACROS AVEC DEFINE.md>)
