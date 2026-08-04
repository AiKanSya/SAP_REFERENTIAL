# PRINCIPES D ABAP UNIT

## RÉSULTAT ATTENDU

Tester automatiquement une unité de logique ABAP de manière rapide, déterministe et indépendante.

## Structure minimale

```abap
" Vérifier un seul comportement observable avec une attente explicite.
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

## Attributs

- `FOR TESTING` identifie une classe ou méthode de test.
- `DURATION SHORT|MEDIUM|LONG` classe la durée attendue.
- `RISK LEVEL HARMLESS|DANGEROUS|CRITICAL` qualifie les effets possibles.

Les tests unitaires devraient généralement être courts et sans effet persistant.

## Caractéristiques d’un bon test

- vérifie un comportement précis ;
- prépare ses propres données ;
- ne dépend pas de l’ordre d’exécution ;
- fournit un message compréhensible en cas d’échec ;
- s’exécute de façon répétable ;
- ne dépend pas d’un utilisateur ou d’une date implicite.

## Périmètre

ABAP Unit ne remplace pas les tests d’intégration, d’autorisation, de performance ou de recette métier. Il protège la logique locale et accélère la détection des régressions.

## PROCESS

### ÉTAPE 1 — CHOISIR UNE UNITÉ OBSERVABLE

Sélectionner une méthode dont l’entrée et le résultat sont déterministes. Isoler les accès base, horloge, utilisateur et appels externes derrière des interfaces lorsque possible. Définir un comportement unique à protéger.

### ÉTAPE 2 — CRÉER LA CLASSE DE TEST LOCALE

Dans l’objet productif, ajouter une classe locale `FOR TESTING`, `FINAL`, avec `DURATION` et `RISK LEVEL` conformes au test. Garder ses données dans la section privée et utiliser un nom décrivant le composant testé.

### ÉTAPE 3 — DÉCLARER UNE MÉTHODE `FOR TESTING`

Nommer la méthode selon le comportement attendu, sans préfixe générique. Préparer ses entrées dans le test ou dans `setup`. Un test ne doit pas dépendre de l’exécution préalable d’une autre méthode.

### ÉTAPE 4 — EXÉCUTER ET ASSERTIR

Appeler l’unité, récupérer son résultat puis utiliser `CL_ABAP_UNIT_ASSERT` avec valeur attendue explicite et message utile. Ne recopier pas dans le test le même algorithme que la méthode productrice.

### ÉTAPE 5 — LANCER ABAP UNIT

Exécuter les tests depuis l’éditeur ou l’outil disponible sur l’objet. Ouvrir le détail d’un échec, corriger le code ou l’attente puis relancer. Vérifier que le test échoue réellement lorsque le comportement est volontairement rompu dans un essai local contrôlé.

### ÉTAPE 6 — INTÉGRER AU CONTRÔLE DE LIVRAISON

Exécuter la classe, le package ou la demande complète selon la procédure. Conserver des tests courts, sans commit ni donnée persistante. Ajouter des tests d’intégration séparés pour les contrats que l’unité ne couvre pas.

## Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Test Attributes](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4925667929ac16b7e10000000a42189d.html)
- [SAP Help Portal — Using the ABAP Unit Wizard](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4729180dafbd475891697ec0e7bc64e2.html)

## VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Vérifier un seul comportement observable avec une attente explicite.
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

## TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
