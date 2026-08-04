# 3. SAP GATEWAY ET ADMINISTRATION

Définitions liées au runtime, au déploiement et au routage des services.

<a id="sap-gateway"></a>
## 3.A SAP GATEWAY

**Définition.** Infrastructure ABAP fournissant les outils de conception, d’exécution, de publication et de supervision des services OData SAP.

**Exemple.** SAP Gateway traite une requête OData envoyée par une application SAP Fiori.

**Repère pratique.** Relever la version de `SAP_GWFND` et le mode de déploiement.

**À distinguer de.** SAP Gateway est l’infrastructure ; OData est le protocole.

---

<a id="embedded-deployment"></a>
## 3.B DÉPLOIEMENT EMBEDDED

**Définition.** Architecture dans laquelle la couche Gateway et l’implémentation métier résident dans le même système ABAP.

**Exemple.** Le service est enregistré et exécuté directement dans le système S/4HANA.

**Repère pratique.** Confirmer que l’alias et les classes conduisent au système local.

**À distinguer de.** Les couches frontend et backend restent logiquement distinctes dans les journaux.

---

<a id="hub-deployment"></a>
## 3.C DÉPLOIEMENT HUB

**Définition.** Architecture dans laquelle un système Gateway central reçoit la requête et appelle un backend distant.

**Exemple.** Le hub transmet la requête à S/4HANA au moyen d’un alias et d’une connexion RFC.

**Repère pratique.** Corréler `/IWFND/ERROR_LOG` dans le hub et `/IWBEP/ERROR_LOG` dans le backend.

**À distinguer de.** L’URL publique du hub ne localise pas le code métier.

---

<a id="system-alias"></a>
## 3.D ALIAS SYSTÈME

**Définition.** Nom logique utilisé par SAP Gateway pour choisir le système qui traite un service.

**Exemple.** Un alias distant conduit vers un backend par une destination configurée.

**Repère pratique.** Relever l’alias dans `/IWFND/MAINT_SERVICE` au lieu de le déduire.

**À distinguer de.** Un alias n’est ni un SID ni une garantie que la connexion RFC fonctionne.

---

<a id="icf"></a>
## 3.E ICF

**Définition.** Internet Communication Framework fournissant les nœuds et handlers HTTP dans un système ABAP.

**Exemple.** Un nœud ICF actif rend le chemin d’un service accessible au runtime HTTP.

**Repère pratique.** Contrôler le nœud associé depuis la maintenance du service.

**À distinguer de.** L’activation ICF ne remplace pas l’enregistrement du service ou les autorisations.

## 3.F RÉFÉRENCE SAP

- [Describing SAP Gateway Deployment Options — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/describing-sap-gateway-deployment-options)
