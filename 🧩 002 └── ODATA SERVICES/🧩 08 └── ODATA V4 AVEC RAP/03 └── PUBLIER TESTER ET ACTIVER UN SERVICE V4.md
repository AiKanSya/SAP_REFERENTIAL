# 3. PUBLIER, TESTER ET ACTIVER UN SERVICE V4

## 3.A RÉSULTAT ATTENDU

Distinguer publication locale du service binding[^terme-service-binding] et activation du service dans les systèmes cibles.

## 3.B PRÉREQUIS

- Service definition et binding actifs.
- Droits de publication locale dans DEV.
- Procédure d’activation cible correspondant à la release.
- Tests de contrat, autorisation et comportement.

## 3.C PUBLICATION LOCALE

Dans l’éditeur du service binding actif, **Publish** crée un endpoint local permettant de tester le service. Le preview valide rapidement le metadata et les annotations UI ; il ne remplace ni les tests d’API ni les tests d’autorisation.

Pour un binding OData V4, SAP Help indique que la publication locale porte sur le binding complet. La publication permet la consommation dans le système courant ; elle n’est pas un objet d’activation transporté automatiquement vers chaque cible on-premise.

## 3.D PROCESS

### 3.D.1 ÉTAPE 1 — ACTIVER

1. Activer la service definition et le binding.

### 3.D.2 ÉTAPE 2 — PUBLIER EN DEV

2. Publier localement dans le système de développement.

### 3.D.3 ÉTAPE 3 — TESTER LE CONTRAT

3. Tester `$metadata` et les entity sets.
4. Tester les actions, validations, déterminations et verrouillages du business object.
5. Tester avec un utilisateur sans droits de développement.
6. Exécuter ABAP Unit et ATC sur les artefacts RAP.

### 3.D.4 ÉTAPE 4 — TRANSPORTER

7. Transporter les objets de conception.

### 3.D.5 ÉTAPE 5 — ACTIVER DANS LA CIBLE

8. Dans chaque système cible, appliquer la procédure d’activation Gateway correspondant au type de binding et à la version de la plateforme.

## 3.E MATRICE DE TEST

| Test | Preuve |
|---|---|
| Metadata | Entités, alias, actions et types attendus |
| Lecture | DCL et pagination correctes |
| Création | Validations et déterminations exécutées |
| Mise à jour | ETag[^terme-etag]/verrouillage selon le behavior |
| Action | Autorisation et message fonctionnel |
| Utilisateur refusé | Aucune donnée ou action contournée |
| ATC/Unit | Aucun défaut bloquant ouvert |

## 3.F CONTRÔLE NÉGATIF

- Binding inactif : publication impossible ou endpoint invalide.
- Service non activé dans la cible : l’existence du binding transporté ne suffit pas.
- DCL ou autorisation refusée : aucune donnée ne doit être exposée par contournement.
- Modification concurrente : le comportement RAP doit retourner l’erreur prévue.

## 3.G ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| Fonctionne en DEV seulement | Endpoint non activé dans la cible | Exécuter l’activation cible |
| Preview correct, API incorrecte | Preview insuffisant | Tester les requêtes HTTP réelles |
| Modification rejetée | ETag, verrouillage ou validation | Lire la réponse et le behavior |
| Données absentes | DCL ou autorisation | Tester avec utilisateurs contrôlés |

## 3.H COMPATIBILITÉ S/4HANA

La granularité de publication diffère entre bindings V2 et V4. Pour V4, la publication locale porte sur le service binding. Toujours vérifier la documentation de la version ABAP Platform cible.

## 3.I RÉFÉRENCES OFFICIELLES SAP

- [Creating an OData V4 Service — SAP Learning](https://learning.sap.com/courses/getting-started-with-creating-an-sap-fiori-elements-app-based-on-an-odata-v4-rap-service/creating-an-odata-v4-service)
- [Service Binding — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-rap/service-binding)
- [Working with OData V4 Service — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-development-tools-for-visual-studio-code/working-with-odata-v4-service-a449458b1816492eb972ae5728ca2a28)

[^terme-service-binding]: **SERVICE BINDING.** Objet reliant une service definition à OData V4 UI ou Web API. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/06 └── RAP ET ODATA V4.md#service-binding>).
[^terme-etag]: **ETAG.** Valeur de version HTTP permettant de contrôler certaines modifications concurrentes. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#etag>).
