# 🌸 PILE D’APPELS ET CONTEXTE D’EXÉCUTION

## 🌺 OBJECTIFS

- Comprendre comment le traitement a atteint la ligne courante
- Naviguer entre appelants et appelés
- Retrouver les paramètres et variables locales d’un niveau
- Distinguer pile ABAP et pile Dynpro
- Identifier le premier appel métier pertinent

## 🌺 PRINCIPE

La pile d’appels représente les blocs actifs qui ont conduit à l’instruction courante.

```mermaid
flowchart TD
    A["Transaction ou rapport"] --> B["Module fonction"]
    B --> C["Méthode de service"]
    C --> D["Méthode métier"]
    D --> E["Instruction courante"]
```

## 🌺 INFORMATIONS DISPONIBLES

Selon la version, une entrée de pile peut indiquer :

- profondeur ;
- type ABAP ou Dynpro ;
- type d’événement ;
- nom de méthode, module ou routine ;
- programme ;
- include ;
- numéro de ligne.

## 🌺 NAVIGUER DANS LA PILE

En sélectionnant un niveau, le débogueur repositionne le contexte visible :

- variables locales de la procédure ;
- paramètres d’entrée et de sortie ;
- variables globales du programme ;
- source correspondant à l’appel.

La navigation dans la pile n’exécute pas le programme. Elle change uniquement le contexte d’analyse.

## 🌺 TROUVER LA CAUSE

Lorsqu’une erreur apparaît dans une routine générique standard, remonter la pile jusqu’au premier niveau qui :

- appartient au développement client ;
- construit les données incorrectes ;
- choisit un paramètre erroné ;
- appelle l’API standard avec un contrat non respecté.

La ligne qui déclenche l’erreur n’est pas toujours la ligne qui crée sa cause.

## 🌺 PILE DYNPRO

Dans une application classique, la pile peut inclure :

- PBO ;
- PAI ;
- modules d’écran ;
- programmes ABAP associés.

Un contexte Dynpro expose principalement les données globales du programme d’écran. Les variables locales appartiennent aux procédures ABAP actives.

## 🌺 PROGRAMMES SYSTÈME

Les programmes système peuvent être masqués ou affichés différemment. Leur analyse nécessite l’activation du débogage système et les autorisations appropriées.

Activer ce mode uniquement lorsque le problème se situe réellement dans une couche système ou standard.

## 🌺 PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## 🌺 VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 🌺 ERREURS FRÉQUENTES

- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

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

- [Breakpoint](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Call Stack — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/88feb68f058446539bb51e8d95caac00.html)
- [System Debugging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4925636629ac16b7e10000000a42189d.html)


---

➡️ [Chapitre suivant — MODIFIER LES DONNÉES ET LE FLUX D’EXÉCUTION](<./10 - 🍧 MODIFIER LES DONNEES ET LE FLUX D EXECUTION.md>)
