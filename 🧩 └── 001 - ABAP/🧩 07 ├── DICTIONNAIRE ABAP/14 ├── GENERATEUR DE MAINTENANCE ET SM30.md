# 14. GÉNÉRATEUR DE MAINTENANCE ET SM30

## 14.A RÉSULTAT ATTENDU

- Générer un dialogue standard de maintenance
- Distinguer SE54 et SM30
- Choisir un écran en une ou deux étapes
- Configurer le groupe de fonctions et l’autorisation
- Identifier les limites d’un dialogue généré

## 14.B PRINCIPE

Le générateur de maintenance crée un programme standard permettant d’afficher, créer, modifier ou supprimer les entrées d’une table ou d’une vue de maintenance.

```mermaid
flowchart LR
    A["Table ou vue DDIC"] --> B["Générateur SE54"]
    B --> C["Dialogue de maintenance généré"]
    C --> D["Exécution avec SM30"]
```

## 14.C PRÉREQUIS

Avant la génération :

- la table ou la vue doit être active ;
- la maintenance doit être autorisée dans ses attributs ;
- la clé doit être correcte ;
- les relations et textes doivent être définis ;
- le besoin d’autorisation et de transport des données doit être clarifié.

## 14.D GÉNÉRATION

Le générateur est accessible :

- depuis `SE11` via les utilitaires ;
- directement avec `SE54`.

Les paramètres principaux sont :

| Paramètre                | Fonction                                               |
| ------------------------ | ------------------------------------------------------ |
| Groupe d’autorisations   | Regrouper les objets pour le contrôle d’accès          |
| Groupe de fonctions      | Contenir les écrans et modules générés                 |
| Type de maintenance      | Une étape ou deux étapes                               |
| Numéros d’écrans         | Identifier les dynpros générés                         |
| Routine d’enregistrement | Gérer le transport éventuel des données de paramétrage |

## 14.E UNE ÉTAPE OU DEUX ÉTAPES

| Mode        | Fonctionnement                          |
| ----------- | --------------------------------------- |
| Une étape   | Liste et modification sur un même écran |
| Deux étapes | Écran de synthèse puis écran de détail  |

Le mode une étape convient aux tables simples comportant peu de champs. Le mode deux étapes est plus adapté lorsque la ligne contient de nombreux champs ou nécessite un écran détaillé.

## 14.F PROCESS

Dans `SM30` :

### 14.F.1 Étape 1 — Ouvrir le bon objet de maintenance

Saisir la table ou la vue dans `SM30`, puis choisir **Afficher** avant **Gérer**. Vérifier le titre, les champs et le nombre d’entrées afin d’exclure une homonymie ou un mauvais mandant.

### 14.F.2 Étape 2 — Déterminer le mode de transport

Contrôler la classe de livraison, le paramétrage du générateur et la procédure du projet. Déterminer si les entrées sont transportées, saisies dans chaque système ou considérées comme données applicatives.

### 14.F.3 Étape 3 — Créer ou modifier une entrée

Choisir **Nouvelles entrées** ou sélectionner une ligne existante. Renseigner la clé en premier, puis les valeurs contrôlées. Ne modifier jamais la clé d’une ligne existante pour simuler une suppression/création sans vérifier les dépendances.

### 14.F.4 Étape 4 — Enregistrer et traiter la demande

Enregistrer. Si une demande Customizing est proposée, sélectionner l’ordre autorisé et contrôler son contenu dans `SE10`. Si aucune demande n’est proposée alors qu’elle est attendue, arrêter et vérifier le paramétrage avant de poursuivre.

### 14.F.5 Étape 5 — Relire et tester

Quitter puis rouvrir la vue avec les mêmes critères. Vérifier la ligne enregistrée et exécuter le processus consommateur. La maintenance est validée lorsque la valeur est persistée dans le bon mandant et rattachée au transport prévu.

## 14.G ÉVÉNEMENTS DU GÉNÉRATEUR

Le générateur propose des événements permettant d’ajouter des contrôles ou traitements spécifiques.

Exemples :

- contrôle avant sauvegarde ;
- initialisation de valeurs ;
- traitement après sauvegarde ;
- adaptation de l’affichage.

Ces extensions sont du code spécifique attaché à un objet généré. Elles doivent être documentées et testées après toute régénération.

## 14.H LIMITES

Un dialogue SM30 convient à la maintenance technique ou de paramétrage simple.

Il est insuffisant lorsque le processus exige :

- une logique métier complexe ;
- plusieurs étapes de validation ;
- des contrôles d’autorisation fins par ligne ;
- des pièces jointes ou traitements annexes ;
- une expérience utilisateur spécifique.

## 14.I POINTS À RETENIR

- SE54 génère ; SM30 exécute le dialogue de maintenance.
- Le choix une ou deux étapes dépend de la structure des données.
- Les autorisations et le transport des données doivent être conçus avant la génération.
- Les événements permettent des adaptations, mais augmentent la maintenance.
- SM30 ne remplace pas une application métier complexe.

## 14.J PROCESS

### 14.J.1 Étape 1 — Préparer la table ou la vue

Vérifier dans `SE11` qu’elle est active, possède une clé cohérente et autorise le type de maintenance voulu. Définir les clés étrangères et textes avant de générer les écrans.

### 14.J.2 Étape 2 — Générer le dialogue de maintenance

Ouvrir le générateur depuis `SE11`, renseigner groupe de fonctions, groupe d’autorisations, type une ou deux étapes et numéros d’écrans. Utiliser un groupe de fonctions client dédié ou explicitement partagé.

### 14.J.3 Étape 3 — Contrôler la génération

Générer puis lire tous les messages. Ouvrir le groupe de fonctions dans `SE80` et vérifier les écrans créés. Ne modifier le code généré directement que si la technique d’événements prévue ne couvre pas le besoin.

### 14.J.4 Étape 4 — Tester les autorisations et opérations

Tester affichage, création, modification et suppression avec les rôles représentatifs. Vérifier les contrôles de domaine, clés étrangères, doublons et transport.

La génération est validée lorsque `SM30` applique les règles de saisie et d’autorisation sans permettre une modification hors périmètre.

## 14.K VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 14.L ERREURS FRÉQUENTES

- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

## 14.M FICHE DE CONTRÔLE À COPIER

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

## 14.N TERMES DU LEXIQUE

- [ABAP Dictionary](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## 14.O RÉFÉRENCES OFFICIELLES SAP

- [Table Maintenance Generator — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525944.html)
- [Maintenance Views — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/ec1c9c8191b74de98feb94001a95dd76/cf21ecdf446011d189700000e8322d00.html)

---

[Chapitre suivant — STRUCTURES APPEND ET EXTENSIONS](<./15 ├── STRUCTURES APPEND ET EXTENSIONS.md>)
