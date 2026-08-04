# 20. TESTER EXCEPTIONS ET CAS LIMITES

## 20.A RÉSULTAT ATTENDU

Vérifier les chemins d’erreur, les limites et les entrées invalides, pas seulement le scénario nominal.

## 20.B Tester une exception

```abap
" Vérifier un seul comportement observable avec une attente explicite.
METHOD rejects_negative_quantity.
  TRY.
      zcl_quantity=>validate( -1 ).
      cl_abap_unit_assert=>fail(
        msg = 'Une exception était attendue' ).
    CATCH zcx_invalid_quantity INTO DATA(lx_error).
      cl_abap_unit_assert=>assert_equals(
        exp = 'NEGATIVE_QUANTITY'
        act = lx_error->reason ).
  ENDTRY.
ENDMETHOD.
```

## 20.C Cas limites à identifier

- valeur initiale ;
- minimum et maximum ;
- juste avant et juste après une borne ;
- table vide et table contenant une ligne ;
- doublons ;
- chaînes vides, espaces et caractères spéciaux ;
- date de changement de période ;
- division par zéro ;
- référence non liée ;
- erreur de conversion.

## 20.D Équivalence

Il n’est pas nécessaire de tester toutes les valeurs. Regrouper les entrées qui doivent produire le même comportement, puis sélectionner une valeur représentative et les bornes.

## 20.E Test d’un message

Lorsque le comportement utilise des messages classiques, préférer isoler la logique métier dans une méthode[^terme-methode] qui retourne un résultat ou lève une exception[^terme-exception]. Les tests deviennent plus simples et moins dépendants du contexte Dynpro[^terme-dynpro].

## 20.F PROCESS

### 20.F.1 ÉTAPE 1 — PARTITIONNER LES ENTRÉES

Lister classes d’équivalence, minimum, maximum, juste avant/après chaque borne, initial, vide, doublon et valeur invalide. Sélectionner une valeur représentative par classe[^terme-classe] plus les limites où le comportement change.

### 20.F.2 ÉTAPE 2 — DÉCLARER UN TEST PAR COMPORTEMENT

Créer une méthode `FOR TESTING` dont le nom indique l’entrée et le résultat : rejet d’une quantité négative, acceptation de zéro ou table vide. Éviter un seul test parcourant tous les cas sans diagnostic précis.

### 20.F.3 ÉTAPE 3 — TESTER UNE EXCEPTION ATTENDUE

Appeler la méthode dans `TRY`. Immédiatement après, utiliser `CL_ABAP_UNIT_ASSERT=>FAIL` si aucune exception n’est levée. Intercepter ensuite la classe exacte attendue, pas `CX_ROOT` si le contrat est plus précis.

### 20.F.4 ÉTAPE 4 — VÉRIFIER LE CONTENU DE L’EXCEPTION

Comparer attribut[^terme-attribut], texte T100, previous ou raison selon le contrat public de la classe. Ne pas dépendre d’un texte traduit si un identifiant stable existe. Vérifier aussi qu’une exception différente n’est pas acceptée silencieusement.

### 20.F.5 ÉTAPE 5 — TESTER LES BORNES POSITIVES

Ajouter les cas juste valides autour de la règle afin de détecter les erreurs `>`/`>=` et les arrondis. Tester tables vides, une ligne et doublons selon le modèle. Utiliser des dates fixes injectées plutôt que `sy-datum` implicite.

### 20.F.6 ÉTAPE 6 — EXÉCUTER INDÉPENDAMMENT

Lancer chaque cas seul puis le groupe complet. Vérifier absence d’état persistant et résultat identique à chaque répétition. Compléter par un test d’intégration lorsque l’erreur dépend d’une base, d’une autorisation ou d’un framework.

## 20.G Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)

## 20.H VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 20.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 20.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Vérifier un seul comportement observable avec une attente explicite.
METHOD rejects_negative_quantity.
  TRY.
      zcl_quantity=>validate( -1 ).
      cl_abap_unit_assert=>fail(
        msg = 'Une exception était attendue' ).
    CATCH zcx_invalid_quantity INTO DATA(lx_error).
      cl_abap_unit_assert=>assert_equals(
        exp = 'NEGATIVE_QUANTITY'
        act = lx_error->reason ).
  ENDTRY.
ENDMETHOD.
```

## 20.K TERMES DU LEXIQUE

- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
