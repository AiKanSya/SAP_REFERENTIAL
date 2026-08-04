# 16. MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS

## 16.A RÉSULTAT ATTENDU

- Comprendre la séquence de modification d’un journal existant
- Éviter les mises à jour concurrentes
- Connaître les fonctions de verrouillage du BAL[^terme-acro-bal]

## 16.B SÉQUENCE

```mermaid
flowchart LR
    A["Rechercher le journal"] --> B["BAL_DB_ENQUEUE"]
    B --> C["BAL_DB_LOAD"]
    C --> D["Modifier en mémoire"]
    D --> E["BAL_DB_SAVE"]
    E --> F["BAL_DB_DEQUEUE"]
```

Les fonctions principales sont :

- `BAL_DB_ENQUEUE` ;
- `BAL_DB_LOAD` ;
- `BAL_LOG_HDR_CHANGE` ;
- `BAL_LOG_MSG_CHANGE` ;
- `BAL_LOG_MSG_DELETE` ;
- `BAL_DB_SAVE` ;
- `BAL_DB_DEQUEUE`.

## 16.C PRÉCAUTIONS

- verrouiller la plus petite durée possible ;
- toujours déverrouiller, y compris après une erreur ;
- éviter de transformer un journal historique en état métier mutable ;
- préférer un nouveau journal pour une nouvelle exécution ;
- documenter pourquoi un journal existant doit être modifié.

## 16.D STATUT DU JOURNAL

Le statut d’un journal est informatif. Il ne remplace pas un statut persistant dans la table métier. Un processus critique ne doit pas dépendre uniquement de `BAL_S_LOG-ALSTATE` pour savoir s’il est terminé.

## 16.E PROCESS

### 16.E.1 ÉTAPE 1 — JUSTIFIER LA MODIFICATION HISTORIQUE

Définir pourquoi un journal existant doit changer et pourquoi un nouveau journal ne suffit pas. Identifier son numéro, son objet et son propriétaire. Ne pas utiliser BAL comme table de statut métier mutable.

### 16.E.2 ÉTAPE 2 — RECHERCHER LE JOURNAL EXACT

Construire un filtre sélectif, appeler `BAL_DB_SEARCH` et vérifier qu’un seul en-tête correspond au numéro ou à l’identifiant attendu. Interrompre si la sélection est ambiguë.

### 16.E.3 ÉTAPE 3 — ACQUÉRIR LE VERROU BAL

Appeler `BAL_DB_ENQUEUE` selon sa signature active avant le chargement destiné à modification. Traiter une collision comme un conflit contrôlé. Limiter la durée du verrou en préparant toutes les données avant cet appel.

### 16.E.4 ÉTAPE 4 — CHARGER ET MODIFIER EN MÉMOIRE

Charger le journal, retrouver son handle et lire l’en-tête ou les messages ciblés. Appeler `BAL_LOG_HDR_CHANGE`, `BAL_LOG_MSG_CHANGE` ou `BAL_LOG_MSG_DELETE` uniquement sur les handles validés. Contrôler chaque retour.

### 16.E.5 ÉTAPE 5 — SAUVEGARDER ET DÉVERROUILLER

Sauvegarder le handle modifié avec `BAL_DB_SAVE`, puis appeler `BAL_DB_DEQUEUE` dans le chemin nominal et les chemins d’erreur. Ne pas laisser un verrou actif après une exception[^terme-exception] gérée.

### 16.E.6 ÉTAPE 6 — VÉRIFIER LA CONCURRENCE ET L’HISTORIQUE

Ouvrir le journal dans `SLG1`[^outil-slg1] et confirmer uniquement les modifications prévues. Tester deux sessions sur le même journal, une erreur avant sauvegarde et une erreur après chargement. Vérifier que l’historique reste fidèle au traitement initial.

## 16.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 16.G ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 16.H FICHE DE CONTRÔLE À COPIER

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

## 16.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 16.J RÉFÉRENCES OFFICIELLES SAP

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)

---

[Chapitre suivant — GÉRER LES HANDLES ET LA MÉMOIRE BAL](<./17 ├── GERER LES HANDLES ET LA MEMOIRE BAL.md>)

[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).

[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
