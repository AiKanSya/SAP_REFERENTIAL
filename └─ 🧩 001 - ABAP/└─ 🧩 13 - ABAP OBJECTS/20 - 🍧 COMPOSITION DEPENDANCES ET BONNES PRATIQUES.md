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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)
- [Documenting ABAP Code — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Interfaces vs. Abstract Classes — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/sub-sections/InterfacesVsAbstractClasses.md)
