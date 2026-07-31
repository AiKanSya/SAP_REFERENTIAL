# 🌸 CRÉER UN OBJET DE VERROUILLAGE AVEC `SE11`

## 🌺 OBJECTIFS

- Définir un objet de verrouillage dans le Dictionary
- Choisir la table primaire et les champs de clé
- Identifier les modules fonction générés

## 🌺 CRÉATION

Dans `SE11` :

1. sélectionner **Objet de verrouillage** ;
2. utiliser un nom client, généralement `EZ...` ou `EY...` ;
3. définir la table primaire, par exemple `ZDEV_ORDER` ;
4. ajouter les éventuelles tables secondaires liées par clé étrangère ;
5. sélectionner les champs composant la clé de verrouillage ;
6. définir le mode par défaut ;
7. activer l’objet.

L’activation de `EZDEV_ORDER` génère notamment :

- `ENQUEUE_EZDEV_ORDER` ;
- `DEQUEUE_EZDEV_ORDER`.

## 🌺 GRANULARITÉ

| Clé transmise                            | Portée possible                                   |
| ---------------------------------------- | ------------------------------------------------- |
| Identifiant complet                      | Une commande                                      |
| Partie de la clé                         | Ensemble de commandes partageant cette partie     |
| Clé initiale avec indicateurs génériques | Ensemble plus large, selon les paramètres générés |

Un verrou trop large réduit la concurrence. Un verrou trop fin ne protège pas toutes les données cohérentes ensemble.

## 🌺 CONTRÔLES

- objet transporté avec son package ;
- relation entre tables correcte ;
- clé compatible avec le découpage métier ;
- modules générés activés ;
- scénario de collision testé avec deux sessions.

## 🌺 CAS D’USAGE

Dans un contexte où plusieurs modifications liées doivent être validées ensemble et protégées contre les accès concurrents, le besoin consiste à **afficher ou maintenir un objet du Dictionary en contrôlant ses dépendances**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE11`.
2. Choisir le type d’objet DDIC correspondant au chapitre.
3. Entrer le nom technique ; utiliser **Afficher** pour un objet existant ou **Créer** pour un objet Z autorisé.
4. Renseigner les attributs et composants en suivant les règles du chapitre.
5. Lancer le contrôle de cohérence.
6. Activer l’objet et traiter chaque message avant de poursuivre.
7. Utiliser la liste d’utilisation et, pour les tables, vérifier les paramètres techniques et la structure physique.

## 🌺 VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 🌺 ERREURS FRÉQUENTES

- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

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

- [SAP LUW](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **afficher ou maintenir un objet du Dictionary en contrôlant ses dépendances**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Lock Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/ec1c9c8191b74de98feb94001a95dd76/cf21eea5446011d189700000e8322d00.html)
- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)


---

➡️ [Chapitre suivant — MODES DE VERROUILLAGE `S`, `E`, `X` ET `O`](<./08 - 🍧 MODES DE VERROUILLAGE S E X ET O.md>)
