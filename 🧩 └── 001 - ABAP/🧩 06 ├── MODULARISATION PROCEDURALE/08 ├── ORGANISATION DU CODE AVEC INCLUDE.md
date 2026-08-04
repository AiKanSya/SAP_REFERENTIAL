# 8. ORGANISATION DU CODE AVEC INCLUDE

## 8.A RÉSULTAT ATTENDU

- Comprendre le rôle d’un include ABAP[^terme-abap]
- Séparer un programme volumineux en unités source
- Identifier les conséquences sur la portée des données
- Utiliser des conventions de nommage cohérentes
- Éviter de confondre include et procédure

## 8.B DÉFINITION

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

## 8.C CE QU’UN INCLUDE NE FAIT PAS

Un include :

- ne crée pas une interface typée ;
- n’encapsule pas automatiquement les données ;
- ne rend pas le code indépendant ;
- n’est pas exécuté par un appel comparable à `PERFORM` ;
- dépend du contexte du programme qui l’inclut.

Il s’agit d’un mécanisme d’organisation du code source.

## 8.D ORGANISATION CLASSIQUE

Pour un programme procédural volumineux, une convention fréquente est :

| Suffixe | Contenu habituel                           |
| ------- | ------------------------------------------ |
| `_TOP`  | Déclarations globales, types et constantes |
| `_F01`  | Sous-programmes `FORM`                     |
| `_I01`  | Modules PAI d’un module pool[^terme-module-pool]               |
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

## 8.E ORDRE DES INCLUDES

L’ordre des instructions `INCLUDE` influence la visibilité[^terme-visibilite] source et la structure résultante.

Une organisation habituelle place :

1. les déclarations globales ;
2. les définitions d’écran de sélection ;
3. les blocs d’événements du programme principal ;
4. les sous-programmes ou modules.

Le contrôle de syntaxe doit porter sur l’ensemble généré, pas uniquement sur un fichier isolé.

## 8.F CRÉATION DANS SAP GUI

Les includes peuvent être créés et ouverts depuis :

- l’éditeur ABAP `SE38`[^outil-se38] ;
- l’Object Navigator `SE80`[^outil-se80] ;
- la navigation depuis une instruction `INCLUDE` selon les fonctions disponibles du système.

Ils appartiennent à un package[^terme-package] et doivent être transportés avec les autres objets du programme.

## 8.G RISQUES

- dépendance excessive aux globales déclarées dans `_TOP` ;
- ordre d’inclusion fragile ;
- cycles ou organisation difficile à suivre ;
- multiplication de petits includes sans cohérence ;
- même include réutilisé dans des contextes incompatibles ;
- activation oubliée d’un include modifié.

## 8.H BONNES PRATIQUES

- un include doit correspondre à une catégorie claire de code ;
- conserver des noms liés au programme principal ;
- éviter de découper une instruction ou une construction logique entre plusieurs includes ;
- préférer les procédures ou classes pour créer une vraie abstraction ;
- vérifier les usages avant de modifier un include partagé.

## 8.I POINTS À RETENIR

- `INCLUDE` organise le code source sans fournir d’encapsulation[^terme-encapsulation].
- Le contenu de l’include est intégré au programme utilisant l’instruction.
- Les données globales restent partagées dans le contexte du programme.
- L’ordre des includes doit être cohérent.
- Un include ne remplace pas une interface de procédure.

## 8.J PROCESS

### 8.J.1 Étape 1 — Définir le contenu de chaque include

Lister les catégories du programme : déclarations globales, écran de sélection, événements et sous-programmes. Affecter une seule catégorie principale à chaque include selon la convention du projet, par exemple `_TOP` et `_F01`.

Un include ne doit pas être créé pour masquer un découpage fonctionnel absent. Il ne fournit ni interface ni encapsulation.

### 8.J.2 Étape 2 — Créer les includes depuis le programme principal

1. Ouvrir le programme dans `SE80`.
2. Ajouter l’instruction `INCLUDE z_nom_include.` à l’emplacement prévu.
3. Double-cliquer sur le nom et confirmer la création comme programme include.
4. Affecter le même package et l’ordre cohérent avec le programme principal.

Si le nom existe déjà, l’ouvrir et vérifier son propriétaire et ses utilisations avant de le réemployer.

### 8.J.3 Étape 3 — Déplacer le code dans l’ordre correct

Déplacer d’abord les déclarations vers l’include chargé avant leurs utilisations, puis les sous-programmes vers l’include dédié. Conserver les blocs d’événements dans un ordre qui rend le flux principal lisible.

Après chaque déplacement, contrôler la syntaxe du programme principal, pas uniquement celle de l’include.

### 8.J.4 Étape 4 — Contrôler les dépendances et le transport

Utiliser la liste d’utilisation de chaque include pour confirmer ses programmes consommateurs. Vérifier dans `SE09`[^outil-se09]/`SE10`[^outil-se10] que programme principal et nouveaux includes appartiennent à la livraison prévue.

### 8.J.5 Étape 5 — Valider l’exécution

Activer l’ensemble proposé, exécuter les mêmes données qu’avant le découpage et comparer le résultat. L’organisation est terminée lorsque tous les includes sont actifs, transportés et que le comportement du programme reste identique.

## 8.K VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace[^terme-trace] ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 8.L ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 8.M SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT z_demo_modular.

INCLUDE z_demo_modular_top.
INCLUDE z_demo_modular_sel.
INCLUDE z_demo_modular_f01.

START-OF-SELECTION.
  PERFORM execute_process.
```

## 8.N TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## 8.O RÉFÉRENCES OFFICIELLES SAP

- [include program — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINCLUDE_PROGRAM_GLOSRY.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)

---

[Chapitre suivant — MACROS AVEC DEFINE](<./09 ├── MACROS AVEC DEFINE.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-module-pool]: **MODULE POOL.** Programme ABAP classique pilotant des dynpros au moyen de modules PBO et PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-pool>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-encapsulation]: **ENCAPSULATION.** Principe consistant à protéger l’état interne d’un objet et à imposer son utilisation par une API contrôlée. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#encapsulation>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se38]: **SE38.** Éditeur ABAP classique utilisé pour créer, modifier, vérifier et exécuter des programmes. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-se09]: **SE09.** Transaction de l’Organisateur de transports utilisée pour consulter et gérer les ordres et tâches de transport. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/03 ├── PACKAGES ET ORDRES DE TRANSPORT.md>).
[^outil-se10]: **SE10.** Transaction de l’Organisateur de transports utilisée pour consulter et gérer les ordres et tâches de transport. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/03 ├── PACKAGES ET ORDRES DE TRANSPORT.md>).
