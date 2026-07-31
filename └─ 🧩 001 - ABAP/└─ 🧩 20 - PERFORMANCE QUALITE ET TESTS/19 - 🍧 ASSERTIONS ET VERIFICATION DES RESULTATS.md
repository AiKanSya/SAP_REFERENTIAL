# 🌸 ASSERTIONS ET VERIFICATION DES RESULTATS

## 🌺 Objectif

Exprimer clairement le résultat attendu avec `CL_ABAP_UNIT_ASSERT`.

## 🌺 Assertions courantes

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
cl_abap_unit_assert=>assert_equals(
  exp = 'APPROVED'
  act = lv_status
  msg = 'Le statut calculé est incorrect' ).
```

## 🌺 Une assertion lisible

La valeur attendue doit être stable et explicite. Éviter de reproduire dans le test le même algorithme que le code testé, car les deux peuvent contenir la même erreur.

## 🌺 Plusieurs vérifications

Regrouper plusieurs assertions uniquement lorsqu’elles décrivent un même comportement. Si la première assertion échoue, les suivantes ne seront pas évaluées ; un test trop large masque donc une partie du diagnostic.

## 🌺 Comparaisons

Tenir compte des types, décimales, arrondis, dates et ordres de lignes. Pour une table dont l’ordre n’est pas fonctionnel, normaliser ou trier explicitement les données du test avant comparaison.

## 🌺 Message d’échec

Le message doit indiquer le comportement attendu et le contexte, pas seulement « test KO ».

## 🌺 Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)

## 🌺 CAS D’USAGE

Dans un contexte où un programme critique doit conserver ses résultats tout en respectant les exigences de performance, qualité et non-régression, le besoin consiste à **appliquer assertions et verification des resultats pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
cl_abap_unit_assert=>assert_equals(
  exp = 'APPROVED'
  act = lv_status
  msg = 'Le statut calculé est incorrect' ).
```

## 🌺 TERMES DU LEXIQUE

- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer assertions et verification des resultats pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — TESTER EXCEPTIONS ET CAS LIMITES](<./20 - 🍧 TESTER EXCEPTIONS ET CAS LIMITES.md>)
