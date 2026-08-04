# 🌸 JOBS PÉRIODIQUES ET FENÊTRES D’EXÉCUTION

## 🌺 OBJECTIFS

- Configurer une répétition maîtrisée
- Comprendre le comportement d’une série périodique
- Éviter les recouvrements et les exécutions devenues inutiles

## 🌺 PÉRIODICITÉ

Dans `SM36`, un job peut être répété selon un intervalle : horaire, quotidien, hebdomadaire, mensuel ou autre période proposée par le système.

```mermaid
flowchart LR
    A["Occurrence N"] --> B["Calcul de la prochaine date"]
    B --> C["Occurrence N plus 1"]
    C --> D["Occurrence N plus 2"]
```

Une série périodique n’est pas automatiquement interrompue parce qu’une occurrence se termine en erreur. La surveillance doit donc détecter les échecs répétés.

## 🌺 RISQUE DE RECOUVREMENT

Un job lancé toutes les 15 minutes mais durant 25 minutes peut produire plusieurs exécutions simultanées.

Mesures possibles :

- verrou applicatif ;
- contrôle d’une exécution déjà active ;
- fréquence supérieure à la durée maximale ;
- découpage du volume ;
- événement déclenché en fin de traitement ;
- planification après le job précédent.

## 🌺 CALENDRIERS MÉTIER

La périodicité classique de `SM36` est principalement fondée sur des intervalles et conditions de démarrage. Les règles complexes de jours ouvrés doivent être prises en charge par la fonctionnalité applicative, une variante dynamique, un programme planificateur ou un outil d’ordonnancement validé.

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

- [Periodicity: Specifying Automatic Job Repetition — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b3087831dd90a93e10000000a421937.html)
- [Specifying Job Start Conditions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2b4a365474fee10000000a421937.html)


---

➡️ [Chapitre suivant — DÉPENDANCES ENTRE JOBS](<./10 - 🍧 DEPENDANCES ENTRE JOBS.md>)
