# 🌸 REDÉFINITION, SUPER ET CONSTRUCTEURS HÉRITÉS

## 🌺 OBJECTIFS

- Redéfinir une méthode héritée
- Appeler l’implémentation de la superclasse avec `super->`
- Comprendre le traitement des constructeurs dans une hiérarchie
- Éviter la duplication de logique héritée

## 🌺 REDÉFINITION

Une méthode d’instance héritée et non finale peut être redéfinie dans une sous-classe.

```abap
CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.
    METHODS get_description REDEFINITION.
ENDCLASS.

CLASS lcl_truck IMPLEMENTATION.
  METHOD get_description.
    rv_text = 'Camion'.
  ENDMETHOD.
ENDCLASS.
```

La signature de la méthode reste définie par la superclasse. La sous-classe remplace seulement son implémentation.

## 🌺 APPEL DE LA SUPERCLASSE

```abap
METHOD get_description.
  rv_text = super->get_description( ).
  rv_text = |{ rv_text } - Camion|.
ENDMETHOD.
```

`super->` permet d’appeler la version héritée lorsque la sous-classe veut compléter plutôt que remplacer entièrement le comportement.

## 🌺 DISPATCH DYNAMIQUE

```abap
DATA lo_vehicle TYPE REF TO lcl_vehicle.
CREATE OBJECT lo_vehicle TYPE lcl_truck.
lv_text = lo_vehicle->get_description( ).
```

Même si la référence est typée sur la superclasse, la méthode redéfinie de `lcl_truck` est exécutée selon le type réel de l’objet.

## 🌺 CONSTRUCTEURS

Le constructeur d’une sous-classe n’est pas une redéfinition au sens de `REDEFINITION`. La sous-classe déclare son propre `constructor` et initialise la partie héritée avec `super->constructor( ... )` lorsque le contrat de la superclasse le requiert.

```abap
METHOD constructor.
  super->constructor( iv_category = 'TRUCK' ).
  mv_capacity = iv_capacity.
ENDMETHOD.
```

L’initialisation de la superclasse doit être effectuée avant d’utiliser un état hérité qui dépend de son constructeur.

## 🌺 RÈGLES

- ne pas changer la signification d’une méthode redéfinie ;
- respecter les préconditions et garanties du contrat hérité ;
- appeler `super->` seulement lorsque son comportement fait partie de l’algorithme voulu ;
- éviter les chaînes de redéfinitions difficiles à suivre ;
- rendre une méthode `FINAL` si l’extension serait dangereuse.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser redéfinition, super et constructeurs hérités dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
METHOD get_description.
  rv_text = super->get_description( ).
  rv_text = |{ rv_text } - Camion|.
ENDMETHOD.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser redéfinition, super et constructeurs hérités dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Using Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-inheritance_e8db2ae2-5d5d-4848-8534-ea9fa00f4f3c)
- [ABAP Objects - Inheritance and Constructors — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/abeninheritance_constructors.html)


---

➡️ [Chapitre suivant — CLASSES ET MÉTHODES ABSTRAITES OU FINALES](<./13 - 🍧 CLASSES ET METHODES ABSTRACTES OU FINALES.md>)
