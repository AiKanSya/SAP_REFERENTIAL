# 10. ACRONYMES SAP

Signification des acronymes SAP et ABAP les plus courants dans ce référentiel.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="acro-abap"></a>
## 10.A ABAP

**Définition.** Advanced Business Application Programming, langage et environnement de développement de la plateforme ABAP.

**Exemple.** Report, classe, module fonction et table interne sont des notions ABAP.

**Repère pratique.** Consulter la documentation des mots-clés avec `F1` dans l’éditeur.

**À distinguer de.** Le développement ABAP classique SAP GUI est distinct des outils ADT traités ultérieurement.


---

<a id="acro-adt"></a>
## 10.B ADT

**Définition.** ABAP Development Tools, environnement de développement ABAP intégré à Eclipse.

**Exemple.** ADT est requis pour plusieurs technologies modernes comme CDS et RAP.

**Repère pratique.** Ce référentiel réserve ADT à un futur dossier dédié.

**À distinguer de.** ADT ne doit pas être mélangé aux procédures SAP GUI décrites ici.


---

<a id="acro-alv"></a>
## 10.C ALV

**Définition.** ABAP List Viewer.

**Exemple.** SALV et ALV Grid sont deux familles d’API ALV.

**Repère pratique.** Choisir la technologie selon lecture seule, édition et événements.

**À distinguer de.** ALV n’est pas un format de fichier.


---

<a id="api"></a>
## 10.D API

**Définition.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants.

**Exemple.** L’API publique d’une classe globale est constituée de ses composants publics.

**Repère pratique.** Considérer la stabilité, les dépendances et la compatibilité avant de modifier une API déjà consommée.

**À distinguer de.** Une API peut être locale au système, distante ou publiée officiellement ; le terme ne désigne pas uniquement les services HTTP.


---

<a id="acro-atc"></a>
## 10.E ATC

**Définition.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité.

**Exemple.** ATC détecte certaines erreurs, risques et violations de règles.

**Repère pratique.** Exécuter les contrôles avant livraison et traiter ou justifier les findings.

**À distinguer de.** ATC ne remplace pas les tests fonctionnels.


---

<a id="acro-badi"></a>
## 10.F BADI

**Définition.** Business Add-In, mécanisme d’extension orienté objet du standard SAP.

**Exemple.** Une implémentation client ajoute une validation sans modifier le code standard.

**Repère pratique.** Analyser dans `SE18` et implémenter dans `SE19` selon la technologie.

**À distinguer de.** Les BAdI classiques et celles du Enhancement Framework ont des modèles différents.


---

<a id="acro-bal"></a>
## 10.G BAL

**Définition.** Business Application Log, API technique du journal applicatif.

**Exemple.** Les fonctions `BAL_LOG_CREATE` et `BAL_DB_SAVE` créent et persistent un log.

**Repère pratique.** Consulter les journaux avec `SLG1`.

**À distinguer de.** BAL désigne l’API ; SLG1 est l’outil de consultation.


---

<a id="acro-bapi"></a>
## 10.H BAPI

**Définition.** Business Application Programming Interface.

**Exemple.** API métier publiée, souvent appelée via un module fonction RFC.

**Repère pratique.** Respecter la documentation, la structure `RETURN` et la gestion de transaction.

**À distinguer de.** Toutes les fonctions RFC ne sont pas des BAPI.


---

<a id="acro-bte"></a>
## 10.I BTE

**Définition.** Business Transaction Event, mécanisme d’extension utilisé notamment dans certains domaines financiers.

**Exemple.** Une fonction client est appelée pour un événement métier configuré.

**Repère pratique.** Analyser et configurer via `FIBF` lorsque le composant le prévoit.

**À distinguer de.** Un BTE n’est pas une BAdI.


---

<a id="acro-cds"></a>
## 10.J CDS

**Définition.** Core Data Services, langage de modélisation de vues et entités de données.

**Exemple.** Les CDS modernes sont généralement développés dans ADT.

**Repère pratique.** Ce sujet sera traité dans un dossier ADT séparé.

**À distinguer de.** Les vues CDS ne sont pas les vues classiques créées dans `SE11`.


---

<a id="acro-ddic"></a>
## 10.K DDIC

**Définition.** Data Dictionary, abréviation courante de l’ABAP Dictionary.

**Exemple.** `SE11` permet de maintenir les objets DDIC.

**Repère pratique.** Utiliser les types DDIC pour partager une sémantique stable.

**À distinguer de.** DDIC peut désigner le composant, les objets ou l’utilisateur technique historique selon le contexte.


---

<a id="acro-gui"></a>
## 10.L GUI

**Définition.** Graphical User Interface.

**Exemple.** SAP GUI for Windows est un client graphique classique.

**Repère pratique.** Vérifier la version et les possibilités du frontend.

**À distinguer de.** Une API GUI ne fonctionne pas nécessairement en background.


---

<a id="acro-luw"></a>
## 10.M LUW

**Définition.** Logical Unit of Work.

**Exemple.** SAP LUW et database LUW ont des périmètres différents.

**Repère pratique.** Définir précisément les bornes de validation et d’annulation.

**À distinguer de.** LUW n’est pas synonyme de transaction SAP GUI.


---

<a id="oo"></a>
## 10.N OO

**Définition.** Object-Oriented, abréviation anglaise de la programmation orientée objet.

**Exemple.** ABAP Objects fournit les classes, interfaces, héritage, événements et exceptions orientées objet.

**Repère pratique.** Dans les documents SAP, `OO` ou `Object-Oriented` peut qualifier une API ou une conception basée sur des objets.

**À distinguer de.** OO décrit un paradigme de programmation, pas un outil SAP particulier.


---

<a id="poo"></a>
## 10.O POO

**Définition.** Programmation orientée objet, traduction française de Object-Oriented Programming.

**Exemple.** Une conception POO répartit les responsabilités entre des objets collaborant par des interfaces.

**Repère pratique.** Employer ce terme pour le concept général ; utiliser « ABAP Objects » pour les mécanismes orientés objet du langage ABAP.

**À distinguer de.** POO est le paradigme ; ABAP Objects est son implémentation dans ABAP.


---

<a id="acro-qrfc"></a>
## 10.P QRFC

**Définition.** Queued RFC.

**Exemple.** Les unités sont ordonnées dans des files surveillées par `SMQ1`/`SMQ2`.

**Repère pratique.** Analyser la première unité en erreur d’une file bloquée.

**À distinguer de.** La mise en file peut séquencer mais aussi retarder les traitements suivants.


---

<a id="acro-rap"></a>
## 10.Q RAP

**Définition.** ABAP RESTful Application Programming Model.

**Exemple.** Framework moderne pour services et applications basés sur des business objects.

**Repère pratique.** RAP est développé principalement avec ADT et sera traité séparément.

**À distinguer de.** RAP n’appartient pas au périmètre SAP GUI classique de ces dossiers.


---

<a id="acro-rfc"></a>
## 10.R RFC

**Définition.** Remote Function Call.

**Exemple.** Appel distant via une destination `SM59`.

**Repère pratique.** Tester connexion, autorisations et sémantique transactionnelle.

**À distinguer de.** Un RFC synchrone et un tRFC n’ont pas le même comportement.


---

<a id="acro-salv"></a>
## 10.S SALV

**Définition.** Simple ALV / famille de classes `CL_SALV_*`.

**Exemple.** `CL_SALV_TABLE` permet un affichage tabulaire rapide.

**Repère pratique.** Préparer la table, appeler `FACTORY`, configurer puis `DISPLAY`.

**À distinguer de.** SALV est principalement orienté affichage et ne remplace pas toujours ALV Grid.


---

<a id="acro-sap"></a>
## 10.T SAP

**Définition.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand.

**Exemple.** SAP S/4HANA s’appuie sur la plateforme ABAP pour de nombreux composants.

**Repère pratique.** Toujours préciser le produit, la release et le composant lorsqu’une procédure peut varier.

**À distinguer de.** « SAP » seul ne décrit pas une technologie précise.


---

<a id="acro-sid"></a>
## 10.U SID

**Définition.** System Identifier.

**Exemple.** Identifiant de trois caractères d’un système SAP.

**Repère pratique.** Le relever dans **Système → Statut**.

**À distinguer de.** Le SID n’est pas le mandant.


---

<a id="acro-sql"></a>
## 10.V SQL

**Définition.** Structured Query Language.

**Exemple.** ABAP SQL permet d’accéder aux sources de données depuis ABAP.

**Repère pratique.** Utiliser les variables hôte et sélectionner uniquement les colonnes nécessaires.

**À distinguer de.** ABAP SQL n’est pas identique au SQL natif de chaque base.


---

<a id="acro-trfc"></a>
## 10.W TRFC

**Définition.** Transactional RFC.

**Exemple.** Les unités en erreur sont consultables dans `SM58`.

**Repère pratique.** Concevoir le traitement pour la reprise.

**À distinguer de.** Le préfixe « transactional » ne dispense pas de gérer les transactions métier.

---

## 10.X Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
