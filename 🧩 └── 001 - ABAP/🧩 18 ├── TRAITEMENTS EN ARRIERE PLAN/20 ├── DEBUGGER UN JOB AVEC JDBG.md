# DEBUGGER UN JOB AVEC `JDBG`

## RÉSULTAT ATTENDU

- Reproduire une étape ABAP dans le Debugger
- Comprendre la différence avec l’exécution batch réelle
- Éviter toute modification de données involontaire

## PROCESS

### ÉTAPE 1 — FIGER LE CONTEXTE DU JOB

Dans `SM37`, relever le nom, le numéro, l’étape, le programme, la variante et l’utilisateur. Lire d’abord le journal, le spool et les dumps éventuels. Utiliser JDBG seulement si ces preuves ne suffisent pas à localiser la cause.

### ÉTAPE 2 — CHOISIR UN ENVIRONNEMENT SÛR

Copier ou reproduire le job en développement ou en qualité avec des données contrôlées. Vérifier si l’étape réalise des écritures, des commits, des appels externes ou des envois. Préparer des breakpoints avant le premier effet irréversible.

### ÉTAPE 3 — SÉLECTIONNER L’OCCURRENCE ET L’ÉTAPE

Dans `SM37`, sélectionner exactement le job à reproduire. Utiliser la fonction de debug batch supportée par la version, notamment la commande `JDBG` lorsqu’elle est disponible. Confirmer l’étape ABAP avant de lancer l’exécution simulée.

### ÉTAPE 4 — VÉRIFIER LE CONTEXTE DÈS L’ENTRÉE

Contrôler les valeurs de l’écran de sélection, `sy-batch`, l’utilisateur, le mandant et les chemins résolus. Comparer ces éléments au job initial. Le debug utilise un contexte de dialogue et ne reproduit pas nécessairement chaque caractéristique du processus batch d’origine.

### ÉTAPE 5 — SUIVRE JUSQU’À LA PREMIÈRE DIVERGENCE

Inspecter la pile, les conditions, la sélection de données et les retours d’API. Arrêter avant les écritures non autorisées. Ne modifier aucune variable afin de « réparer » une donnée productive ; toute correction doit passer par le code ou la procédure métier contrôlée.

### ÉTAPE 6 — CONFIRMER HORS DEBUG

Après correction, exécuter un nouveau job avec la même variante et un identifiant distinct. Vérifier journal, spool, données et durée. Le comportement hors debugger constitue la validation finale.

La commande `JDBG` exécute l’étape dans un processus de dialogue sous contrôle du Debugger. Le contexte est simulé pour reproduire certains aspects du batch, mais l’environnement ne doit pas être considéré comme strictement identique.

## PRÉCAUTIONS

- utiliser un système de développement ou de test ;
- éviter de debugger une étape qui modifiera des données productives ;
- positionner les breakpoints avant les écritures ;
- vérifier la variante ;
- ne pas poursuivre jusqu’au commit sans autorisation ;
- ne jamais modifier des variables pour « corriger » directement la production.

## ALTERNATIVES

- exécuter le programme en dialogue avec la même variante ;
- ajouter une journalisation temporaire contrôlée ;
- utiliser `ST12` ou `SAT` pour une trace ;
- analyser `ST22`, le journal de job et `SLG1` ;
- utiliser un breakpoint externe pour un processus précis lorsque la procédure le permet.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

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

- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [Starting and Directly Debugging ABAP Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)
- [Batch Debugging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/bf1a5464da734b559d94199e80926005.html)

---

[Chapitre suivant — COMMANDES ET PROGRAMMES EXTERNES](<./21 ├── COMMANDES ET PROGRAMMES EXTERNES.md>)
