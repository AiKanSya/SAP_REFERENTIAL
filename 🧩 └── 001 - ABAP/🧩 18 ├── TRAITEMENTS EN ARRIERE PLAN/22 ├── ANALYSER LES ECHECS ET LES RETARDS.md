# ANALYSER LES ÉCHECS ET LES RETARDS

## RÉSULTAT ATTENDU

- Appliquer une méthode de diagnostic reproductible
- Distinguer un job non démarré, lent ou annulé
- Corréler les outils SAP

## JOB NON DÉMARRÉ

Contrôler dans cet ordre :

1. statut libéré ;
2. condition de démarrage atteinte ;
3. date limite non dépassée ;
4. serveur cible disponible ;
5. processus batch disponibles ;
6. classe et concurrence ;
7. autorisations de libération ;
8. cohérence du système de jobs.

## JOB ANNULÉ

```mermaid
flowchart TD
    A["Job annulé"] --> B["Journal SM37"]
    B --> C{"Dump ABAP ?"}
    C -->|"Oui"| D["ST22"]
    C -->|"Non"| E{"Erreur applicative ?"}
    E -->|"Oui"| F["SLG1 et données métier"]
    E -->|"Non"| G["SM21, autorisations, OS ou SAPXPG"]
```

## JOB LENT

- mesurer la durée par phase ;
- analyser SQL avec `ST05` ;
- analyser le runtime avec `SAT` ou `ST12` ;
- contrôler les volumes de sélection ;
- vérifier les verrous et attentes ;
- rechercher les exécutions simultanées ;
- contrôler le serveur et les processus ;
- comparer avec une exécution précédente de volume similaire.

## DONNÉES À CONSERVER

- nom et numéro du job ;
- date, heure et client ;
- utilisateur d’exécution ;
- programme et variante ;
- serveur ;
- statut ;
- journal ;
- spool ;
- dump éventuel ;
- volumes ;
- traces et identifiants applicatifs.

## PROCESS

### ÉTAPE 1 — IDENTIFIER L’OCCURRENCE ET LE SYMPTÔME

Dans `SM37`, relever nom, numéro, statut, heure prévue, début, fin, serveur et étape. Classer le problème : non déclenché, démarré en retard, durée excessive, annulé ou terminé avec résultat métier incorrect.

### ÉTAPE 2 — ANALYSER LA CONDITION DE DÉMARRAGE

Pour un job en attente, vérifier date, événement, argument, prédécesseur, périodicité et statut libéré. Comparer l’heure prévue au début réel. Contrôler ensuite la capacité batch et le ciblage serveur avec Basis.

### ÉTAPE 3 — LOCALISER LA PREMIÈRE ERREUR

Lire journal, étapes et spool dans l’ordre. Corréler l’heure avec `ST22`, `SM13`, `SLG1`, les traces d’autorisation ou les systèmes externes selon le message. Relever la clé métier et le dernier point de progression confirmé.

### ÉTAPE 4 — ANALYSER UNE DURÉE EXCESSIVE

Comparer volume et durée à plusieurs exécutions de référence. Distinguer attente de verrou, SQL coûteux, appel externe, spool volumineux et manque de capacité. Utiliser une trace ciblée sur une reproduction contrôlée, pas sur une hypothèse générale.

### ÉTAPE 5 — DÉTERMINER L’ÉTAT APRÈS INTERRUPTION

Vérifier les commits, documents, fichiers, événements et statuts déjà produits. Identifier la première unité non validée. Ne pas relancer avant de savoir si le job est idempotent ou si une compensation est nécessaire.

### ÉTAPE 6 — CORRIGER ET MESURER LE MÊME SCÉNARIO

Appliquer la correction prouvée puis relancer avec la même variante et un volume comparable. Vérifier résultat métier, absence de doublons, début, durée, journal et spool. Conserver les identifiants avant/après dans le diagnostic.

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

- [Job Was Not Started — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b272c13d1341780e10000000a42189c.html)
- [Managing Jobs from the Job Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc2224c594ba2e10000000a42189c.html)
- [Job Storage Management — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc0974c594ba2e10000000a42189c.html)

---

[Chapitre suivant — CONCEPTION, REPRISE, IDEMPOTENCE ET BONNES PRATIQUES](<./23 └── CONCEPTION REPRISE IDEMPOTENCE ET BONNES PRATIQUES.md>)
