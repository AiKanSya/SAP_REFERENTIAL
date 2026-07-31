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

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser composants d instance et composants statiques dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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

## 🌺 TERMES DU LEXIQUE

- [Instance](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/01 - 🍧 SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#instance>)
- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser composants d instance et composants statiques dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)


---

➡️ [Chapitre suivant — ENCAPSULATION ET ÉTAT COHÉRENT](<./10 - 🍧 ENCAPSULATION ET ETAT COHERENT.md>)
