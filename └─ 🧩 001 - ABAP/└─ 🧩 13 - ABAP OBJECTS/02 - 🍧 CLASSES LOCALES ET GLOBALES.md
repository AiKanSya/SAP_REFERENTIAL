# 🌸 CLASSES LOCALES ET GLOBALES

## 🌺 OBJECTIFS

- Distinguer classes locales et classes globales
- Choisir la portée adaptée au besoin
- Comprendre l’impact sur la réutilisation et le transport
- Identifier les règles de déclaration d’une classe locale

## 🌺 CLASSE LOCALE

Une classe locale est déclarée dans le code source d’un programme ABAP. Elle n’est utilisable que dans ce programme.

```abap
CLASS lcl_validator DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS is_valid
      IMPORTING iv_value        TYPE i
      RETURNING VALUE(rv_valid) TYPE abap_bool.
ENDCLASS.

CLASS lcl_validator IMPLEMENTATION.
  METHOD is_valid.
    rv_valid = xsdbool( iv_value > 0 ).
  ENDMETHOD.
ENDCLASS.
```

Préfixe couramment utilisé : `LCL_` pour une classe locale et `LIF_` pour une interface locale. Ces préfixes relèvent d’une convention de nommage, pas d’une obligation du langage.

## 🌺 CLASSE GLOBALE

Une classe globale est un objet du Repository ABAP. Elle est créée dans la bibliothèque de classes, généralement avec `SE24` ou `SE80`, puis affectée à un package et à un ordre de transport.

```mermaid
flowchart LR
    A["Classe locale"] --> B["Utilisable dans un seul programme"]
    C["Classe globale"] --> D["Utilisable dans les programmes autorisés du système"]
```

## 🌺 COMPARAISON

| Critère                   | Classe locale     | Classe globale              |
| ------------------------- | ----------------- | --------------------------- |
| Portée                    | Programme courant | Repository ABAP             |
| Réutilisation             | Locale            | Transversale                |
| Objet Repository distinct | Non               | Oui                         |
| Package propre            | Non               | Oui                         |
| Transport indépendant     | Non               | Oui                         |
| Nom typique               | `LCL_*`           | `ZCL_*` ou namespace client |

## 🌺 CHOIX PRATIQUE

Utiliser une classe locale pour :

- structurer un rapport spécifique ;
- isoler un gestionnaire d’événement local ;
- créer un adaptateur limité à un seul programme ;
- encapsuler une logique qui ne constitue pas une API partagée.

Utiliser une classe globale pour :

- exposer un service réutilisable ;
- partager un contrat entre plusieurs applications ;
- implémenter un framework SAP ;
- centraliser une logique métier ou technique stable ;
- permettre une utilisation par d’autres objets Repository.

## 🌺 ORDRE DANS UN PROGRAMME

La définition d’une classe locale doit être connue avant son utilisation. La forme classique est :

1. déclarations globales éventuelles ;
2. définitions des classes locales ;
3. implémentations des classes locales ;
4. blocs événementiels du programme.

Des déclarations différées avec `CLASS ... DEFINITION DEFERRED` permettent de résoudre certaines dépendances circulaires de typage, mais elles ne remplacent pas une architecture claire.

## 🌺 RÈGLE DE CONCEPTION

Ne rendre une classe globale que lorsqu’elle constitue réellement une unité réutilisable. Une classe globale inutilement publique augmente la surface d’API à maintenir.

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser classes locales et globales dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE80`.
2. Sélectionner le type d’objet ou le package dans la liste de gauche.
3. Entrer le nom technique puis valider.
4. Commencer en mode **Afficher** pour analyser l’objet et ses sous-objets.
5. Passer en modification uniquement dans un système et un objet autorisés.
6. Contrôler la syntaxe, activer les objets modifiés puis vérifier leur statut actif.

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
CLASS lcl_validator DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS is_valid
      IMPORTING iv_value        TYPE i
      RETURNING VALUE(rv_valid) TYPE abap_bool.
ENDCLASS.

CLASS lcl_validator IMPLEMENTATION.
  METHOD is_valid.
    rv_valid = xsdbool( iv_value > 0 ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser classes locales et globales dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [Global Declarations of a Program — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENGLOBAL_DECLAR_GUIDL.html)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)


---

➡️ [Chapitre suivant — CLASS BUILDER SE24 ET CLASS POOLS](<./03 - 🍧 CLASS BUILDER SE24 ET CLASS POOLS.md>)
