# 2. CHOISIR UNE TECHNOLOGIE D’EXTENSION

## 2.A RÉSULTAT ATTENDU

- Choisir la technologie la plus stable disponible
- Éviter l’utilisation d’un enhancement implicite lorsqu’une extension publiée existe
- Situer les technologies historiques

## 2.B ORDRE DE RECHERCHE

```mermaid
flowchart TD
    A["Besoin métier"] --> B{"Customizing suffisant ?"}
    B -->|"Oui"| C["Configurer sans développement"]
    B -->|"Non"| D{"BAdI ou exit publié ?"}
    D -->|"Oui"| E["Implémenter le point publié"]
    D -->|"Non"| F{"Point explicite disponible ?"}
    F -->|"Oui"| G["Créer une enhancement implementation"]
    F -->|"Non"| H{"Option implicite acceptable ?"}
    H -->|"Oui"| I["Implémentation minimale et documentée"]
    H -->|"Non"| J["Escalade architecturale avant modification"]
```

## 2.C MATRICE DE CHOIX

| Technologie                   | Utilisation principale                               | Outil SAP GUI[^terme-sap-gui]          |
| ----------------------------- | ---------------------------------------------------- | ---------------------- |
| Customer exit                 | Extensions classiques fournies par SAP               | `SMOD`[^outil-smod], `CMOD`[^outil-cmod]         |
| BAdI[^terme-acro-badi] classique                | Extension orientée objet historique                  | `SE18`[^outil-se18], `SE19`[^outil-se19]         |
| BAdI du Enhancement Framework | Extension orientée objet intégrée au framework       | `SE18`, `SE19`, `SE80`[^outil-se80] |
| Enhancement point ou section  | Insertion ou remplacement à un point explicite       | Éditeur ABAP[^terme-abap], `SE80`   |
| Option implicite              | Insertion à un emplacement systématique              | Éditeur ABAP           |
| BTE[^terme-acro-bte]                           | Extension événementielle, fréquente en FI            | `FIBF`[^outil-fibf]                 |
| User exit codé                | Routine historique nommée dans un programme standard | `SE38`[^outil-se38], `SE80`         |

## 2.D CRITÈRES

Évaluer systématiquement :

- stabilité du contrat ;
- possibilité de plusieurs implémentations ;
- filtrage disponible ;
- contexte transactionnel ;
- fréquence d’appel ;
- volume de données ;
- dépendance à une ligne précise du standard ;
- comportement après upgrade ;
- possibilité de désactivation rapide.

## 2.E PROCESS

### 2.E.1 ÉTAPE 1 — IDENTIFIER LE TYPE DE PROCESSUS

Déterminer si le besoin concerne une transaction classique, un traitement FI, un écran Dynpro[^terme-dynpro], une classe[^terme-classe], une API[^terme-api] ou un framework applicatif. Relever le composant logiciel et le scénario exact. La technologie pertinente dépend du point d’exécution réel.

### 2.E.2 ÉTAPE 2 — RECHERCHER LES EXTENSIONS DOCUMENTÉES

Consulter la documentation du composant et les objets Repository associés. Pour chaque BAdI, customer exit, BTE ou enhancement explicite trouvé, relever les paramètres, les filtres, l’usage multiple, le moment d’appel et les restrictions.

### 2.E.3 ÉTAPE 3 — CONFIRMER L’APPEL AU RUNTIME

Placer un breakpoint[^terme-breakpoint] dans le point candidat ou utiliser un breakpoint sur les mécanismes d’appel adaptés. Reproduire une seule fois le processus. Vérifier que le point est atteint avec les données requises et dans le bon contexte transactionnel.

### 2.E.4 ÉTAPE 4 — COMPARER LES CANDIDATS

Classer chaque option selon sa stabilité, son périmètre, ses données disponibles, son ordre d’exécution et sa transportabilité. Privilégier le contrat d’extension prévu par SAP. N’utiliser une option implicite qu’en l’absence de point public approprié et avec une justification documentée.

### 2.E.5 ÉTAPE 5 — VÉRIFIER LES IMPLÉMENTATIONS EXISTANTES

Rechercher les projets CMOD, implémentations BAdI et enhancements actifs. Contrôler leurs filtres et leur ordre éventuel. Déterminer si le besoin doit compléter une implémentation existante ou s’il peut être isolé sans comportement concurrent.

### 2.E.6 ÉTAPE 6 — CONSIGNER LA DÉCISION

Documenter le point retenu, les alternatives écartées, le scénario de preuve, les objets à transporter et les tests de non-régression. Cette fiche devient le contrôle de référence lors des upgrades et changements de support package[^terme-package].

## 2.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 2.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 2.H FICHE DE CONTRÔLE À COPIER

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

## 2.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 2.J RÉFÉRENCES OFFICIELLES SAP

- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)
- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)

---

[Chapitre suivant — RECHERCHER UN POINT D’EXTENSION](<./03 ├── RECHERCHER UN POINT D EXTENSION.md>)

[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-acro-badi]: **BADI.** Business Add-In, mécanisme d’extension orienté objet du standard SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-bte]: **BTE.** Business Transaction Event, mécanisme d’extension utilisé notamment dans certains domaines financiers. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).

[^outil-smod]: **SMOD.** Transaction de recherche et d’analyse des enhancements SAP classiques. Voir [le chapitre associé](<06 ├── ANALYSER UN ENHANCEMENT AVEC SMOD.md>).
[^outil-cmod]: **CMOD.** Transaction de gestion des projets d’extensions client classiques. Voir [le chapitre associé](<07 ├── CREER ET ACTIVER UN PROJET CMOD.md>).
[^outil-se18]: **SE18.** BAdI Builder utilisé pour rechercher et analyser les définitions de BAdI. Voir [le chapitre associé](<14 ├── ANALYSER UNE DEFINITION BADI AVEC SE18.md>).
[^outil-se19]: **SE19.** BAdI Builder utilisé pour créer et maintenir les implémentations de BAdI. Voir [le chapitre associé](<15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>).
[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-fibf]: **FIBF.** Transaction d’accès au framework Business Transaction Events et à ses produits/processus. Voir [le chapitre associé](<22 ├── BUSINESS TRANSACTION EVENTS AVEC FIBF.md>).
[^outil-se38]: **SE38.** Éditeur ABAP classique utilisé pour créer, modifier, vérifier et exécuter des programmes. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
