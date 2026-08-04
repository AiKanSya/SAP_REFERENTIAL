# 1. PRINCIPES DE PERFORMANCE QUALITE ET TESTS

## 1.A RÉSULTAT ATTENDU

Positionner les trois dimensions qui rendent un développement ABAP exploitable dans la durée : **performance mesurée**, **qualité vérifiable** et **tests reproductibles**.

## 1.B Trois axes complémentaires

| Axe              | Question principale                                         | Outils typiques                           |
| ---------------- | ----------------------------------------------------------- | ----------------------------------------- |
| Performance      | Où le temps et la mémoire sont-ils consommés ?              | `SAT`, `ST05`, `SQLM`, `SWLT`             |
| Qualité statique | Quels défauts sont détectables sans exécuter le programme ? | contrôle syntaxique, `SLIN`, `SCI`, `ATC` |
| Tests            | Le comportement attendu reste-t-il correct ?                | ABAP Unit, `SCOV`, tests d’intégration    |

```mermaid
flowchart LR
    A["Besoin fonctionnel"] --> B["Implémentation"]
    B --> C["Contrôles statiques"]
    C --> D["Tests automatisés"]
    D --> E["Mesures de performance"]
    E --> F["Livraison contrôlée"]
```

Une optimisation qui modifie le résultat est un défaut. Un code correct mais non mesuré peut rester trop lent. Un code rapide sans contrôle statique ni test devient difficile à maintenir.

## 1.C Ordre de travail recommandé

1. Définir le résultat attendu et les volumes représentatifs.
2. Écrire un code lisible et modulaire.
3. Exécuter les contrôles syntaxiques et statiques.
4. Ajouter les tests unitaires sur la logique stable.
5. Mesurer le comportement réel.
6. Corriger la cause dominante, puis mesurer à nouveau.

## 1.D Principes non négociables

- Ne pas optimiser sur intuition uniquement.
- Ne pas supprimer un contrôle métier pour gagner du temps.
- Ne pas masquer un finding sans justification technique.
- Ne pas considérer un taux de couverture comme une preuve de qualité.
- Ne pas tester avec des volumes irréalistes.

## 1.E Résultat attendu

Un développement est prêt lorsque son comportement est démontré, ses findings sont traités, ses performances sont compatibles avec le contexte d’exécution et sa maintenance ne dépend pas d’une connaissance implicite.

## 1.F Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)
- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)

## 1.G PROCESS

### 1.G.1 ÉTAPE 1 — FIGER LE COMPORTEMENT ATTENDU

Définir entrées, résultat, volume, utilisateur, mandant et contexte d’exécution. Créer des tests couvrant cas nominal, limites et erreurs avant une optimisation ou refonte. Sans oracle fonctionnel, une amélioration de temps peut masquer une régression.

### 1.G.2 ÉTAPE 2 — ÉTABLIR UNE MESURE DE RÉFÉRENCE

Exécuter un scénario représentatif et conserver durée, accès SQL, mémoire, compteurs et horodatage. Choisir `SAT`, `ST05`, `SQLM`, Memory Inspector ou un autre outil selon le coût suspecté. Ne pas cumuler des traces inutiles.

### 1.G.3 ÉTAPE 3 — LOCALISER LE COÛT DOMINANT

Identifier une méthode, une instruction SQL, une boucle, un volume ou une copie soutenus par la mesure. Distinguer temps propre, temps appelé, attente et nombre d’exécutions. Formuler une cause vérifiable avant de modifier le code.

### 1.G.4 ÉTAPE 4 — CORRIGER UNE SEULE CAUSE

Réduire le volume lu, le nombre d’allers-retours, la complexité d’accès ou les copies selon la preuve. Conserver un code lisible et une sémantique identique. Ne pas remplacer une API stable par une astuce non mesurée.

### 1.G.5 ÉTAPE 5 — EXÉCUTER LES CONTRÔLES DE QUALITÉ

Lancer contrôle syntaxique, SLIN, SCI ou ATC selon la gouvernance, puis les tests ABAP Unit et tests d’intégration pertinents. Corriger les findings introduits. Une amélioration locale n’est acceptable que si le périmètre complet reste valide.

### 1.G.6 ÉTAPE 6 — REMESURER ET COMPARER

Répéter le même scénario avec le même volume et le même contexte. Comparer les métriques avant/après et le résultat métier. Conserver la mesure uniquement si le gain est réel, stable et supérieur au coût de complexité ajouté.

## 1.H ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 1.I FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 1.J TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
