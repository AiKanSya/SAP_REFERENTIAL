# REPOSITORY, PACKAGES ET TRANSPORTS

Définitions liées aux objets de développement, à leur organisation et à leur transport entre systèmes.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="import-transport"></a>
## IMPORT

**Définition.** Chargement d’un ordre exporté dans un système cible.

**Exemple.** Un ordre validé en DEV est importé en qualité pour les tests.

**Repère pratique.** L’import est généralement piloté par les équipes autorisées via le Transport Management System.

**À distinguer de.** Un import réussi techniquement ne garantit pas la réussite fonctionnelle.


---

<a id="liberation-transport"></a>
## LIBÉRATION

**Définition.** Action qui clôt une tâche ou un ordre et prépare l’export de son contenu.

**Exemple.** Le développeur libère d’abord sa tâche, puis le responsable libère l’ordre.

**Repère pratique.** Effectuer un contrôle du contenu et des dépendances avant la libération.

**À distinguer de.** La libération est difficilement réversible et peut déclencher l’export.


---

<a id="namespace-client"></a>
## NAMESPACE CLIENT

**Définition.** Espace de noms réservé aux développements spécifiques, souvent préfixés par `Z` ou `Y`.

**Exemple.** `ZCL_ORDER_SERVICE` est un nom de classe client classique.

**Repère pratique.** Respecter les conventions de nommage du projet et les namespaces enregistrés.

**À distinguer de.** Le préfixe `Z` ne garantit pas que l’objet soit sûr ou correctement conçu.


---

<a id="objet-local-tmp"></a>
## OBJET LOCAL $TMP

**Définition.** Objet affecté au package local `$TMP`, non destiné au transport vers un autre système.

**Exemple.** Un report jetable de démonstration peut être créé dans `$TMP`.

**Repère pratique.** Choisir **Objet local** lorsque SAP demande un package, uniquement si le contexte l’autorise.

**À distinguer de.** Un objet `$TMP` n’est pas adapté à une correction devant être livrée.


---

<a id="objet-repository"></a>
## OBJET REPOSITORY

**Définition.** Unité de développement gérée par le Repository et le système de transport.

**Exemple.** Une classe globale ou une table transparente constitue un objet Repository.

**Repère pratique.** Consulter l’entrée de répertoire pour connaître le package, le responsable et la couche de transport.

**À distinguer de.** Tous les sous-éléments visibles dans un éditeur ne sont pas transportés séparément.


---

<a id="ordre-customizing"></a>
## ORDRE CUSTOMIZING

**Définition.** Type d’ordre utilisé principalement pour transporter du paramétrage dépendant du mandant.

**Exemple.** Une modification de configuration effectuée dans une transaction IMG peut être enregistrée dans un ordre Customizing.

**Repère pratique.** SAP propose l’ordre lors de l’enregistrement d’une modification de paramétrage transportable.

**À distinguer de.** Tout paramétrage n’est pas automatiquement transportable.


---

<a id="ordre-transport"></a>
## ORDRE DE TRANSPORT

**Définition.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes.

**Exemple.** Un ordre Workbench peut contenir un programme, une classe et une table Z.

**Repère pratique.** Les ordres et tâches sont consultables dans `SE09` ou `SE10`.

**À distinguer de.** Libérer un ordre ne l’importe pas automatiquement dans tous les systèmes.


---

<a id="ordre-workbench"></a>
## ORDRE WORKBENCH

**Définition.** Type d’ordre utilisé principalement pour les objets Repository et les modifications inter-mandants.

**Exemple.** Une classe ABAP globale est généralement enregistrée dans un ordre Workbench.

**Repère pratique.** Le type d’ordre est déterminé par l’objet et le package.

**À distinguer de.** Les règles exactes dépendent du paysage et de la configuration CTS.


---

<a id="package"></a>
## PACKAGE

**Définition.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité.

**Exemple.** `ZDEV_DEMO` peut regrouper les objets d’un exercice ou d’une application.

**Repère pratique.** Le package est demandé lors de l’enregistrement d’un objet Repository.

**À distinguer de.** Un package n’est pas un dossier du système de fichiers.


---

<a id="repository-abap"></a>
## REPOSITORY ABAP

**Définition.** Ensemble central des objets de développement d’un système ABAP.

**Exemple.** Programmes, classes, tables DDIC, messages et transactions sont des objets Repository.

**Repère pratique.** Utiliser `SE80` ou `SE84` pour rechercher et naviguer dans les objets.

**À distinguer de.** Le Repository contient des définitions ; les données applicatives résident dans les tables.


---

<a id="tache-transport"></a>
## TÂCHE DE TRANSPORT

**Définition.** Sous-conteneur affecté à un utilisateur dans un ordre de transport.

**Exemple.** Chaque développeur enregistre ses objets dans sa tâche, puis la libère avant l’ordre parent.

**Repère pratique.** Ouvrir l’ordre dans `SE09`/`SE10` pour afficher les tâches et leur contenu.

**À distinguer de.** Une tâche libérée ne peut plus recevoir de nouvelles modifications.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [LANGAGE ET DÉVELOPPEMENT ABAP](<./04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md>)
