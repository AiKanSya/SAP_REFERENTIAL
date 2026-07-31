# 🌸 CLASSES ET MÉTHODES ABSTRAITES OU FINALES

## 🌺 OBJECTIFS

- Définir une classe abstraite
- Déclarer une méthode abstraite
- Interdire l’héritage ou la redéfinition avec `FINAL`
- Choisir entre classe abstraite et interface

## 🌺 CLASSE ABSTRAITE

```abap
CLASS lcl_document DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS render ABSTRACT
      RETURNING VALUE(rv_content) TYPE string.
ENDCLASS.
```

Une classe abstraite ne peut pas être instanciée directement. Elle sert de base à des sous-classes concrètes.

Une méthode abstraite :

- ne possède pas d’implémentation dans la classe abstraite ;
- définit un contrat à implémenter dans une sous-classe concrète ;
- doit être déclarée dans une classe abstraite.

## 🌺 SOUS CLASSE CONCRÈTE

```abap
CLASS lcl_pdf_document DEFINITION
  INHERITING FROM lcl_document
  FINAL.
  PUBLIC SECTION.
    METHODS render REDEFINITION.
ENDCLASS.
```

La sous-classe doit fournir une implémentation des méthodes abstraites héritées pour devenir instanciable.

## 🌺 CLASSE FINALE

```abap
CLASS lcl_configuration DEFINITION FINAL.
```

Une classe finale ne peut pas avoir de sous-classe. Utiliser `FINAL` lorsque la classe n’est pas conçue pour l’extension.

## 🌺 MÉTHODE FINALE

Une méthode redéfinissable dans une hiérarchie peut être déclarée finale afin d’interdire toute nouvelle redéfinition dans les descendants.

Cette restriction protège un comportement dont la stabilité est nécessaire aux invariants de la hiérarchie.

## 🌺 INTERFACE OU CLASSE ABSTRAITE

| Besoin                         | Interface | Classe abstraite                |
| ------------------------------ | --------- | ------------------------------- |
| Définir uniquement un contrat  | Adaptée   | Possible mais plus contraignant |
| Partager une implémentation    | Non       | Oui                             |
| Partager un état protégé       | Non       | Oui                             |
| Implémenter plusieurs contrats | Oui       | Une seule superclasse directe   |
| Imposer une famille de types   | Oui       | Oui                             |

Préférer une interface lorsque les consommateurs ont seulement besoin d’un comportement. Utiliser une classe abstraite lorsqu’une base commune cohérente doit réellement partager état et implémentation.

## 🌺 RÈGLE

Une classe extensible constitue un contrat pour des sous-classes inconnues. Ne laisser une classe ou une méthode ouverte que si cette extension a été conçue et documentée.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Interfaces vs. Abstract Classes — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/sub-sections/InterfacesVsAbstractClasses.md)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)

---

➡️ [Chapitre suivant — POLYMORPHISME, UP-CAST ET DOWN-CAST](<./14 - 🍧 POLYMORPHISME UP CAST ET DOWN CAST.md>)
