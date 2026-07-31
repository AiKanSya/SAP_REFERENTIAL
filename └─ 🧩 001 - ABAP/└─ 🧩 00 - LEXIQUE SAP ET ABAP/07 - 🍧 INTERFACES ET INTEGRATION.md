# 🌸 INTERFACES ET INTÉGRATION

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="interface-integration"></a>
## 🌺 INTERFACE

### 🍧 DÉFINITION

Mécanisme d’échange de données ou de fonctions entre composants.

### 🍧 EXEMPLE

Un fichier CSV entrant alimente une table Z après contrôles.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir contrat, direction, format, fréquence, sécurité, reprise et journalisation.

### 🍧 À NE PAS CONFONDRE

Une interface technique doit être distinguée d’une interface ABAP Objects.

<a id="flux-entrant"></a>
## 🌺 FLUX ENTRANT

### 🍧 DÉFINITION

Échange dans lequel SAP reçoit des données ou une demande.

### 🍧 EXEMPLE

Un fichier fournisseur est importé chaque nuit.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Valider format, encodage, doublons, autorisations et idempotence avant mise à jour.

### 🍧 À NE PAS CONFONDRE

Recevoir un fichier ne signifie pas que les données sont acceptées métier.

<a id="flux-sortant"></a>
## 🌺 FLUX SORTANT

### 🍧 DÉFINITION

Échange dans lequel SAP produit des données à destination d’un autre système.

### 🍧 EXEMPLE

Un export quotidien génère les stocks disponibles.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir sélection, format, nommage, emplacement, accusé de réception et rétention.

### 🍧 À NE PAS CONFONDRE

L’absence d’erreur lors de l’écriture ne garantit pas la consommation par le destinataire.

<a id="fichier-serveur-application"></a>
## 🌺 SERVEUR D’APPLICATION

### 🍧 DÉFINITION

Emplacement du backend où un programme ABAP peut lire ou écrire avec `OPEN DATASET`.

### 🍧 EXEMPLE

Un job de fond écrit un fichier dans un répertoire logique.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser un chemin logique, contrôler `S_DATASET` et vérifier le fichier dans `AL11` si le répertoire est exposé.

### 🍧 À NE PAS CONFONDRE

Le chemin est vu par le serveur, pas par le poste utilisateur.

<a id="fichier-frontend"></a>
## 🌺 FICHIER FRONTEND

### 🍧 DÉFINITION

Fichier situé sur le poste utilisateur et manipulé via les services SAP GUI.

### 🍧 EXEMPLE

Un utilisateur sélectionne un CSV avec un dialogue de fichier.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser `CL_GUI_FRONTEND_SERVICES` uniquement dans un contexte dialogué compatible.

### 🍧 À NE PAS CONFONDRE

Ce mécanisme ne fonctionne généralement pas en arrière-plan.

<a id="csv"></a>
## 🌺 CSV

### 🍧 DÉFINITION

Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement.

### 🍧 EXEMPLE

`A123;10;EUR` est une ligne simple utilisant le point-virgule.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir séparateur, guillemets, encodage, format des dates et séparateur décimal.

### 🍧 À NE PAS CONFONDRE

Faire un simple `SPLIT` n’est pas suffisant lorsque les champs peuvent contenir le séparateur ou des guillemets.

<a id="encodage"></a>
## 🌺 ENCODAGE

### 🍧 DÉFINITION

Règle transformant les caractères en octets et inversement.

### 🍧 EXEMPLE

UTF-8 représente correctement les caractères accentués si l’émetteur et le récepteur l’utilisent tous deux.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir explicitement l’encodage du contrat et tester les caractères non ASCII.

### 🍧 À NE PAS CONFONDRE

L’encodage est distinct du format métier du fichier.

<a id="code-page"></a>
## 🌺 CODE PAGE

### 🍧 DÉFINITION

Table de correspondance entre caractères et valeurs binaires utilisée pour un encodage.

### 🍧 EXEMPLE

Une interface ancienne peut imposer une code page non UTF-8.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier la code page attendue et effectuer une conversion contrôlée.

### 🍧 À NE PAS CONFONDRE

Une mauvaise code page peut produire des caractères illisibles sans erreur métier explicite.

<a id="xml"></a>
## 🌺 XML

### 🍧 DÉFINITION

Format texte hiérarchique basé sur des balises.

### 🍧 EXEMPLE

Une Simple Transformation peut sérialiser une structure ABAP en XML.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Définir le schéma, les namespaces, l’encodage et les règles de validation.

### 🍧 À NE PAS CONFONDRE

Un XML bien formé n’est pas nécessairement conforme au contrat attendu.

<a id="json"></a>
## 🌺 JSON

### 🍧 DÉFINITION

Format texte structuré utilisant objets, tableaux, chaînes, nombres, booléens et valeur null.

### 🍧 EXEMPLE

Une structure ABAP peut être sérialisée pour une API ou un fichier.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier le mapping des noms, dates, décimaux, valeurs nulles et encodage UTF-8.

### 🍧 À NE PAS CONFONDRE

La casse des propriétés peut faire partie du contrat.

<a id="destination-rfc"></a>
## 🌺 DESTINATION RFC

### 🍧 DÉFINITION

Configuration `SM59` décrivant comment joindre une cible RFC.

### 🍧 EXEMPLE

Une destination de type ABAP pointe vers un système partenaire.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Tester la connexion et l’autorisation, puis documenter l’utilisateur technique et les responsabilités.

### 🍧 À NE PAS CONFONDRE

Un test de connexion réussi ne garantit pas l’autorisation d’exécuter le module distant.

<a id="trfc"></a>
## 🌺 TRFC

### 🍧 DÉFINITION

RFC transactionnel garantissant la répétition d’un appel jusqu’à son traitement unique côté protocole.

### 🍧 EXEMPLE

Un appel temporairement impossible reste enregistré et peut être repris.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Surveiller les unités dans `SM58`.

### 🍧 À NE PAS CONFONDRE

La logique métier appelée doit elle-même être conçue pour les reprises.

<a id="qrfc"></a>
## 🌺 QRFC

### 🍧 DÉFINITION

RFC transactionnel avec gestion de files afin de respecter un ordre de traitement.

### 🍧 EXEMPLE

Des mises à jour d’un même objet sont envoyées dans la même file.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Surveiller les files sortantes et entrantes dans `SMQ1` et `SMQ2`.

### 🍧 À NE PAS CONFONDRE

Une file bloquée peut retenir les unités suivantes.

<a id="idoc"></a>
## 🌺 IDOC

### 🍧 DÉFINITION

Document intermédiaire SAP structuré en segments pour l’échange de messages métier.

### 🍧 EXEMPLE

Un IDoc peut transporter une commande ou un mouvement de stock.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier type de base, type de message, partenaires et statuts.

### 🍧 À NE PAS CONFONDRE

Les IDoc ne sont pas détaillés dans le présent parcours ABAP de base.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — EXÉCUTION, EXPLOITATION ET ADMINISTRATION](<./08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md>)
