# 🍧 IDENTIFIER LES COUTS D EXECUTION

## 🎯 Objectif

Distinguer les principales familles de coûts d’un traitement ABAP afin de sélectionner l’outil et la correction appropriés.

## 🧱 Composants du temps de réponse

| Composant       | Exemples de causes                                          |
| --------------- | ----------------------------------------------------------- |
| ABAP            | boucles imbriquées, conversions répétées, appels dynamiques |
| Base de données | requêtes répétées, filtres insuffisants, gros transferts    |
| Réseau/RFC      | nombreux petits appels, données surdimensionnées            |
| Verrous         | attente sur objets de verrouillage                          |
| Mise à jour     | traitements V1/V2 longs ou en erreur                        |
| Présentation    | ALV volumineux, contrôles frontend                          |

## 🔎 Symptômes fréquents

- **Temps base dominant** : analyser `ST05`, `SQLM` et le volume transféré.
- **Temps ABAP dominant** : analyser `SAT`, les appels et les boucles.
- **Mémoire croissante** : comparer des snapshots et vérifier les références conservées.
- **Durée irrégulière** : examiner les verrous, la concurrence, les buffers et les données.
- **Rapide en DEV, lent en production** : comparer les volumes et le plan d’accès, pas seulement le code.

## 🧠 Complexité algorithmique

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

## ⚠️ Ne pas confondre cause et symptôme

Réduire une boucle ABAP ne corrige pas une requête ramenant dix fois trop de colonnes. Ajouter un index ne corrige pas une requête exécutée dans une boucle. Le diagnostic doit localiser le coût avant le choix technique.

## 🔗 Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [ABAP Keyword Documentation — Complexity](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCOMPLEXITY_GDL.html)
- [SAP Help Portal — Analyzing Performance with ABAP Runtime Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/3c74c6163ce4459888bc06dedda37685.html)
- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)

---

➡️ [Chapitre suivant : OPTIMISER LES ACCES ABAP SQL](<04 - 🍧 OPTIMISER LES ACCES ABAP SQL.md>)
