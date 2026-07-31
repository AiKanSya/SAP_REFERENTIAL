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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Using Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-inheritance_e8db2ae2-5d5d-4848-8534-ea9fa00f4f3c)
- [ABAP Objects - Inheritance and Constructors — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/abeninheritance_constructors.html)

---

➡️ [Chapitre suivant — CLASSES ET MÉTHODES ABSTRAITES OU FINALES](<./13 - 🍧 CLASSES ET METHODES ABSTRACTES OU FINALES.md>)
