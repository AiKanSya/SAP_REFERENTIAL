# 2. CRÉER UNE SERVICE DEFINITION ET UN SERVICE BINDING

## 2.A RÉSULTAT ATTENDU

Exposer une projection CDS par une service definition[^terme-service-definition] et un service binding[^terme-service-binding] OData V4 testable dans ADT.

Le résultat est atteint lorsque le binding actif est publié localement, que le preview s’ouvre et que `$metadata` contient uniquement les alias prévus.

## 2.B PRÉREQUIS

- Projet ABAP dans ADT.
- Modèle CDS et projection actifs.
- Behavior projection active pour un service transactionnel.
- Autorisations de création et de publication locale.

## 2.C CONTRAT AVANT CODE

| Décision | Valeur à fixer |
|---|---|
| Consommateur | Fiori elements ou client d’API |
| Binding | OData V4 UI ou Web API |
| Entités | Projections strictement nécessaires |
| Alias | Noms publics stables |
| Comportements | CRUD, actions et fonctions projetés |
| Autorisations | DCL et authorization control |

## 2.D SERVICE DEFINITION

```abap
@EndUserText.label: 'Sales Order API'
define service ZUI_SALES_ORDER {
  expose ZC_SalesOrder as SalesOrders;
  expose ZC_SalesOrderItem as SalesOrderItems;
}
```

Exemple de projection CDS minimale :

```abap
@EndUserText.label: 'Sales Order Service Projection'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_SalesOrder
  provider contract transactional_query
  as projection on ZI_SalesOrder
{
  key SalesOrder,
      CompanyCode,
      SalesOrganization,
      CreatedAt,
      LastChangedAt,
      Currency,
      NetAmount,
      _Items : redirected to composition child ZC_SalesOrderItem
}
```

`ZI_SalesOrder`, les annotations, l’association et les champs doivent correspondre au business object réel. La DCL associée doit être testée avec des utilisateurs non administrateurs.

## 2.E PROCESS

### 2.E.1 ÉTAPE 1 — CRÉER LA SERVICE DEFINITION

1. Créer la service definition dans le package transportable.
2. Exposer uniquement les projections appartenant au contrat.
3. Activer et corriger toutes les dépendances.

### 2.E.2 ÉTAPE 2 — CRÉER LE BINDING

4. Créer un service binding de type OData V4 UI ou Web API.
5. Affecter la service definition et activer le binding.

### 2.E.3 ÉTAPE 3 — PUBLIER LOCALEMENT

6. Publier l’endpoint local pour le test dans le système de développement.

### 2.E.4 ÉTAPE 4 — TESTER

7. Ouvrir le preview ou l’URL du service.
8. Contrôler metadata, lectures, autorisations et comportements transactionnels.

## 2.F POINTS À REMPLACER

| Exemple | Valeur cible |
|---|---|
| `ZUI_SALES_ORDER` | Nom de service client |
| `ZC_SalesOrder` | Projection CDS |
| `SalesOrders` | Alias public stable |

## 2.G CONTRÔLE POSITIF

1. Activer tous les artefacts sans erreur.
2. Publier le binding local.
3. Ouvrir `$metadata`.
4. Confirmer les alias `SalesOrders` et `SalesOrderItems`.
5. Exécuter une lecture bornée.
6. Pour un service transactionnel, tester une validation et une action exposée.

## 2.H CONTRÔLE NÉGATIF

- Retirer une action de la behavior projection dans une branche de test : elle ne doit plus être exposée après activation.
- Utiliser un utilisateur sans autorisation : la DCL ou l’authorization control doit limiter le résultat.
- Appeler un alias non exposé : le runtime doit le refuser.

## 2.I ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| Binding inactif | Dépendance inactive | Activer depuis la source vers le binding |
| Preview vide | Données, DCL ou annotations | Tester l’API puis les annotations |
| Action absente | Behavior projection incomplète | Projeter le comportement |
| Entité en trop | Service definition trop large | Retirer l’exposition |

## 2.J COMPATIBILITÉ S/4HANA

Le type de binding disponible dépend de la release. La publication depuis ADT est locale au système. Elle ne constitue pas automatiquement l’activation dans les systèmes transportés.

## 2.K RÉFÉRENCES OFFICIELLES SAP

- [Creating an OData V4 Service — SAP Learning](https://learning.sap.com/courses/getting-started-with-creating-an-sap-fiori-elements-app-based-on-an-odata-v4-rap-service/creating-an-odata-v4-service)
- [Understanding RAP — SAP Learning](https://learning.sap.com/courses/building-transactional-apps-with-the-abap-restful-application-programming-model/exploring-the-concept-and-architecture-of-rap)
- [Service Binding — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-rap/service-binding)

[^terme-service-definition]: **SERVICE DEFINITION.** Objet sélectionnant et nommant les projections CDS exposées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/06 └── RAP ET ODATA V4.md#service-definition>).
[^terme-service-binding]: **SERVICE BINDING.** Objet reliant une service definition à un protocole et un type de consommation. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/06 └── RAP ET ODATA V4.md#service-binding>).
