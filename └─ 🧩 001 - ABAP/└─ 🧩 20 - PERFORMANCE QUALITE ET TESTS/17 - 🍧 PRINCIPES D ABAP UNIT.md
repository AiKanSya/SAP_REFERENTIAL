# 🍧 PRINCIPES D ABAP UNIT

## 🎯 Objectif

Tester automatiquement une unité de logique ABAP de manière rapide, déterministe et indépendante.

## 🧱 Structure minimale

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

## 📌 Attributs

- `FOR TESTING` identifie une classe ou méthode de test.
- `DURATION SHORT|MEDIUM|LONG` classe la durée attendue.
- `RISK LEVEL HARMLESS|DANGEROUS|CRITICAL` qualifie les effets possibles.

Les tests unitaires devraient généralement être courts et sans effet persistant.

## 🎯 Caractéristiques d’un bon test

- vérifie un comportement précis ;
- prépare ses propres données ;
- ne dépend pas de l’ordre d’exécution ;
- fournit un message compréhensible en cas d’échec ;
- s’exécute de façon répétable ;
- ne dépend pas d’un utilisateur ou d’une date implicite.

## ⚠️ Périmètre

ABAP Unit ne remplace pas les tests d’intégration, d’autorisation, de performance ou de recette métier. Il protège la logique locale et accélère la détection des régressions.

## 🔗 Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Test Attributes](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4925667929ac16b7e10000000a42189d.html)
- [SAP Help Portal — Using the ABAP Unit Wizard](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4729180dafbd475891697ec0e7bc64e2.html)

---

➡️ [Chapitre suivant : CLASSES DE TEST ET CYCLE D EXECUTION](<18 - 🍧 CLASSES DE TEST ET CYCLE D EXECUTION.md>)
