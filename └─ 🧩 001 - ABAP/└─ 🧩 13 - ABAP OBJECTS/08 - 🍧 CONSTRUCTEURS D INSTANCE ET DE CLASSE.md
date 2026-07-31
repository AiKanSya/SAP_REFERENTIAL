# 🌸 CONSTRUCTEURS D INSTANCE ET DE CLASSE

## 🌺 OBJECTIFS

- Initialiser une instance avec `constructor`
- Initialiser un état statique avec `class_constructor`
- Garantir les invariants dès la création
- Éviter les traitements métier cachés dans les constructeurs

## 🌺 CONSTRUCTEUR D INSTANCE

La méthode spéciale `constructor` est exécutée lors de la création d’une instance.

```abap
CLASS lcl_counter DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_start TYPE i.
    METHODS get_value
      RETURNING VALUE(rv_value) TYPE i.
  PRIVATE SECTION.
    DATA mv_value TYPE i.
ENDCLASS.

CLASS lcl_counter IMPLEMENTATION.
  METHOD constructor.
    mv_value = iv_start.
  ENDMETHOD.
ENDCLASS.
```

Le constructeur ne se déclare pas avec `RETURNING`. Il initialise l’objet qui vient d’être créé.

## 🌺 INVARIANT

Un invariant est une règle qui doit rester vraie pour toute instance valide. Le constructeur doit empêcher la création d’un objet incohérent.

```abap
METHOD constructor.
  IF iv_start < 0.
    RAISE EXCEPTION TYPE zcx_dev_invalid_value.
  ENDIF.

  mv_value = iv_start.
ENDMETHOD.
```

## 🌺 CONSTRUCTEUR DE CLASSE

`class_constructor` est une méthode statique spéciale exécutée automatiquement avant la première utilisation pertinente de la classe dans une session interne.

```abap
CLASS-METHODS class_constructor.
CLASS-DATA gv_default_limit TYPE i READ-ONLY.
```

```abap
METHOD class_constructor.
  gv_default_limit = 100.
ENDMETHOD.
```

Le constructeur de classe :

- ne possède pas de paramètres ;
- n’est pas appelé explicitement ;
- sert à initialiser des composants statiques ;
- ne doit pas dépendre d’un ordre implicite entre plusieurs classes.

## 🌺 LIMITER LE TRAVAIL DU CONSTRUCTEUR

Éviter dans un constructeur :

- un traitement long ;
- un `COMMIT WORK` ;
- une interaction utilisateur ;
- des écritures en base non attendues ;
- des dépendances réseau cachées ;
- une logique qui pourrait être appelée explicitement par une méthode nommée.

Le constructeur doit principalement valider les entrées et établir un état cohérent.

## 🌺 CRÉATION IMPOSSIBLE

Si le constructeur lève une exception, aucune référence valide à la nouvelle instance n’est retournée à l’appelant.

```mermaid
flowchart TD
    A["Demande de création"] --> B["Exécution du constructeur"]
    B --> C["Entrées valides ?"]
    C -->|"Oui"| D["Instance utilisable"]
    C -->|"Non"| E["Exception et création interrompue"]
```

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser constructeurs d instance et de classe dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
METHOD constructor.
  IF iv_start < 0.
    RAISE EXCEPTION TYPE zcx_dev_invalid_value.
  ENDIF.

  mv_value = iv_start.
ENDMETHOD.
```

## 🌺 TERMES DU LEXIQUE

- [Instance](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/01 - 🍧 SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#instance>)
- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser constructeurs d instance et de classe dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects - Inheritance and Constructors — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/abeninheritance_constructors.html)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [ABAP Objects Example — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS_ABEXA.html)


---

➡️ [Chapitre suivant — COMPOSANTS D INSTANCE ET COMPOSANTS STATIQUES](<./09 - 🍧 COMPOSANTS D INSTANCE ET COMPOSANTS STATIQUES.md>)
