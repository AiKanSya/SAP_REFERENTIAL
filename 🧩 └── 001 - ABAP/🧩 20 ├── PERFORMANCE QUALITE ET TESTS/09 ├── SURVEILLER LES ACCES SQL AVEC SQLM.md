# SURVEILLER LES ACCES SQL AVEC SQLM

## RÉSULTAT ATTENDU

Collecter des statistiques SQL agrégées sur une période plus longue que la trace ponctuelle `ST05`.

## Positionnement

`SQLM` enregistre les exécutions SQL avec un faible surcoût conçu pour l’analyse de charge. Il permet d’identifier les instructions réellement utilisées et leur coût cumulé sur des scénarios représentatifs.

## Démarche

1. Définir le périmètre de collecte avec l’administration.
2. Activer le moniteur pour une durée limitée.
3. Laisser s’exécuter les traitements représentatifs.
4. Arrêter la collecte.
5. Analyser avec `SQLMD` ou l’affichage proposé par la release.
6. Filtrer les packages clients `Z*`, `Y*` ou le namespace concerné.

## Indicateurs utiles

- nombre total d’exécutions ;
- temps SQL cumulé ;
- temps moyen ;
- lignes retournées ;
- point source ;
- entrée applicative ou requête selon la vue disponible.

## ST05 ou SQLM

| Besoin                                  | Outil  |
| --------------------------------------- | ------ |
| scénario unique et détail exact         | `ST05` |
| comportement cumulé sur une période     | `SQLM` |
| priorisation croisée statique/dynamique | `SWLT` |

## Gouvernance

La collecte doit être bornée, documentée et arrêtée après usage. Exporter un snapshot permet d’analyser les données dans un autre système, notamment avec `SWLT`, selon les possibilités de la version installée.

## Références SAP officielles

- [SAP Help Portal — SQL Monitor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/a24970c68fcf4770a64bf9a78e3719e2/1ec2329419b64f3992a9c342437d3a0f.html)
- [SAP Help Portal — SQL Performance Tuning Worklist](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/a24970c68fcf4770a64bf9a78e3719e2/713ff185b9b347aaacbe3ada28d4fa72.html)

## PROCESS

### ÉTAPE 1 — DÉFINIR LA PÉRIODE D’OBSERVATION

Choisir le système, la fenêtre, les utilisateurs ou applications et le problème à mesurer. Obtenir l’accord d’administration requis. SQLM sert à collecter une charge agrégée ; il ne remplace pas une trace ST05 courte pour un appel unique.

### ÉTAPE 2 — CONFIGURER ET ACTIVER SQLM

Saisir `/nSQLM`, définir le périmètre disponible sur la release puis activer la collecte. Relever l’heure de début et la configuration. Éviter une activation indéfinie sans propriétaire ni date de fin.

### ÉTAPE 3 — LAISSER S’EXÉCUTER LA CHARGE REPRÉSENTATIVE

Exécuter les transactions, jobs ou interfaces pendant la fenêtre choisie. Noter les volumes et événements particuliers. Ne pas mélanger une période anormale avec une charge nominale sans l’indiquer.

### ÉTAPE 4 — ARRÊTER ET AFFICHER LES DONNÉES

Désactiver la collecte à la fin prévue. Ouvrir les résultats et filtrer par objet, source ou contexte. Trier par temps cumulé, nombre d’exécutions et lignes afin d’identifier les coûts réellement fréquents.

### ÉTAPE 5 — NAVIGUER VERS LE CODE SOURCE

Pour les accès prioritaires, relever programme, include et position. Vérifier la logique et reproduire si nécessaire avec `ST05` ou `SAT` pour obtenir le détail absent de l’agrégat. Ne corriger que les instructions dont le contexte d’exécution est compris.

### ÉTAPE 6 — COMPARER DEUX FENÊTRES

Après correction, collecter une période comparable en durée et en charge. Comparer exécutions, temps cumulé et volume. Conserver les paramètres des deux sessions pour éviter une conclusion fondée sur des charges différentes.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## FICHE DE CONTRÔLE À COPIER

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

## TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
