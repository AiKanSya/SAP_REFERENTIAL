# LANGAGE ET DÉVELOPPEMENT ABAP

Définitions fondamentales du langage ABAP et de la programmation orientée objet sur la plateforme ABAP.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="abap"></a>
## ABAP

**Définition.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP.

**Exemple.** Un report ABAP peut lire des données, appliquer des règles et produire une liste.

**Repère pratique.** Dans SAP GUI, le code classique est notamment maintenu avec `SE38`, `SE80`, `SE24` ou `SE37` selon l’objet.

**À distinguer de.** ABAP est le langage ; SAP GUI est un client utilisateur.


---

<a id="classe"></a>
## CLASSE

**Définition.** Modèle orienté objet définissant état et comportements.

**Exemple.** `ZCL_ORDER_SERVICE` peut encapsuler la validation d’une commande.

**Repère pratique.** Créer une classe globale avec `SE24` ou une classe locale dans un programme.

**À distinguer de.** Une classe est une définition ; une instance est un objet créé à l’exécution.


---

<a id="exception"></a>
## EXCEPTION

**Définition.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter.

**Exemple.** Une conversion exacte peut lever une exception si la valeur ne peut pas être représentée.

**Repère pratique.** Utiliser `TRY ... CATCH` et documenter les exceptions propagées.

**À distinguer de.** `sy-subrc` est un code retour, pas une exception de classe.


---

<a id="expression"></a>
## EXPRESSION

**Définition.** Construction qui produit une valeur à partir d’opérandes et d’opérateurs.

**Exemple.** `lv_net + lv_tax` est une expression arithmétique.

**Repère pratique.** Vérifier les types et les conversions implicites ou explicites.

**À distinguer de.** Une expression n’est pas nécessairement une instruction complète.


---

<a id="field-symbol"></a>
## FIELD-SYMBOL

**Définition.** Alias dynamique vers une zone de mémoire existante.

**Exemple.** `ASSIGNING FIELD-SYMBOL(<ls_row>)` permet de modifier directement une ligne de table interne.

**Repère pratique.** Toujours vérifier qu’un field-symbol est affecté avant de l’utiliser.

**À distinguer de.** Il ne possède pas nécessairement sa propre zone mémoire.


---

<a id="instruction-abap"></a>
## INSTRUCTION ABAP

**Définition.** Unité syntaxique terminée par un point.

**Exemple.** `DATA lv_total TYPE i.` est une instruction.

**Repère pratique.** Utiliser le contrôle syntaxique avant l’activation.

**À distinguer de.** Une instruction peut s’étendre sur plusieurs lignes.


---

<a id="interface-abap-objects"></a>
## INTERFACE ABAP OBJECTS

**Définition.** Contrat de méthodes, événements et types qu’une classe peut implémenter.

**Exemple.** Plusieurs classes peuvent implémenter la même interface de validation.

**Repère pratique.** Déclarer `INTERFACES` dans la classe, puis implémenter les méthodes requises.

**À distinguer de.** Une interface ne fournit généralement pas d’état d’instance.


---

<a id="objet-donnees"></a>
## OBJET DE DONNÉES

**Définition.** Zone de mémoire typée contenant une valeur pendant l’exécution.

**Exemple.** Une variable déclarée avec `DATA` est un objet de données.

**Repère pratique.** Observer sa valeur dans le débogueur.

**À distinguer de.** Une table interne est aussi un objet de données, mais structuré et dynamique.


---

<a id="reference"></a>
## RÉFÉRENCE

**Définition.** Valeur qui pointe vers un objet de données ou une instance de classe.

**Exemple.** `REF TO` déclare un type de référence.

**Repère pratique.** Tester la référence avec `IS BOUND` avant la déréférenciation lorsque son état est incertain.

**À distinguer de.** Une référence initiale ne pointe vers aucun objet utilisable.


---

<a id="structure-abap"></a>
## STRUCTURE

**Définition.** Objet ou type composé de plusieurs composants nommés.

**Exemple.** Une structure de commande peut contenir numéro, client, date et montant.

**Repère pratique.** Accéder à un composant avec le tiret : `ls_order-id`.

**À distinguer de.** Une structure ne contient qu’une ligne, contrairement à une table interne.


---

<a id="table-interne"></a>
## TABLE INTERNE

**Définition.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP.

**Exemple.** Le résultat d’un `SELECT ... INTO TABLE` est souvent reçu dans une table interne.

**Repère pratique.** Déclarer le type de ligne et la catégorie de table, puis utiliser `LOOP AT`, `READ TABLE` ou une expression de table.

**À distinguer de.** Une table interne n’est pas une table de base de données.


---

<a id="type-donnees"></a>
## TYPE DE DONNÉES

**Définition.** Définition des propriétés d’une valeur : nature, longueur, précision et opérations autorisées.

**Exemple.** `i`, `string` et `d` sont des types intégrés ABAP.

**Repère pratique.** Déclarer un type local avec `TYPES` ou réutiliser un type DDIC.

**À distinguer de.** Le type n’est pas la variable qui contient la valeur.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [DONNÉES, DICTIONNAIRE ET BASE DE DONNÉES](<./05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md>)
