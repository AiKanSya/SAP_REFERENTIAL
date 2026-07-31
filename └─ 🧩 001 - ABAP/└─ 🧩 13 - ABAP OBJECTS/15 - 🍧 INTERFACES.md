# 🌸 INTERFACES

## 🌺 OBJECTIFS

- Définir un contrat indépendant d’une implémentation
- Implémenter une interface dans une classe
- Appeler une méthode d’interface
- Distinguer interface, classe et héritage

## 🌺 DÉFINITION

Une interface décrit des composants publics sans fournir l’implémentation des méthodes.

```abap
INTERFACE lif_logger.
  METHODS log
    IMPORTING iv_message TYPE string.
ENDINTERFACE.
```

Une interface peut déclarer notamment :

- méthodes d’instance ou statiques ;
- types ;
- constantes ;
- attributs ;
- événements.

Ses composants sont publics.

## 🌺 IMPLÉMENTATION

```abap
CLASS lcl_console_logger DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_logger.
ENDCLASS.

CLASS lcl_console_logger IMPLEMENTATION.
  METHOD lif_logger~log.
    WRITE / iv_message.
  ENDMETHOD.
ENDCLASS.
```

Le nom qualifié `lif_logger~log` identifie la méthode fournie par l’interface.

## 🌺 UTILISATION

```abap
DATA lo_logger TYPE REF TO lif_logger.
CREATE OBJECT lo_logger TYPE lcl_console_logger.
lo_logger->log( iv_message = 'Traitement terminé' ).
```

Le consommateur dépend du contrat `lif_logger`, pas de la classe concrète.

## 🌺 PLUSIEURS INTERFACES

Une classe peut implémenter plusieurs interfaces :

```abap
PUBLIC SECTION.
  INTERFACES lif_logger.
  INTERFACES lif_flushable.
```

ABAP ne permet qu’une superclasse directe, mais autorise plusieurs contrats d’interface.

## 🌺 CONCEPTION

Une interface utile :

- représente une capacité cohérente ;
- contient peu de méthodes liées entre elles ;
- ne dépend pas d’une implémentation précise ;
- permet de remplacer un fournisseur par un autre ;
- évite d’exposer des méthodes inutiles au consommateur.

Éviter une interface générale contenant toutes les opérations possibles d’un domaine.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser interfaces dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
- Exposer des attributs modifiables au lieu d’encapsuler l’état.
- Créer une hiérarchie d’héritage alors qu’une composition suffit.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CLASS lcl_console_logger DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_logger.
ENDCLASS.

CLASS lcl_console_logger IMPLEMENTATION.
  METHOD lif_logger~log.
    WRITE / iv_message.
  ENDMETHOD.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser interfaces dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [Using Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-interfaces_e45af9bb-46e5-457b-88ef-d5ad6b0d38d7)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)


---

➡️ [Chapitre suivant — RÉFÉRENCES D’INTERFACE, ALIASES ET IMPLÉMENTATIONS MULTIPLES](<./16 - 🍧 REFERENCES D INTERFACE ALIASES ET IMPLEMENTATIONS MULTIPLES.md>)
