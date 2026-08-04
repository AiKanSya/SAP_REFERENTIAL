# 2. CONCEVOIR ENTITÉS, CLÉS ET ASSOCIATIONS

## 2.A RÉSULTAT ATTENDU

Produire un modèle OData stable, minimal et exploitable par son consommateur.

Le metadata final doit permettre d’identifier sans ambiguïté la collection, sa clé, les types des propriétés, la cardinalité et le sens de chaque navigation.

## 2.B PRÉREQUIS

- Projet SEGW créé et transportable.
- Cas d’usage et ressources validés.
- Structure DDIC ou contrat fonctionnel disponible.
- Propriétaire fonctionnel capable de valider la sémantique des champs.

## 2.C COMPOSANTS DU MODÈLE

| Composant | Fonction |
|---|---|
| Entity type | Forme d’une ressource |
| Entity set | Collection adressable d’entités du même type |
| Complex type | Groupe de propriétés sans identité propre |
| Association | Relation V2 et cardinalité entre types |
| Association set | Relation entre entity sets |
| Navigation property | Chemin exposé depuis une entité |
| Function import | Opération V2 hors CRUD standard |

## 2.D RÈGLES

- Exposer un contrat de service, pas la copie brute d’une table SAP.
- Choisir une clé stable, non vide et reconstructible.
- Distinguer propriété obligatoire, nullable et calculée.
- Conserver les sémantiques de devise, unité, date et heure.
- Créer une association seulement si le consommateur doit naviguer entre les ressources.
- Éviter d’exposer des champs techniques ou sensibles sans besoin explicite.

Une entity type doit avoir au moins une propriété de clé. L’entity set doit être addressable pour être appelé directement. La navigation ne remplace pas le contrôle d’autorisation sur la cible.

## 2.E PROCESS

### 2.E.1 ÉTAPE 1 — CRÉER OU IMPORTER L’ENTITY TYPE

1. Décrire les cas d’usage GET, création, modification et suppression.
2. Déduire les ressources et leurs identifiants.
3. Mapper les types ABAP/DDIC vers les types EDM.

Dans `Data Model > Entity Types`, créer le type et, si nécessaire, l’entity set associé. En cas d’import DDIC, désélectionner les champs sans utilité publique.

### 2.E.2 ÉTAPE 2 — DÉFINIR LA CLÉ ET LES FACETTES

4. Marquer les clés avant de générer.

Vérifier type EDM, longueur, précision, échelle, nullabilité, libellé et sémantique. Une clé ne doit pas dépendre d’un libellé mutable.

### 2.E.3 ÉTAPE 3 — CRÉER L’ASSOCIATION

5. Ajouter les associations et cardinalités.

Depuis `Data Model`, lancer l’assistant d’association. Sélectionner principal, dépendant, multiplicités et contrainte référentielle. Créer une navigation property dont le nom décrit la cible.

### 2.E.4 ÉTAPE 4 — GÉNÉRER ET CONTRÔLER

6. Contrôler le metadata produit.
7. Faire valider le contrat par le consommateur avant l’implémentation.

## 2.F EXEMPLE DE MODÈLE

| Type | Clé | Propriétés | Entity set |
|---|---|---|---|
| `SalesOrder` | `SalesOrder` | `CompanyCode`, `CreatedAt`, `Currency`, `NetAmount` | `SalesOrderSet` |
| `SalesOrderItem` | `SalesOrder`, `Item` | `Product`, `Quantity`, `Unit`, `Amount` | `SalesOrderItemSet` |

Association : `SalesOrder` `1` vers `SalesOrderItem` `0..n`. Navigation source : `ToItems`.

## 2.G POINTS À REMPLACER

- Noms de types et sets selon le contrat public.
- Types EDM et longueurs selon le domaine fonctionnel.
- Cardinalité selon les données réelles.
- Contrainte référentielle selon les clés, pas selon une simple ressemblance de nom.

## 2.H CONTRÔLE

1. Générer et activer.
2. Lire `$metadata`.
3. Confirmer clés, types, entity sets et navigation.
4. Appeler une entité puis `/<clé>/ToItems`.
5. Tester une clé sans cible : la réponse doit respecter la cardinalité et le contrat.

## 2.I ERREURS FRÉQUENTES

- Modifier le type ou la clé après mise en production sans versionner le contrat.
- Exposer directement des numéros internes avec leurs zéros sans documenter leur représentation externe.
- Utiliser une association pour masquer une lecture N+1 coûteuse.

| Symptôme | Cause | Correction |
|---|---|---|
| Entity set absent | Non créé ou non addressable | Corriger le modèle puis régénérer |
| Navigation `404` | Navigation ou association set incorrect | Reprendre le metadata et le sens |
| Clé mal formatée | Type EDM incohérent | Corriger le type ou l’URI |
| Données sensibles visibles | Import DDIC trop large | Retirer les propriétés du contrat |

## 2.J COMPATIBILITÉ S/4HANA

Ce chapitre concerne le modèle OData V2 défini dans SEGW. OData V4 n’utilise pas les association sets de la même manière. Ne pas recopier le modèle technique dans un service RAP sans reconcevoir les projections.

## 2.K RÉFÉRENCES OFFICIELLES SAP

- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)
- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [SAP Gateway Service Builder — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/cddd22512c312314e10000000a44176d.html)
