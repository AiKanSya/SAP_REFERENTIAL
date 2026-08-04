# SERVICES ODATA SAP SUR SAP GATEWAY ET ABAP

## PÉRIMÈTRE

Ce domaine couvre la conception, la création, l’activation, la maintenance, la sécurisation et le diagnostic des services OData V2 et V4 sur une plateforme ABAP.

Deux filières sont traitées séparément :

- **SAP Gateway OData V2 classique** : projet `SEGW`, classes `MPC_EXT` et `DPC_EXT`, enregistrement avec `/IWFND/MAINT_SERVICE` et diagnostic Gateway ;
- **OData V4 moderne avec RAP** : CDS, behavior definition, service definition et service binding dans ADT.

Un projet `SEGW` reste pertinent pour maintenir ou étendre un service du code-based OData Channel. Pour un nouveau service transactionnel compatible avec le modèle ABAP Cloud, utiliser RAP et un service binding OData V4 lorsque la plateforme et le besoin le permettent.

## PARCOURS

0. [Lexique OData et SAP Gateway](<🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY>)
1. [Fondations OData](<🧩 01 ├── FONDATIONS ODATA>)
2. [Architecture SAP Gateway](<🧩 02 ├── ARCHITECTURE SAP GATEWAY>)
3. [Développement OData V2 avec SEGW](<🧩 03 ├── ODATA V2 AVEC SEGW>)
4. [Activation et administration Gateway](<🧩 04 ├── ACTIVATION ET ADMINISTRATION GATEWAY>)
5. [Requêtes et consommation](<🧩 05 ├── REQUETES ET CONSOMMATION>)
6. [Diagnostic et maintenance](<🧩 06 ├── DIAGNOSTIC ET MAINTENANCE>)
7. [Sécurité et qualité](<🧩 07 ├── SECURITE ET QUALITE>)
8. [OData V4 avec RAP](<🧩 08 └── ODATA V4 AVEC RAP>)

## BASE DE COMPATIBILITÉ

- Toujours relever la version de `SAP_GWFND`, la version ABAP Platform et le type de déploiement avant d’appliquer une procédure.
- Les URI V2 utilisent normalement `/sap/opu/odata/sap/<SERVICE>/`.
- Les URI et mécanismes d’activation V4 dépendent du type d’implémentation : Gateway V4 classique ou service binding RAP.
- Une publication locale depuis ADT ne remplace pas l’activation requise dans les systèmes de qualification et de production.
- Les noms `Z...` sont des exemples et doivent être remplacés.

## OBJECTIF ÉDITORIAL

Chaque page doit permettre d’exécuter ou de diagnostiquer une action précise. Une page opérationnelle contient :

- un résultat observable ;
- les prérequis techniques et les autorisations ;
- une procédure exécutable dans l’ordre ;
- une URI, un payload ou un code minimal prêt à adapter ;
- les valeurs à remplacer ;
- un contrôle positif et un contrôle négatif ;
- les erreurs fréquentes et leur correction ;
- le statut V2, V4, classique ou recommandé ;
- une leçon SAP Learning et une référence SAP Help directement liées au sujet.

## CONVENTION DES TITRES

| Niveau | Numérotation | Usage |
|---|---|---|
| `#` | `1.` | Titre unique du fichier |
| `##` | `1.A` | Section principale |
| `###` | `1.A.1` | Étape ou sous-section |

Le numéro du titre reprend le préfixe du fichier. Les sections suivent l’ordre alphabétique sans rupture.

## CONVENTION DES NOTES DE BAS DE PAGE

- Un terme OData ou SAP Gateway reçoit une note à sa première occurrence utile dans chaque chapitre.
- La note donne une définition courte et pointe vers l’ancre stable du lexique.
- Les transactions, classes et identifiants propres à un exemple sont expliqués dans le texte ou le code.
- Les pages du lexique ne reçoivent pas de notes circulaires.
- Une notion ne reçoit qu’une note par chapitre.

## RÉFÉRENCES OFFICIELLES SAP

- [SAP Gateway Service Builder — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/cddd22512c312314e10000000a44176d.html)
- [SAP Gateway and OData — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/PRODUCT_ID/22bbe89ef68b4d0e98d05f0d56a7f6c8/24d9ac6065954bf7a61f2dc9040f7870.html)
- [Service Binding — ABAP RESTful Application Programming Model](https://help.sap.com/docs/abap-cloud/abap-rap/service-binding)
- [Building OData Services with SAP Gateway — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway)
- [Building Transactional Apps with RAP — SAP Learning](https://learning.sap.com/courses/building-transactional-apps-with-the-abap-restful-application-programming-model)
