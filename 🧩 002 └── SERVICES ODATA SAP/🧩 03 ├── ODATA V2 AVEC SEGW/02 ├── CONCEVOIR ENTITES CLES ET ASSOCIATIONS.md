# 2. CONCEVOIR ENTITÉS, CLÉS ET ASSOCIATIONS

## 2.A RÉSULTAT ATTENDU

Produire un modèle OData stable, minimal et exploitable, avec des associations[^terme-association] et navigation properties[^terme-navigation] explicites.

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

## 2.E CONVENTIONS DE NOMMAGE

SAP Learning utilise une notation camel case pour les noms OData et un nom ABAP distinct en majuscules avec underscores.

| Objet | Convention | Exemple |
|---|---|---|
| Entity Type | Singulier, concept métier | `BusinessPartner` |
| Entity Set | Collection, convention homogène du projet | `BusinessPartnerSet` |
| Property | Camel case, nom public stable | `BusinessPartnerID` |
| ABAP Field Name | Majuscules et underscores | `BUSINESSPARTNERID` ou champ DDIC mappé |
| Navigation Property | Cible ou relation compréhensible | `ToProducts` |
| Association | Source et cible | `BusinessPartner_Products` |

Règles :

- Ne pas exposer les noms physiques de tables comme contrat public.
- Ne pas utiliser d’abréviation interne incompréhensible pour le consommateur.
- Stabiliser la casse : les segments URI et propriétés sont sensibles au nom publié.
- Ne pas renommer une propriété productive sans traiter la rupture de contrat.
- Vérifier les limites de longueur des artefacts générés ; SAP Learning recommande un nom de projet de 18 caractères maximum afin d’éviter les troncatures difficiles à relire.

## 2.F CRÉER UN ENTITY TYPE MANUELLEMENT

### 2.F.1 ÉTAPE 1 — OUVRIR L’ASSISTANT

1. Ouvrir le projet dans `SEGW`.
2. Développer `Data Model`.
3. Ouvrir le menu contextuel de `Entity Types`.
4. Choisir **Create**.
5. Saisir `BusinessPartner` dans **Entity Type Name**.
6. Cocher **Create Related Entity Set** si la collection doit être créée immédiatement.
7. Valider.

### 2.F.2 ÉTAPE 2 — CRÉER LES PROPRIÉTÉS

1. Développer `Entity Types > BusinessPartner`.
2. Ouvrir `Properties`.
3. Passer en modification.
4. Choisir **Append Row**.
5. Renseigner nom public, key, type EDM, longueur, nullabilité et libellé.
6. Ouvrir l’ABAP Type Editor lorsque le mapping ABAP n’est pas déduit d’une structure importée.
7. Sauvegarder puis lancer le consistency check.

## 2.G CONFIGURER LES PROPRIÉTÉS

| Champ SEGW | Fonction | Contrôle |
|---|---|---|
| `Name` | Nom public dans le metadata et le JSON | Stable, camel case |
| `Is Key` | Composant de la clé | Au moins une clé par Entity Type |
| `Edm Core Type` | Type OData primitif | Compatible avec la valeur ABAP |
| `Precision` | Nombre maximal de chiffres significatifs | Pertinent pour `Edm.Decimal` |
| `Scale` | Nombre maximal de chiffres après la virgule | Cohérent avec devise/quantité |
| `Max Length` | Longueur maximale transmise | Cohérente avec le domaine |
| `Nullable` | Valeur absente autorisée | Faux pour une clé |
| `ABAP Field Name` | Composant utilisé dans les structures générées | Nom ABAP valide |
| `ABAP Type` | Type backend associé | Vérifié dans l’ABAP Type Editor |
| `Label` | Libellé lisible | Texte traduisible selon la gouvernance |
| `Creatable` | Propriété acceptée à la création | Faux pour une clé générée |
| `Updatable` | Propriété acceptée à la modification | Faux pour une clé immuable |
| `Sortable` | Tri annoncé | Doit être traité par le backend |
| `Filterable` | Filtre annoncé | Doit être traité ou rejeté correctement |

Les options disponibles varient selon le type de projet et la release. Ne cocher aucune capacité uniquement pour faire apparaître une annotation : l’implémentation et les tests doivent la confirmer.

## 2.H CHOISIR LE TYPE EDM

| Type EDM V2 courant | Usage | Type ABAP typique | Point de vigilance |
|---|---|---|---|
| `Edm.String` | Identifiant, texte, code | `CHAR`, `STRING`, `NUMC` selon mapping | `MaxLength`, zéros et conversion exit |
| `Edm.Boolean` | Valeur logique | `ABAP_BOOL` ou domaine compatible | Représentation externe |
| `Edm.Byte` | Entier non signé court | Type numérique compatible | Plage de valeurs |
| `Edm.SByte` | Petit entier signé | `INT2`, `INT`, `NUM` selon mapping | Plage effective |
| `Edm.Int16` | Entier 16 bits | `INT2` ou compatible | Dépassement |
| `Edm.Int32` | Entier 32 bits | `INT4` ou compatible | Dépassement |
| `Edm.Int64` | Entier 64 bits | `INT8`, packed ou NUM selon release/mapping | Littéral V2 et client JavaScript |
| `Edm.Decimal` | Montant ou quantité | `P`, `DECFLOAT16/34` | `Precision`, `Scale`, devise/unité |
| `Edm.Double` | Nombre flottant | `F` | Arrondis binaires |
| `Edm.DateTime` | Date, heure ou timestamp V2 selon mapping | `D`, `T` ou packed timestamp | Sémantique et fuseau |
| `Edm.DateTimeOffset` | Horodatage avec décalage | Timestamp compatible | Conversion du fuseau |
| `Edm.Time` | Durée/temps selon V2 | Type compatible défini par le mapping | Ne pas l’assimiler automatiquement à `TIMS` |
| `Edm.Guid` | Identifiant GUID | Type RAW/CHAR compatible | Format canonique |
| `Edm.Binary` | Contenu binaire | `XSTRING`/RAW compatible | Taille et média type |

Ce tableau est un guide, pas une matrice universelle. SAP Help impose de confirmer le mapping avec l’ABAP Type Editor, notamment pour `DateTime`, `DateTimeOffset`, types décimaux et types importés du DDIC.

### 2.H.1 EXEMPLE BUSINESS PARTNER

| Property Name | Key | EDM | Max Length | Nullable | Creatable | Updatable |
|---|---:|---|---:|---:|---:|---:|
| `BusinessPartnerID` | Oui | `Edm.String` | 10 | Non | Non si générée | Non |
| `BusinessPartnerRole` | Non | `Edm.String` | 3 | Non selon contrat | Oui | Oui |
| `EmailAddress` | Non | `Edm.String` | 255 | Oui | Oui | Oui |
| `CompanyName` | Non | `Edm.String` | 80 | Oui | Oui | Oui |
| `CurrencyCode` | Non | `Edm.String` | 5 | Oui | Oui | Oui |
| `City` | Non | `Edm.String` | 40 | Oui | Oui | Oui |
| `Street` | Non | `Edm.String` | 60 | Oui | Oui | Oui |
| `Country` | Non | `Edm.String` | 3 | Oui | Oui | Oui |
| `AddressType` | Non | `Edm.String` | 2 | Oui | Oui | Oui |

Les longueurs correspondent à l’exercice SAP Learning. Elles doivent être remplacées par les types et domaines du contrat réel.

## 2.I ANNOTATIONS MINIMALES DU MODÈLE

Définir dans ce chapitre uniquement les annotations nécessaires à la cohérence structurelle : libellé, capacités des propriétés et relation montant-devise ou quantité-unité.

Le choix des mécanismes, les annotations `sap:*`, les vocabulaires, les exemples `MPC_EXT` et les tests dans Gateway Client sont traités dans [3. Modéliser les annotations OData V2](<03 ├── MODELLISER LES ANNOTATIONS ODATA V2.md>).
## 2.J CONFIGURER L’ENTITY SET ET SES OPÉRATIONS

Ouvrir `Data Model > Entity Sets`, passer en modification puis renseigner la ligne correspondant à l’Entity Type.

| Indicateur | Signification | Requête concernée | Exigence backend |
|---|---|---|---|
| `Addressable` | Accès direct autorisé | `GET /BusinessPartnerSet` | Contrôle réel du runtime ; sans ce flag, accès indirect par navigation |
| `Creatable` | Création annoncée | `POST /BusinessPartnerSet` | `CREATE_ENTITY` ou mapping implémenté |
| `Updatable` | Modification annoncée | `PUT/PATCH/MERGE ...('<KEY>')` | `UPDATE_ENTITY` implémentée |
| `Deletable` | Suppression annoncée | `DELETE ...('<KEY>')` | `DELETE_ENTITY` implémentée |
| `Pageable` | Pagination annoncée | `$top`, `$skip` | Pagination stable et bornée |
| `Searchable` | Recherche annoncée | `$search` selon capacité/runtime | Implémentation ou génération compatible |
| `Subscribable` | Abonnement annoncé | Scénario spécifique | Infrastructure correspondante |
| `Requires Filter` | Filtre obligatoire | Query sans `$filter` refusée | Validation des filtres acceptés |

`Addressable` n’est pas seulement documentaire selon SAP Learning : il détermine si l’Entity Set est accessible directement ou seulement par navigation. Les autres indicateurs annoncent les capacités dans le metadata et doivent rester cohérents avec les méthodes effectivement implémentées.

### 2.J.1 MATRICE DE DÉCISION

| Service voulu | Addressable | Creatable | Updatable | Deletable | Pageable | Requires Filter |
|---|---:|---:|---:|---:|---:|---:|
| Catalogue en lecture directe | Oui | Non | Non | Non | Oui | Selon volume |
| Ressource modifiable | Oui | Oui | Oui | Selon règle métier | Oui | Selon volume |
| Collection accessible uniquement depuis un parent | Non | Selon contrat | Selon contrat | Selon contrat | Oui | Non ou sans objet |
| Recherche volumineuse exigeant un critère | Oui | Non | Non | Non | Oui | Oui |

## 2.K PROCESS

### 2.K.1 ÉTAPE 1 — CRÉER OU IMPORTER L’ENTITY TYPE

1. Décrire les cas d’usage GET, création, modification et suppression.
2. Déduire les ressources et leurs identifiants.
3. Mapper les types ABAP/DDIC vers les types EDM.

Dans `Data Model > Entity Types`, créer le type et, si nécessaire, l’entity set associé. En cas d’import DDIC, désélectionner les champs sans utilité publique.

### 2.K.2 ÉTAPE 2 — DÉFINIR LA CLÉ ET LES FACETTES

4. Marquer les clés avant de générer.

Vérifier type EDM, longueur, précision, échelle, nullabilité, libellé et sémantique. Une clé ne doit pas dépendre d’un libellé mutable.

### 2.K.3 ÉTAPE 3 — CRÉER L’ASSOCIATION

5. Ajouter les associations et cardinalités.

Depuis `Data Model`, lancer l’assistant d’association. Sélectionner principal, dépendant, multiplicités et contrainte référentielle. Créer une navigation property dont le nom décrit la cible.

### 2.K.4 ÉTAPE 4 — GÉNÉRER ET CONTRÔLER

6. Contrôler le metadata produit.
7. Faire valider le contrat par le consommateur avant l’implémentation.

## 2.L EXEMPLE DE MODÈLE

| Type | Clé | Propriétés | Entity set |
|---|---|---|---|
| `SalesOrder` | `SalesOrder` | `CompanyCode`, `CreatedAt`, `Currency`, `NetAmount` | `SalesOrderSet` |
| `SalesOrderItem` | `SalesOrder`, `Item` | `Product`, `Quantity`, `Unit`, `Amount` | `SalesOrderItemSet` |

Association : `SalesOrder` `1` vers `SalesOrderItem` `0..n`. Navigation source : `ToItems`.

## 2.M METADATA ATTENDU

Extrait simplifié servant au contrôle, pas au remplacement du metadata généré :

```xml
<EntityType Name="BusinessPartner">
  <Key>
    <PropertyRef Name="BusinessPartnerID" />
  </Key>
  <Property Name="BusinessPartnerID"
            Type="Edm.String"
            Nullable="false"
            MaxLength="10" />
  <Property Name="EmailAddress"
            Type="Edm.String"
            MaxLength="255" />
</EntityType>

<EntitySet Name="BusinessPartnerSet"
           EntityType="ZBP_SRV.BusinessPartner"
           sap:addressable="true"
           sap:creatable="true"
           sap:updatable="true"
           sap:deletable="true" />
```

Le namespace et les annotations exactes dépendent du service généré.

## 2.N POINTS À REMPLACER

- Noms de types et sets selon le contrat public.
- Types EDM et longueurs selon le domaine fonctionnel.
- Cardinalité selon les données réelles.
- Contrainte référentielle selon les clés, pas selon une simple ressemblance de nom.

## 2.O CONTRÔLE

1. Générer et activer.
2. Lire `$metadata`.
3. Confirmer clés, types, entity sets et navigation.
4. Appeler une entité puis `/<clé>/ToItems`.
5. Tester une clé sans cible : la réponse doit respecter la cardinalité et le contrat.

Contrôles des capacités :

1. Si `Addressable` est actif, appeler directement l’Entity Set.
2. Si `Creatable` est actif, exécuter un `POST` valide et un invalide.
3. Si `Updatable` est actif, modifier uniquement une propriété marquée updatable.
4. Si `Deletable` est actif, supprimer uniquement l’objet créé pour le test.
5. Si `Requires Filter` est actif, vérifier le refus d’une query sans filtre puis le succès avec filtre.
6. Comparer les annotations produites dans `$metadata` aux indicateurs SEGW.

## 2.P ERREURS FRÉQUENTES

- Modifier le type ou la clé après mise en production sans versionner le contrat.
- Exposer directement des numéros internes avec leurs zéros sans documenter leur représentation externe.
- Utiliser une association pour masquer une lecture N+1 coûteuse.

| Symptôme | Cause | Correction |
|---|---|---|
| Entity set absent | Non créé ou non addressable | Corriger le modèle puis régénérer |
| Navigation `404` | Navigation ou association set incorrect | Reprendre le metadata et le sens |
| Clé mal formatée | Type EDM incohérent | Corriger le type ou l’URI |
| Données sensibles visibles | Import DDIC trop large | Retirer les propriétés du contrat |

| Opération annoncée mais rejetée | Flag actif, méthode non implémentée | Implémenter ou retirer la capacité |
| `POST` accepte une clé serveur | Propriété clé marquée creatable | Désactiver si la clé est générée |
| Montant tronqué | Precision/scale ou mapping ABAP incorrect | Corriger facets et type backend |
| Date décalée | Sémantique DateTime/fuseau incorrecte | Définir et tester la conversion |
| Accès direct impossible | `Addressable` inactif | Activer uniquement si l’accès direct est voulu |
| Montant sans devise | `sap:unit` absent ou cible incorrecte | Référencer la propriété de devise/unité |
| Libellé non traduit | Texte codé en dur ou source de texte absente | Utiliser DDIC, élément de texte ou fournisseur traduisible |
| Annotation UI ignorée | `Target`, terme ou chemin incorrect | Comparer namespace, type et propriétés au `$metadata` |
| UI autorisant une opération rejetée | Annotation incohérente avec DPC_EXT | Aligner modèle, implémentation et autorisations |

## 2.Q COMPATIBILITÉ S/4HANA

Ce chapitre concerne le modèle OData V2 défini dans SEGW. OData V4 n’utilise pas les association sets de la même manière. Ne pas recopier le modèle technique dans un service RAP sans reconcevoir les projections.

## 2.R RÉFÉRENCES OFFICIELLES SAP

- [Defining a Data Model — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/defining-a-data-model)
- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)
- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [Defining Properties — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/97dc22512c312314e10000000a44176d.html)
- [Entity Sets — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/68bf513362174d54b58cddec28794093/b6dc22512c312314e10000000a44176d.html)
- [Mappings and ABAP Type Editor — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_740/68bf513362174d54b58cddec28794093/ea0437caa33c4da3ab0f1a9d2bad1f96.html)
- [SAP Gateway Service Builder — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/cddd22512c312314e10000000a44176d.html)
- [Creating a Service Builder Project — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/68bf513362174d54b58cddec28794093/6c4f22518bc72214e10000000a44176d.html)
- [Working With OData Annotations — SAPUI5](https://help.sap.com/docs/SAPUI5/b2f662dd9d7a4ec680056733050b4d34/8b55ead17bd54c56b5597977fbf4b123.html)
- [Vocabulary-Based Annotations — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/296e3434bd4749708ceeb690b692eea1.html)
- [/IWBEP/IF_MGW_ODATA_PROPERTY — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/dafb2651c294256ee10000000a445394.html)
- [OData Vocabulary Annotations APIs — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/68bf513362174d54b58cddec28794093/652c3419f01e48f7a7f67adc52fdf9a0.html)

[^terme-association]: **ASSOCIATION.** Relation OData V2 définissant les types liés et leurs cardinalités. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#association>).
[^terme-navigation]: **NAVIGATION PROPERTY.** Propriété permettant de suivre une relation vers des entités liées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#navigation-property>).
