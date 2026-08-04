# 1. DISTINGUER DÉPLOIEMENT EMBEDDED ET HUB

## 1.A RÉSULTAT ATTENDU

Localiser le traitement frontend et backend d’une requête OData avant le diagnostic.

Le résultat est observable lorsque le système Gateway, le système d’implémentation, l’alias et la destination RFC éventuelle sont identifiés.

## 1.B PRÉREQUIS

- Accès aux informations système et à `/IWFND/MAINT_SERVICE`.
- Nom technique du service et mandant d’appel.
- Accès en lecture à la configuration des alias et destinations.

## 1.C ARCHITECTURES

| Architecture | Service Gateway | Logique métier | Conséquence |
|---|---|---|---|
| Embedded | Système backend | Même système | Diagnostic local |
| Hub | Système Gateway distinct | Backend distant | Alias et RFC à contrôler |

Dans un déploiement hub, `/IWFND/ERROR_LOG` analyse le frontend Gateway et `/IWBEP/ERROR_LOG` le backend. Dans un déploiement embedded, les deux couches restent logiquement distinctes même si elles partagent le système.

## 1.D CRITÈRES DE CHOIX

SAP Learning présente le déploiement embedded comme le scénario simplifiant le traitement et évitant un saut RFC. Un hub centralise certaines fonctions Gateway mais ajoute l’alias, la destination, le routage et la corrélation entre journaux. Le choix réel dépend de l’architecture existante, des versions et des exigences d’exploitation ; il ne doit pas être déduit de l’URL seule.

## 1.E PROCESS

### 1.E.1 ÉTAPE 1 — IDENTIFIER LE POINT D’ENTRÉE

Relever le SID, le mandant et l’hôte qui reçoivent la requête HTTP.

### 1.E.2 ÉTAPE 2 — LIRE L’ENREGISTREMENT

1. Ouvrir `/IWFND/MAINT_SERVICE` dans le système appelé.
2. Rechercher le service technique.
3. Relever l’alias système et l’ICF node.

### 1.E.3 ÉTAPE 3 — CLASSER L’ALIAS

4. Déterminer si l’alias est local ou distant.

### 1.E.4 ÉTAPE 4 — SUIVRE LE ROUTAGE DISTANT

5. Pour un alias distant, vérifier la destination RFC et le backend d’implémentation.

### 1.E.5 ÉTAPE 5 — LOCALISER LE CODE

6. Ouvrir le projet ou les classes dans le système qui porte réellement l’implémentation.

## 1.F CONTRÔLE

- Embedded : l’appel `$metadata` et le code d’implémentation sont corrélés dans le même système.
- Hub : l’enregistrement frontend conduit par alias et RFC au backend attendu.
- Une erreur reproduite peut être retrouvée dans le journal frontend puis, si nécessaire, backend.

## 1.G ERREURS FRÉQUENTES

- Déboguer la classe DPC dans le hub alors qu’elle se trouve dans le backend.
- Réenregistrer un service pour corriger un défaut RFC.
- Confondre l’URL publique, le système Gateway et le système métier.

## 1.H COMPATIBILITÉ S/4HANA

Les déploiements embedded et hub existent dans les paysages SAP Gateway. La composition exacte des composants et les options disponibles varient avec la version. SAP Learning indique que `SAP_GWFND` est inclus dans AS ABAP à partir de 7.40.

## 1.I RÉFÉRENCES OFFICIELLES SAP

- [Describing SAP Gateway Deployment Options — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/describing-sap-gateway-deployment-options)
- [SAP Gateway and OData — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/PRODUCT_ID/22bbe89ef68b4d0e98d05f0d56a7f6c8/24d9ac6065954bf7a61f2dc9040f7870.html)
