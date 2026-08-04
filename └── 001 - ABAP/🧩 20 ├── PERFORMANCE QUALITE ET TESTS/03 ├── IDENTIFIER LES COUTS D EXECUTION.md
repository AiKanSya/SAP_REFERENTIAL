# IDENTIFIER LES COUTS D EXECUTION

## Objectif

Distinguer les principales familles de coûts d’un traitement ABAP afin de sélectionner l’outil et la correction appropriés.

## Composants du temps de réponse

| Composant       | Exemples de causes                                          |
| --------------- | ----------------------------------------------------------- |
| ABAP            | boucles imbriquées, conversions répétées, appels dynamiques |
| Base de données | requêtes répétées, filtres insuffisants, gros transferts    |
| Réseau/RFC      | nombreux petits appels, données surdimensionnées            |
| Verrous         | attente sur objets de verrouillage                          |
| Mise à jour     | traitements V1/V2 longs ou en erreur                        |
| Présentation    | ALV volumineux, contrôles frontend                          |

## Symptômes fréquents

- **Temps base dominant** : analyser `ST05`, `SQLM` et le volume transféré.
- **Temps ABAP dominant** : analyser `SAT`, les appels et les boucles.
- **Mémoire croissante** : comparer des snapshots et vérifier les références conservées.
- **Durée irrégulière** : examiner les verrous, la concurrence, les buffers et les données.
- **Rapide en DEV, lent en production** : comparer les volumes et le plan d’accès, pas seulement le code.

## Complexité algorithmique

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

## Ne pas confondre cause et symptôme

Réduire une boucle ABAP ne corrige pas une requête ramenant dix fois trop de colonnes. Ajouter un index ne corrige pas une requête exécutée dans une boucle. Le diagnostic doit localiser le coût avant le choix technique.

## Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [ABAP Keyword Documentation — Complexity](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCOMPLEXITY_GDL.html)
- [SAP Help Portal — Analyzing Performance with ABAP Runtime Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/3c74c6163ce4459888bc06dedda37685.html)
- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)

## PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## SNIPPET À RÉUTILISER

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

## TERMES DU LEXIQUE

- [ATC](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
