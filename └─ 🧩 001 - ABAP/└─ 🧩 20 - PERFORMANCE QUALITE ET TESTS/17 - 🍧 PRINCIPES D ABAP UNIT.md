# 🌸 PRINCIPES D ABAP UNIT

## 🌺 Objectif

Tester automatiquement une unité de logique ABAP de manière rapide, déterministe et indépendante.

## 🌺 Structure minimale

```abap
CLASS ltc_calculator DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS add_two_numbers FOR TESTING.
ENDCLASS.

CLASS ltc_calculator IMPLEMENTATION.
  METHOD add_two_numbers.
    DATA(lv_result) = zcl_calculator=>add(
      iv_left  = 2
      iv_right = 3 ).

    cl_abap_unit_assert=>assert_equals(
      exp = 5
      act = lv_result ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 Attributs

- `FOR TESTING` identifie une classe ou méthode de test.
- `DURATION SHORT|MEDIUM|LONG` classe la durée attendue.
- `RISK LEVEL HARMLESS|DANGEROUS|CRITICAL` qualifie les effets possibles.

Les tests unitaires devraient généralement être courts et sans effet persistant.

## 🌺 Caractéristiques d’un bon test

- vérifie un comportement précis ;
- prépare ses propres données ;
- ne dépend pas de l’ordre d’exécution ;
- fournit un message compréhensible en cas d’échec ;
- s’exécute de façon répétable ;
- ne dépend pas d’un utilisateur ou d’une date implicite.

## 🌺 Périmètre

ABAP Unit ne remplace pas les tests d’intégration, d’autorisation, de performance ou de recette métier. Il protège la logique locale et accélère la détection des régressions.

## 🌺 Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Test Attributes](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4925667929ac16b7e10000000a42189d.html)
- [SAP Help Portal — Using the ABAP Unit Wizard](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4729180dafbd475891697ec0e7bc64e2.html)

## 🌺 CAS D’USAGE

Dans un contexte où un programme critique doit conserver ses résultats tout en respectant les exigences de performance, qualité et non-régression, le besoin consiste à **isoler une unité de code et vérifier automatiquement ses résultats**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

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
CLASS ltc_calculator DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS add_two_numbers FOR TESTING.
ENDCLASS.

CLASS ltc_calculator IMPLEMENTATION.
  METHOD add_two_numbers.
    DATA(lv_result) = zcl_calculator=>add(
      iv_left  = 2
      iv_right = 3 ).

    cl_abap_unit_assert=>assert_equals(
      exp = 5
      act = lv_result ).
  ENDMETHOD.
ENDCLASS.
```

## 🌺 TERMES DU LEXIQUE

- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **isoler une unité de code et vérifier automatiquement ses résultats**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — CLASSES DE TEST ET CYCLE D EXECUTION](<./18 - 🍧 CLASSES DE TEST ET CYCLE D EXECUTION.md>)
