# TEST, DOCUMENTATION ET LIBÉRATION

## RÉSULTAT ATTENDU

- Tester un module dans `SE37`
- Constituer des données de test reproductibles
- Documenter le contrat complet
- Comprendre la portée d’un statut de libération

## TEST DIRECT

Dans `SE37`, choisir **Tester / Exécuter**. L’écran de test reprend les sections de l’interface.

Procédure :

### Étape 1 — Préparer un jeu de données

Relever une clé existante pour le cas nominal, une clé absente et une valeur limite. Identifier avant le test les effets persistants ou appels externes possibles.

### Étape 2 — Renseigner l’interface

Dans `SE37`, choisir **Tester/Exécuter** et saisir tous les imports obligatoires. Pour les structures et tables, contrôler chaque composant et son format interne.

### Étape 3 — Exécuter et relever toutes les sorties

Noter exports, changing, tables, exception et messages. Comparer avec le résultat attendu avant de modifier une entrée.

### Étape 4 — Vérifier les effets de bord

Rechercher les écritures, verrous, tâches update ou commits indiqués par le contrat. Nettoyer les données de test selon la procédure prévue.

### Étape 5 — Tester les autres branches

Recommencer avec cas absent, limite et chaque erreur prévue. Le test direct est validé lorsque toutes les branches ont un résultat observable et reproductible.

```mermaid
flowchart LR
    A["Cas nominal"] --> D["Test SE37"]
    B["Cas limite"] --> D
    C["Cas erreur"] --> D
    D --> E["Résultats et exceptions"]
```

## SÉQUENCES DE TEST

Certains modules doivent être testés dans une séquence, par exemple :

### Étape 1 — Définir l’ordre imposé

Identifier le module d’initialisation, la lecture, la modification et le module ou BAPI de validation. Relever les données transmises entre appels.

### Étape 2 — Construire la séquence

Dans l’outil de séquence `SE37`, ajouter les modules dans cet ordre et renseigner des entrées cohérentes. Ne valider pas encore la transaction si le test doit contrôler un rollback.

### Étape 3 — Exécuter jusqu’à la modification

Contrôler les sorties après chaque appel. Si une étape échoue, arrêter : les étapes suivantes ne doivent pas masquer la première erreur.

### Étape 4 — Tester validation et annulation

Exécuter une séquence avec commit prévu, puis une autre avec rollback. Vérifier la persistance réelle des données dans les deux cas.

Utiliser les fonctions de séquence de test disponibles dans le Function Builder lorsque le scénario l’exige. Ne pas conclure à un défaut uniquement parce qu’un module transactionnel a été appelé isolément.

## DOCUMENTATION

Documenter :

- objectif métier ou technique ;
- préconditions ;
- paramètres et unités ;
- valeurs facultatives ;
- effets en base ;
- exceptions et messages ;
- gestion du commit ;
- autorisations requises ;
- restrictions RFC éventuelles.

## LIBÉRATION

Un indicateur de libération ou une documentation d’API est une information importante pour les consommateurs. Pour un objet SAP standard, ne pas déduire la stabilité publique du simple fait que le module est visible ou testable.

Pour un module client :

- définir les consommateurs autorisés ;
- établir une politique de compatibilité ;
- éviter les suppressions ou changements incompatibles ;
- versionner lorsque nécessaire.

## LIMITES DU TEST SE37

Le test direct ne remplace pas :

- un test du programme appelant ;
- un test d’autorisation RFC ;
- un test de destination ;
- un test de concurrence ;
- un test de rollback ;
- un test automatisé autour de la logique métier.

## PROCESS

### Étape 1 — Compléter la documentation

Documenter objectif, paramètres, unités, valeurs initiales, exceptions, autorisations et responsabilité de commit. Un lecteur doit pouvoir construire un appel sans lire l’implémentation.

### Étape 2 — Exécuter la matrice de tests

Tester cas nominal, absent, limite, autorisation refusée et erreur technique applicable. Conserver entrées et résultats.

### Étape 3 — Contrôler qualité et dépendances

Exécuter contrôle syntaxique, ATC/SCI prévu et liste d’utilisation. Vérifier que les types DDIC et objets appelés sont actifs et transportés avant le module.

### Étape 4 — Libérer la livraison

Contrôler contenu de la tâche, activer le groupe complet puis libérer selon le processus. La livraison est validée lorsque documentation, tests et dépendances correspondent à la version transportée.

## VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## ERREURS FRÉQUENTES

- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

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

- [Libération](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#liberation-transport>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>)

## RÉFÉRENCES OFFICIELLES SAP

- [Testing Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c6663103e6ad47dcb8bb830d85137077/496d3bbee0221ec6e10000000a42189b.html)
- [Specifying Parameters and Exceptions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_2021/bd833c8355f34e96a6e83096b38bf192/d1801f0f454211d189710000e8322d00.html)
- [Looking Up Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801ec1454211d189710000e8322d00.html)


---

[Chapitre suivant — MODULES FONCTION DE MISE À JOUR](<./11 ├── MODULES FONCTION DE MISE A JOUR.md>)
