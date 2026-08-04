# PATTER" Définir le contrat et limiter l’API publique au besoin réel.
NS STRATEGY, ADAPTER ET FAÇADE

## RÉSULTAT ATTENDU

- Reconnaître trois patterns courants en ABAP Objects.
- Choisir un pattern en fonction du problème, pas par effet de mode.
- Distinguer variation d’algorithme, incompatibilité d’interface et simplification d’un sous-système.

## STRATEGY

**Problème :** plusieurs algorithmes interchangeables.

Exemple : calcul de remise standard, partenaire ou campagne. Chaque stratégie implémente `ZIF_DEV_DISCOUNT`.

```abap
DATA(lo_strategy) = zcl_dev_discount_factory=>create( iv_type ).
DATA(lv_discount) = lo_strategy->calculate( is_context ).
```

## ADAPTER

**Problème :** une classe existante fournit le bon service avec une interface incompatible.

L’adapter implémente l’interface attendue et traduit l’appel vers l’objet existant.

Contrat attendu par le consommateur :

```abap
INTERFACE zif_dev_logger PUBLIC.
  METHODS info
    IMPORTING iv_message TYPE string.
ENDINTERFACE.
```

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD zif_dev_logger~info.
  mo_legacy_log->add_message(
    iv_type = 'I'
    iv_text = iv_message ).
ENDMETHOD.
```

## FACADE

**Problème :** un sous-système exige plusieurs appels complexes. La façade fournit un point d’entrée simple.

```abap
DATA(lv_document_id) = lo_billing_facade->create_and_post(
  is_request = ls_request ).
```

La façade orchestre les validateurs, repositories et appels techniques, mais ne doit pas devenir une classe géante.

## PROCÉDURE DE CHOIX

1. Décrire le problème sans citer de pattern.
2. Identifier ce qui varie ou ce qui est incompatible.
3. Vérifier qu’une interface simple peut représenter le contrat.
4. Appliquer le pattern minimal.
5. Écrire un test démontrant la substitution ou la simplification.
6. Documenter pourquoi une solution plus simple ne suffisait pas.

## TABLEAU DE DÉCISION

| Situation | Pattern probable |
|---|---|
| Changer un calcul à l’exécution | Strategy |
| Réutiliser une API existante incompatible | Adapter |
| Masquer une séquence d’appels complexes | Façade |
| Centraliser la création | Factory |
| Une seule instance par session | Singleton, avec prudence |

## CONTRÔLE

Le pattern doit réduire le couplage observable. Si le nombre de classes augmente sans simplifier les consommateurs ou les tests, la conception doit être réévaluée.

## ERREURS FRÉQUENTES

- Ajouter un pattern pour un seul `IF` stable.
- Confondre façade et classe « fourre-tout ».
- Adapter une API que l’on contrôle au lieu de corriger directement son contrat.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects Design Patterns – Adapter — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapobjects/3353526304.html)
- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)

---

[Chapitre suivant — CLASSES LOCALES DANS UN CLASS POOL](<./22 ├── CLASSES LOCALES DANS UN CLASS POOL.md>)
