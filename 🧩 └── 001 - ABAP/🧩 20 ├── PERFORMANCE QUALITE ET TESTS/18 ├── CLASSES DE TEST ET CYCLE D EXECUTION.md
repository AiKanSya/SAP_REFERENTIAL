# 18. CLASSES DE TEST ET CYCLE D EXECUTION

## 18.A RÉSULTAT ATTENDU

Utiliser les fixtures ABAP Unit pour préparer et nettoyer un contexte de test cohérent.

## 18.B Méthodes prédéfinies

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

## 18.C Exemple

```abap
" Vérifier un seul comportement observable avec une attente explicite.
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

## 18.D Isolation

Chaque test doit pouvoir s’exécuter seul. `setup` ne doit pas dépendre des modifications réalisées par un test précédent. Les ressources partagées dans `class_setup` doivent être en lecture seule ou réinitialisées.

## 18.E PROCESS

### 18.E.1 ÉTAPE 1 — INVENTORIER LES DONNÉES DE FIXTURE

Séparer les objets coûteux et immuables partagés par la classe des données propres à chaque test. Éviter les tables ou singletons modifiés qui conserveraient un état entre méthodes.

### 18.E.2 ÉTAPE 2 — DÉCLARER LE CYCLE

Déclarer `class_setup` et `class_teardown` comme méthodes de classe si nécessaires, puis `setup` et `teardown` comme méthodes d’instance. Déclarer les scénarios avec `FOR TESTING`. Utiliser uniquement les méthodes de cycle réellement utiles.

### 18.E.3 ÉTAPE 3 — INITIALISER LE PARTAGE IMMUTABLE

Dans `class_setup`, créer les ressources de lecture coûteuses utilisées par tous les tests. Ne pas créer une donnée mutable que les scénarios modifieront. Prévoir son nettoyage symétrique si elle utilise une ressource externe au runtime ABAP.

### 18.E.4 ÉTAPE 4 — RECRÉER LE COMPOSANT AVANT CHAQUE TEST

Dans `setup`, instancier le code sous test et ses doubles avec un état initial connu. Remettre tous les attributs modifiables à zéro. Le résultat ne doit dépendre ni de l’ordre ni d’une exécution précédente.

### 18.E.5 ÉTAPE 5 — NETTOYER SANS MASQUER LES ÉCHECS

Dans `teardown`, libérer les ressources propres au scénario sans supprimer une preuve nécessaire au diagnostic. Dans `class_teardown`, nettoyer les ressources partagées. Éviter les commits ou suppressions larges.

### 18.E.6 ÉTAPE 6 — EXÉCUTER ISOLÉMENT ET EN GROUPE

Lancer chaque méthode seule, puis toute la classe dans un ordre différent si l’outil le permet. Un résultat divergent révèle une dépendance de fixture. Corriger l’isolation avant d’ajouter de nouveaux scénarios.

## 18.F Références SAP officielles

- [SAP Help Portal — ABAP Unit Test Execution Sequence](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/baf1b5eb64254b8e8a4e5e79437cd441.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

## 18.G VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 18.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 18.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Vérifier un seul comportement observable avec une attente explicite.
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

## 18.J TERMES DU LEXIQUE

- [Classe](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
