# SYSTÈMES, ENVIRONNEMENTS ET MANDANTS

Définitions liées à l’architecture d’un paysage SAP, aux systèmes, aux mandants et aux composants d’exécution.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="backend"></a>
## BACKEND

**Définition.** Système serveur qui exécute la logique ABAP et accède aux données.

**Exemple.** Un report lancé depuis SAP GUI est exécuté dans le backend ABAP.

**Repère pratique.** Le système et le serveur sont visibles dans **Système → Statut**.

**À distinguer de.** Le backend ne désigne pas uniquement la base de données.


---

<a id="dependant-mandant"></a>
## DÉPENDANT DU MANDANT

**Définition.** Qualifie une donnée ou un objet dont le contenu est séparé par mandant.

**Exemple.** Une table dont le premier champ de clé est `MANDT` est généralement dépendante du mandant.

**Repère pratique.** Vérifier la définition de la table dans `SE11` et la présence de `MANDT`.

**À distinguer de.** La définition Repository de la table reste généralement commune au système, même si ses données sont séparées.


---

<a id="environnement"></a>
## ENVIRONNEMENT

**Définition.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production.

**Exemple.** Une correction est développée en DEV, validée en qualité puis importée en production.

**Repère pratique.** Vérifier le rôle du système dans la documentation du paysage et dans **Système → Statut**.

**À distinguer de.** Un environnement n’est pas un objet technique ABAP.


---

<a id="frontend"></a>
## FRONTEND

**Définition.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows.

**Exemple.** `CL_GUI_FRONTEND_SERVICES` accède à des fonctions disponibles sur le poste utilisateur.

**Repère pratique.** Vérifier si le traitement est dialogué et si un frontend graphique est présent.

**À distinguer de.** Un job de fond ne dispose généralement pas d’un frontend utilisateur.


---

<a id="instance"></a>
## INSTANCE

**Définition.** Ensemble de processus SAP démarrant et s’arrêtant ensemble sur un hôte.

**Exemple.** Un système peut contenir plusieurs instances de dialogue.

**Repère pratique.** Les informations d’instance sont visibles dans les outils d’administration et dans le statut système.

**À distinguer de.** Instance, système et serveur physique ne sont pas synonymes.


---

<a id="inter-mandants"></a>
## INTER-MANDANTS

**Définition.** Qualifie une donnée ou une action commune à tous les mandants d’un même système.

**Exemple.** La modification d’un programme ABAP actif concerne normalement tous les mandants du système.

**Repère pratique.** Vérifier la catégorie de l’objet et les avertissements affichés par SAP.

**À distinguer de.** Une table sans `MANDT` n’est pas automatiquement modifiable sans risque.


---

<a id="mandant"></a>
## MANDANT

**Définition.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs.

**Exemple.** Les mandants `100` et `200` peuvent appartenir au même système mais contenir des données différentes.

**Repère pratique.** Le mandant est saisi à la connexion et apparaît dans **Système → Statut**. Dans les tables dépendantes du mandant, il correspond généralement au champ `MANDT`.

**À distinguer de.** Le mandant n’est ni un système distinct ni un serveur physique.


---

<a id="paysage-systeme"></a>
## PAYSAGE SYSTÈME

**Définition.** Organisation des systèmes SAP et des routes de transport entre eux.

**Exemple.** DEV → QAS → PRD est une chaîne simple de transport.

**Repère pratique.** Les équipes Basis administrent généralement le paysage et les routes dans le Transport Management System.

**À distinguer de.** Le paysage peut comporter plusieurs systèmes de développement ou de recette.


---

<a id="serveur-applications-abap"></a>
## SERVEUR D’APPLICATIONS ABAP

**Définition.** Composant qui exécute les programmes ABAP au moyen de processus de travail.

**Exemple.** Un utilisateur connecté peut être traité par un serveur d’application différent de celui d’une autre session.

**Repère pratique.** Le serveur courant est visible dans **Système → Statut**.

**À distinguer de.** Il ne s’agit pas de la base de données.


---

<a id="sid"></a>
## SID

**Définition.** Identifiant technique d’un système SAP, composé de trois caractères alphanumériques.

**Exemple.** `D01`, `Q01` ou `P01` sont des exemples de SID possibles.

**Repère pratique.** Le SID apparaît dans **Système → Statut**, dans SAP Logon et dans plusieurs noms techniques.

**À distinguer de.** Le SID n’indique pas obligatoirement l’environnement ; les conventions dépendent de l’entreprise.


---

<a id="systeme-sap"></a>
## SYSTÈME SAP

**Définition.** Ensemble technique cohérent comprenant au minimum une base de données et un ou plusieurs serveurs d’applications. Il est généralement identifié par un SID de trois caractères.

**Exemple.** Le système `D01` peut être utilisé pour le développement tandis que `Q01` sert aux tests.

**Repère pratique.** Dans SAP GUI, ouvrir **Système → Statut** pour relever le système, le mandant et le serveur d’application.

**À distinguer de.** Ne pas confondre le système avec le mandant ni avec le rôle DEV/QUAL/PRD attribué dans le paysage.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [SAP GUI, NAVIGATION ET TRANSACTIONS](<./02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md>)
