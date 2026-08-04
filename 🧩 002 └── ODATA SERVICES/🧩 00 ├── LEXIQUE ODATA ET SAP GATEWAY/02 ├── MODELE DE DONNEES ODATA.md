# 2. MODÈLE DE DONNÉES ODATA

Définitions liées à l’Entity Data Model et au document de métadonnées.

<a id="edm"></a>
## 2.A EDM

**Définition.** Entity Data Model décrivant les types, propriétés, clés, collections, relations et opérations d’un service OData.

**Exemple.** Le modèle contient un type `SalesOrder` et un set `SalesOrderSet`.

**Repère pratique.** Lire le modèle dans `$metadata` avant de construire une requête.

**À distinguer de.** L’EDM est un contrat externe ; il ne doit pas reproduire automatiquement le schéma physique d’une table.

---

<a id="metadata"></a>
## 2.B METADATA

**Définition.** Document CSDL accessible par `$metadata` et décrivant le contrat technique du service.

**Exemple.** Le document indique qu’une clé `SalesOrder` est de type `Edm.String`.

**Repère pratique.** Comparer les metadata avant et après une livraison.

**À distinguer de.** Le metadata ne documente pas toutes les règles fonctionnelles ou d’autorisation.

---

<a id="entity-type"></a>
## 2.C ENTITY TYPE

**Définition.** Type nommé définissant la clé, les propriétés et les navigations d’une entité.

**Exemple.** `SalesOrder` possède les propriétés `SalesOrder`, `CompanyCode` et `NetAmount`.

**Repère pratique.** Contrôler la clé, les types EDM et la nullabilité.

**À distinguer de.** Un entity type décrit une forme ; un entity set expose une collection d’instances.

---

<a id="entity-set"></a>
## 2.D ENTITY SET

**Définition.** Collection nommée et adressable d’entités d’un même type.

**Exemple.** `SalesOrderSet` est appelé dans l’URI pour lire des commandes.

**Repère pratique.** Utiliser le nom publié dans l’entity container.

**À distinguer de.** Le nom d’entity set peut différer de celui de l’entity type.

---

<a id="association"></a>
## 2.E ASSOCIATION

**Définition.** Relation OData V2 entre deux entity types avec des extrémités et des cardinalités.

**Exemple.** Une commande est associée à zéro ou plusieurs positions.

**Repère pratique.** Vérifier principal, dépendant, multiplicité et contrainte référentielle.

**À distinguer de.** En V2, l’association set relie les entity sets ; V4 utilise des navigation property bindings.

---

<a id="navigation-property"></a>
## 2.F NAVIGATION PROPERTY

**Définition.** Propriété permettant de suivre une relation depuis une entité vers une ou plusieurs entités liées.

**Exemple.** `ToItems` navigue d’une commande vers ses positions.

**Repère pratique.** Tester le sens et la cardinalité depuis une clé connue.

**À distinguer de.** `$expand` inclut la cible dans la réponse ; une navigation directe adresse la cible par une URI distincte.

---

<a id="annotation"></a>
## 2.G ANNOTATION

**Définition.** Information attachée à un artefact du modèle pour en préciser la sémantique, les capacités ou la présentation sans ajouter une propriété métier à l’entité.

**Exemple.** `sap:unit="CurrencyCode"` relie un montant à la propriété contenant sa devise.

**Repère pratique.** Contrôler l’annotation produite dans `$metadata`, puis vérifier son effet dans le client cible.

**À distinguer de.** `Nullable`, `MaxLength`, `Precision` et `Scale` sont des facettes CSDL, pas des annotations.

---

<a id="vocabulaire-odata"></a>
## 2.H VOCABULAIRE ODATA

**Définition.** Ensemble de termes nommés permettant d’exprimer des annotations réutilisables et interprétables par les consommateurs.

**Exemple.** `com.sap.vocabularies.UI.v1.LineItem` décrit les champs d’une liste pour un client compatible.

**Repère pratique.** Dans SEGW, consulter `Extras > Vocabulary Repository` et vérifier la disponibilité du vocabulaire sur la release cible.

**À distinguer de.** Les attributs SAP V2 comme `sap:label` et `sap:unit` ne sont pas écrits sous la forme d’un terme `UI`, `Common` ou `Capabilities`.

---

<a id="annotation-in-place"></a>
## 2.I ANNOTATION IN-PLACE

**Définition.** Annotation de vocabulaire intégrée au document de metadata du service.

**Exemple.** Un bloc `<Annotations>` ciblant un entity type est livré dans le `$metadata` principal.

**Repère pratique.** Vérifier le namespace, le `Target` et les chemins de propriétés.

**À distinguer de.** Une annotation ex-place est fournie dans un document séparé.

---

<a id="annotation-ex-place"></a>
## 2.J ANNOTATION EX-PLACE

**Définition.** Annotation de vocabulaire fournie hors du metadata principal, au moyen d’un document d’annotations et d’un fournisseur associé au service.

**Exemple.** Une Annotation Provider Class produit un document enregistré avec `/IWBEP/REG_VOCAN`.

**Repère pratique.** Contrôler séparément l’enregistrement, le document d’annotations et le service cible.

**À distinguer de.** L’annotation ex-place découple la description complémentaire du modèle principal ; elle ne modifie pas l’implémentation DPC_EXT.

## 2.K RÉFÉRENCES SAP

- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [Working With OData Annotations — SAPUI5](https://help.sap.com/docs/SAPUI5/b2f662dd9d7a4ec680056733050b4d34/8b55ead17bd54c56b5597977fbf4b123.html)
- [Vocabulary-Based Annotations — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/296e3434bd4749708ceeb690b692eea1.html)
