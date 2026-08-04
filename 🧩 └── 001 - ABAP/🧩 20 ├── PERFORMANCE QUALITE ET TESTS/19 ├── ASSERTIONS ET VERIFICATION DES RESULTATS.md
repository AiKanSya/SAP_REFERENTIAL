# ASSERTIONS ET VERIFICATION DES RESULTATS

## RÉSULTAT ATTENDU

Exprimer clairement le résultat attendu avec `CL_ABAP_UNIT_ASSERT`.

## Assertions courantes

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

## Une assertion lisible

La valeur attendue doit être stable et explicite. Éviter de reproduire dans le test le même algorithme que le code testé, car les deux peuvent contenir la même erreur.

## Plusieurs vérifications

Regrouper plusieurs assertions uniquement lorsqu’elles décrivent un même comportement. Si la première assertion échoue, les suivantes ne seront pas évaluées ; un test trop large masque donc une partie du diagnostic.

## Comparaisons

Tenir compte des types, décimales, arrondis, dates et ordres de lignes. Pour une table dont l’ordre n’est pas fonctionnel, normaliser ou trier explicitement les données du test avant comparaison.

## Message d’échec

Le message doit indiquer le comportement attendu et le contexte, pas seulement « test KO ».

## Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)

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
cl_abap_unit_assert=>assert_equals(
  exp = 'APPROVED'
  act = lv_status
  msg = 'Le statut calculé est incorrect' ).
```

## TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
