# JOURNAL DE JOB ET MESSAGES

## RÉSULTAT ATTENDU

- Lire le journal dans l’ordre chronologique
- Distinguer messages système et applicatifs
- Produire des informations exploitables

## CONTENU

Le journal de job contient notamment :

- démarrage et fin des étapes ;
- programme et variante ;
- messages du système de traitement de fond ;
- erreurs émises par les programmes ABAP ;
- sorties ou erreurs de certains programmes externes ;
- informations de terminaison.

## ANALYSE

```mermaid
flowchart TD
    A["Ouvrir le journal"] --> B["Identifier la première anomalie"]
    B --> C["Relever programme et étape"]
    C --> D["Corréler avec ST22 ou SLG1"]
    D --> E["Vérifier les données métier"]
```

La dernière erreur affichée peut n’être qu’une conséquence. Rechercher le premier message anormal et son contexte.

## JOURNALISATION APPLICATIVE

Pour un traitement professionnel, enregistrer au minimum :

- identifiant de l’exécution ;
- plage de données ;
- nombre lu, traité, réussi et rejeté ;
- erreurs avec clé métier ;
- durée des phases ;
- statut final métier.

Le Business Application Log, consultable avec `SLG1`, est souvent plus adapté qu’une longue série de `WRITE` ou de messages génériques.

## MESSAGES DANGEREUX

Des messages de type `A`, `E` ou certaines exceptions non traitées peuvent provoquer l’annulation du job. Le comportement doit être testé explicitement en arrière-plan.

## PROCESS

### ÉTAPE 1 — OUVRIR L’OCCURRENCE EXACTE

Dans `SM37`, rechercher le job avec nom, utilisateur et période, puis vérifier l’heure et le numéro. Sélectionner l’occurrence et ouvrir son journal. Ne pas utiliser le journal d’une exécution homonyme comme preuve.

### ÉTAPE 2 — LIRE LES MESSAGES DANS L’ORDRE

Relever l’heure, le type de message, l’étape et le texte complet. Identifier le dernier message de progression réussi puis la première erreur. Les messages de fin qui suivent peuvent être des conséquences et non la cause initiale.

### ÉTAPE 3 — RETROUVER LA SOURCE DU MESSAGE

Pour un message de classe, relever l’identifiant et le numéro puis l’analyser dans `SE91`. Pour un texte écrit par le report, localiser l’instruction correspondante. Relier le message au programme et à la variante de l’étape.

### ÉTAPE 4 — CORRÉLER AVEC LES AUTRES PREUVES

À la même heure et sous le même utilisateur, rechercher un dump dans `ST22`, une erreur d’update dans `SM13`, un log applicatif dans `SLG1` ou un problème de spool. N’ouvrir que les outils justifiés par le type d’échec observé.

### ÉTAPE 5 — AMÉLIORER LA JOURNALISATION DU PROGRAMME

Ajouter des messages avant et après les unités importantes, avec identifiant d’exécution, clé métier et compteurs. Utiliser le journal applicatif pour les traitements nécessitant recherche, regroupement et conservation structurée. Éviter les données sensibles et les milliers de messages identiques.

### ÉTAPE 6 — VALIDER LE DIAGNOSTIC

Rejouer avec la même variante après correction. Vérifier que la progression atteint l’étape suivante, que le résultat métier est correct et que le journal contient un résumé cohérent : lus, réussis, rejetés et durée.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

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

- [Displaying a Job Log — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bbd0f4c594ba2e10000000a42189c.html)
- [Background Processing Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/4d906689eba36e73e10000000a15822b.html)

---

[Chapitre suivant — SPOOL, SORTIES ET DESTINATAIRES](<./18 ├── SPOOL SORTIES ET DESTINATAIRES.md>)
