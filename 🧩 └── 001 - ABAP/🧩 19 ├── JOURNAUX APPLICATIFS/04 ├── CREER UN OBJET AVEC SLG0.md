# CRÉER UN OBJET AVEC SLG0

## RÉSULTAT ATTENDU

- Créer un objet et ses sous-objets
- Comprendre leur transport
- Vérifier que la combinaison est exploitable par le code

## TRANSACTION

La transaction `SLG0` maintient les objets du journal applicatif et leurs sous-objets.

```mermaid
flowchart LR
    A["SLG0"] --> B["Créer l objet"]
    B --> C["Créer les sous-objets"]
    C --> D["Affecter le package et le transport"]
    D --> E["Tester dans SLG1 ou par programme"]
```

## PROCESS

### ÉTAPE 1 — VÉRIFIER L’EXISTANT

Saisir `/nSLG0` et rechercher un objet correspondant au domaine, au propriétaire et à la rétention attendus. Ouvrir ses sous-objets et descriptions. Réutiliser l’existant uniquement si sa sémantique et ses autorisations conviennent.

### ÉTAPE 2 — CRÉER L’OBJET CLIENT

Choisir la création, saisir un nom Z ou Y conforme aux conventions et une description destinée à l’exploitation. Le nom représente un domaine durable. Éviter les noms de programme, de ticket ou d’environnement.

### ÉTAPE 3 — CRÉER LES SOUS-OBJETS

Ajouter un sous-objet par processus cohérent. Renseigner des descriptions permettant de choisir le filtre dans `SLG1`. Vérifier qu’aucun sous-objet existant ne couvre déjà le besoin.

### ÉTAPE 4 — ENREGISTRER DANS LE BON PACKAGE

Affecter l’objet à un package transportable et à la demande Workbench attendue. Contrôler que l’objet et tous les sous-objets figurent dans la demande. Éviter `$TMP` pour une configuration destinée aux autres systèmes.

### ÉTAPE 5 — TESTER AVEC UN JOURNAL MINIMAL

Créer un report Z qui utilise exactement l’objet et le sous-objet, appelle `BAL_LOG_CREATE`, ajoute un message puis sauvegarde. Contrôler tous les retours. Une erreur d’en-tête indique souvent une configuration absente ou incohérente.

### ÉTAPE 6 — CONTRÔLER APRÈS TRANSPORT

Dans le système cible, vérifier l’objet dans `SLG0` avant le premier job. Exécuter le test autorisé et rechercher le résultat dans `SLG1`. Documenter l’objet, les sous-objets et la politique de rétention.

## CONTRÔLE PAR PROGRAMME

Les fonctions suivantes permettent de contrôler les définitions :

- `BAL_OBJECT_SELECT` ;
- `BAL_SUBOBJECT_SELECT` ;
- `BAL_OBJECT_SUBOBJECT`.

Le framework vérifie aussi la cohérence lors de `BAL_LOG_CREATE`. Une combinaison inexistante provoque une erreur de création du journal.

## ERREURS FRÉQUENTES

- sous-objet créé dans le mauvais objet ;
- définition créée localement alors qu’elle doit être transportée ;
- nom différent entre `SLG0` et le code ;
- objet absent dans le système de recette ou de production ;
- texte métier insuffisant pour l’équipe de support.

## VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

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

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Application Log Methodology in SAP — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524098.html)
- [Registering Subobjects for the Application Log — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70761bba72014fb48199b9232d0d8409/5f770b3303c142c69e5ab3e97a16d7a8.html)

---

[Chapitre suivant — ANALYSER LES JOURNAUX AVEC SLG1](<./05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>)
