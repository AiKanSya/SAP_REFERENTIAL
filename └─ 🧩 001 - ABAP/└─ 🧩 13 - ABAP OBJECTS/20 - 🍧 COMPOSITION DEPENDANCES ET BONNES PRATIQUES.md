# 🌸 COMPOSITION, DÉPENDANCES ET BONNES PRATIQUES

## 🌺 OBJECTIFS

- Construire une collaboration entre objets
- Préférer un contrat explicite aux dépendances globales
- Choisir entre composition et héritage
- Appliquer une checklist de conception ABAP Objects

## 🌺 COMPOSITION

Une classe utilise une autre classe ou interface comme collaborateur.

```abap
CLASS lcl_order_service DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING io_logger TYPE REF TO lif_logger.
    METHODS process.
  PRIVATE SECTION.
    DATA mo_logger TYPE REF TO lif_logger.
ENDCLASS.

CLASS lcl_order_service IMPLEMENTATION.
  METHOD constructor.
    mo_logger = io_logger.
  ENDMETHOD.

  METHOD process.
    mo_logger->log( iv_message = 'Début du traitement' ).
  ENDMETHOD.
ENDCLASS.
```

La dépendance est fournie explicitement au constructeur. La classe ne crée pas elle-même une implémentation précise du logger.

## 🌺 COMPOSITION OU HÉRITAGE

| Question                      | Composition                        | Héritage                                    |
| ----------------------------- | ---------------------------------- | ------------------------------------------- |
| Relation principale           | « utilise un » ou « possède un »   | « est un »                                  |
| Remplacement du collaborateur | Facile via une interface           | Dépend de la hiérarchie                     |
| Couplage                      | Contrat du collaborateur           | Contrat public et protégé de la superclasse |
| Réutilisation                 | Délégation                         | Héritage de composants                      |
| Multiplicité                  | Plusieurs collaborateurs possibles | Une seule superclasse directe               |

Préférer généralement la composition lorsqu’aucune relation de spécialisation stable n’existe.

## 🌺 DÉPENDANCES EXPLICITES

Une dépendance cachée peut être :

- une classe statique appelée partout ;
- une variable globale ;
- un singleton mutable ;
- un accès direct à la base dans une méthode inattendue ;
- un module fonction appelé sans contrat local clair.

Rendre les dépendances visibles dans le constructeur ou dans la signature de la méthode concernée.

## 🌺 RESPONSABILITÉ UNIQUE

Une classe doit posséder une raison principale de changer. Séparer par exemple :

- lecture des données ;
- validation métier ;
- transformation ;
- persistance ;
- présentation ;
- communication externe.

Éviter une classe centrale qui connaît toutes les couches du traitement.

## 🌺 NOMMAGE

Le nom doit exprimer une responsabilité, pas une catégorie vague.

| Nom faible     | Nom plus précis              |
| -------------- | ---------------------------- |
| `ZCL_UTILS`    | `ZCL_CURRENCY_CONVERTER`     |
| `ZCL_MANAGER`  | `ZCL_PURCHASE_ORDER_SERVICE` |
| `DO_IT`        | `CALCULATE_TOTAL`            |
| `PROCESS_DATA` | `VALIDATE_DELIVERY`          |

## 🌺 CHECKLIST

- La classe possède une responsabilité identifiable.
- Les attributs sont privés par défaut.
- Les méthodes publiques constituent un contrat minimal.
- Les dépendances sont explicites.
- Les interfaces sont orientées vers les besoins des consommateurs.
- L’héritage correspond à une vraie spécialisation.
- Les méthodes ne réalisent pas de commit caché.
- Les exceptions décrivent les échecs du contrat.
- L’état statique mutable est évité.
- Les méthodes restent courtes et nommées selon leur intention.
- Les commentaires expliquent la raison, pas la syntaxe.
- La liste des utilisations est examinée avant une modification publique.

## 🌺 ABAP DOC

Documenter les composants publics avec ABAP Doc lorsqu’un contrat nécessite une explication :

```abap
"! Calcule le total d une commande.
"! @parameter iv_quantity | Quantité strictement positive
"! @parameter rv_total    | Montant calculé
METHODS calculate_total
  IMPORTING iv_quantity     TYPE i
  RETURNING VALUE(rv_total) TYPE decfloat34.
```

## 🌺 RÈGLE FINALE

Le but d’ABAP Objects n’est pas de multiplier les classes. Il est de rendre les responsabilités, les contrats et les dépendances explicites afin que le code puisse évoluer sans effets imprévus.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser composition, dépendances et bonnes pratiques dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque plusieurs solutions sont possibles et il faut retenir celle qui limite les risques de maintenance.

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
CLASS lcl_order_service DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING io_logger TYPE REF TO lif_logger.
    METHODS process.
  PRIVATE SECTION.
    DATA mo_logger TYPE REF TO lif_logger.
ENDCLASS.

CLASS lcl_order_service IMPLEMENTATION.
  METHOD constructor.
    mo_logger = io_logger.
  ENDMETHOD.

  METHOD process.
    mo_logger->log( iv_message = 'Début du traitement' ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser composition, dépendances et bonnes pratiques dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)
- [Documenting ABAP Code — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Interfaces vs. Abstract Classes — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/sub-sections/InterfacesVsAbstractClasses.md)
