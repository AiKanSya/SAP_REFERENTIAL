# 6. RAP ET ODATA V4

Définitions liées à l’exposition moderne d’un business object RAP.

<a id="rap"></a>
## 6.A RAP

**Définition.** ABAP RESTful Application Programming Model, modèle de programmation fondé sur CDS, ABAP et des business services.

**Exemple.** Un business object transactionnel est exposé comme API OData V4.

**Repère pratique.** Suivre le modèle CDS, le behavior, les projections, la service definition et le binding.

**À distinguer de.** RAP ne correspond pas à un projet SEGW réécrit dans ADT.

---

<a id="business-object-rap"></a>
## 6.B BUSINESS OBJECT RAP

**Définition.** Ensemble cohérent d’entités CDS et de comportements formant une unité transactionnelle ou de lecture.

**Exemple.** Une commande racine contient des positions et expose validations et actions.

**Repère pratique.** Lire le behavior pour connaître CRUD, verrouillage, autorisation, ETag et draft.

**À distinguer de.** La service definition expose le business object mais ne porte pas sa logique.

---

<a id="service-definition"></a>
## 6.C SERVICE DEFINITION

**Définition.** Objet Repository sélectionnant et nommant les projections CDS rendues disponibles à un service.

**Exemple.** `expose ZC_SalesOrder as SalesOrders`.

**Repère pratique.** Exposer uniquement les projections appartenant au contrat public.

**À distinguer de.** La service definition ne choisit pas le protocole.

---

<a id="service-binding"></a>
## 6.D SERVICE BINDING

**Définition.** Objet Repository reliant une service definition à un protocole et à un type de consommation.

**Exemple.** Binding OData V4 UI ou OData V4 Web API.

**Repère pratique.** Relever type, version, statut de publication et URL.

**À distinguer de.** Le binding expose le contrat ; le behavior implémente les capacités métier.

---

<a id="draft"></a>
## 6.E DRAFT

**Définition.** Capacité RAP permettant de conserver un état de travail avant activation de la version active.

**Exemple.** Un utilisateur modifie une commande en plusieurs étapes avant sauvegarde finale.

**Repère pratique.** Vérifier que le behavior et la consommation UI sont conçus pour le draft.

**À distinguer de.** Draft n’est ni une transaction longue de base de données ni une sauvegarde automatique universelle.

## 6.F RÉFÉRENCE SAP

- [Understanding RAP — SAP Learning](https://learning.sap.com/courses/building-transactional-apps-with-the-abap-restful-application-programming-model/exploring-the-concept-and-architecture-of-rap)
