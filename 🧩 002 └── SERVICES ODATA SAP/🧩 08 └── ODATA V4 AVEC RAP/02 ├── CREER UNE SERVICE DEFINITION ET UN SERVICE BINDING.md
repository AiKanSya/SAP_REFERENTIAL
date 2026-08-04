# 2. CRÉER UNE SERVICE DEFINITION ET UN SERVICE BINDING

## 2.A RÉSULTAT ATTENDU

Exposer une projection CDS par un endpoint OData V4 local testable dans ADT.

## 2.B PRÉREQUIS

- Projet ABAP dans ADT.
- Modèle CDS et projection actifs.
- Behavior projection active pour un service transactionnel.
- Autorisations de création et de publication locale.

## 2.C SERVICE DEFINITION

```abap
@EndUserText.label: 'Sales Order API'
define service ZUI_SALES_ORDER {
  expose ZC_SalesOrder as SalesOrders;
  expose ZC_SalesOrderItem as SalesOrderItems;
}
```

## 2.D PROCESS

1. Créer la service definition dans le package transportable.
2. Exposer uniquement les projections appartenant au contrat.
3. Activer et corriger toutes les dépendances.
4. Créer un service binding de type OData V4 UI ou Web API.
5. Affecter la service definition et activer le binding.
6. Publier l’endpoint local pour le test dans le système de développement.
7. Ouvrir le preview ou l’URL du service.
8. Contrôler metadata, lectures, autorisations et comportements transactionnels.

## 2.E POINTS À REMPLACER

| Exemple | Valeur cible |
|---|---|
| `ZUI_SALES_ORDER` | Nom de service client |
| `ZC_SalesOrder` | Projection CDS |
| `SalesOrders` | Alias public stable |

## 2.F RÉFÉRENCE OFFICIELLE SAP

- [Service Binding — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-rap/service-binding)
