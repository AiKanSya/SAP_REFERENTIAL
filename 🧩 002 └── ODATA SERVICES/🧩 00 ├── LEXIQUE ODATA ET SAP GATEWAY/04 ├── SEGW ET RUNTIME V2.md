# 4. SEGW ET RUNTIME V2

Définitions liées au développement classique d’un service OData V2.

<a id="segw"></a>
## 4.A SEGW

**Définition.** Transaction SAP Gateway Service Builder utilisée pour créer et maintenir des projets du code-based OData Channel.

**Exemple.** Un projet SEGW définit un modèle, une implémentation et des runtime artifacts.

**Repère pratique.** Examiner les quatre branches du projet avant toute modification.

**À distinguer de.** Un service RAP est conçu dans ADT et ne repose pas sur un projet SEGW.

---

<a id="mpc"></a>
## 4.B MPC

**Définition.** Model Provider Class générant le modèle et les métadonnées d’un service Gateway classique.

**Exemple.** `ZCL_ZSALES_MPC` contient le modèle généré.

**Repère pratique.** Placer les enrichissements persistants dans `MPC_EXT`.

**À distinguer de.** MPC décrit le modèle ; DPC fournit les données et comportements.

---

<a id="dpc"></a>
## 4.C DPC

**Définition.** Data Provider Class fournissant les méthodes d’accès et de modification des données d’un service Gateway classique.

**Exemple.** `SALESORDERSET_GET_ENTITYSET` traite la lecture d’une collection.

**Repère pratique.** Redéfinir les méthodes dans `DPC_EXT`.

**À distinguer de.** La classe DPC de base est régénérable et ne doit pas recevoir le code client durable.

---

<a id="runtime-artifact"></a>
## 4.D RUNTIME ARTIFACT

**Définition.** Objet technique généré par SEGW pour exécuter ou enregistrer le service.

**Exemple.** Classes MPC/DPC, modèle technique et service technique.

**Repère pratique.** Vérifier nom, package, transport et activation après génération.

**À distinguer de.** Le projet de conception n’est pas à lui seul un endpoint actif.

---

<a id="deep-insert"></a>
## 4.E DEEP INSERT

**Définition.** Création d’une structure d’entités liées transmise dans une seule requête.

**Exemple.** Création d’une commande avec ses positions.

**Repère pratique.** Valider toutes les données et garantir l’atomicité prévue.

**À distinguer de.** Un changeset `$batch` regroupe plusieurs opérations HTTP et n’est pas un deep insert.

## 4.F RÉFÉRENCE SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
