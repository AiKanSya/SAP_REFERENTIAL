# 7. CRÉER UN OBJET DE VERROUILLAGE AVEC `SE11`

## 7.A RÉSULTAT ATTENDU

- Définir un objet de verrouillage dans le Dictionary
- Choisir la table primaire et les champs de clé
- Identifier les modules fonction générés

## 7.B CRÉATION

Dans `SE11`[^outil-se11] :

1. sélectionner **Objet de verrouillage** ;
2. utiliser un nom client, généralement `EZ...` ou `EY...` ;
3. définir la table primaire, par exemple `ZDEV_ORDER` ;
4. ajouter les éventuelles tables secondaires liées par clé étrangère[^terme-cle-etrangere] ;
5. sélectionner les champs composant la clé de verrouillage ;
6. définir le mode par défaut ;
7. activer l’objet.

L’activation de `EZDEV_ORDER` génère notamment :

- `ENQUEUE_EZDEV_ORDER` ;
- `DEQUEUE_EZDEV_ORDER`.

## 7.C GRANULARITÉ

| Clé transmise                            | Portée possible                                   |
| ---------------------------------------- | ------------------------------------------------- |
| Identifiant complet                      | Une commande                                      |
| Partie de la clé                         | Ensemble de commandes partageant cette partie     |
| Clé initiale avec indicateurs génériques | Ensemble plus large, selon les paramètres générés |

Un verrou trop large réduit la concurrence. Un verrou trop fin ne protège pas toutes les données cohérentes ensemble.

## 7.D CONTRÔLES

- objet transporté avec son package[^terme-package] ;
- relation entre tables correcte ;
- clé compatible avec le découpage métier ;
- modules générés activés ;
- scénario de collision testé avec deux sessions.

## 7.E PROCESS

### 7.E.1 ÉTAPE 1 — DÉFINIR LA RESSOURCE ET LA CLÉ

Identifier la table racine et les champs représentant l’unité métier à protéger. Inclure le mandant[^terme-mandant] lorsque la table est dépendante du mandant. Vérifier que la clé choisie bloque toutes les écritures incompatibles sans immobiliser des documents indépendants.

### 7.E.2 ÉTAPE 2 — CRÉER L’OBJET DANS `SE11`

Saisir `/nSE11`, sélectionner **Objet de verrouillage**, entrer un nom Z respectant la convention du projet, puis choisir **Créer**. Renseigner une description et affecter le package et la demande de transport attendus.

### 7.E.3 ÉTAPE 3 — AJOUTER LES TABLES

Définir la table primaire. Ajouter les tables secondaires uniquement si le même verrou doit couvrir leurs données et si leurs relations de clé sont explicites. Contrôler les relations proposées par le DDIC[^terme-acro-ddic] ; une association incorrecte produit un argument de verrou inadéquat.

### 7.E.4 ÉTAPE 4 — CHOISIR LE MODE ET LES PARAMÈTRES

Définir le mode de verrouillage correspondant aux accès concurrents autorisés. Dans l’onglet des paramètres, conserver uniquement les champs nécessaires à la granularité métier. Examiner l’effet d’une valeur initiale, qui peut élargir le périmètre verrouillé.

### 7.E.5 ÉTAPE 5 — GÉNÉRER LES MODULES FONCTION

Contrôler puis activer l’objet. Vérifier dans `SE37`[^outil-se37] la génération des modules `ENQUEUE_<objet>` et `DEQUEUE_<objet>`. Relever leurs paramètres de clé, de mode, `_SCOPE`, `_WAIT` et les exceptions réellement disponibles.

### 7.E.6 ÉTAPE 6 — TESTER AVEC DEUX SESSIONS

Créer un report Z non destructif appelant l’enqueue et maintenant temporairement le verrou. Depuis une seconde session, tester la même clé puis une clé différente. Contrôler `foreign_lock`, l’entrée visible dans `SM12`[^outil-sm12] et la libération après dequeue, commit ou rollback selon le scénario.

## 7.F VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 7.G ERREURS FRÉQUENTES

- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 7.H FICHE DE CONTRÔLE À COPIER

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

## 7.I TERMES DU LEXIQUE

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 7.J RÉFÉRENCES OFFICIELLES SAP

- [Lock Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/ec1c9c8191b74de98feb94001a95dd76/cf21eea5446011d189700000e8322d00.html)
- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)

---

[Chapitre suivant — MODES DE VERROUILLAGE `S`, `E`, `X` ET `O`](<./08 ├── MODES DE VERROUILLAGE S E X ET O.md>)

[^terme-cle-etrangere]: **CLÉ ÉTRANGÈRE.** Relation DDIC entre des champs d’une table et une table de contrôle. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#cle-etrangere>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se11]: **SE11.** Transaction de l’ABAP Dictionary utilisée pour analyser et maintenir les objets DDIC. Voir [le chapitre associé](<../🧩 07 ├── DICTIONNAIRE ABAP/02 ├── NAVIGATION ET ANALYSE AVEC SE11.md>).
[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
[^outil-sm12]: **SM12.** Transaction de surveillance et d’administration des entrées de verrouillage SAP. Voir [le chapitre associé](<12 ├── ANALYSER LES VERROUS AVEC SM12.md>).
