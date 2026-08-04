# 21. PATTERNS STRATEGY, ADAPTER ET FAÇADE

## 21.A RÉSULTAT ATTENDU

- Reconnaître trois patterns courants en ABAP Objects.
- Choisir un pattern en fonction du problème, pas par effet de mode.
- Distinguer variation d’algorithme, incompatibilité d’interface et simplification d’un sous-système.

## 21.B STRATEGY

**Problème :** plusieurs algorithmes interchangeables.

Exemple : calcul de remise standard, partenaire ou campagne. Chaque stratégie implémente `ZIF_DEV_DISCOUNT`.

```abap
DATA(lo_strategy) = zcl_dev_discount_factory=>create( iv_type ).
DATA(lv_discount) = lo_strategy->calculate( is_context ).
```

## 21.C ADAPTER

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

## 21.D FACADE

**Problème :** un sous-système exige plusieurs appels complexes. La façade fournit un point d’entrée simple.

```abap
DATA(lv_document_id) = lo_billing_facade->create_and_post(
  is_request = ls_request ).
```

La façade orchestre les validateurs, repositories et appels techniques, mais ne doit pas devenir une classe géante.

## 21.E PROCESS

### 21.E.1 Étape 1 — Décrire le problème concret

Écrire les variantes, incompatibilités ou complexités observées sans nommer de pattern. Si le problème tient en une condition locale stable, ne créer pas d’architecture supplémentaire.

### 21.E.2 Étape 2 — Choisir la relation adaptée

Utiliser Strategy pour plusieurs algorithmes substituables, Adapter pour convertir une interface existante et Facade pour offrir un point d’entrée simplifié sur plusieurs services.

### 21.E.3 Étape 3 — Définir le contrat minimal

Créer l’interface ou la méthode de façade à partir des besoins de l’appelant. Ne recopier pas toutes les méthodes du composant interne.

### 21.E.4 Étape 4 — Implémenter sans logique dupliquée

La Strategy porte l’algorithme, l’Adapter traduit les paramètres/résultats et la Facade orchestre. Ne déplacer pas la même règle métier dans plusieurs couches.

### 21.E.5 Étape 5 — Prouver l’intérêt

Tester substitution, traduction ou simplification. Documenter pourquoi une fonction ou composition directe ne suffisait pas. Le pattern est validé uniquement si cette preuve reste observable.

## 21.F TABLEAU DE DÉCISION

| Situation                                 | Pattern probable         |
| ----------------------------------------- | ------------------------ |
| Changer un calcul à l’exécution           | Strategy                 |
| Réutiliser une API existante incompatible | Adapter                  |
| Masquer une séquence d’appels complexes   | Façade                   |
| Centraliser la création                   | Factory                  |
| Une seule instance par session            | Singleton, avec prudence |

## 21.G CONTRÔLE

Le pattern doit réduire le couplage observable. Si le nombre de classes augmente sans simplifier les consommateurs ou les tests, la conception doit être réévaluée.

## 21.H ERREURS FRÉQUENTES

- Ajouter un pattern pour un seul `IF` stable.
- Confondre façade et classe « fourre-tout ».
- Adapter une API que l’on contrôle au lieu de corriger directement son contrat.

## 21.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 21.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects Design Patterns – Adapter — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapobjects/3353526304.html)
- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)

---

[Chapitre suivant — CLASSES LOCALES DANS UN CLASS POOL](<./22 ├── CLASSES LOCALES DANS UN CLASS POOL.md>)
