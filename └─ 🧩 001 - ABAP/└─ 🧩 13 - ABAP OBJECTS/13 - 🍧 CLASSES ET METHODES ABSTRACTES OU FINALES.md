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

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser classes et méthodes abstraites ou finales dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
CLASS lcl_pdf_document DEFINITION
  INHERITING FROM lcl_document
  FINAL.
  PUBLIC SECTION.
    METHODS render REDEFINITION.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser classes et méthodes abstraites ou finales dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Interfaces vs. Abstract Classes — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/sub-sections/InterfacesVsAbstractClasses.md)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)


---

➡️ [Chapitre suivant — POLYMORPHISME, UP-CAST ET DOWN-CAST](<./14 - 🍧 POLYMORPHISME UP CAST ET DOWN CAST.md>)
