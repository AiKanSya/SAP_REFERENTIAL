# 🌸 JOBS ET ÉTAPES DE JOB

## 🌺 OBJECTIFS

- Distinguer le job de ses étapes
- Comprendre l’ordre d’exécution
- Identifier les paramètres propres à chaque étape

## 🌺 MODÈLE

Un job est une unité de planification. Il contient une ou plusieurs étapes exécutées dans l’ordre défini.

```mermaid
flowchart LR
    A["Job"] --> B["Étape 1"]
    B --> C["Étape 2"]
    C --> D["Étape 3"]
```

Une étape peut exécuter :

- un programme ABAP ;
- une commande externe définie dans SAP ;
- un programme externe, sous réserve des autorisations nécessaires.

## 🌺 PROPRIÉTÉS D’UNE ÉTAPE ABAP

- nom du programme ;
- variante ;
- utilisateur d’exécution ;
- langue ;
- paramètres de spool et d’archivage.

Le job possède ses propres propriétés : nom, numéro interne, classe, condition de démarrage, périodicité et éventuellement serveur cible.

## 🌺 ÉCHEC D’UNE ÉTAPE

Les étapes ne constituent pas automatiquement une transaction métier unique. Si l’étape 2 échoue après la validation de l’étape 1, les données écrites par la première étape ne sont pas annulées. Une chaîne doit donc être conçue avec une stratégie de reprise explicite.

## 🌺 RECOMMANDATION

Utiliser plusieurs étapes lorsque l’enchaînement est réellement indissociable et simple. Pour une orchestration complexe, préférer des jobs distincts reliés par une condition « après job » ou par un événement documenté.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSM37`.
2. Renseigner le nom du job, l’utilisateur et une période suffisamment précise.
3. Exécuter la recherche et sélectionner le job correspondant au bon horodatage.
4. Lire le statut, le journal de job, les étapes et le spool.
5. En cas d’échec, relever le message, le programme, la variante, l’utilisateur et l’heure avant toute relance.

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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Jobs and Job Steps Explained — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc12b4c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)


---

➡️ [Chapitre suivant — PRÉPARER UN PROGRAMME ABAP POUR LE BATCH](<./04 - 🍧 PREPARER UN PROGRAMME ABAP POUR LE BATCH.md>)
