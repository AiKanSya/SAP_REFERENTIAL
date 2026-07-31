# 🌸 REPOSITORY, PACKAGES ET TRANSPORTS

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="repository-abap"></a>
## 🌺 REPOSITORY ABAP

### 🍧 DÉFINITION

Ensemble central des objets de développement d’un système ABAP.

### 🍧 EXEMPLE

Programmes, classes, tables DDIC, messages et transactions sont des objets Repository.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser `SE80` ou `SE84` pour rechercher et naviguer dans les objets.

### 🍧 À NE PAS CONFONDRE

Le Repository contient des définitions ; les données applicatives résident dans les tables.

<a id="objet-repository"></a>
## 🌺 OBJET REPOSITORY

### 🍧 DÉFINITION

Unité de développement gérée par le Repository et le système de transport.

### 🍧 EXEMPLE

Une classe globale ou une table transparente constitue un objet Repository.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Consulter l’entrée de répertoire pour connaître le package, le responsable et la couche de transport.

### 🍧 À NE PAS CONFONDRE

Tous les sous-éléments visibles dans un éditeur ne sont pas transportés séparément.

<a id="package"></a>
## 🌺 PACKAGE

### 🍧 DÉFINITION

Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité.

### 🍧 EXEMPLE

`ZDEV_DEMO` peut regrouper les objets d’un exercice ou d’une application.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Le package est demandé lors de l’enregistrement d’un objet Repository.

### 🍧 À NE PAS CONFONDRE

Un package n’est pas un dossier du système de fichiers.

<a id="objet-local-tmp"></a>
## 🌺 OBJET LOCAL $TMP

### 🍧 DÉFINITION

Objet affecté au package local `$TMP`, non destiné au transport vers un autre système.

### 🍧 EXEMPLE

Un report jetable de démonstration peut être créé dans `$TMP`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Choisir **Objet local** lorsque SAP demande un package, uniquement si le contexte l’autorise.

### 🍧 À NE PAS CONFONDRE

Un objet `$TMP` n’est pas adapté à une correction devant être livrée.

<a id="ordre-transport"></a>
## 🌺 ORDRE DE TRANSPORT

### 🍧 DÉFINITION

Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes.

### 🍧 EXEMPLE

Un ordre Workbench peut contenir un programme, une classe et une table Z.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Les ordres et tâches sont consultables dans `SE09` ou `SE10`.

### 🍧 À NE PAS CONFONDRE

Libérer un ordre ne l’importe pas automatiquement dans tous les systèmes.

<a id="tache-transport"></a>
## 🌺 TÂCHE DE TRANSPORT

### 🍧 DÉFINITION

Sous-conteneur affecté à un utilisateur dans un ordre de transport.

### 🍧 EXEMPLE

Chaque développeur enregistre ses objets dans sa tâche, puis la libère avant l’ordre parent.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Ouvrir l’ordre dans `SE09`/`SE10` pour afficher les tâches et leur contenu.

### 🍧 À NE PAS CONFONDRE

Une tâche libérée ne peut plus recevoir de nouvelles modifications.

<a id="ordre-workbench"></a>
## 🌺 ORDRE WORKBENCH

### 🍧 DÉFINITION

Type d’ordre utilisé principalement pour les objets Repository et les modifications inter-mandants.

### 🍧 EXEMPLE

Une classe ABAP globale est généralement enregistrée dans un ordre Workbench.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Le type d’ordre est déterminé par l’objet et le package.

### 🍧 À NE PAS CONFONDRE

Les règles exactes dépendent du paysage et de la configuration CTS.

<a id="ordre-customizing"></a>
## 🌺 ORDRE CUSTOMIZING

### 🍧 DÉFINITION

Type d’ordre utilisé principalement pour transporter du paramétrage dépendant du mandant.

### 🍧 EXEMPLE

Une modification de configuration effectuée dans une transaction IMG peut être enregistrée dans un ordre Customizing.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

SAP propose l’ordre lors de l’enregistrement d’une modification de paramétrage transportable.

### 🍧 À NE PAS CONFONDRE

Tout paramétrage n’est pas automatiquement transportable.

<a id="liberation-transport"></a>
## 🌺 LIBÉRATION

### 🍧 DÉFINITION

Action qui clôt une tâche ou un ordre et prépare l’export de son contenu.

### 🍧 EXEMPLE

Le développeur libère d’abord sa tâche, puis le responsable libère l’ordre.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Effectuer un contrôle du contenu et des dépendances avant la libération.

### 🍧 À NE PAS CONFONDRE

La libération est difficilement réversible et peut déclencher l’export.

<a id="import-transport"></a>
## 🌺 IMPORT

### 🍧 DÉFINITION

Chargement d’un ordre exporté dans un système cible.

### 🍧 EXEMPLE

Un ordre validé en DEV est importé en qualité pour les tests.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

L’import est généralement piloté par les équipes autorisées via le Transport Management System.

### 🍧 À NE PAS CONFONDRE

Un import réussi techniquement ne garantit pas la réussite fonctionnelle.

<a id="namespace-client"></a>
## 🌺 NAMESPACE CLIENT

### 🍧 DÉFINITION

Espace de noms réservé aux développements spécifiques, souvent préfixés par `Z` ou `Y`.

### 🍧 EXEMPLE

`ZCL_ORDER_SERVICE` est un nom de classe client classique.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Respecter les conventions de nommage du projet et les namespaces enregistrés.

### 🍧 À NE PAS CONFONDRE

Le préfixe `Z` ne garantit pas que l’objet soit sûr ou correctement conçu.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — LANGAGE ET DÉVELOPPEMENT ABAP](<./04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md>)
