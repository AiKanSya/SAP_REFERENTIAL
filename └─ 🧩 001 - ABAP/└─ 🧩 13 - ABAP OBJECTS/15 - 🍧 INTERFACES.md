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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [Using Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-interfaces_e45af9bb-46e5-457b-88ef-d5ad6b0d38d7)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)

---

➡️ [Chapitre suivant — RÉFÉRENCES D’INTERFACE, ALIASES ET IMPLÉMENTATIONS MULTIPLES](<./16 - 🍧 REFERENCES D INTERFACE ALIASES ET IMPLEMENTATIONS MULTIPLES.md>)
