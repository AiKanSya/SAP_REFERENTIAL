# 6. MAITRISER MEMOIRE COPIES ET VOLUMES

## 6.A RÉSULTAT ATTENDU

Limiter la consommation mémoire sans introduire de libérations prématurées ou de code obscur.

## 6.B Principales sources de consommation

- tables internes volumineuses ;
- copies de structures ou de tables ;
- références maintenant des objets accessibles ;
- caches globaux non bornés ;
- résultats SQL[^terme-acro-sql] surdimensionnés ;
- transformations créant plusieurs versions complètes des mêmes données.

## 6.C Copier ou référencer

```abap
LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
  " Accès direct à la ligne
ENDLOOP.
```

`ASSIGNING` ou `REFERENCE INTO` peut réduire les copies. La référence ne doit toutefois pas survivre inutilement au contexte qui possède les données.

## 6.D CLEAR et FREE

- `CLEAR` remet une variable à sa valeur initiale.
- `FREE` libère aussi les ressources dynamiques associées lorsque cela est pertinent.
- La fin de portée libère normalement les données locales ; ajouter `FREE` partout n’est pas une stratégie d’optimisation.

```abap
FREE lt_large_result.
```

Cette instruction est utile lorsqu’une grande table n’est plus nécessaire alors que le traitement continue longtemps.

## 6.E Mesurer avec le Memory Inspector

Comparer deux snapshots : avant le chargement, après le traitement et éventuellement après libération. Examiner les catégories mémoire et les chemins de référence qui empêchent la collecte.

```mermaid
flowchart LR
    A["Snapshot initial"] --> B["Traitement volumineux"]
    B --> C["Snapshot après traitement"]
    C --> D["Comparaison des objets"]
```

## 6.F Priorité

Réduire d’abord le volume lu et conservé. Une micro-optimisation de quelques structures ne compense pas une extraction inutile de millions de lignes.

## 6.G PROCESS

### 6.G.1 ÉTAPE 1 — REPRODUIRE LE PIC MÉMOIRE

Fixer programme, variante, volume et étape où la consommation augmente. Relever les tailles de sélections, tables internes et transformations. Éviter de mesurer un scénario réduit qui n’atteint pas le comportement problématique.

### 6.G.2 ÉTAPE 2 — PRENDRE DES SNAPSHOTS COMPARABLES

Avec Memory Inspector, capturer avant le chargement, après le pic et après le nettoyage attendu. Nommer les snapshots avec l’étape et l’horodatage. Comparer classes d’objets, tables et chemins de référence.

### 6.G.3 ÉTAPE 3 — IDENTIFIER LA RÉTENTION

Déterminer si la mémoire provient du volume nécessaire, de copies, d’un cache non borné ou de références maintenant des objets accessibles. Remonter le chemin de référence avant d’ajouter `FREE` au hasard.

### 6.G.4 ÉTAPE 4 — RÉDUIRE À LA SOURCE

Limiter les colonnes et lignes SQL, traiter par paquets, libérer les résultats intermédiaires et éviter plusieurs représentations complètes. Utiliser `ASSIGNING` ou références pour les accès en place lorsque leur durée de vie reste maîtrisée.

### 6.G.5 ÉTAPE 5 — LIBÉRER AU BON MOMENT

Utiliser `FREE` pour une grande donnée réellement devenue inutile alors que le processus continue. Laisser la fin de portée gérer les variables locales ordinaires. Ne pas libérer une table encore référencée ou nécessaire à une reprise.

### 6.G.6 ÉTAPE 6 — REPRENDRE LES SNAPSHOTS ET TESTS

Répéter le même volume et comparer pic, mémoire retenue et durée. Vérifier le résultat métier et la stabilité en batch. Une baisse mémoire accompagnée d’un temps ou d’un nombre de lectures excessif doit être évaluée globalement.

## 6.H Références SAP officielles

- [SAP Help Portal — Memory Inspector Concepts](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/8884fb5269d34838a1f119b41dcdbc57.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [ABAP Keyword Documentation — Internal Tables Performance Notes](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenitab_perfo.html)

## 6.I VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 6.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 6.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
  " Accès direct à la ligne
ENDLOOP.
```

## 6.L TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
