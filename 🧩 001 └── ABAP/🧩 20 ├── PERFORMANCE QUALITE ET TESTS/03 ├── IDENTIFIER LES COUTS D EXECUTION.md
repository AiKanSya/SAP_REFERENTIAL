# 3. IDENTIFIER LES COUTS D EXECUTION

## 3.A RÉSULTAT ATTENDU

Distinguer les principales familles de coûts d’un traitement ABAP[^terme-abap] afin de sélectionner l’outil et la correction appropriés.

## 3.B Composants du temps de réponse

| Composant       | Exemples de causes                                          |
| --------------- | ----------------------------------------------------------- |
| ABAP            | boucles imbriquées, conversions répétées, appels dynamiques |
| Base de données | requêtes répétées, filtres insuffisants, gros transferts    |
| Réseau/RFC[^terme-rfc]      | nombreux petits appels, données surdimensionnées            |
| Verrous         | attente sur objets de verrouillage                          |
| Mise à jour     | traitements V1/V2 longs ou en erreur                        |
| Présentation    | ALV[^terme-alv] volumineux, contrôles frontend[^terme-frontend]                          |

## 3.C Symptômes fréquents

- **Temps base dominant** : analyser `ST05`[^outil-st05], `SQLM`[^outil-sqlm] et le volume transféré.
- **Temps ABAP dominant** : analyser `SAT`[^outil-sat], les appels et les boucles.
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

Cette forme doit déclencher une analyse : table triée avec clé adaptée, table hachée, regroupement préalable ou traitement SQL[^terme-acro-sql] unique.

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

Si la base domine, activer une trace[^terme-trace] limitée à l’utilisateur, exécuter une fois puis désactiver immédiatement. Regrouper les instructions et relever exécutions, durée, lignes et source ABAP. Identifier SQL en boucle, filtre insuffisant ou accès coûteux.

### 3.G.4 ÉTAPE 4 — MESURER VOLUME ET MÉMOIRE

Relever tailles de tables internes, copies complètes, résultats SQL et snapshots mémoire autour de la phase suspecte. Distinguer mémoire temporaire libérée en fin de portée et objet retenu par une référence longue.

### 3.G.5 ÉTAPE 5 — CLASSER PAR IMPACT ET FRÉQUENCE

Combiner coût unitaire, nombre d’exécutions et fréquence en production. Prioriser un coût cumulé élevé et un code réellement utilisé. Ne pas optimiser une méthode[^terme-methode] rarement appelée pendant qu’un SQL répétitif domine le scénario.

### 3.G.6 ÉTAPE 6 — PROUVER LA CAUSE PAR UNE MODIFICATION CIBLÉE

Modifier une seule source de coût, exécuter les tests puis remesurer. La cause est confirmée si la métrique correspondante baisse avec un résultat identique. Conserver les captures avant/après.

## 3.H VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
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
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-rfc]: **RFC.** Remote Function Call, mécanisme permettant d’appeler un module fonction compatible dans un autre contexte ou système. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#rfc>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-st05]: **ST05.** Performance Trace utilisée notamment pour enregistrer et analyser les accès SQL. Voir [le chapitre associé](<08 ├── ANALYSER LES ACCES SQL AVEC ST05.md>).
[^outil-sqlm]: **SQLM.** SQL Monitor utilisé pour agréger l’usage des instructions SQL pendant une période d’enregistrement. Voir [le chapitre associé](<09 ├── SURVEILLER LES ACCES SQL AVEC SQLM.md>).
[^outil-sat]: **SAT.** Runtime Analysis utilisée pour mesurer et analyser le temps d’exécution ABAP. Voir [le chapitre associé](<07 ├── MESURER LE TEMPS D EXECUTION AVEC SAT.md>).
