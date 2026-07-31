# 🌸 MISES À JOUR `V1` ET `V2`

## 🌺 OBJECTIFS

- Distinguer mises à jour prioritaires et secondaires
- Comprendre leur ordre de traitement
- Choisir la catégorie selon la criticité métier

## 🌺 PRIORITÉS

| Catégorie | Usage                                                       | Caractéristique                                                                    |
| --------- | ----------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| V1        | Données primaires indispensables à la transaction           | Exécutées en premier, dans l’ordre d’enregistrement, dans une database LUW commune |
| V2        | Données secondaires pouvant suivre la validation principale | Exécutées après la réussite de V1, éventuellement par des processus dédiés         |

```mermaid
flowchart LR
    A["COMMIT WORK"] --> B["Modules V1"]
    B --> C{"V1 réussie ?"}
    C -->|"Oui"| D["Commit V1"]
    D --> E["Modules V2"]
    C -->|"Non"| F["Rollback V1 et statut d erreur"]
```

Une erreur V2 ne doit pas remettre en cause les données V1 déjà validées. V2 convient donc uniquement aux mises à jour dont le retard ou la reprise séparée est acceptable.

## 🌺 CRITÈRE DE CHOIX

Utiliser V1 pour ce qui définit la cohérence de l’objet métier. Utiliser V2 pour des informations dérivées ou statistiques lorsque le standard concerné le prévoit. Ne pas détourner V2 pour masquer un traitement lent sans analyser la cohérence.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [V1 and V2 Update Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/23e9aa61638e404d81575e939b5cd847.html)
- [The Update Process — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/979cf1522d164bf7a781796efd8850ee/c8ed15db039b4f45a8507015f531976b.html)
- [Update Statuses — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/3c7ad8b964b74aac9e1d3e709b33e794.html)

---

➡️ [Chapitre suivant — MISE A JOUR LOCALE AVEC SET UPDATE TASK LOCAL](<./17 - 🍧 MISE A JOUR LOCALE AVEC SET UPDATE TASK LOCAL.md>)
