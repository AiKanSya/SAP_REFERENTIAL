# 2. TRANSPORTER ET MAINTENIR UN SERVICE

## 2.A RÉSULTAT ATTENDU

Séparer les artefacts de développement, l’enregistrement Gateway et la configuration propre à chaque environnement.

## 2.B PRÉREQUIS

- Liste des objets du projet et de l’activation.
- Route DEV→QAS→PRD et mandants cibles connus.
- Responsables backend, Gateway et sécurité identifiés.
- Metadata de référence et cas de non-régression conservés.

## 2.C OBJETS À DISTINGUER

- Projet `SEGW` et classes générées.
- Extensions `MPC_EXT` et `DPC_EXT`.
- Enregistrement du service Gateway.
- Nœud ICF.
- Alias système et destination RFC.
- Rôles et autorisations.

## 2.D PROCESS

### 2.D.1 ÉTAPE 1 — INVENTORIER

1. Vérifier les packages et transports des artefacts backend.
2. Identifier les objets d’activation transportés selon la version de la plateforme.

### 2.D.2 ÉTAPE 2 — SÉPARER CODE ET CONFIGURATION

3. Ne pas transporter des destinations RFC ou identifiants comme s’ils étaient du code.

### 2.D.3 ÉTAPE 3 — CONTRÔLER APRÈS IMPORT

4. Après import, contrôler l’alias et l’activation dans le mandant cible.
5. Exécuter `$metadata`, une lecture, une mutation refusée et une mutation autorisée.
6. Conserver une preuve de version du metadata.

## 2.E MAINTENANCE D’UN PROJET SEGW

Avant une régénération SEGW, comparer les classes d’extension et le metadata. Après régénération, activer l’ensemble et exécuter les tests de non-régression. Ne vider les caches Gateway que lorsqu’un décalage de métadonnées est prouvé.

## 2.F CONTRÔLE

| Contrôle | DEV | QAS | PRD |
|---|---|---|---|
| Objets backend actifs | Obligatoire | Obligatoire | Obligatoire |
| Enregistrement cible | Vérifié | Vérifié | Vérifié |
| Metadata identique à la version livrée | Oui | Oui | Oui |
| Test négatif d’autorisation | Oui | Oui | Selon protocole validé |
| Secret dans transport | Aucun | Aucun | Aucun |

## 2.G ERREURS FRÉQUENTES

- Transporter le code sans l’activation nécessaire.
- Supposer que l’alias DEV convient aux autres environnements.
- Régénérer sans comparer le metadata.
- Vider globalement les caches après chaque import.
- Valider uniquement avec un compte administrateur.

## 2.H CRITÈRE DE SORTIE

Le service cible expose la version attendue, utilise le bon backend et passe les tests positifs et négatifs avec un utilisateur non administrateur.

## 2.I COMPATIBILITÉ S/4HANA

Les objets transportés et les actions post-import dépendent de la version, du mode embedded/hub et du type V2/V4. La checklist doit être ajustée au système cible.

## 2.J RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [SAP Gateway and OData — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/PRODUCT_ID/22bbe89ef68b4d0e98d05f0d56a7f6c8/24d9ac6065954bf7a61f2dc9040f7870.html)
