# 17. BONNES PRATIQUES ET CHECKLIST

## 17.A RÉSULTAT ATTENDU

- Concevoir un programme exécutable[^terme-programme-executable] maintenable
- Sécuriser l’écran de sélection
- Préserver la compatibilité avec les variantes
- Préparer l’exécution en dialogue et en arrière-plan
- Vérifier le programme avant livraison

## 17.B STRUCTURE RECOMMANDÉE

```abap
REPORT zdev_business_report.

SELECTION-SCREEN BEGIN OF BLOCK b_sel WITH FRAME TITLE text-t01.
  PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
  SELECT-OPTIONS s_date FOR sy-datum.
SELECTION-SCREEN END OF BLOCK b_sel.

INITIALIZATION.
  PERFORM initialize_selection.

AT SELECTION-SCREEN.
  PERFORM validate_selection.

START-OF-SELECTION.
  lcl_application=>run(
    iv_bukrs = p_bukrs
    ir_date  = s_date[]
  ).
```

Les événements orchestrent. La logique métier reste dans des unités réutilisables.

## 17.C ÉCRAN DE SÉLECTION

- limiter le nombre de champs ;
- utiliser les types DDIC[^terme-acro-ddic] ;
- regrouper les critères par fonction ;
- définir des libellés métier ;
- fournir des valeurs par défaut prudentes ;
- éviter une sélection complète involontaire ;
- valider les relations entre champs ;
- conserver la compatibilité avec les variantes.

## 17.D TRAITEMENT

- effectuer les contrôles d’autorisation ;
- séparer lecture, traitement et restitution ;
- ne pas modifier la base pendant `AT SELECTION-SCREEN` ;
- ne pas placer de `COMMIT WORK`[^terme-commit-work] sans frontière transactionnelle explicite ;
- éviter les appels dynamiques non contrôlés ;
- produire des messages exploitables ;
- prévoir un mode test pour les traitements de masse lorsque le besoin le justifie.

## 17.E ARRIÈRE-PLAN

- ne pas utiliser de dialogue obligatoire ;
- éviter les dépendances au frontend[^terme-frontend] SAP GUI[^terme-sap-gui] ;
- rendre les entrées enregistrables dans une variante ;
- écrire une sortie spool[^terme-spool] ou un journal applicatif ;
- traiter les erreurs sans intervention immédiate ;
- vérifier `sy-batch` uniquement lorsqu’un comportement différent est réellement nécessaire.

## 17.F PERFORMANCE

- limiter les critères trop ouverts ;
- appliquer les filtres dans ABAP[^terme-abap] SQL[^terme-acro-sql] ;
- éviter les lectures massives déclenchées pendant la saisie ;
- afficher un avertissement avant un traitement particulièrement large ;
- mesurer les scénarios réels avec les outils adaptés.

## 17.G CHECKLIST

- [ ] Le programme est-il de type exécutable et affecté au bon package[^terme-package] ?
- [ ] Le point d’entrée `START-OF-SELECTION` est-il explicite ?
- [ ] Les paramètres utilisent-ils des types DDIC pertinents ?
- [ ] Les valeurs initiales respectent-elles les variantes ?
- [ ] Les contrôles de sélection sont-ils sans effet métier durable ?
- [ ] Les autorisations sont-elles vérifiées dans le code ?
- [ ] Une sélection vide peut-elle provoquer un volume excessif ?
- [ ] Le programme fonctionne-t-il sans interaction frontend si le background est prévu ?
- [ ] Les erreurs sont-elles compréhensibles et traçables ?
- [ ] Les appels `SUBMIT` utilisent-ils une interface stable et contrôlée ?
- [ ] La sortie est-elle adaptée au besoin réel ?
- [ ] La documentation décrit-elle les impacts productifs ?

## 17.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 17.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 17.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT zdev_business_report.

SELECTION-SCREEN BEGIN OF BLOCK b_sel WITH FRAME TITLE text-t01.
  PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
  SELECT-OPTIONS s_date FOR sy-datum.
SELECTION-SCREEN END OF BLOCK b_sel.

INITIALIZATION.
  PERFORM initialize_selection.

AT SELECTION-SCREEN.
  PERFORM validate_selection.

START-OF-SELECTION.
  lcl_application=>run(
    iv_bukrs = p_bukrs
    ir_date  = s_date[]
  ).
```

## 17.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 17.L RÉFÉRENCES OFFICIELLES SAP

- [REPORT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREPORT.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)
- [Event Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/0b32146b63054bb293de32877a6ebfe9.html)
- [Understanding the Concept of Background Processing — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-ii-of-sap-s-4hana-and-sap-business-suite/understanding-the-concept-of-background-processing-1)
- [Authorization Checks — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/9fdbaccb35c111d1829f0000e829fbfe.html)

[^terme-programme-executable]: **PROGRAMME EXÉCUTABLE.** Programme ABAP de type report pouvant être lancé directement, généralement avec `F8` ou par une transaction. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
