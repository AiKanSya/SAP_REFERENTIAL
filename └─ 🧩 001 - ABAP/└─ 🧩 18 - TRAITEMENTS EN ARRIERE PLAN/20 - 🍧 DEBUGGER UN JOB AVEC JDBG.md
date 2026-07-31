# 🌸 DEBUGGER UN JOB AVEC `JDBG`

## 🌺 OBJECTIFS

- Reproduire une étape ABAP dans le Debugger
- Comprendre la différence avec l’exécution batch réelle
- Éviter toute modification de données involontaire

## 🌺 PROCÉDURE CLASSIQUE

Dans `SM37` :

1. sélectionner le job et l’étape ABAP concernée ;
2. saisir `/h` ou `JDBG` selon la procédure supportée par la version ;
3. lancer le debug de l’étape ;
4. analyser les paramètres, la pile et les données.

La commande `JDBG` exécute l’étape dans un processus de dialogue sous contrôle du Debugger. Le contexte est simulé pour reproduire certains aspects du batch, mais l’environnement ne doit pas être considéré comme strictement identique.

## 🌺 PRÉCAUTIONS

- utiliser un système de développement ou de test ;
- éviter de debugger une étape qui modifiera des données productives ;
- positionner les breakpoints avant les écritures ;
- vérifier la variante ;
- ne pas poursuivre jusqu’au commit sans autorisation ;
- ne jamais modifier des variables pour « corriger » directement la production.

## 🌺 ALTERNATIVES

- exécuter le programme en dialogue avec la même variante ;
- ajouter une journalisation temporaire contrôlée ;
- utiliser `ST12` ou `SAT` pour une trace ;
- analyser `ST22`, le journal de job et `SLG1` ;
- utiliser un breakpoint externe pour un processus précis lorsque la procédure le permet.

## 🌺 CAS D’USAGE

Dans un contexte où un traitement récurrent et volumineux doit s’exécuter sans session utilisateur, laisser des traces et pouvoir être repris, le besoin consiste à **arrêter l’exécution au bon endroit et observer les données utiles**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 🌺 ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 🌺 FICHE DE CONTRÔLE À COPIER

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

## 🌺 TERMES DU LEXIQUE

- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **arrêter l’exécution au bon endroit et observer les données utiles**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Starting and Directly Debugging ABAP Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)
- [Batch Debugging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/bf1a5464da734b559d94199e80926005.html)


---

➡️ [Chapitre suivant — COMMANDES ET PROGRAMMES EXTERNES](<./21 - 🍧 COMMANDES ET PROGRAMMES EXTERNES.md>)
