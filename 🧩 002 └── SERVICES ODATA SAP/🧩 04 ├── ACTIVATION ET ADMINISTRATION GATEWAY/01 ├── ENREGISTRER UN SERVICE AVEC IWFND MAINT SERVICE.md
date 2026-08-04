# 1. ENREGISTRER UN SERVICE AVEC /IWFND/MAINT_SERVICE

## 1.A RÉSULTAT ATTENDU

Rendre un service OData V2 généré accessible dans le système Gateway cible.

Le résultat est atteint lorsque le service apparaît dans le Service Catalog du mandant cible, pointe vers le bon alias et retourne son metadata.

## 1.B PRÉREQUIS

- Artefacts actifs dans le backend.
- Alias système correct.
- Autorisation d’administration Gateway.
- Package et transport pour les objets d’activation.

## 1.C OBJETS À RELEVER

| Objet | Origine |
|---|---|
| Technical Service Name | `Runtime Artifacts` dans SEGW |
| Service Version | Projet généré |
| System Alias | Architecture Gateway du paysage |
| Package | Gouvernance des transports frontend |
| ICF Node | Enregistrement du service |

Ne pas confondre le nom du projet, le nom du modèle, le nom technique du service et le nom externe affiché dans le catalogue.

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — CONFIRMER LE BACKEND

Dans SEGW, activer le projet et relever le service technique. Dans un hub, confirmer que l’alias conduit au système portant les classes DPC/MPC.

### 1.D.2 ÉTAPE 2 — RECHERCHER LE SERVICE

1. Ouvrir `/IWFND/MAINT_SERVICE` dans le système Gateway.
2. Choisir **Add Service**.
3. Saisir l’alias puis rechercher le nom technique exact.
4. Sélectionner la version attendue.

Une recherche vide impose de contrôler alias, RFC, génération et mandant avant toute autre action.

### 1.D.3 ÉTAPE 3 — AJOUTER

5. Ajouter le service dans un package transportable ; réserver `$TMP` aux essais jetables.
6. Contrôler la création de l’enregistrement et du nœud ICF.

### 1.D.4 ÉTAPE 4 — TESTER

7. Tester `$metadata` depuis le bouton SAP Gateway Client.

## 1.E URI PRÊTE À ADAPTER

```http
GET /sap/opu/odata/sap/ZSALES_SRV/$metadata
```

Le résultat attendu est `200`. Un `404` oriente vers le chemin, l’activation ou l’enregistrement. Un `500` exige l’analyse des error logs.

## 1.F POINTS À REMPLACER

| Exemple | Valeur cible |
|---|---|
| `ZSALES_SRV` | Nom technique et version enregistrés |
| Alias | Alias propre à l’environnement |
| Package | Package frontend transportable |
| Mandant | Mandant consommé par l’application |

## 1.G CONTRÔLE

1. Ouvrir le Service Catalog et retrouver le service.
2. Vérifier alias, package et ICF.
3. Exécuter `$metadata` avec un utilisateur autorisé.
4. Exécuter une lecture limitée.
5. Tester un utilisateur sans droit métier : l’activation ne doit pas contourner l’autorisation applicative.

## 1.H ERREURS FRÉQUENTES

- Utiliser l’alias incorrect dans une architecture hub.
- Enregistrer le service dans le mauvais mandant.
- Réenregistrer sans analyser le journal d’erreurs.
- Laisser une activation productive dans `$TMP`.

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun service trouvé | Alias, backend ou génération | Vérifier dans cet ordre |
| `404` | Enregistrement ou ICF | Contrôler catalogue et nœud |
| Metadata d’un ancien modèle | Cache ou mauvaise version | Comparer version, puis invalider ciblé |
| Service actif dans DEV seulement | Activation non traitée dans la cible | Exécuter la procédure post-import |

## 1.I COMPATIBILITÉ S/4HANA

`/IWFND/MAINT_SERVICE` maintient les services OData V2 enregistrés. Le processus des service bindings RAP et de Gateway V4 diffère. Toujours choisir la procédure correspondant au type de service.

## 1.J RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Configuring SAP Gateway — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-i-of-sap-s-4hana-and-sap-business-suite/configuring-sap-gateway)
- [Activate OData Service in the SAP Gateway Hub — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/PRODUCT_ID/cc0c305d2fab47bd808adcad3ca7ee9d/1b023c1cad774eeb8b85b25c86d94f87.html)
