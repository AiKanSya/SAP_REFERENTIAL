# 🌸 ATTRIBUTS, CONSTANTES ET TYPES DE CLASSE

## 🌺 OBJECTIFS

- Déclarer les données d’une classe
- Distinguer attribut d’instance et attribut statique
- Exposer des constantes et des types sans exposer l’état interne
- Utiliser `READ-ONLY` avec précision

## 🌺 ATTRIBUTS D INSTANCE

Un attribut déclaré avec `DATA` dans une classe existe séparément pour chaque instance.

```abap
CLASS lcl_employee DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_name TYPE string.
    METHODS get_name
      RETURNING VALUE(rv_name) TYPE string.
  PRIVATE SECTION.
    DATA mv_name TYPE string.
ENDCLASS.
```

Deux objets `lcl_employee` possèdent chacun leur propre valeur de `mv_name`.

## 🌺 ATTRIBUTS STATIQUES

Un attribut déclaré avec `CLASS-DATA` appartient à la classe et est partagé entre toutes ses instances dans le contexte d’exécution concerné.

```abap
CLASS-DATA gv_instance_count TYPE i READ-ONLY.
```

Un état statique mutable introduit un couplage global. Il doit être réservé aux besoins réellement communs à la classe.

## 🌺 CONSTANTES

```abap
PUBLIC SECTION.
  CONSTANTS gc_status_active TYPE c LENGTH 1 VALUE 'A'.
```

Une constante publique convient lorsqu’elle fait partie du contrat. Une valeur purement interne doit rester privée.

## 🌺 TYPES

```abap
PUBLIC SECTION.
  TYPES:
    BEGIN OF ty_result,
      success TYPE abap_bool,
      message TYPE string,
    END OF ty_result.
```

Un type public permet aux consommateurs de déclarer des variables compatibles avec l’interface de la classe. Ne pas exposer un type interne qui n’est pas nécessaire à l’appelant.

## 🌺 READ ONLY

L’ajout `READ-ONLY` sur un attribut public limite les écritures depuis l’extérieur. La classe peut continuer à modifier cet attribut dans son implémentation.

```abap
PUBLIC SECTION.
  DATA mv_identifier TYPE string READ-ONLY.
```

Cette technique reste moins protectrice qu’un attribut privé exposé par une méthode de lecture. Une méthode permet de changer ultérieurement le calcul, le format ou les contrôles sans modifier le contrat de données.

## 🌺 ACCÈS AUX COMPOSANTS

| Composant           | Accès depuis une référence d’objet | Accès par le nom de classe |
| ------------------- | ---------------------------------- | -------------------------- |
| Attribut d’instance | `lo_object->mv_value`              | Non                        |
| Attribut statique   | Sans objet                         | `lcl_class=>gv_value`      |
| Constante statique  | Sans objet                         | `lcl_class=>gc_value`      |
| Type public         | Sans objet                         | `lcl_class=>ty_type`       |

Pour un composant statique, utiliser le sélecteur `=>` afin de rendre l’intention explicite.

## 🌺 RÈGLE

Les attributs publics doivent rester exceptionnels. Préférer un état privé et des méthodes exprimant les opérations autorisées.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser attributs, constantes et types de classe dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
CLASS lcl_employee DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_name TYPE string.
    METHODS get_name
      RETURNING VALUE(rv_name) TYPE string.
  PRIVATE SECTION.
    DATA mv_name TYPE string.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser attributs, constantes et types de classe dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)


---

➡️ [Chapitre suivant — MÉTHODES ET PARAMÈTRES](<./06 - 🍧 METHODES ET PARAMETRES.md>)
