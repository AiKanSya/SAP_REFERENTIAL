# 3. IDENTIFIER LES COUTS D EXECUTION

## 3.A RÉSULTAT ATTENDU

Distinguer les principales familles de coûts d’un traitement ABAP afin de sélectionner l’outil et la correction appropriés.

## 3.B Composants du temps de réponse

| Composant       | Exemples de causes                                          |
| --------------- | ----------------------------------------------------------- |
| ABAP            | boucles imbriquées, conversions répétées, appels dynamiques |
| Base de données | requêtes répétées, filtres insuffisants, gros transferts    |
| Réseau/RFC      | nombreux petits appels, données surdimensionnées            |
| Verrous         | attente sur objets de verrouillage                          |
| Mise à jour     | traitements V1/V2 longs ou en erreur                        |
| Présentation    | ALV volumineux, contrôles frontend                          |

## 3.C Symptômes fréquents

- **Temps base dominant** : analyser `ST05`, `SQLM` et le volume transféré.
- **Temps ABAP dominant** : analyser `SAT`, les appels et les boucles.
- **Mémoire croissante** : comparer des snapshots et vérifier les références conservées.
- **Durée irrégulière** : examiner les verrous, la concurrence, les buffers et les données.
- **Rapide en DEV, lent en production** : comparer les volumes et le plan d’accès, pas seulement le code.

## 3.D Complexité algorithmique

Une boucle simple sur `n` lignes a généralement un coût proportionnel à `n`. Deux parcours imbriqués peuvent produire un coût proche de `n × m`. Sur quelques lignes, la différence est invisible ; sur plusieurs centaines de milliers, elle devient dominante.

```abap
LOOP AT lt_header INTO DATA(ls_header).
  LOOP AT lt_item INTO DATA(ls_item)
       WHERE document_id = ls_header-document_id.
    " Traitement
  ENDLOOP.
ENDLOOP.
```

Cette forme doit déclencher une analyse : table triée avec clé adaptée, table hachée, regroupement préalable ou traitement SQL unique.

## 3.E Ne pas confondre cause et symptôme

Réduire une boucle ABAP ne corrige pas une requête ramenant dix fois trop de colonnes. Ajouter un index ne corrige pas une requête exécutée dans une boucle. Le diagnostic doit localiser le coût avant le choix technique.

## 3.F Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [ABAP Keyword Documentation — Complexity](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCOMPLEXITY_GDL.html)
- [SAP Help Portal — Analyzing Performance with ABAP Runtime Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/3c74c6163ce4459888bc06dedda37685.html)
- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)

## 3.G PROCESS

### 3.G.1 ÉTAPE 1 — DÉCOMPOSER LE TEMPS OBSERVÉ

Relever durée totale, temps CPU, base de données, appels externes, attente de verrou et traitement frontend lorsque disponibles. Identifier la catégorie dominante avant de choisir l’outil de détail.

### 3.G.2 ÉTAPE 2 — MESURER LE CODE ABAP AVEC `SAT`

Tracer un scénario court et ouvrir la hit list et la hiérarchie d’appels. Trier par temps net puis par nombre d’appels. Repérer les méthodes coûteuses, boucles et conversions, sans attribuer au code appelant le temps réellement passé dans un sous-appel.

### 3.G.3 ÉTAPE 3 — MESURER LE SQL AVEC `ST05`

Si la base domine, activer une trace limitée à l’utilisateur, exécuter une fois puis désactiver immédiatement. Regrouper les instructions et relever exécutions, durée, lignes et source ABAP. Identifier SQL en boucle, filtre insuffisant ou accès coûteux.

### 3.G.4 ÉTAPE 4 — MESURER VOLUME ET MÉMOIRE

Relever tailles de tables internes, copies complètes, résultats SQL et snapshots mémoire autour de la phase suspecte. Distinguer mémoire temporaire libérée en fin de portée et objet retenu par une référence longue.

### 3.G.5 ÉTAPE 5 — CLASSER PAR IMPACT ET FRÉQUENCE

Combiner coût unitaire, nombre d’exécutions et fréquence en production. Prioriser un coût cumulé élevé et un code réellement utilisé. Ne pas optimiser une méthode rarement appelée pendant qu’un SQL répétitif domine le scénario.

### 3.G.6 ÉTAPE 6 — PROUVER LA CAUSE PAR UNE MODIFICATION CIBLÉE

Modifier une seule source de coût, exécuter les tests puis remesurer. La cause est confirmée si la métrique correspondante baisse avec un résultat identique. Conserver les captures avant/après.

## 3.H VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 3.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 3.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
LOOP AT lt_header INTO DATA(ls_header).
  LOOP AT lt_item INTO DATA(ls_item)
       WHERE document_id = ls_header-document_id.
    " Traitement
  ENDLOOP.
ENDLOOP.
```

## 3.K TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
