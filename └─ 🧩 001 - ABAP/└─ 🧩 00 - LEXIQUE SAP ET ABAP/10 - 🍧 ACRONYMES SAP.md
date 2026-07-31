# 🌸 ACRONYMES SAP

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="acro-abap"></a>
## 🌺 ABAP

### 🍧 DÉFINITION

Advanced Business Application Programming, langage et environnement de développement de la plateforme ABAP.

### 🍧 EXEMPLE

Report, classe, module fonction et table interne sont des notions ABAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Consulter la documentation des mots-clés avec `F1` dans l’éditeur.

### 🍧 À NE PAS CONFONDRE

Le développement ABAP classique SAP GUI est distinct des outils ADT traités ultérieurement.

<a id="acro-adt"></a>
## 🌺 ADT

### 🍧 DÉFINITION

ABAP Development Tools, environnement de développement ABAP intégré à Eclipse.

### 🍧 EXEMPLE

ADT est requis pour plusieurs technologies modernes comme CDS et RAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Ce référentiel réserve ADT à un futur dossier dédié.

### 🍧 À NE PAS CONFONDRE

ADT ne doit pas être mélangé aux procédures SAP GUI décrites ici.

<a id="acro-alv"></a>
## 🌺 ALV

### 🍧 DÉFINITION

ABAP List Viewer.

### 🍧 EXEMPLE

SALV et ALV Grid sont deux familles d’API ALV.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Choisir la technologie selon lecture seule, édition et événements.

### 🍧 À NE PAS CONFONDRE

ALV n’est pas un format de fichier.

<a id="acro-atc"></a>
## 🌺 ATC

### 🍧 DÉFINITION

ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité.

### 🍧 EXEMPLE

ATC détecte certaines erreurs, risques et violations de règles.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Exécuter les contrôles avant livraison et traiter ou justifier les findings.

### 🍧 À NE PAS CONFONDRE

ATC ne remplace pas les tests fonctionnels.

<a id="acro-badi"></a>
## 🌺 BADI

### 🍧 DÉFINITION

Business Add-In, mécanisme d’extension orienté objet du standard SAP.

### 🍧 EXEMPLE

Une implémentation client ajoute une validation sans modifier le code standard.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser dans `SE18` et implémenter dans `SE19` selon la technologie.

### 🍧 À NE PAS CONFONDRE

Les BAdI classiques et celles du Enhancement Framework ont des modèles différents.

<a id="acro-bapi"></a>
## 🌺 BAPI

### 🍧 DÉFINITION

Business Application Programming Interface.

### 🍧 EXEMPLE

API métier publiée, souvent appelée via un module fonction RFC.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Respecter la documentation, la structure `RETURN` et la gestion de transaction.

### 🍧 À NE PAS CONFONDRE

Toutes les fonctions RFC ne sont pas des BAPI.

<a id="acro-bal"></a>
## 🌺 BAL

### 🍧 DÉFINITION

Business Application Log, API technique du journal applicatif.

### 🍧 EXEMPLE

Les fonctions `BAL_LOG_CREATE` et `BAL_DB_SAVE` créent et persistent un log.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Consulter les journaux avec `SLG1`.

### 🍧 À NE PAS CONFONDRE

BAL désigne l’API ; SLG1 est l’outil de consultation.

<a id="acro-bte"></a>
## 🌺 BTE

### 🍧 DÉFINITION

Business Transaction Event, mécanisme d’extension utilisé notamment dans certains domaines financiers.

### 🍧 EXEMPLE

Une fonction client est appelée pour un événement métier configuré.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser et configurer via `FIBF` lorsque le composant le prévoit.

### 🍧 À NE PAS CONFONDRE

Un BTE n’est pas une BAdI.

<a id="acro-cds"></a>
## 🌺 CDS

### 🍧 DÉFINITION

Core Data Services, langage de modélisation de vues et entités de données.

### 🍧 EXEMPLE

Les CDS modernes sont généralement développés dans ADT.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Ce sujet sera traité dans un dossier ADT séparé.

### 🍧 À NE PAS CONFONDRE

Les vues CDS ne sont pas les vues classiques créées dans `SE11`.

<a id="acro-ddic"></a>
## 🌺 DDIC

### 🍧 DÉFINITION

Data Dictionary, abréviation courante de l’ABAP Dictionary.

### 🍧 EXEMPLE

`SE11` permet de maintenir les objets DDIC.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser les types DDIC pour partager une sémantique stable.

### 🍧 À NE PAS CONFONDRE

DDIC peut désigner le composant, les objets ou l’utilisateur technique historique selon le contexte.

<a id="acro-gui"></a>
## 🌺 GUI

### 🍧 DÉFINITION

Graphical User Interface.

### 🍧 EXEMPLE

SAP GUI for Windows est un client graphique classique.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier la version et les possibilités du frontend.

### 🍧 À NE PAS CONFONDRE

Une API GUI ne fonctionne pas nécessairement en background.

<a id="acro-luw"></a>
## 🌺 LUW

### 🍧 DÉFINITION

Logical Unit of Work.

### 🍧 EXEMPLE

SAP LUW et database LUW ont des périmètres différents.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir précisément les bornes de validation et d’annulation.

### 🍧 À NE PAS CONFONDRE

LUW n’est pas synonyme de transaction SAP GUI.

<a id="acro-rfc"></a>
## 🌺 RFC

### 🍧 DÉFINITION

Remote Function Call.

### 🍧 EXEMPLE

Appel distant via une destination `SM59`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Tester connexion, autorisations et sémantique transactionnelle.

### 🍧 À NE PAS CONFONDRE

Un RFC synchrone et un tRFC n’ont pas le même comportement.

<a id="acro-salv"></a>
## 🌺 SALV

### 🍧 DÉFINITION

Simple ALV / famille de classes `CL_SALV_*`.

### 🍧 EXEMPLE

`CL_SALV_TABLE` permet un affichage tabulaire rapide.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Préparer la table, appeler `FACTORY`, configurer puis `DISPLAY`.

### 🍧 À NE PAS CONFONDRE

SALV est principalement orienté affichage et ne remplace pas toujours ALV Grid.

<a id="acro-sap"></a>
## 🌺 SAP

### 🍧 DÉFINITION

Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand.

### 🍧 EXEMPLE

SAP S/4HANA s’appuie sur la plateforme ABAP pour de nombreux composants.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Toujours préciser le produit, la release et le composant lorsqu’une procédure peut varier.

### 🍧 À NE PAS CONFONDRE

« SAP » seul ne décrit pas une technologie précise.

<a id="acro-sid"></a>
## 🌺 SID

### 🍧 DÉFINITION

System Identifier.

### 🍧 EXEMPLE

Identifiant de trois caractères d’un système SAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Le relever dans **Système → Statut**.

### 🍧 À NE PAS CONFONDRE

Le SID n’est pas le mandant.

<a id="acro-sql"></a>
## 🌺 SQL

### 🍧 DÉFINITION

Structured Query Language.

### 🍧 EXEMPLE

ABAP SQL permet d’accéder aux sources de données depuis ABAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser les variables hôte et sélectionner uniquement les colonnes nécessaires.

### 🍧 À NE PAS CONFONDRE

ABAP SQL n’est pas identique au SQL natif de chaque base.

<a id="acro-trfc"></a>
## 🌺 TRFC

### 🍧 DÉFINITION

Transactional RFC.

### 🍧 EXEMPLE

Les unités en erreur sont consultables dans `SM58`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Concevoir le traitement pour la reprise.

### 🍧 À NE PAS CONFONDRE

Le préfixe « transactional » ne dispense pas de gérer les transactions métier.

<a id="acro-qrfc"></a>
## 🌺 QRFC

### 🍧 DÉFINITION

Queued RFC.

### 🍧 EXEMPLE

Les unités sont ordonnées dans des files surveillées par `SMQ1`/`SMQ2`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser la première unité en erreur d’une file bloquée.

### 🍧 À NE PAS CONFONDRE

La mise en file peut séquencer mais aussi retarder les traitements suivants.

<a id="acro-rap"></a>
## 🌺 RAP

### 🍧 DÉFINITION

ABAP RESTful Application Programming Model.

### 🍧 EXEMPLE

Framework moderne pour services et applications basés sur des business objects.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

RAP est développé principalement avec ADT et sera traité séparément.

### 🍧 À NE PAS CONFONDRE

RAP n’appartient pas au périmètre SAP GUI classique de ces dossiers.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)
