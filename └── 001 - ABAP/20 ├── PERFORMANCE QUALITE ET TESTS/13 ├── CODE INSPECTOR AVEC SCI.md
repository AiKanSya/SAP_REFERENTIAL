# CODE INSPECTOR AVEC SCI

## Objectif

Utiliser `SCI` pour exécuter un ensemble cohérent de contrôles sur un objet ou un groupe d’objets Repository.

## Objets principaux

| Objet SCI            | Rôle                                            |
| -------------------- | ----------------------------------------------- |
| Variante de contrôle | règles et paramètres appliqués                  |
| Jeu d’objets         | objets Repository analysés                      |
| Inspection           | association variante + jeu d’objets + résultats |

## Contrôle ad hoc

1. Ouvrir `SCI`.
2. Lancer une inspection ad hoc.
3. Définir les objets ou le package.
4. Choisir une variante globale autorisée.
5. Exécuter et analyser les résultats.

```mermaid
flowchart LR
    A["Jeu d objets"] --> C["Inspection SCI"]
    B["Variante de contrôle"] --> C
    C --> D["Findings"]
```

## Domaines de contrôle

Selon la variante : performance, sécurité, robustesse, conventions, syntaxe, recherche de code, objets DDIC, traductions ou dépendances.

## Gouvernance

Une variante locale personnelle n’est pas une référence projet. Pour une validation de livraison, utiliser la variante globale définie par l’équipe qualité ou l’ATC central.

## Relation avec ATC

ATC réutilise l’infrastructure et les contrôles du Code Inspector, tout en ajoutant une gouvernance centralisée des exécutions, résultats, exemptions et transports. SCI reste utile pour construire et comprendre les variantes ainsi que pour les analyses ad hoc.

## Références SAP officielles

- [SAP Help Portal — Code Inspector](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49205531d0fc14cfe10000000a42189b.html)
- [SAP Help Portal — Creating Code Inspections](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4926dff4c93016b8e10000000a42189d.html)
- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)

## PROCÉDURE PAS À PAS

1. Saisir `/nSCI`.
2. Créer ou sélectionner une variante de contrôles approuvée par le projet.
3. Créer une inspection sur le package, l’objet ou l’ensemble de transport visé.
4. Exécuter l’inspection.
5. Analyser chaque finding, corriger la cause ou documenter l’exception selon la gouvernance.
6. Relancer jusqu’à obtenir le niveau de qualité attendu.

## VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

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

- [ATC](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
