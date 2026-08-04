# 🌸 CONDITIONS DE DÉMARRAGE

## 🌺 OBJECTIFS

- Choisir un déclencheur adapté
- Comprendre la différence entre heure prévue et heure réelle
- Éviter les chaînes fragiles basées uniquement sur l’heure

## 🌺 TYPES DE CONDITIONS

| Condition           | Usage                                          |
| ------------------- | ---------------------------------------------- |
| Immédiat            | Exécution dès que possible après libération    |
| Date et heure       | Traitement planifié à un instant donné         |
| Après job           | Dépendance avec un job prédécesseur            |
| Après événement     | Démarrage lié à un signal technique ou métier  |
| Mode d’exploitation | Démarrage lors de l’activation d’un mode donné |

## 🌺 HEURE THÉORIQUE ET HEURE RÉELLE

La condition rend le job **éligible**. Elle ne garantit pas un démarrage exactement à la seconde prévue. Le job peut attendre :

- un processus de fond disponible ;
- la fin d’un job prioritaire ;
- la disponibilité du serveur cible ;
- la résolution d’un problème système.

```mermaid
flowchart TD
    A["Condition satisfaite"] --> B["Job prêt"]
    B --> C{"Ressource disponible ?"}
    C -->|"Non"| B
    C -->|"Oui"| D["Job actif"]
```

## 🌺 DATE LIMITE

Une date ou fenêtre limite peut empêcher le démarrage tardif d’un traitement devenu inutile ou dangereux. Elle doit être définie selon les exigences métier, pas seulement pour masquer un problème de capacité.

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

- [Specifying Job Start Conditions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2b4a365474fee10000000a421937.html)
- [Job Start Management — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc0094c594ba2e10000000a42189c.html)


---

➡️ [Chapitre suivant — CLASSES DE JOB, PRIORITÉS ET SERVEUR CIBLE](<./08 - 🍧 CLASSES DE JOB PRIORITES ET SERVEUR CIBLE.md>)
