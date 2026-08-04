# 1. PROTOCOLE HTTP ET ODATA

Définitions liées au protocole OData, aux requêtes HTTP et au contrat exposé aux consommateurs.

<a id="odata"></a>
## 1.A ODATA

**Définition.** Open Data Protocol, protocole standardisé permettant d’exposer et de manipuler des ressources au moyen de HTTP.

**Exemple.** Une application lit une collection avec `GET .../SalesOrderSet`.

**Repère pratique.** Identifier la version OData avant de construire les URI ou les payloads.

**À distinguer de.** OData définit un protocole et un modèle ; il ne constitue pas une base de données.

---

<a id="service-odata"></a>
## 1.B SERVICE ODATA

**Définition.** Endpoint HTTP publiant un modèle de ressources, des collections et des opérations conformes à une version OData.

**Exemple.** `ZSALES_SRV` publie des commandes et leurs positions.

**Repère pratique.** Relever URL racine, version, metadata et système d’implémentation.

**À distinguer de.** Le nom externe du service peut différer du projet ou de la classe qui l’implémente.

---

<a id="http"></a>
## 1.C HTTP

**Définition.** Protocole de communication requête-réponse utilisé par OData pour transporter méthodes, URI, en-têtes, statuts et corps.

**Exemple.** `GET` lit une ressource et `POST` demande une création.

**Repère pratique.** Conserver méthode, URI, en-têtes, statut et corps lors d’un diagnostic.

**À distinguer de.** Un statut HTTP décrit le résultat protocolaire ; la cause métier se trouve dans le contexte applicatif.

---

<a id="uri"></a>
## 1.D URI

**Définition.** Identifiant textuel d’une ressource ou d’une opération accessible dans un service.

**Exemple.** `SalesOrderSet('500000001')/ToItems` cible les positions d’une commande.

**Repère pratique.** Construire l’URI à partir des noms et types présents dans `$metadata`.

**À distinguer de.** Une URI relative ne contient pas nécessairement le protocole, l’hôte et le port.

---

<a id="csrf-token"></a>
## 1.E JETON CSRF

**Définition.** Jeton lié à une session HTTP et utilisé pour protéger les requêtes qui modifient l’état contre certaines requêtes forgées.

**Exemple.** Le client demande `X-CSRF-Token: Fetch`, conserve les cookies puis envoie le jeton avec le `POST`.

**Repère pratique.** Récupérer et utiliser le jeton dans la même session.

**À distinguer de.** Le jeton CSRF ne remplace ni l’authentification ni l’autorisation métier.

## 1.F RÉFÉRENCE SAP

- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
