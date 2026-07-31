# 🌸 PRINCIPES DES TRAITEMENTS EN ARRIÈRE-PLAN

## 🌺 OBJECTIFS

- Comprendre le rôle du traitement de fond dans un système SAP
- Distinguer une exécution en dialogue d’un job
- Identifier les contraintes techniques d’un programme batch

## 🌺 DÉFINITION

Un traitement en arrière-plan exécute une ou plusieurs étapes sans session utilisateur interactive. Le système planifie le job, attend que sa condition de démarrage soit satisfaite, puis affecte ses étapes à un processus de travail de fond disponible.

```mermaid
flowchart LR
    A["Définition du job"] --> B["Condition de démarrage"]
    B --> C["File d attente"]
    C --> D["Processus de travail batch"]
    D --> E["Journal et spool"]
```

## 🌺 CAS D’USAGE

- traitements longs ou volumineux ;
- traitements périodiques ;
- imports et exports ;
- clôtures et calculs planifiés ;
- nettoyages techniques ;
- traitements déclenchés par un événement ;
- opérations qui ne nécessitent aucune interaction utilisateur.

## 🌺 DIALOGUE OU BATCH

| Critère                 | Dialogue                    | Arrière-plan                   |
| ----------------------- | --------------------------- | ------------------------------ |
| Interaction utilisateur | Possible                    | Impossible pendant l’exécution |
| Démarrage               | Immédiat depuis une session | Selon une condition planifiée  |
| Sortie classique        | Écran SAP GUI               | Journal et spool               |
| Durée attendue          | Courte                      | Peut être longue               |
| Ressource               | Processus de dialogue       | Processus de fond              |

## 🌺 LIMITE DE PÉRIMÈTRE

Ce dossier traite des jobs classiques de l’AS ABAP accessibles principalement avec `SM36` et `SM37`. Les applications Fiori **Application Jobs**, les modèles RAP et les développements ADT sont hors périmètre.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Background Processing: Concepts and Features — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/3ad3ba0715c5422eae08578d4c40328d/4b2b51c34c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

➡️ [Chapitre suivant — ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH](<./02 - 🍧 ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH.md>)
