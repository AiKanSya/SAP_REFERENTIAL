# 7. INTERFACES ET INTÉGRATION

Définitions liées aux échanges de données, aux fichiers et aux mécanismes d’intégration SAP.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="code-page"></a>
## 7.A CODE PAGE

**Définition.** Table de correspondance entre caractères et valeurs binaires utilisée pour un encodage.

**Exemple.** Une interface ancienne peut imposer une code page non UTF-8.

**Repère pratique.** Identifier la code page attendue et effectuer une conversion contrôlée.

**À distinguer de.** Une mauvaise code page peut produire des caractères illisibles sans erreur métier explicite.


---

<a id="csv"></a>
## 7.B CSV

**Définition.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement.

**Exemple.** `A123;10;EUR` est une ligne simple utilisant le point-virgule.

**Repère pratique.** Définir séparateur, guillemets, encodage, format des dates et séparateur décimal.

**À distinguer de.** Faire un simple `SPLIT` n’est pas suffisant lorsque les champs peuvent contenir le séparateur ou des guillemets.


---

<a id="destination-rfc"></a>
## 7.C DESTINATION RFC

**Définition.** Configuration `SM59` décrivant comment joindre une cible RFC.

**Exemple.** Une destination de type ABAP pointe vers un système partenaire.

**Repère pratique.** Tester la connexion et l’autorisation, puis documenter l’utilisateur technique et les responsabilités.

**À distinguer de.** Un test de connexion réussi ne garantit pas l’autorisation d’exécuter le module distant.


---

<a id="encodage"></a>
## 7.D ENCODAGE

**Définition.** Règle transformant les caractères en octets et inversement.

**Exemple.** UTF-8 représente correctement les caractères accentués si l’émetteur et le récepteur l’utilisent tous deux.

**Repère pratique.** Définir explicitement l’encodage du contrat et tester les caractères non ASCII.

**À distinguer de.** L’encodage est distinct du format métier du fichier.


---

<a id="fichier-frontend"></a>
## 7.E FICHIER FRONTEND

**Définition.** Fichier situé sur le poste utilisateur et manipulé via les services SAP GUI.

**Exemple.** Un utilisateur sélectionne un CSV avec un dialogue de fichier.

**Repère pratique.** Utiliser `CL_GUI_FRONTEND_SERVICES` uniquement dans un contexte dialogué compatible.

**À distinguer de.** Ce mécanisme ne fonctionne généralement pas en arrière-plan.


---

<a id="flux-entrant"></a>
## 7.F FLUX ENTRANT

**Définition.** Échange dans lequel SAP reçoit des données ou une demande.

**Exemple.** Un fichier fournisseur est importé chaque nuit.

**Repère pratique.** Valider format, encodage, doublons, autorisations et idempotence avant mise à jour.

**À distinguer de.** Recevoir un fichier ne signifie pas que les données sont acceptées métier.


---

<a id="flux-sortant"></a>
## 7.G FLUX SORTANT

**Définition.** Échange dans lequel SAP produit des données à destination d’un autre système.

**Exemple.** Un export quotidien génère les stocks disponibles.

**Repère pratique.** Définir sélection, format, nommage, emplacement, accusé de réception et rétention.

**À distinguer de.** L’absence d’erreur lors de l’écriture ne garantit pas la consommation par le destinataire.


---

<a id="idoc"></a>
## 7.H IDOC

**Définition.** Document intermédiaire SAP structuré en segments pour l’échange de messages métier.

**Exemple.** Un IDoc peut transporter une commande ou un mouvement de stock.

**Repère pratique.** Identifier type de base, type de message, partenaires et statuts.

**À distinguer de.** Les IDoc ne sont pas détaillés dans le présent parcours ABAP de base.


---

<a id="interface-integration"></a>
## 7.I INTERFACE

**Définition.** Mécanisme d’échange de données ou de fonctions entre composants.

**Exemple.** Un fichier CSV entrant alimente une table Z après contrôles.

**Repère pratique.** Définir contrat, direction, format, fréquence, sécurité, reprise et journalisation.

**À distinguer de.** Une interface technique doit être distinguée d’une interface ABAP Objects.


---

<a id="json"></a>
## 7.J JSON

**Définition.** Format texte structuré utilisant objets, tableaux, chaînes, nombres, booléens et valeur null.

**Exemple.** Une structure ABAP peut être sérialisée pour une API ou un fichier.

**Repère pratique.** Vérifier le mapping des noms, dates, décimaux, valeurs nulles et encodage UTF-8.

**À distinguer de.** La casse des propriétés peut faire partie du contrat.


---

<a id="qrfc"></a>
## 7.K QRFC

**Définition.** RFC transactionnel avec gestion de files afin de respecter un ordre de traitement.

**Exemple.** Des mises à jour d’un même objet sont envoyées dans la même file.

**Repère pratique.** Surveiller les files sortantes et entrantes dans `SMQ1` et `SMQ2`.

**À distinguer de.** Une file bloquée peut retenir les unités suivantes.


---

<a id="fichier-serveur-application"></a>
## 7.L SERVEUR D’APPLICATION

**Définition.** Emplacement du backend où un programme ABAP peut lire ou écrire avec `OPEN DATASET`.

**Exemple.** Un job de fond écrit un fichier dans un répertoire logique.

**Repère pratique.** Utiliser un chemin logique, contrôler `S_DATASET` et vérifier le fichier dans `AL11` si le répertoire est exposé.

**À distinguer de.** Le chemin est vu par le serveur, pas par le poste utilisateur.


---

<a id="trfc"></a>
## 7.M TRFC

**Définition.** RFC transactionnel garantissant la répétition d’un appel jusqu’à son traitement unique côté protocole.

**Exemple.** Un appel temporairement impossible reste enregistré et peut être repris.

**Repère pratique.** Surveiller les unités dans `SM58`.

**À distinguer de.** La logique métier appelée doit elle-même être conçue pour les reprises.


---

<a id="xml"></a>
## 7.N XML

**Définition.** Format texte hiérarchique basé sur des balises.

**Exemple.** Une Simple Transformation peut sérialiser une structure ABAP en XML.

**Repère pratique.** Définir le schéma, les namespaces, l’encodage et les règles de validation.

**À distinguer de.** Un XML bien formé n’est pas nécessairement conforme au contrat attendu.

---

## 7.O Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [EXÉCUTION, EXPLOITATION ET ADMINISTRATION](<./08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md>)
