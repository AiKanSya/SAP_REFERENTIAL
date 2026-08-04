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

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSM36`.
2. Donner un nom explicite au job et définir sa classe/priorité selon les règles d’exploitation.
3. Ajouter une étape ABAP avec programme, variante et utilisateur d’exécution.
4. Définir la condition de démarrage : immédiate, date/heure, après job ou événement.
5. Enregistrer puis vérifier que le job est planifié.
6. Surveiller ensuite son exécution dans `SM37`.

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

- [Background Processing: Concepts and Features — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/3ad3ba0715c5422eae08578d4c40328d/4b2b51c34c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)


---

➡️ [Chapitre suivant — ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH](<./02 - 🍧 ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH.md>)
