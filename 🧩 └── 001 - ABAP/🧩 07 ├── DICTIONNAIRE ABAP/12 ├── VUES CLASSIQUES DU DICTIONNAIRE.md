# VUES CLASSIQUES DU DICTIONNAIRE

## RÉSULTAT ATTENDU

- Identifier les types de vues classiques de SE11
- Comprendre leur mode d’implémentation
- Choisir une vue selon le besoin
- Reconnaître les contraintes de jointure
- Situer les vues classiques par rapport aux développements modernes

## TYPES DE VUES

Le Dictionary classique propose plusieurs catégories de vues.

| Type                   | Usage                                                                                   | Objet correspondant en base |
| ---------------------- | --------------------------------------------------------------------------------------- | --------------------------: |
| Vue de base de données | Lire une projection ou une jointure interne                                             |                         Oui |
| Vue de projection      | Masquer certains champs d’une table                                                     |                         Non |
| Vue de maintenance     | Maintenir conjointement des données reliées                                             |                         Non |
| Vue d’aide             | Fournir une source pour une aide à la recherche, avec possibilités de jointure adaptées |                         Non |

## VUE DE BASE DE DONNÉES

Une vue de base de données est représentée par une vue correspondante dans la base.

Elle combine les tables avec des conditions de jointure de type interne et expose une sélection de champs.

```mermaid
flowchart LR
    A["Table A"] --> C["Vue de base de données"]
    B["Table B"] --> C
    C --> D["Objet de vue dans la base"]
```

Elle est principalement utilisée pour la lecture.

## VUE DE PROJECTION

Une vue de projection présente uniquement certains champs d’une table unique.

Elle ne possède pas d’objet de vue propre dans la base. Elle sert à limiter l’exposition d’une structure de table dans les usages classiques.

## VUE DE MAINTENANCE

Une vue de maintenance permet de générer un dialogue de maintenance commun à plusieurs tables reliées par des clés étrangères.

Elle est utilisée avec le générateur de maintenance et la transaction `SM30`.

Les relations entre tables doivent être correctement modélisées dans le Dictionary.

## VUE D’AIDE

Une vue d’aide sert principalement de méthode de sélection pour une aide à la recherche.

Elle permet de réunir des données de plusieurs tables en tenant compte des relations DDIC et des besoins de recherche.

## CHOIX DU TYPE

```mermaid
flowchart TD
    A["Besoin"] --> B["Objectif principal"]
    B -->|"Lecture en base"| C["Vue de base de données"]
    B -->|"Sous-ensemble d’une table"| D["Vue de projection"]
    B -->|"Maintenance SM30"| E["Vue de maintenance"]
    B -->|"Source F4"| F["Vue d’aide"]
```

## POSITIONNEMENT ACTUEL

Les vues classiques restent présentes dans de nombreux systèmes et sont nécessaires pour maintenir des applications SAP GUI existantes, des aides à la recherche et des dialogues de maintenance.

Pour de nouveaux modèles de lecture, SAP privilégie les vues CDS. Leur conception nécessite un traitement distinct dans le futur dossier consacré à ADT.

## POINTS À RETENIR

- Les quatre types de vues classiques répondent à des usages différents.
- Seule la vue de base de données crée une vue correspondante dans la base.
- Les vues de maintenance et d’aide s’appuient sur les relations DDIC.
- Une vue de projection ne porte que sur une table.
- Les vues CDS ne sont pas traitées dans ce dossier SAP GUI.

## PROCESS

### Étape 1 — Choisir le type de vue classique

Définir le besoin : jointure de lecture, projection, aide de recherche ou maintenance. Vérifier qu’une vue CDS n’appartient pas au périmètre prévu du projet ; ce chapitre traite uniquement les vues classiques `SE11`.

### Étape 2 — Définir les sources et jointures

1. Ouvrir `SE11`, choisir **Vue** et créer un objet client.
2. Sélectionner le type de vue adapté.
3. Ajouter les tables sources.
4. Définir chaque condition de jointure sur des champs de types compatibles.

Pour une vue dépendante du mandant, contrôler la gestion de `MANDT` et éviter une jointure qui combine des clients différents.

### Étape 3 — Sélectionner les champs

Ajouter uniquement les champs nécessaires au consommateur. Conserver des noms non ambigus et vérifier les références de devise ou d’unité pour les montants et quantités.

### Étape 4 — Définir les conditions de sélection autorisées

Ajouter les conditions fixes réellement inhérentes à la vue. Ne pas figer un filtre dépendant d’un utilisateur ou d’un scénario ponctuel ; ce filtre appartient au programme consommateur.

### Étape 5 — Activer et comparer

Activer, tester le contenu dans `SE11`, puis exécuter une requête ABAP SQL avec des critères précis. Comparer les lignes avec une jointure directe de référence. La vue est validée lorsque jointures, mandant, cardinalité observée et champs retournés correspondent au modèle attendu.

## VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## ERREURS FRÉQUENTES

- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

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

- [ABAP Dictionary](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## RÉFÉRENCES OFFICIELLES SAP

- [Views — ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/ec1c9c8191b74de98feb94001a95dd76/cf21ec5d446011d189700000e8322d00.html?version=7.40.30)
- [Maintenance Views — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/ec1c9c8191b74de98feb94001a95dd76/cf21ecdf446011d189700000e8322d00.html)

---

[Chapitre suivant — OBJETS DE VERROUILLAGE](<./13 ├── OBJETS DE VERROUILLAGE.md>)
