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

## PROCÉDURE PAS À PAS

1. Saisir `/nST05` dans une session dédiée.
2. Choisir la trace SQL et limiter le périmètre à l’utilisateur concerné.
3. Activer la trace juste avant la reproduction.
4. Exécuter le scénario dans l’autre session.
5. Désactiver immédiatement la trace.
6. Afficher la trace et analyser durée, nombre d’exécutions, lignes et index utilisés.

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
