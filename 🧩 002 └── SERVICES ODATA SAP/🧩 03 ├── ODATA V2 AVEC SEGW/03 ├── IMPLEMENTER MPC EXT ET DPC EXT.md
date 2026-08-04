# 3. IMPLÉMENTER MPC_EXT ET DPC_EXT

## 3.A RÉSULTAT ATTENDU

Placer les extensions de modèle dans `MPC_EXT` et les opérations de données dans `DPC_EXT`.

## 3.B PRÉREQUIS

- Projet SEGW cohérent et runtime artifacts générés.
- Classes de base et d’extension actives.
- API métier identifiée.
- Cas de test avec clé existante et absente.

## 3.C RESPONSABILITÉS

| Classe | Responsabilité |
|---|---|
| MPC | Modèle généré |
| MPC_EXT | Annotations ou enrichissements client du modèle |
| DPC | Contrat d’exécution généré |
| DPC_EXT | Redéfinition des lectures et mutations |

La MPC fournit le metadata. La DPC fournit l’accès aux données. SAP Learning indique que cinq méthodes sont générées par entity set : `CREATE_ENTITY`, `GET_ENTITY`, `GET_ENTITYSET`, `UPDATE_ENTITY` et `DELETE_ENTITY`.

## 3.D CHOISIR LA MÉTHODE

| Besoin | Méthode générée |
|---|---|
| Créer une entité | `<SET>_CREATE_ENTITY` |
| Lire par clé | `<SET>_GET_ENTITY` |
| Interroger une collection | `<SET>_GET_ENTITYSET` |
| Modifier | `<SET>_UPDATE_ENTITY` |
| Supprimer | `<SET>_DELETE_ENTITY` |

Le nom réel dépend de l’entity set et peut être tronqué par le générateur. L’ouvrir depuis `Service Implementation`, sans le deviner.

## 3.E PROCESS

### 3.E.1 ÉTAPE 1 — OUVRIR LA BONNE REDÉFINITION

1. Identifier la méthode générée correspondant à l’entity set.
2. Redéfinir uniquement cette méthode dans `DPC_EXT`.

### 3.E.2 ÉTAPE 2 — LIRE LE CONTEXTE

3. Lire les clés, filtres, tri et pagination depuis le contexte technique fourni.

### 3.E.3 ÉTAPE 3 — APPELER LE DOMAINE MÉTIER

4. Valider les entrées avant d’appeler l’API métier.
5. Utiliser une API publiée ou un contrat métier ; ne jamais modifier directement une table applicative SAP.

### 3.E.4 ÉTAPE 4 — RETOURNER OU LEVER UNE ERREUR

6. Convertir les erreurs métier en message container puis en exception Gateway adaptée.
7. Ne pas exécuter de `COMMIT WORK` arbitraire dans une simple lecture.

## 3.F SQUELETTE DE LECTURE PAR CLÉ

Fragment à adapter dans la redéfinition générée :

```abap
DATA(lt_keys) = io_tech_request_context->get_keys( ).

READ TABLE lt_keys WITH KEY name = 'SalesOrder'
  INTO DATA(ls_key).
IF sy-subrc <> 0 OR ls_key-value IS INITIAL.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
    EXPORTING
      message = 'Clé SalesOrder absente'.
ENDIF.

" Remplacer par une API métier ou une lecture autorisée.
SELECT SINGLE salesorder, companycode
  FROM zi_salesorder
  WHERE salesorder = @ls_key-value
  INTO CORRESPONDING FIELDS OF @er_entity.

IF sy-subrc <> 0.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
    EXPORTING
      message = 'Commande introuvable'.
ENDIF.
```

Le nom des paramètres et types dépend de la signature générée. Ce fragment n’est pas autonome.

## 3.G POINTS À REMPLACER

| Exemple | Remplacement |
|---|---|
| `SalesOrder` | Nom de propriété de clé du metadata |
| `ZI_SALESORDER` | Source autorisée du projet |
| `ER_ENTITY` | Paramètre généré de la méthode |
| Messages | Textes T100 ou message container du projet |

## 3.H CONTRÔLE

- Les classes de base générées ne contiennent aucune modification client.
- Une régénération ne supprime pas l’implémentation.
- Les filtres et la pagination sont appliqués avant de charger un volume important.
- Les erreurs produisent un statut HTTP et un message cohérents.

Cas positif : une clé existante retourne exactement l’entité attendue. Cas négatif : une clé absente produit une erreur contrôlée, pas une structure initiale ambiguë.

## 3.I ERREURS FRÉQUENTES

- Implémenter uniquement `GET_ENTITYSET` et filtrer toutes les données en mémoire.
- Ignorer les clés techniques de la requête.
- Retourner une table vide pour masquer une erreur backend.

| Symptôme | Cause | Correction |
|---|---|---|
| Breakpoint jamais atteint | Mauvaise méthode ou backend | Ouvrir depuis SEGW et vérifier l’alias |
| Code perdu | Modification de DPC/MPC de base | Redéfinir dans EXT |
| `500` sans message utile | Exception non convertie | Alimenter le message container |
| Temps croissant | Options appliquées après lecture massive | Pousser filtre et pagination vers la source |

## 3.J COMPATIBILITÉ S/4HANA

Les classes `/IWBEP/*` et signatures varient avec le runtime Gateway. Toujours reprendre la signature générée dans le système cible. Cette implémentation classique n’est pas un modèle ABAP Cloud.

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [SAP Gateway Service Builder — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/cddd22512c312314e10000000a44176d.html)
