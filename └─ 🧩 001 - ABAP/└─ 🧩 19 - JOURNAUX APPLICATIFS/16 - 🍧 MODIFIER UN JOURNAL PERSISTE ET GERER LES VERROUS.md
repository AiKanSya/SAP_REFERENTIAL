# 🌸 MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS

## 🌺 OBJECTIFS

- Comprendre la séquence de modification d’un journal existant
- Éviter les mises à jour concurrentes
- Connaître les fonctions de verrouillage du BAL

## 🌺 SÉQUENCE

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

## 🌺 PRÉCAUTIONS

- verrouiller la plus petite durée possible ;
- toujours déverrouiller, y compris après une erreur ;
- éviter de transformer un journal historique en état métier mutable ;
- préférer un nouveau journal pour une nouvelle exécution ;
- documenter pourquoi un journal existant doit être modifié.

## 🌺 STATUT DU JOURNAL

Le statut d’un journal est informatif. Il ne remplace pas un statut persistant dans la table métier. Un processus critique ne doit pas dépendre uniquement de `BAL_S_LOG-ALSTATE` pour savoir s’il est terminé.

## 🌺 PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## 🌺 VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 🌺 ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

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

- [Application Log](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bal>)
- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)


---

➡️ [Chapitre suivant — GÉRER LES HANDLES ET LA MÉMOIRE BAL](<./17 - 🍧 GERER LES HANDLES ET LA MEMOIRE BAL.md>)
