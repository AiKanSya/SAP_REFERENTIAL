# 🌸 PRINCIPES DES PROGRAMMES EXÉCUTABLES

## 🌺 OBJECTIFS

- Comprendre le rôle d’un programme exécutable ABAP
- Identifier son point d’entrée et son cycle général
- Distinguer sélection, traitement et restitution
- Délimiter son usage dans une architecture SAP
- Préparer un programme compatible avec SAP GUI

## 🌺 DÉFINITION

Un **programme exécutable** est un objet du Repository ABAP pouvant être lancé directement. Il est généralement introduit par l’instruction `REPORT`.

```abap
REPORT zdev_flight_report.
```

Dans les attributs du programme, son type est **Programme exécutable**. Le terme historique **report** reste largement utilisé, même lorsque le programme ne produit pas uniquement un état.

```mermaid
flowchart LR
    A["Lancement du programme"] --> B["Écran de sélection éventuel"]
    B --> C["Traitement ABAP"]
    C --> D["Restitution ou mise à jour"]
```

## 🌺 RESPONSABILITÉS HABITUELLES

Un programme exécutable peut notamment :

- lire et analyser des données ;
- produire une liste ou un ALV ;
- lancer un traitement de masse ;
- appeler une API métier ;
- préparer des données pour une interface ;
- être exécuté en dialogue ou en arrière-plan.

Un programme exécutable n’est pas une couche métier réutilisable à lui seul. La logique importante doit être placée dans des procédures ou classes dédiées, puis appelée depuis le point d’entrée du programme.

## 🌺 STRUCTURE RECOMMANDÉE

```abap
REPORT zdev_flight_report.

PARAMETERS p_carr TYPE scarr-carrid.

START-OF-SELECTION.
  lcl_application=>run( p_carr ).
```

Le bloc événementiel orchestre le traitement. Il ne doit pas contenir toute l’implémentation lorsque celle-ci devient significative.

## 🌺 PROGRAMME EXÉCUTABLE ET TRANSACTION

Un programme peut être lancé :

- depuis `SE38` ou `SA38` ;
- depuis `SE80` ;
- depuis une transaction de type programme et écran de sélection ;
- depuis un autre programme avec `SUBMIT` ;
- depuis un job d’arrière-plan.

Le mode de lancement ne remplace pas les contrôles d’autorisation métier dans le code.

## 🌺 PÉRIMÈTRE DU DOSSIER

Ce dossier couvre :

- les événements des programmes exécutables ;
- les écrans de sélection générés par ABAP ;
- les paramètres et critères de sélection ;
- les validations et adaptations dynamiques ;
- les variantes ;
- les appels avec `SUBMIT` ;
- la sortie classique minimale.

Les ALV, dynpros, jobs d’arrière-plan et messages avancés seront détaillés dans des dossiers distincts.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur doit exécuter un report paramétrable, valider ses critères et réutiliser des variantes, le besoin consiste à **configurer principes des programmes exécutables dans un programme exécutable et vérifier le comportement de l’écran de sélection**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

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
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT zdev_flight_report.

PARAMETERS p_carr TYPE scarr-carrid.

START-OF-SELECTION.
  lcl_application=>run( p_carr ).
```

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **configurer principes des programmes exécutables dans un programme exécutable et vérifier le comportement de l’écran de sélection**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [REPORT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREPORT.html)
- [Event Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/0b32146b63054bb293de32877a6ebfe9.html)
- [Accessing and Editing ABAP Repository Objects — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-i-of-sap-s-4hana-and-sap-business-suite/accessing-and-editing-abap-repository-objects)


---

➡️ [Chapitre suivant — ATTRIBUTS, EXÉCUTION ET DOCUMENTATION](<./02 - 🍧 ATTRIBUTS EXECUTION ET DOCUMENTATION.md>)
