# 1. CRÉER UN PROJET SEGW

## 1.A RÉSULTAT ATTENDU

Créer un projet Service Builder dans SEGW[^terme-segw] et obtenir ses runtime artifacts[^terme-runtime-artifact].

Le contrôle est réussi lorsque le projet contient les quatre branches `Data Model`, `Service Implementation`, `Runtime Artifacts` et `Service Maintenance`, et que les classes MPC/DPC de base et d’extension sont actives.

## 1.B PRÉREQUIS

- Composant `SAP_GWFND` compatible.
- Package et ordre de transport.
- Modèle de données et contrat fonctionnel validés.
- Convention de nommage client.

## 1.C PHASES DU PROJET

SAP Learning distingue quatre phases prises en charge par `SEGW` :

1. **Service Definition** : création du projet qui regroupe les artefacts.
2. **Data Model Definition** : entity types, entity sets, associations et opérations.
3. **Service Implementation** : implémentation ou mapping des opérations.
4. **Service Maintenance** : enregistrement et activation dans le système Gateway.

Les phases sont liées mais ne sont pas strictement séquentielles. Une modification du modèle impose de régénérer puis de retester le contrat.

## 1.D SOURCES DE MODÈLE

| Source | Usage | Contrôle |
|---|---|---|
| Création manuelle | Contrat conçu sans structure existante | Types et clés saisis explicitement |
| Structure DDIC | Réutilisation d’un type ABAP | Ne pas exposer automatiquement tous les champs |
| RFC/BOR | Génération et mapping classiques | Lire effets transactionnels et exceptions |
| Fichier EDMX/XML | Contrat externe existant | Valider version et cohérence |
| Search Help | Scénario d’aide à la saisie | Contrôler volume et autorisations |

## 1.E PROCESS

### 1.E.1 ÉTAPE 1 — DÉFINIR LE CONTRAT

Lister les ressources, clés, propriétés, navigations, opérations et droits. Définir un cas positif et un cas négatif avant la création.

### 1.E.2 ÉTAPE 2 — CRÉER LE PROJET

1. Ouvrir `SEGW` dans le système d’implémentation.
2. Créer le projet `Z...`, saisir description, package et transport.

### 1.E.3 ÉTAPE 3 — DÉFINIR LE MODÈLE

3. Construire le modèle manuellement ou importer une source prise en charge.
4. Définir les entity types, clés, propriétés et entity sets.
5. Créer les associations uniquement lorsqu’une navigation doit appartenir au contrat.

### 1.E.4 ÉTAPE 4 — CONTRÔLER ET GÉNÉRER

6. Exécuter le contrôle de cohérence.
7. Générer les runtime artifacts dans le package approprié.
8. Vérifier la création des classes MPC, MPC_EXT, DPC et DPC_EXT.

### 1.E.5 ÉTAPE 5 — ACTIVER

Activer les classes et le projet. Ouvrir chaque artefact depuis la branche `Runtime Artifacts` pour confirmer son nom et son package.

## 1.F ARTEFACTS ATTENDUS

| Artefact | Rôle |
|---|---|
| `ZCL_<PROJET>_MPC` | Modèle généré |
| `ZCL_<PROJET>_MPC_EXT` | Extension persistante du modèle |
| `ZCL_<PROJET>_DPC` | Data provider généré |
| `ZCL_<PROJET>_DPC_EXT` | Implémentation client persistante |
| `<PROJET>_MDL` | Modèle technique enregistré |
| `<PROJET>_SRV` | Service technique enregistré |

Les noms exacts sont ceux affichés dans `Runtime Artifacts` ; ne pas les déduire lorsque le projet existant utilise une convention différente.

## 1.G RÈGLE DE MAINTENANCE

Ne pas placer les redéfinitions client dans les classes générées MPC ou DPC. Utiliser `MPC_EXT` et `DPC_EXT`, car une nouvelle génération peut remplacer le contenu des classes de base.

## 1.H POINTS À REMPLACER

| Exemple | Valeur attendue |
|---|---|
| `Z...` | Nom de projet client |
| Package | Package transportable du domaine |
| Structure DDIC | Structure d’interface, pas table brute par défaut |
| Transport | Demande appartenant au même lot fonctionnel |

## 1.I CONTRÔLE

- Le projet est cohérent.
- Les quatre classes attendues existent et sont actives.
- Tous les objets appartiennent au bon package et au bon transport.
- Le service technique généré est identifiable avant l’activation.

Contrôle négatif : créer une propriété de test non clé dans un environnement isolé, exécuter le consistency check puis annuler la modification. Le contrôle doit signaler toute incohérence introduite sans altérer le projet partagé.

## 1.J ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| Classe EXT absente | Génération incomplète | Revoir les runtime settings puis régénérer |
| Modifications perdues | Code placé dans la classe de base | Déplacer la logique dans EXT |
| Objets locaux | Package `$TMP` | Recréer ou réaffecter selon la gouvernance |
| Metadata incohérent | Projet non régénéré ou non actif | Check, generate, activate, puis cache ciblé |

## 1.K COMPATIBILITÉ S/4HANA

`SEGW` appartient au code-based OData Channel et reste adapté à la maintenance des services Gateway. SAP Learning indique qu’il nécessite plus `IW_BEP` séparé dans un AS ABAP 7.40 ou supérieur avec `SAP_GWFND`. Pour un nouveau service RAP, utiliser ADT, CDS et service binding.

## 1.L RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Getting Started with the Service Builder — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_1909/68bf513362174d54b58cddec28794093/36742c510e87fa50e10000000a441470.html)

[^terme-segw]: **SEGW.** SAP Gateway Service Builder utilisé pour créer et maintenir les projets OData classiques. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#segw>).
[^terme-runtime-artifact]: **RUNTIME ARTIFACT.** Objet généré par SEGW pour exécuter ou enregistrer le service. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#runtime-artifact>).
