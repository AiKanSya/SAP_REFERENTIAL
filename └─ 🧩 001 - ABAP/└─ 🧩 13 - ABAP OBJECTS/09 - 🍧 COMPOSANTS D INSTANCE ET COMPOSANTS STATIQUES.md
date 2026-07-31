# 🌸 COMPOSANTS D INSTANCE ET COMPOSANTS STATIQUES

## 🌺 OBJECTIFS

- Distinguer état d’instance et état partagé
- Utiliser `METHODS` et `CLASS-METHODS`
- Employer correctement `->` et `=>`
- Éviter l’état statique mutable non maîtrisé

## 🌺 COMPOSANTS D INSTANCE

Les composants d’instance appartiennent à chaque objet :

- attribut déclaré avec `DATA` ;
- méthode déclarée avec `METHODS` ;
- événement déclaré avec `EVENTS`.

Accès :

```abap
lo_counter->increment( ).
lv_value = lo_counter->get_value( ).
```

Le sélecteur `->` nécessite une référence d’objet liée.

## 🌺 COMPOSANTS STATIQUES

Les composants statiques appartiennent à la classe :

- attribut déclaré avec `CLASS-DATA` ;
- méthode déclarée avec `CLASS-METHODS` ;
- événement déclaré avec `CLASS-EVENTS` ;
- constantes et types de classe.

Accès recommandé :

```abap
lv_result = lcl_math=>calculate_square( iv_value = 5 ).
```

Le sélecteur `=>` rend explicite l’absence d’instance.

## 🌺 EXEMPLE

```abap
CLASS lcl_math DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS calculate_square
      IMPORTING iv_value         TYPE i
      RETURNING VALUE(rv_result) TYPE i.
ENDCLASS.

CLASS lcl_math IMPLEMENTATION.
  METHOD calculate_square.
    rv_result = iv_value * iv_value.
  ENDMETHOD.
ENDCLASS.
```

Une méthode statique convient à une opération sans état d’instance. La classe ne sert alors que d’espace de nom contrôlé.

## 🌺 ÉTAT STATIQUE MUTABLE

```abap
CLASS-DATA gv_last_result TYPE i.
```

Cet état est partagé. Il peut créer :

- une dépendance à l’ordre des appels ;
- des tests interdépendants ;
- des résultats différents selon la session ;
- un couplage invisible entre consommateurs.

Éviter d’utiliser `CLASS-DATA` comme variable globale déguisée.

## 🌺 CHOIX

| Besoin                          | Composant conseillé                                             |
| ------------------------------- | --------------------------------------------------------------- |
| État propre à chaque objet      | Attribut d’instance                                             |
| Comportement utilisant cet état | Méthode d’instance                                              |
| Constante commune               | `CONSTANTS`                                                     |
| Opération pure sans instance    | Méthode statique                                                |
| Cache partagé                   | Seulement avec stratégie explicite d’invalidation et de session |

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)

---

➡️ [Chapitre suivant — ENCAPSULATION ET ÉTAT COHÉRENT](<./10 - 🍧 ENCAPSULATION ET ETAT COHERENT.md>)
