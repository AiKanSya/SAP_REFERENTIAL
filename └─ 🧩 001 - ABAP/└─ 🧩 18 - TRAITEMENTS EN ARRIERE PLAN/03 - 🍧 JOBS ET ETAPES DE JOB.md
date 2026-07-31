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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Jobs and Job Steps Explained — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc12b4c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

➡️ [Chapitre suivant — PREPARER UN PROGRAMME ABAP POUR LE BATCH](<./04 - 🍧 PREPARER UN PROGRAMME ABAP POUR LE BATCH.md>)
