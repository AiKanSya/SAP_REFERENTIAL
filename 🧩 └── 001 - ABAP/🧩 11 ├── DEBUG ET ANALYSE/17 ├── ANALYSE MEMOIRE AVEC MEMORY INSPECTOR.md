# ANALYSE MÉMOIRE AVEC MEMORY INSPECTOR

## RÉSULTAT ATTENDU

- Comprendre le principe d’un snapshot mémoire
- Comparer deux états d’un traitement
- Identifier les tables, objets ou chaînes dominants
- Distinguer volume nécessaire et rétention anormale
- Relier l’analyse mémoire au code ABAP

## PRINCIPE

Le Memory Inspector analyse des snapshots de la mémoire d’un programme ABAP. La comparaison de deux snapshots permet de voir ce qui a été créé, augmenté ou conservé entre deux étapes.

```mermaid
flowchart LR
    A["Snapshot T0"] --> B["Traitement"]
    B --> C["Snapshot T1"]
    A --> D["Comparaison"]
    C --> D
    D --> E["Objets et tables en croissance"]
```

## CAS D USAGE

- dump de manque de mémoire ;
- croissance progressive d’un traitement par lots ;
- table interne beaucoup plus volumineuse que prévu ;
- accumulation d’objets référencés ;
- chaînes ou buffers conservés ;
- différence importante entre deux étapes.

## SNAPSHOTS

Un snapshot représente un état. Une comparaison pertinente nécessite :

- même programme ;
- même scénario ;
- points de capture clairement définis ;
- volume connu ;
- absence de manipulations parasites entre les captures.

## VUES D ANALYSE

Selon la version, les vues peuvent présenter :

- synthèse ;
- tables internes ;
- classes et objets ;
- programmes ;
- chaînes ;
- relations ou cycles de références ;
- différences entre snapshots.

## INTERPRÉTATION

Une consommation élevée n’est pas automatiquement une fuite. Vérifier :

- nécessité fonctionnelle du volume ;
- durée de vie attendue ;
- libération à la fin de l’unité ;
- référence globale conservant un objet ;
- copie inutile d’une table ;
- accumulation dans une boucle ;
- résultat SQL trop volumineux.

## ACTIONS DE CODE POSSIBLES

Après preuve :

- réduire les colonnes sélectionnées ;
- traiter par paquets ;
- éviter les copies ;
- libérer une table devenue inutile ;
- supprimer une référence conservée sans besoin ;
- revoir l’algorithme ;
- déplacer une agrégation vers la base lorsque pertinent.

Ne pas ajouter `FREE` partout sans mesurer. La gestion mémoire ABAP suit ses propres mécanismes et une libération prématurée peut dégrader la lisibilité sans résoudre la cause.

## PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

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

- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## RÉFÉRENCES OFFICIELLES SAP

- [Using the Memory Inspector Transaction — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49255f4629ac16b7e10000000a42189d.html)
- [Understanding the Memory Inspector Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d538045f647c46adab25a98299a2dd03.html)
- [ABAP Test and Analysis Tools — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491aa66f87041903e10000000a42189c.html)


---

[Chapitre suivant — DIAGNOSTIC ET BONNES PRATIQUES](<./18 └── METHODE DE DIAGNOSTIC ET CHECKLIST.md>)
