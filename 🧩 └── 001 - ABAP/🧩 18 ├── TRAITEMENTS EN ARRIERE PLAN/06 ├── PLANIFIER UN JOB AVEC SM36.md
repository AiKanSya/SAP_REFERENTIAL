# 6. PLANIFIER UN JOB AVEC `SM36`

## 6.A RÉSULTAT ATTENDU

- Créer un job[^terme-job] classique dans SAP GUI[^terme-sap-gui]
- Définir ses étapes et sa condition de démarrage
- Vérifier qu’il est effectivement libéré

## 6.B PROCESS

### 6.B.1 ÉTAPE 1 — PRÉPARER LES OBJETS D’EXÉCUTION

Vérifier que le programme est actif, que la variante existe dans le système et que l’utilisateur technique possède les autorisations métier et techniques requises. Définir la fréquence, la classe[^terme-classe] et l’éventuel groupe de serveurs avec l’exploitation.

### 6.B.2 ÉTAPE 2 — CRÉER LE JOB

Saisir `/nSM36`, entrer un nom explicite et choisir la classe autorisée. Renseigner un serveur cible uniquement si une contrainte technique validée l’exige. Un ciblage inutile réduit les possibilités d’ordonnancement.

### 6.B.3 ÉTAPE 3 — AJOUTER L’ÉTAPE ABAP

Ouvrir **Étapes**, choisir un programme ABAP[^terme-abap], puis saisir le report, sa variante et l’utilisateur d’exécution. Enregistrer l’étape et vérifier le récapitulatif. Ajouter d’autres étapes seulement si leur séquence appartient au même cycle de reprise.

### 6.B.4 ÉTAPE 4 — DÉFINIR LA CONDITION DE DÉMARRAGE

Choisir un démarrage immédiat, une date/heure, une dépendance à un job ou un événement selon le besoin. Pour une exécution périodique, définir la périodicité et le comportement de calendrier. Contrôler le fuseau horaire utilisé par le système.

### 6.B.5 ÉTAPE 5 — ENREGISTRER ET LIBÉRER

Enregistrer le job et vérifier le message de planification. Ouvrir `SM37`[^outil-sm37], rechercher le nom et contrôler le statut, l’heure prévue, les étapes, les variantes et l’utilisateur. Un job seulement créé mais non libéré ne démarrera pas.

### 6.B.6 ÉTAPE 6 — VALIDER LA PREMIÈRE EXÉCUTION

Surveiller le passage aux statuts actif puis terminé. Lire le journal et le spool[^terme-spool], contrôler le résultat métier et relever la durée. En cas d’erreur, conserver les preuves avant toute copie ou replanification.

```mermaid
flowchart LR
    A["Nom et classe"] --> B["Étapes"]
    B --> C["Condition de démarrage"]
    C --> D["Enregistrement"]
    D --> E["Contrôle dans SM37"]
```

## 6.C NOM DU JOB

Le nom doit permettre de retrouver rapidement :

- le domaine fonctionnel ;
- le traitement ;
- la fréquence ou le déclencheur ;
- éventuellement l’interface ou le système consommateur.

Éviter les noms génériques comme `TEST`, `JOB1` ou `TRAITEMENT`.

## 6.D ASSISTANT DE PLANIFICATION

`SM36`[^outil-sm36] propose également un assistant guidé. Il simplifie la saisie, mais ne remplace pas la compréhension des étapes, des variantes, des utilisateurs d’exécution et des conditions de démarrage.

## 6.E CONTRÔLE FINAL

Un job enregistré mais non libéré ne démarrera pas. Vérifier le statut, l’heure prévue, l’utilisateur, le programme, la variante et le serveur cible éventuel.

## 6.F VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 6.G ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 6.H FICHE DE CONTRÔLE À COPIER

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

## 6.I TERMES DU LEXIQUE

- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)
- [Job Scheduling Wizard — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bbf7b4c594ba2e10000000a42189c.html)

---

[Chapitre suivant — CONDITIONS DE DÉMARRAGE](<./07 ├── CONDITIONS DE DEMARRAGE.md>)

[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).

[^outil-sm37]: **SM37.** Transaction de recherche, surveillance et administration des jobs d’arrière-plan. Voir [le chapitre associé](<15 ├── SURVEILLER LES JOBS AVEC SM37.md>).
[^outil-sm36]: **SM36.** Transaction de définition et de planification des jobs d’arrière-plan. Voir [le chapitre associé](<06 ├── PLANIFIER UN JOB AVEC SM36.md>).
