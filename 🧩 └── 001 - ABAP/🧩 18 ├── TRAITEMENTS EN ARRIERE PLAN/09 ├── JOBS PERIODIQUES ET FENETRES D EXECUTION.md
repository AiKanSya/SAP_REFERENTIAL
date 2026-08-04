# JOBS PÉRIODIQUES ET FENÊTRES D’EXÉCUTION

## RÉSULTAT ATTENDU

- Configurer une répétition maîtrisée
- Comprendre le comportement d’une série périodique
- Éviter les recouvrements et les exécutions devenues inutiles

## PÉRIODICITÉ

Dans `SM36`, un job peut être répété selon un intervalle : horaire, quotidien, hebdomadaire, mensuel ou autre période proposée par le système.

```mermaid
flowchart LR
    A["Occurrence N"] --> B["Calcul de la prochaine date"]
    B --> C["Occurrence N plus 1"]
    C --> D["Occurrence N plus 2"]
```

Une série périodique n’est pas automatiquement interrompue parce qu’une occurrence se termine en erreur. La surveillance doit donc détecter les échecs répétés.

## RISQUE DE RECOUVREMENT

Un job lancé toutes les 15 minutes mais durant 25 minutes peut produire plusieurs exécutions simultanées.

Mesures possibles :

- verrou applicatif ;
- contrôle d’une exécution déjà active ;
- fréquence supérieure à la durée maximale ;
- découpage du volume ;
- événement déclenché en fin de traitement ;
- planification après le job précédent.

## CALENDRIERS MÉTIER

La périodicité classique de `SM36` est principalement fondée sur des intervalles et conditions de démarrage. Les règles complexes de jours ouvrés doivent être prises en charge par la fonctionnalité applicative, une variante dynamique, un programme planificateur ou un outil d’ordonnancement validé.

## PROCESS

### ÉTAPE 1 — DÉFINIR LA FENÊTRE D’EXPLOITATION

Fixer l’heure de début autorisée, l’heure limite, la fréquence et le calendrier. Recenser les jobs, sauvegardes et interfaces concurrents. Définir ce qui doit se passer si l’occurrence précédente est encore active.

### ÉTAPE 2 — MESURER UNE DURÉE DE RÉFÉRENCE

Dans `SM37`, relever plusieurs exécutions comparables avec leur volume, début et fin. Utiliser la durée haute représentative pour dimensionner la fenêtre. Ne pas planifier sur la seule durée d’un test à faible volume.

### ÉTAPE 3 — CONFIGURER LA PÉRIODICITÉ

Dans `SM36`, définir la première date et heure, puis activer l’exécution périodique avec l’intervalle prévu. Vérifier le fuseau du système et les effets des changements d’heure, fins de mois et jours non ouvrés selon le contrat.

### ÉTAPE 4 — EMPÊCHER LES CHEVAUCHEMENTS NON AUTORISÉS

Ajouter un verrou applicatif, un statut d’exécution ou un contrôle de prédécesseur pour la même unité de traitement. En cas d’instance déjà active, sortir avec un message contrôlé ou différer selon la règle documentée ; ne pas traiter deux fois le même périmètre.

### ÉTAPE 5 — CONTRÔLER LES PROCHAINES OCCURRENCES

Après enregistrement, afficher le job dans `SM37` et vérifier son statut périodique, sa prochaine date et sa condition. Contrôler la première exécution et l’occurrence suivante. Une seule exécution réussie ne prouve pas la périodicité.

### ÉTAPE 6 — TRAITER UN DÉPASSEMENT DE FENÊTRE

Comparer chaque fin à l’heure limite et journaliser le volume. Si la fenêtre est dépassée, déterminer s’il s’agit d’un retard de démarrage ou d’une durée excessive. Ajuster code, capacité ou calendrier avec des mesures comparables, puis retester la reprise après interruption.

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

- [Periodicity: Specifying Automatic Job Repetition — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b3087831dd90a93e10000000a421937.html)
- [Specifying Job Start Conditions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2b4a365474fee10000000a421937.html)

---

[Chapitre suivant — DÉPENDANCES ENTRE JOBS](<./10 ├── DEPENDANCES ENTRE JOBS.md>)
