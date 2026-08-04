# PROGRAMMES DE DÉMONSTRATION, TESTS ET DIAGNOSTIC

## RÉSULTAT ATTENDU

- Utiliser les démonstrations standard SAP
- Tester chaque étape du cycle BAL
- Diagnostiquer un journal absent ou incomplet

## PROGRAMMES STANDARD

SAP documente plusieurs programmes de démonstration :

| Programme      | Sujet principal                 |
| -------------- | ------------------------------- |
| `SBAL_DEMO_01` | Création et ajout simple        |
| `SBAL_DEMO_02` | Méthodes avancées de collecte   |
| `SBAL_DEMO_03` | Recherche et lecture en mémoire |
| `SBAL_DEMO_04` | Profils et affichage            |
| `SBAL_DEMO_05` | Interface base de données       |

Analyser ces programmes dans `SE38` ou `SE80` avant d’inventer une implémentation spécifique.

## PROCESS

### ÉTAPE 1 — ÉTUDIER LES DÉMONSTRATIONS STANDARD

Ouvrir les programmes `SBAL_DEMO_*` disponibles dans `SE38` ou `SE80`. Vérifier leur documentation et leur code sur la release cible. Exécuter uniquement les exemples autorisés dans un système de développement.

### ÉTAPE 2 — CONFIGURER UN OBJET DE TEST

Créer ou utiliser un objet et un sous-objet Z dédiés dans `SLG0`. Définir un identifiant externe unique. Ne pas tester avec un objet productif si la démonstration peut créer ou supprimer des journaux persistants.

### ÉTAPE 3 — TESTER LE CYCLE EN MÉMOIRE

Créer le log, ajouter un message `S`, `W`, `E`, un texte libre et une exception. Contrôler chaque retour et conserver les handles. Afficher le journal en dialogue avec un profil adapté.

### ÉTAPE 4 — TESTER LA PERSISTANCE

Sauvegarder uniquement le handle créé, relever le numéro persistant puis rechercher dans `SLG1`. Comparer en-tête, messages, niveaux et contexte. Tester aussi le comportement après rollback selon la stratégie retenue.

### ÉTAPE 5 — TESTER RECHERCHE ET CHARGEMENT

Construire un filtre sélectif pour `BAL_DB_SEARCH`, charger l’en-tête retourné avec `BAL_DB_LOAD`, puis réafficher le handle. Nettoyer ensuite la mémoire. Vérifier qu’un autre log présent dans la session n’est pas affecté.

### ÉTAPE 6 — DIAGNOSTIQUER UN LOG ABSENT

Contrôler successivement configuration `SLG0`, en-tête, retour de `BAL_LOG_CREATE`, handle des ajouts, retour de `BAL_DB_SAVE`, LUW, filtres `SLG1` et autorisations. Conserver la première étape en échec avant de modifier le code.

### ÉTAPE 7 — TESTER UN UTILISATEUR REPRÉSENTATIF

Exécuter la recherche et l’affichage avec le rôle d’exploitation réel. Vérifier le refus sur un autre objet et l’absence de données sensibles. Documenter les objets d’autorisation et le résultat de chaque scénario.

## JOURNAL ABSENT DANS SLG1

```mermaid
flowchart TD
    A["Journal absent"] --> B{"BAL_LOG_CREATE réussi ?"}
    B -->|"Non"| C["Vérifier SLG0 et l en-tête"]
    B -->|"Oui"| D{"BAL_DB_SAVE appelé ?"}
    D -->|"Non"| E["Journal uniquement en mémoire"]
    D -->|"Oui"| F["Vérifier filtres SLG1 et autorisations"]
```

## MESSAGES MANQUANTS

Contrôler :

- handle transmis ;
- `sy-subrc` des fonctions d’ajout ;
- niveau de détail ou filtre d’affichage ;
- cumul involontaire ;
- journal retiré de la mémoire ;
- rollback ou échec de l’update task ;
- sélection trop restrictive dans `SLG1`.

## VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

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

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Log Display — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/addb96cd90c945dfb3182865363bbc47/4e2102fa35d44180e10000000a15822b.html)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)

---

[Chapitre suivant — BONNES PRATIQUES ET CHECKLIST](<./24 └── BONNES PRATIQUES ET CHECKLIST.md>)
