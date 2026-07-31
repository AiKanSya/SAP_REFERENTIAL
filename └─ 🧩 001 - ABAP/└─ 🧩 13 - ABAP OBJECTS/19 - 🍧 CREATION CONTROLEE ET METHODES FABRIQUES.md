# 🌸 CRÉATION CONTRÔLÉE ET MÉTHODES FABRIQUES

## 🌺 OBJECTIFS

- Restreindre la création directe d’instances
- Utiliser `CREATE PRIVATE` ou `CREATE PROTECTED`
- Implémenter une méthode fabrique statique
- Distinguer fabrique et singleton

## 🌺 CRÉATION PRIVÉE

```abap
CLASS lcl_currency DEFINITION
  FINAL
  CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS create
      IMPORTING iv_code              TYPE string
      RETURNING VALUE(ro_currency)   TYPE REF TO lcl_currency
      RAISING   zcx_dev_invalid_code.
    METHODS get_code
      RETURNING VALUE(rv_code) TYPE string.
  PRIVATE SECTION.
    METHODS constructor
      IMPORTING iv_code TYPE string.
    DATA mv_code TYPE string.
ENDCLASS.
```

Le consommateur ne peut pas utiliser directement `CREATE OBJECT` ou `NEW` sur cette classe. Il doit passer par la méthode publique prévue.

## 🌺 MÉTHODE FABRIQUE

```abap
METHOD create.
  IF iv_code IS INITIAL.
    RAISE EXCEPTION TYPE zcx_dev_invalid_code.
  ENDIF.

  CREATE OBJECT ro_currency
    EXPORTING
      iv_code = iv_code.
ENDMETHOD.
```

La fabrique peut :

- valider les paramètres ;
- choisir une sous-classe ;
- retourner une instance mise en cache ;
- masquer une construction complexe ;
- garantir une politique de création uniforme.

## 🌺 POLYMORPHISME

Une fabrique peut retourner une référence d’interface :

```abap
CLASS-METHODS create
  IMPORTING iv_type           TYPE string
  RETURNING VALUE(ro_service) TYPE REF TO lif_service.
```

```mermaid
flowchart TD
    A["Type demandé"] --> B["Fabrique"]
    B --> C["Implémentation A"]
    B --> D["Implémentation B"]
    B --> E["Implémentation C"]
```

Le consommateur reste indépendant des classes concrètes.

## 🌺 CREATE PROTECTED

`CREATE PROTECTED` réserve la création à la classe, à ses sous-classes et aux amis autorisés. L’utiliser lorsqu’une hiérarchie doit contrôler l’instanciation tout en permettant la construction par les descendants.

## 🌺 SINGLETON

Un singleton impose une instance unique dans le périmètre d’exécution concerné. Il s’appuie généralement sur :

- `CREATE PRIVATE` ;
- un attribut statique contenant l’instance ;
- une méthode statique `get_instance`.

Ne pas utiliser ce modèle par défaut. Il introduit un état global, complique le remplacement de la dépendance et peut conserver un état plus longtemps que prévu.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser création contrôlée et méthodes fabriques dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
CLASS lcl_currency DEFINITION
  FINAL
  CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS create
      IMPORTING iv_code              TYPE string
      RETURNING VALUE(ro_currency)   TYPE REF TO lcl_currency
      RAISING   zcx_dev_invalid_code.
    METHODS get_code
      RETURNING VALUE(rv_code) TYPE string.
  PRIVATE SECTION.
    METHODS constructor
      IMPORTING iv_code TYPE string.
    DATA mv_code TYPE string.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser création contrôlée et méthodes fabriques dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)


---

➡️ [Chapitre suivant — COMPOSITION, DÉPENDANCES ET BONNES PRATIQUES](<./20 - 🍧 COMPOSITION DEPENDANCES ET BONNES PRATIQUES.md>)
