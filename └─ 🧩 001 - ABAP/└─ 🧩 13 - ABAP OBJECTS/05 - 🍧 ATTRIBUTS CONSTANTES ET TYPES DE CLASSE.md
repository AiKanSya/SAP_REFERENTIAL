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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)

---

➡️ [Chapitre suivant — MÉTHODES ET PARAMÈTRES](<./06 - 🍧 METHODES ET PARAMETRES.md>)
