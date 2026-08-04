# ÉDITEURS ABAP `SE38` ET `SE80`

## RÉSULTAT ATTENDU

- Distinguer les rôles de `SE38` et `SE80`
- Ouvrir, modifier, contrôler et activer un programme
- Naviguer dans les sous-objets d’un programme
- Utiliser les principales fonctions de l’éditeur ABAP dans SAP GUI
- Choisir l’outil adapté au contexte

## VUE D’ENSEMBLE

```mermaid
flowchart LR
    A["Programme ABAP"] --> B{"Besoin"}
    B -->|Accès direct au programme| C["SE38"]
    B -->|Navigation Repository et package| D["SE80"]
    C --> E["Éditeur de code source"]
    D --> E
```

## TRANSACTION `SE38`

`SE38` ouvre l’ABAP Editor avec une approche centrée sur un programme.

Utilisations courantes :

- créer un programme ;
- afficher ou modifier son code source ;
- exécuter un programme exécutable ;
- maintenir ses variantes ;
- accéder aux textes ;
- lancer des contrôles liés au programme.

`SE38` est adaptée lorsqu’on connaît déjà le nom du programme à traiter.

## TRANSACTION `SE80`

`SE80` ouvre l’Object Navigator et permet de travailler dans le contexte du Repository.

Utilisations courantes :

- naviguer dans un package ;
- afficher les objets liés à un programme ;
- ouvrir des includes, écrans, statuts GUI ou classes locales ;
- créer différents types d’objets ;
- consulter les relations entre objets ;
- accéder à la liste d’utilisations.

`SE80` est généralement plus efficace pour analyser une application classique composée de plusieurs objets.

## COMPARAISON

| Besoin                                      |                     `SE38` |     `SE80` |
| ------------------------------------------- | -------------------------: | ---------: |
| Ouvrir rapidement un programme connu        |                        Oui |        Oui |
| Exécuter un programme                       |                        Oui |        Oui |
| Parcourir un package                        |                     Limité |        Oui |
| Naviguer entre sous-objets                  |                     Limité |        Oui |
| Créer plusieurs catégories d’objets         |                        Non |        Oui |
| Analyser une application classique complète | Possible mais peu pratique | Recommandé |

## ÉDITEUR DE CODE SOURCE

L’éditeur de code source ABAP est intégré à plusieurs outils du Workbench, notamment `SE38`, `SE80`, `SE24` et `SE37`.

Fonctions principales :

- coloration syntaxique ;
- indentation ;
- recherche et remplacement ;
- aide sur les mots-clés ;
- contrôle syntaxique ;
- activation ;
- gestion des points d’arrêt ;
- navigation vers les définitions et utilisations selon le contexte.

## ACTIONS ESSENTIELLES

| Action               | Effet                                                           |
| -------------------- | --------------------------------------------------------------- |
| Enregistrer          | Sauvegarde l’état de travail, qui peut rester inactif           |
| Contrôler            | Exécute le contrôle syntaxique                                  |
| Activer              | Génère et publie la version active si les contrôles réussissent |
| Exécuter             | Lance un programme exécutable                                   |
| Afficher/Modifier    | Bascule entre consultation et édition selon les autorisations   |
| Liste d’utilisations | Recherche les consommateurs identifiables de l’objet            |

### RACCOURCIS CLASSIQUES

| Raccourci     | Action courante                  |
| ------------- | -------------------------------- |
| `Ctrl` + `S`  | Enregistrer                      |
| `Ctrl` + `F2` | Contrôle syntaxique              |
| `Ctrl` + `F3` | Activer                          |
| `F8`          | Exécuter un programme exécutable |

Les raccourcis peuvent dépendre du contexte de l’écran et des paramètres du frontend.

## AIDE SUR LE CODE

### DOCUMENTATION D’UN MOT-CLÉ

Placer le curseur sur un mot-clé ABAP puis utiliser l’aide permet d’ouvrir la documentation correspondante disponible dans le système.

La documentation locale du système est particulièrement utile pour vérifier la syntaxe compatible avec sa version ABAP.

### COMPLÉTION ET MODÈLES

L’éditeur de code source peut proposer :

- des modèles de code ;
- de la complétion ;
- des corrections de casse ;
- une indentation automatique.

Ces fonctions aident à saisir du code, mais ne remplacent ni le contrôle syntaxique ni la vérification fonctionnelle.

## VERROU ET MODE MODIFICATION

L’ouverture en modification peut échouer lorsque :

- l’objet est verrouillé par un autre utilisateur ;
- l’utilisateur ne possède pas l’autorisation ;
- le système ou le client est non modifiable ;
- l’objet appartient au standard SAP et la modification n’est pas autorisée ;
- une réparation ou une clé serait nécessaire selon le contexte du système.

> [!CAUTION]
> Ne jamais contourner un verrou ou une restriction sans comprendre son origine et sans validation du responsable technique.

## MÉTHODE DE TRAVAIL

```mermaid
flowchart TD
    A["Ouvrir l’objet"] --> B["Comprendre le contexte"]
    B --> C["Contrôler les utilisations"]
    C --> D["Modifier"]
    D --> E["Enregistrer"]
    E --> F["Contrôle syntaxique"]
    F --> G["Activer"]
    G --> H["Tester"]
```

- privilégier `SE80` pour comprendre une application et ses dépendances ;
- utiliser `SE38` pour l’accès direct à un programme connu ;
- lire l’objet avant de le modifier ;
- contrôler la requête de transport associée ;
- comparer la version active et inactive en cas de doute ;
- ne pas confondre enregistrement et activation.

## PROCESS

### Étape 1 — Ouvrir un programme connu dans SE38

1. Saisir `/nSE38`.
2. Entrer le nom technique exact du programme.
3. Choisir **Afficher** pour l’analyse ou **Modifier** uniquement si une correction est autorisée.

Si le programme est introuvable, vérifier son nom et son type. Une classe, un groupe de fonctions ou un include ne doit pas être créé comme report pour contourner une recherche incorrecte.

### Étape 2 — Déterminer si SE38 suffit

Utiliser SE38 pour consulter, modifier, contrôler, activer ou exécuter directement un programme connu. Relever ses includes et objets associés lorsque le changement dépasse le source principal.

Si l’analyse exige des écrans, GUI status, includes nombreux ou objets d’un package, poursuivre dans SE80.

### Étape 3 — Retrouver le même objet dans SE80

1. Ouvrir `/nSE80`.
2. Choisir le type **Programme**.
3. Saisir le même nom puis valider.
4. Développer l’arborescence et comparer le source principal, les includes, écrans et GUI status avec les informations vues dans SE38.

L’objet ouvert dans les deux transactions doit porter le même nom et le même statut d’activation. SE80 ajoute la vue structurée ; il ne crée pas une copie distincte.

### Étape 4 — Contrôler et activer

1. Enregistrer la modification.
2. Exécuter `Ctrl+F2` et traiter chaque erreur syntaxique.
3. Exécuter `Ctrl+F3` pour activer.
4. Vérifier dans l’arborescence que les objets dépendants ne restent pas inactifs.

Un contrôle syntaxique réussi ne remplace pas l’activation. Une version enregistrée mais inactive n’est pas celle exécutée normalement.

### Étape 5 — Consulter l’aide de la release

Positionner le curseur sur une instruction ou une addition ABAP puis appuyer sur `F1`. Vérifier la syntaxe, les prérequis de release, les exceptions et les exemples applicables au système connecté.

Le chapitre est validé lorsque le lecteur sait choisir SE38 pour l’accès direct et SE80 pour la navigation structurée, puis contrôler et activer le même objet sans ambiguïté.

## VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## ERREURS FRÉQUENTES

- Intervenir dans le mauvais système ou mandant.
- Confondre sauvegarde et activation.

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

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Système SAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#systeme-sap>)
- [Mandant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>)
- [SAP GUI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Repository ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#repository-abap>)

## RÉFÉRENCES OFFICIELLES SAP

- [Object Navigator](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/efd94b7bebf811d295b100a0c94260a5.html)
- [Source Code-Based Editor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/4b2015f1ec4f0120e10000000a42189c.html)
- [ABAP Source Code Editor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/9ac600a0fad14967aaf2964be5a21963.html)
- [Creating a Program](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801a47454211d189710000e8322d00-65.html)

---

[Chapitre suivant — CRÉATION D’UN PREMIER PROGRAMME](<./05 ├── CREATION D UN PREMIER PROGRAMME.md>)
