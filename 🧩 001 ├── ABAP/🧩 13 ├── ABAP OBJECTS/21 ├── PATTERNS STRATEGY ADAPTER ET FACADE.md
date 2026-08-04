# 21. PATTERNS STRATEGY, ADAPTER ET FAÇADE

## 21.A RÉSULTAT ATTENDU

- Reconnaître trois patterns courants en ABAP Objects[^terme-abap-objects].
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

**Problème :** une classe[^terme-classe] existante fournit le bon service avec une interface incompatible.

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

**Problème :** un sous-système exige plusieurs appels complexes. La façade[^terme-facade] fournit un point d’entrée simple.

```abap
DATA(lv_document_id) = lo_billing_facade->create_and_post(
  is_request = ls_request ).
```

La façade orchestre les validateurs, repositories et appels techniques, mais ne doit pas devenir une classe géante.

## 21.E PROCESS

### 21.E.1 Étape 1 — Décrire le problème concret

Écrire les variantes, incompatibilités ou complexités observées sans nommer de pattern. Si le problème tient en une condition locale stable, ne créer pas d’architecture supplémentaire.

### 21.E.2 Étape 2 — Choisir la relation adaptée

Utiliser Strategy[^terme-strategy] pour plusieurs algorithmes substituables, Adapter pour convertir une interface existante et Facade pour offrir un point d’entrée simplifié sur plusieurs services.

### 21.E.3 Étape 3 — Définir le contrat minimal

Créer l’interface ou la méthode[^terme-methode] de façade à partir des besoins de l’appelant. Ne recopier pas toutes les méthodes du composant interne.

### 21.E.4 Étape 4 — Implémenter sans logique dupliquée

La Strategy porte l’algorithme, l’Adapter traduit les paramètres/résultats et la Facade orchestre. Ne déplacer pas la même règle métier[^terme-regle-metier] dans plusieurs couches.

### 21.E.5 Étape 5 — Prouver l’intérêt

Tester substitution, traduction ou simplification. Documenter pourquoi une fonction ou composition[^terme-composition] directe ne suffisait pas. Le pattern est validé uniquement si cette preuve reste observable.

## 21.F TABLEAU DE DÉCISION

| Situation                                 | Pattern probable         |
| ----------------------------------------- | ------------------------ |
| Changer un calcul à l’exécution           | Strategy                 |
| Réutiliser une API[^terme-api] existante incompatible | Adapter                  |
| Masquer une séquence d’appels complexes   | Façade                   |
| Centraliser la création                   | Factory                  |
| Une seule instance par session            | Singleton[^terme-singleton], avec prudence |

## 21.G CONTRÔLE

Le pattern doit réduire le couplage observable. Si le nombre de classes augmente sans simplifier les consommateurs ou les tests, la conception doit être réévaluée.

## 21.H ERREURS FRÉQUENTES

- Ajouter un pattern pour un seul `IF` stable.
- Confondre façade et classe « fourre-tout ».
- Adapter une API que l’on contrôle au lieu de corriger directement son contrat.

## 21.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 21.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects Design Patterns – Adapter — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapobjects/3353526304.html)
- [Implementing Factory Methods — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-factory-methods_ff885b1e-5e7c-4d73-b9df-b4be5112e1fa)
- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)

---

[Chapitre suivant — CLASSES LOCALES DANS UN CLASS POOL](<./22 ├── CLASSES LOCALES DANS UN CLASS POOL.md>)

[^terme-abap-objects]: **ABAP OBJECTS.** Extension orientée objet du langage ABAP fournissant classes, interfaces, héritage, événements et exceptions de classe. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap-objects>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-facade]: **FAÇADE.** Pattern fournissant une interface simplifiée devant plusieurs composants ou sous-systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#facade>).
[^terme-strategy]: **STRATEGY.** Pattern qui encapsule plusieurs algorithmes interchangeables derrière une même interface. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#strategy>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-regle-metier]: **RÈGLE MÉTIER.** Condition ou calcul imposé par le processus fonctionnel. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#regle-metier>).
[^terme-composition]: **COMPOSITION.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#composition>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-singleton]: **SINGLETON.** Pattern limitant la création à une seule instance accessible dans une session interne ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#singleton>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
