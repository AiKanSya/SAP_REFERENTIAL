# 1. ANALYSER /IWFND/ERROR_LOG ET /IWBEP/ERROR_LOG

## 1.A RÉSULTAT ATTENDU

Localiser une erreur dans la couche Gateway frontend ou dans l’implémentation backend.

## 1.B PRÉREQUIS

- Horodatage, utilisateur, URI, méthode et statut HTTP.
- Type de déploiement embedded ou hub.
- Autorisation de lire les journaux du mandant concerné.
- Requête de reproduction expurgée de ses secrets.

## 1.C JOURNAUX

| Transaction | Couche | Usage |
|---|---|---|
| `/IWFND/ERROR_LOG` | Gateway frontend | Erreurs reçues pendant l’appel OData |
| `/IWBEP/ERROR_LOG` | Backend | Erreurs pendant l’exécution du fournisseur |
| `/IWFND/APPS_LOG` | Gateway | Détails techniques complémentaires selon configuration |
| `ST22` | ABAP | Dumps corrélés |
| `STAUTHTRACE` | Autorisations | Contrôles réellement exécutés |

Les logs Gateway n’affichent pas nécessairement un échec d’authentification survenu avant l’entrée dans le runtime.

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — FIGER LE SCÉNARIO

1. Reproduire une seule fois la requête en notant heure, utilisateur, service, URI et statut HTTP.

### 1.D.2 ÉTAPE 2 — ANALYSER LE FRONTEND

2. Ouvrir `/IWFND/ERROR_LOG` dans le système Gateway.
3. Filtrer sur la période et l’utilisateur.
4. Ouvrir le contexte de l’erreur et relever exception, service, transaction ID et backend.
5. Utiliser le replay seulement si la requête ne contient pas de données sensibles et si l’action est sans risque.

### 1.D.3 ÉTAPE 3 — SUIVRE LE BACKEND

6. Pour une erreur backend, ouvrir `/IWBEP/ERROR_LOG` dans le système d’implémentation.

### 1.D.4 ÉTAPE 4 — CORRÉLER

7. Corréler avec `ST22`, `SM21`, `SLG1` ou la trace d’autorisation selon l’exception observée.

## 1.E TABLE DE DÉCISION

| Observation | Action suivante |
|---|---|
| Service introuvable | Enregistrement, alias et ICF |
| Exception DPC | Code `DPC_EXT` et API métier |
| Dump | `ST22` au même horodatage |
| Refus | `SU53` ou `STAUTHTRACE` |
| Timeout | Volume, SQL, RFC et limites HTTP |

## 1.F CONTRÔLE

Cas positif : retrouver l’entrée exacte à partir de l’heure et de l’utilisateur, puis identifier la classe ou la configuration responsable. Cas négatif : reproduire une clé inexistante et vérifier qu’elle produit une erreur métier contrôlée sans dump.

## 1.G ERREURS FRÉQUENTES

- Filtrer sur le mauvais mandant ou le mauvais système.
- Rejouer un `POST` ou `DELETE` productif.
- Corriger le premier message visible sans ouvrir le contexte complet.
- Vider les caches alors que le journal prouve une exception applicative.
- Confondre statut HTTP et cause racine.

## 1.H CRITÈRE DE SORTIE

La cause est prouvée par une entrée de journal, une trace ou un dump corrélé à la requête. Le statut HTTP seul ne constitue pas une cause.

## 1.I COMPATIBILITÉ S/4HANA

Le couple frontend/backend reste pertinent en embedded comme en hub. Les détails affichés et le replay peuvent être limités par la configuration de sécurité.

## 1.J RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [SAP Gateway Error Logs — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079390.html)
