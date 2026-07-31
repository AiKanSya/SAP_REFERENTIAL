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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Lock Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/ec1c9c8191b74de98feb94001a95dd76/cf21eea5446011d189700000e8322d00.html)
- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)

---

➡️ [Chapitre suivant — MODES DE VERROUILLAGE S E X ET O](<./08 - 🍧 MODES DE VERROUILLAGE S E X ET O.md>)
