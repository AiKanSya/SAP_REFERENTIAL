# 17. BONNES PRATIQUES DE MODÉLISATION DDIC

## 17.A RÉSULTAT ATTENDU

- Concevoir des objets DDIC[^terme-acro-ddic] réutilisables
- Réduire les dépendances inutiles
- Sécuriser les extensions et évolutions
- Éviter les erreurs classiques de modélisation
- Disposer d’une checklist de revue

## 17.B MODÉLISER PAR NIVEAUX

```mermaid
flowchart LR
    A["Domaine technique cohérent"] --> B["Élément de données sémantique"]
    B --> C["Structure ou champ de table"]
    C --> D["Relation, aide et verrou"]
    D --> E["Programme consommateur"]
```

Chaque niveau doit apporter une information distincte : format, sens, composition[^terme-composition], persistance ou comportement.

## 17.C RÈGLES DE CONCEPTION

### 17.C.1 Domaines

- créer un domaine partagé uniquement lorsque les valeurs ont réellement le même format et la même plage ;
- ne pas utiliser une table de valeurs comme substitut à une clé étrangère[^terme-cle-etrangere] ;
- documenter les routines de conversion particulières ;
- éviter les domaines génériques sans signification technique stable.

### 17.C.2 Éléments de données

- créer un élément par concept métier identifiable ;
- maintenir les quatre libellés ;
- rédiger une documentation utile pour les champs ambigus ;
- éviter de réutiliser un élément uniquement parce que sa longueur correspond.

### 17.C.3 Structures

- créer des structures dédiées aux interfaces plutôt que d’exposer systématiquement une table complète ;
- utiliser les includes pour les groupes de champs réellement communs ;
- limiter les structures profondes lorsque les consommateurs exigent des types plats.

### 17.C.4 Tables

- choisir une clé stable ;
- décider explicitement de la dépendance au mandant[^terme-mandant] ;
- choisir la classe[^terme-classe] de livraison selon le cycle de vie des données ;
- maintenir les références de devise et d’unité ;
- ne pas activer la bufferisation sans analyse ;
- créer un index seulement après démonstration du besoin.

### 17.C.5 Relations et aides

- maintenir les clés étrangères et cardinalités correctes ;
- utiliser des tables de texte pour les libellés traduits ;
- placer les aides F4[^terme-aide-f4] au niveau le plus réutilisable ;
- réserver les exits aux cas non couverts par la définition standard.

### 17.C.6 Extensions

- utiliser append ou customer include lorsque le mécanisme est prévu ;
- ne pas modifier directement un objet standard ;
- vérifier la catégorie d’amélioration ;
- tester les consommateurs après tout changement de structure.

## 17.D ANTI-PATTERNS

- domaine `CHAR50` réutilisé pour des concepts sans rapport ;
- élément de données[^terme-element-donnees] sans libellé ni documentation ;
- table indépendante du mandant créée par omission de `MANDT`[^terme-mandt] ;
- clé composée de champs modifiables ;
- bufferisation intégrale d’une table transactionnelle ;
- index secondaire[^terme-index-secondaire] créé sans mesure ;
- appel direct à SE14[^outil-se14] pour contourner une erreur d’activation ;
- ajout d’un champ standard par modification plutôt que par extension.

## 17.E CHECKLIST DE REVUE

- [ ] Le nom technique est-il dans l’espace client et compréhensible ?
- [ ] Le domaine correspond-il réellement au format et à la plage de valeurs ?
- [ ] L’élément de données exprime-t-il une sémantique unique ?
- [ ] Les libellés et la documentation sont-ils complets ?
- [ ] La structure est-elle plate ou profonde de manière intentionnelle ?
- [ ] La clé primaire[^terme-cle-primaire] est-elle stable et minimale ?
- [ ] La dépendance au mandant est-elle volontaire ?
- [ ] La classe de livraison correspond-elle au cycle de vie des données ?
- [ ] Les clés étrangères et cardinalités sont-elles correctes ?
- [ ] Les paramètres techniques sont-ils justifiés ?
- [ ] Les dépendances et impacts d’activation ont-ils été analysés ?
- [ ] L’objet standard est-il étendu sans modification directe ?

## 17.F POINTS À RETENIR

- La qualité du modèle DDIC conditionne le code, les contrôles et les interfaces classiques.
- La réutilisation doit être sémantique, pas uniquement technique.
- Les décisions sur clé, mandant, livraison et buffer doivent être explicites.
- Les extensions doivent utiliser les mécanismes prévus par SAP[^terme-acro-sap].
- Toute évolution DDIC exige une analyse des dépendances et de la base physique.

## 17.G PROCESS

### 17.G.1 Étape 1 — Reconstituer le modèle

Lister tables, clés, relations, domaines, éléments de données, structures et aides de recherche du périmètre. Associer chaque objet à sa signification métier et à son propriétaire.

### 17.G.2 Étape 2 — Rechercher les duplications sémantiques

Comparer les objets de même type et longueur. Déterminer s’ils représentent réellement la même donnée. Fusionner ou réutiliser uniquement lorsque format, valeurs autorisées, libellés et cycle de vie coïncident.

### 17.G.3 Étape 3 — Vérifier les clés et relations

Contrôler stabilité des clés, gestion du mandant, clés étrangères, tables de textes et références devise/unité. Pour chaque relation absente, décider si elle doit être portée par le DDIC ou par une validation applicative documentée.

### 17.G.4 Étape 4 — Vérifier les propriétés physiques

Examiner classes de livraison, paramètres techniques, bufferisation et index. Exiger une justification mesurée pour chaque index secondaire ou buffer actif.

### 17.G.5 Étape 5 — Contrôler l’évolutivité

Vérifier catégories d’amélioration, append existants, listes d’utilisation et interfaces exposées. Simuler l’ajout d’un champ ou d’une valeur afin d’identifier les consommateurs fragiles.

### 17.G.6 Étape 6 — Formaliser les corrections

Classer chaque anomalie par objet source, impact et ordre de correction. Activer du bas vers le haut et tester les consommateurs. La revue est terminée lorsque chaque objet possède une responsabilité claire et qu’aucune incohérence technique connue n’est laissée sans décision documentée.

## 17.H VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package[^terme-package] attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 17.I ERREURS FRÉQUENTES

- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

## 17.J FICHE DE CONTRÔLE À COPIER

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

## 17.K TERMES DU LEXIQUE

- [DDIC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>)
- [ABAP Dictionary](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## 17.L RÉFÉRENCES OFFICIELLES SAP

- [Exploring ABAP Dictionary — SAP Learning](https://learning.sap.com/courses/building-data-models-with-the-abap-dictionary-and-abap-core-data-services/exploring-abap-dictionary_af8fdedf-0a10-43ab-aa1b-20abbece9d8b)
- [Using Dictionary Objects as Data Types — SAP Learning](https://learning.sap.com/courses/building-data-models-with-the-abap-dictionary-and-abap-core-data-services/using-dictionary-objects-as-data-types_e28df7c3-7686-414e-9827-673dceeb21fb)
- [Creating Database Tables — SAP Learning](https://learning.sap.com/courses/building-data-models-with-the-abap-dictionary-and-abap-core-data-services/creating-database-tables_ebc1477d-96ed-414b-82d4-4171da43f4a6)
- [Append Structures — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/ec1c9c8191b74de98feb94001a95dd76/cf21eb61446011d189700000e8322d00.html)

[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-composition]: **COMPOSITION.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#composition>).
[^terme-cle-etrangere]: **CLÉ ÉTRANGÈRE.** Relation DDIC entre des champs d’une table et une table de contrôle. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#cle-etrangere>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-aide-f4]: **AIDE F4.** Aide à la saisie proposant des valeurs autorisées ou recherchables. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f4>).
[^terme-element-donnees]: **ÉLÉMENT DE DONNÉES.** Objet DDIC qui attribue une signification métier, des libellés et une documentation à un type élémentaire ou à un domaine. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>).
[^terme-mandt]: **MANDT.** Champ technique de type mandant, généralement placé en première position de clé dans les tables dépendantes du mandant. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>).
[^terme-index-secondaire]: **INDEX SECONDAIRE.** Structure de base de données supplémentaire accélérant certains accès au prix d’un coût de stockage et de maintenance. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#index-secondaire>).
[^terme-cle-primaire]: **CLÉ PRIMAIRE.** Ensemble minimal de champs identifiant de manière unique une ligne de table. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#cle-primaire>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).

[^outil-se14]: **SE14.** Utilitaire de base de données du Dictionary utilisé pour comparer ou ajuster la définition DDIC et l’objet physique. Voir [le chapitre associé](<16 ├── ACTIVATION AJUSTEMENT BASE ET ANALYSE DES DEPENDANCES.md>).
