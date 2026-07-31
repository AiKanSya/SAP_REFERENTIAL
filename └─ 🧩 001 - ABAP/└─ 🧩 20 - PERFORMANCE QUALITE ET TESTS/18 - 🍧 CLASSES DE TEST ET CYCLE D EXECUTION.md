# 🌸 CLASSES DE TEST ET CYCLE D EXECUTION

## 🌺 Objectif

Utiliser les fixtures ABAP Unit pour préparer et nettoyer un contexte de test cohérent.

## 🌺 Méthodes prédéfinies

| Méthode               | Fréquence                             |
| --------------------- | ------------------------------------- |
| `class_setup`         | une fois avant les tests de la classe |
| `setup`               | avant chaque méthode de test          |
| méthode `FOR TESTING` | exécution du scénario                 |
| `teardown`            | après chaque méthode de test          |
| `class_teardown`      | une fois après tous les tests         |

```mermaid
flowchart LR
    A["CLASS_SETUP"] --> B["SETUP"]
    B --> C["Méthode de test"]
    C --> D["TEARDOWN"]
    D --> E["Test suivant"]
    E --> B
    E --> F["CLASS_TEARDOWN"]
```

## 🌺 Exemple

```abap
CLASS ltc_service DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO zcl_service.
    METHODS setup.
    METHODS returns_default_value FOR TESTING.
ENDCLASS.

CLASS ltc_service IMPLEMENTATION.
  METHOD setup.
    mo_cut = NEW zcl_service( ).
  ENDMETHOD.

  METHOD returns_default_value.
    cl_abap_unit_assert=>assert_not_initial(
      act = mo_cut->get_default_value( ) ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 Isolation

Chaque test doit pouvoir s’exécuter seul. `setup` ne doit pas dépendre des modifications réalisées par un test précédent. Les ressources partagées dans `class_setup` doivent être en lecture seule ou réinitialisées.

## 🌺 Références SAP officielles

- [SAP Help Portal — ABAP Unit Test Execution Sequence](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/baf1b5eb64254b8e8a4e5e79437cd441.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

## 🌺 CAS D’USAGE

Dans un contexte où un programme critique doit conserver ses résultats tout en respectant les exigences de performance, qualité et non-régression, le besoin consiste à **appliquer classes de test et cycle d execution pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CLASS ltc_service DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO zcl_service.
    METHODS setup.
    METHODS returns_default_value FOR TESTING.
ENDCLASS.

CLASS ltc_service IMPLEMENTATION.
  METHOD setup.
    mo_cut = NEW zcl_service( ).
  ENDMETHOD.

  METHOD returns_default_value.
    cl_abap_unit_assert=>assert_not_initial(
      act = mo_cut->get_default_value( ) ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer classes de test et cycle d execution pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — ASSERTIONS ET VERIFICATION DES RESULTATS](<./19 - 🍧 ASSERTIONS ET VERIFICATION DES RESULTATS.md>)
