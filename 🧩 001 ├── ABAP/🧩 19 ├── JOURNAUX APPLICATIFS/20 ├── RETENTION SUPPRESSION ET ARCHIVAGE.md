# 20. RÉTENTION, SUPPRESSION ET ARCHIVAGE

## 20.A RÉSULTAT ATTENDU

- Définir une durée de conservation
- Supprimer les journaux de façon contrôlée
- Éviter la croissance illimitée des tables BAL[^terme-acro-bal]

## 20.B PRINCIPES

Un journal applicatif est une donnée technique persistante. Sa durée de conservation doit être définie selon :

- besoin opérationnel ;
- fréquence du traitement ;
- obligations d’audit ;
- présence de données personnelles ;
- volumétrie ;
- capacité de reprise.

## 20.C SUPPRESSION AVEC SLG2

La transaction `SLG2`[^outil-slg2] utilise le programme de suppression standard du BAL. La sélection doit cibler l’objet, le sous-objet, la période ou la date d’expiration.

```mermaid
flowchart LR
    A["Date d expiration atteinte"] --> B["Sélection SLG2"]
    B --> C["Exécution de contrôle"]
    C --> D["Suppression en job"]
    D --> E["Contrôle de volumétrie"]
```

Planifier la suppression en arrière-plan pour les volumes importants.

## 20.D ARCHIVAGE

L’objet d’archivage `BC_SBAL` permet d’archiver les journaux applicatifs. SAP[^terme-acro-sap] fournit notamment des programmes pour écrire les données BAL dans les archives puis supprimer les données archivées des tables d’origine.

## 20.E PRÉCAUTIONS

- ne pas supprimer tous les objets sans filtre ;
- tester la sélection en environnement[^terme-environnement] non productif ;
- aligner `DATE_DEL` et la politique d’exploitation ;
- documenter la responsabilité du nettoyage ;
- surveiller les tables techniques et les temps de sélection `SLG1`[^outil-slg1].

## 20.F PROCESS

### 20.F.1 ÉTAPE 1 — DÉFINIR LA POLITIQUE PAR OBJET

Pour chaque objet et sous-objet, fixer durée opérationnelle, obligation d’audit, données personnelles, volumétrie et besoin de reprise. Déterminer qui autorise la suppression et si l’archivage `BC_SBAL` est requis.

### 20.F.2 ÉTAPE 2 — ALIGNER LA DATE D’EXPIRATION

Lors de la création du log, renseigner la date de suppression uniquement selon cette politique. Vérifier plusieurs journaux dans `SLG1` et confirmer que leur expiration correspond au domaine. Corriger le producteur avant de planifier une purge incohérente.

### 20.F.3 ÉTAPE 3 — TESTER LA SÉLECTION DANS `SLG2`

Saisir `/nSLG2`, filtrer sur objet, sous-objet et période ou expiration. Commencer dans un environnement non productif et examiner le périmètre sélectionné. Ne jamais lancer une suppression sans filtre compris et validé.

### 20.F.4 ÉTAPE 4 — PLANIFIER LA SUPPRESSION EN BATCH

Pour un volume important, sauvegarder la sélection dans une variante et planifier le programme standard via la procédure d’exploitation. Utiliser un utilisateur technique autorisé. Conserver le journal du job[^terme-job] et les critères appliqués.

### 20.F.5 ÉTAPE 5 — UTILISER L’ARCHIVAGE SI NÉCESSAIRE

Avec l’équipe archivage, configurer l’objet `BC_SBAL`, exécuter d’abord l’écriture des archives puis la suppression des données archivées. Tester lecture et restitution selon les obligations avant la première purge productive.

### 20.F.6 ÉTAPE 6 — CONTRÔLER APRÈS TRAITEMENT

Comparer nombre de journaux, période accessible et volumétrie avant/après. Vérifier dans `SLG1` qu’un log à conserver reste présent et qu’un log expiré est supprimé ou archivé. Surveiller régulièrement la durée des recherches et la croissance des tables BAL.

## 20.G VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 20.H ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 20.I FICHE DE CONTRÔLE À COPIER

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

## 20.J TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 20.K RÉFÉRENCES OFFICIELLES SAP

- [Archiving Object BC_SBAL — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e4a2209872c3b0fe10000000a42189e.html)
- [Deletion of Business Application Logs — SAP Help Portal](https://help.sap.com/docs/btc/security-guide/deletion-of-business-application-logs)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)

---

[Chapitre suivant — AUTORISATIONS ET DONNÉES SENSIBLES](<./21 ├── AUTORISATIONS ET DONNEES SENSIBLES.md>)

[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-environnement]: **ENVIRONNEMENT.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#environnement>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).

[^outil-slg2]: **SLG2.** Transaction de suppression planifiée ou contrôlée des journaux applicatifs persistés. Voir [le chapitre associé](<20 ├── RETENTION SUPPRESSION ET ARCHIVAGE.md>).
[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
