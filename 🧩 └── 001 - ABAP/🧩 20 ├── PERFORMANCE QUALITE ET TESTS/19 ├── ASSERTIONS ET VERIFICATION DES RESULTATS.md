# 19. ASSERTIONS ET VERIFICATION DES RESULTATS

## 19.A RÉSULTAT ATTENDU

Exprimer clairement le résultat attendu avec `CL_ABAP_UNIT_ASSERT`.

## 19.B Assertions courantes

| Besoin              | Méthode typique      |
| ------------------- | -------------------- |
| égalité             | `ASSERT_EQUALS`      |
| valeur initiale     | `ASSERT_INITIAL`     |
| valeur non initiale | `ASSERT_NOT_INITIAL` |
| condition vraie     | `ASSERT_TRUE`        |
| condition fausse    | `ASSERT_FALSE`       |
| référence liée      | `ASSERT_BOUND`       |
| échec explicite     | `FAIL`               |

```abap
" Vérifier un seul comportement observable avec une attente explicite.
cl_abap_unit_assert=>assert_equals(
  exp = 'APPROVED'
  act = lv_status
  msg = 'Le statut calculé est incorrect' ).
```

## 19.C Une assertion lisible

La valeur attendue doit être stable et explicite. Éviter de reproduire dans le test le même algorithme que le code testé, car les deux peuvent contenir la même erreur.

## 19.D Plusieurs vérifications

Regrouper plusieurs assertions uniquement lorsqu’elles décrivent un même comportement. Si la première assertion échoue, les suivantes ne seront pas évaluées ; un test trop large masque donc une partie du diagnostic.

## 19.E Comparaisons

Tenir compte des types, décimales, arrondis, dates et ordres de lignes. Pour une table dont l’ordre n’est pas fonctionnel, normaliser ou trier explicitement les données du test avant comparaison.

## 19.F Message d’échec

Le message doit indiquer le comportement attendu et le contexte, pas seulement « test KO ».

## 19.G PROCESS

### 19.G.1 ÉTAPE 1 — FORMULER UNE ATTENTE UNIQUE

Écrire le comportement en termes d’entrée, action et résultat observable. Choisir une valeur attendue indépendante de l’implémentation. Si plusieurs résultats n’appartiennent pas au même comportement, créer plusieurs tests.

### 19.G.2 ÉTAPE 2 — CHOISIR L’ASSERTION LA PLUS PRÉCISE

Utiliser `ASSERT_EQUALS` pour une valeur, `ASSERT_INITIAL` ou `ASSERT_NOT_INITIAL` pour l’état initial, `ASSERT_TRUE`/`FALSE` pour un booléen et `ASSERT_BOUND` pour une référence. Réserver `FAIL` à l’absence d’un événement attendu comme une exception.

### 19.G.3 ÉTAPE 3 — NORMALISER UNIQUEMENT LA SÉMANTIQUE NON SIGNIFICATIVE

Trier une table si l’ordre n’appartient pas au contrat. Normaliser les arrondis, fuseaux ou formats selon les règles métier. Ne pas supprimer une différence qui devrait justement faire échouer le test.

### 19.G.4 ÉTAPE 4 — AJOUTER UN MESSAGE ACTIONNABLE

Renseigner `MSG` avec le comportement et le contexte utile. Ne pas y placer un simple doublon de la valeur réelle ni une donnée sensible. Le développeur doit comprendre l’intention sans relire tout le test.

### 19.G.5 ÉTAPE 5 — VÉRIFIER QUE LE TEST DÉTECTE LE DÉFAUT

Dans un essai local, modifier temporairement l’entrée ou l’attente et confirmer l’échec sur l’assertion prévue. Restaurer immédiatement. Un test qui reste vert malgré un comportement faux ne protège rien.

### 19.G.6 ÉTAPE 6 — EXÉCUTER LE GROUPE COMPLET

Relancer tous les tests du composant et vérifier qu’un échec n’est pas masqué par une exception précédente ou une fixture partagée. Conserver des assertions peu nombreuses et directement liées au nom de la méthode.

## 19.H Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)

## 19.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 19.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Vérifier un seul comportement observable avec une attente explicite.
cl_abap_unit_assert=>assert_equals(
  exp = 'APPROVED'
  act = lv_status
  msg = 'Le statut calculé est incorrect' ).
```

## 19.K TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
