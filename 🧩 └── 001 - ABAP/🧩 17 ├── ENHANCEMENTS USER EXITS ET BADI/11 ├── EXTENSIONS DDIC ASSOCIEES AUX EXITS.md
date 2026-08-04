# 11. EXTENSIONS DDIC ASSOCIÉES AUX EXITS

## 11.A RÉSULTAT ATTENDU

- Relier un champ client à une extension applicative
- Utiliser append structures et éléments de données sans modifier la table SAP[^terme-acro-sap]
- Organiser le transport des dépendances

## 11.B CAS CLASSIQUE

Un screen exit affiche un champ client. La persistance peut nécessiter :

- un élément de données[^terme-element-donnees] client ;
- un domaine client ;
- une append structure sur une structure ou table extensible ;
- un sous-écran ;
- des function exits pour l’alimentation et la sauvegarde.

```mermaid
flowchart TD
    A["Champ du sous-écran"] --> B["Élément de données client"]
    B --> C["Append structure"]
    C --> D["Structure ou table SAP extensible"]
    A --> E["Function exits de transfert"]
```

## 11.C RÈGLES

- utiliser les mécanismes d’append prévus par le Dictionary ;
- ne pas ajouter un champ directement dans une table SAP ;
- vérifier les catégories d’extension autorisées ;
- respecter le namespace client[^terme-namespace-client] ;
- ne pas supposer que l’ajout DDIC[^terme-acro-ddic] entraîne automatiquement l’affichage ou la sauvegarde ;
- analyser les impacts sur les structures, interfaces, IDoc[^terme-idoc] et extractions.

## 11.D TRANSPORT

Transporter dans un ordre cohérent :

1. domaine et élément de données ;
2. append structure ;
3. sous-écran et code ;
4. projet ou implémentation d’extension ;
5. paramétrage éventuel.

## 11.E PROCESS

### 11.E.1 ÉTAPE 1 — IDENTIFIER LE POINT DDIC PRÉVU

Depuis la documentation `SMOD`[^outil-smod] et les paramètres des exits, relever la structure client, l’include `CI_*` ou l’append attendu. Vérifier sa présence dans les tables et structures réellement utilisées par le processus. Ne pas ajouter un champ à une structure voisine sans preuve de propagation.

### 11.E.2 ÉTAPE 2 — DÉFINIR LES CHAMPS Z

Créer ou réutiliser des éléments de données Z avec domaine, libellés, aide de recherche et documentation cohérents. Choisir des types compatibles avec le stockage, l’écran et l’interface de l’exit. Définir les règles de valeur initiale et de conversion.

### 11.E.3 ÉTAPE 3 — CRÉER L’APPEND OU COMPLÉTER L’INCLUDE

Dans `SE11`[^outil-se11], ouvrir l’objet autorisé et ajouter les composants dans une append structure Z ou l’include client prévu. Affecter le package[^terme-package] et la demande de transport. Ne pas modifier directement les composants livrés par SAP.

### 11.E.4 ÉTAPE 4 — CONTRÔLER ET ACTIVER LE DDIC

Exécuter le contrôle de cohérence puis activer les domaines, éléments de données et append dans l’ordre des dépendances. Examiner les messages d’activation et, pour une table, vérifier l’état de la structure physique selon la procédure Basis du système.

### 11.E.5 ÉTAPE 5 — ADAPTER L’EXIT ET L’ÉCRAN

Utiliser les nouveaux champs dans le screen exit ou le function exit prévu pour l’initialisation et la sauvegarde. Éviter les affectations dynamiques si le champ est désormais typé dans le contrat client. Conserver la validation métier dans une classe[^terme-classe] dédiée.

### 11.E.6 ÉTAPE 6 — TESTER LE CYCLE ET LE TRANSPORT

Créer, modifier, afficher et annuler un document avec les nouveaux champs. Vérifier la persistance, les valeurs initiales, les aides et les autorisations. Contrôler que les objets DDIC sont transportés avant le code et les écrans qui les référencent.

## 11.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint[^terme-breakpoint] confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 11.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 11.H FICHE DE CONTRÔLE À COPIER

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

## 11.I TERMES DU LEXIQUE

- [DDIC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>)
- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 11.J RÉFÉRENCES OFFICIELLES SAP

- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)
- [Types of Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975e643b111d1896f0000e8322d00.html)

---

[Chapitre suivant — FIELD EXITS ET TECHNOLOGIES HISTORIQUES](<./12 ├── FIELD EXITS ET TECHNOLOGIES HISTORIQUES.md>)

[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-element-donnees]: **ÉLÉMENT DE DONNÉES.** Objet DDIC qui attribue une signification métier, des libellés et une documentation à un type élémentaire ou à un domaine. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>).
[^terme-namespace-client]: **NAMESPACE CLIENT.** Espace de noms réservé aux développements spécifiques, souvent préfixés par `Z` ou `Y`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#namespace-client>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-idoc]: **IDOC.** Document intermédiaire SAP structuré en segments pour l’échange de messages métier. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#idoc>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).

[^outil-smod]: **SMOD.** Transaction de recherche et d’analyse des enhancements SAP classiques. Voir [le chapitre associé](<06 ├── ANALYSER UN ENHANCEMENT AVEC SMOD.md>).
[^outil-se11]: **SE11.** Transaction de l’ABAP Dictionary utilisée pour analyser et maintenir les objets DDIC. Voir [le chapitre associé](<../🧩 07 ├── DICTIONNAIRE ABAP/02 ├── NAVIGATION ET ANALYSE AVEC SE11.md>).
