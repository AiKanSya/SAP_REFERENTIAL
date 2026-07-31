# 🌸 LANGAGE ET DÉVELOPPEMENT ABAP

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="abap"></a>
## 🌺 ABAP

### 🍧 DÉFINITION

Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP.

### 🍧 EXEMPLE

Un report ABAP peut lire des données, appliquer des règles et produire une liste.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Dans SAP GUI, le code classique est notamment maintenu avec `SE38`, `SE80`, `SE24` ou `SE37` selon l’objet.

### 🍧 À NE PAS CONFONDRE

ABAP est le langage ; SAP GUI est un client utilisateur.

<a id="instruction-abap"></a>
## 🌺 INSTRUCTION ABAP

### 🍧 DÉFINITION

Unité syntaxique terminée par un point.

### 🍧 EXEMPLE

`DATA lv_total TYPE i.` est une instruction.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser le contrôle syntaxique avant l’activation.

### 🍧 À NE PAS CONFONDRE

Une instruction peut s’étendre sur plusieurs lignes.

<a id="expression"></a>
## 🌺 EXPRESSION

### 🍧 DÉFINITION

Construction qui produit une valeur à partir d’opérandes et d’opérateurs.

### 🍧 EXEMPLE

`lv_net + lv_tax` est une expression arithmétique.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier les types et les conversions implicites ou explicites.

### 🍧 À NE PAS CONFONDRE

Une expression n’est pas nécessairement une instruction complète.

<a id="type-donnees"></a>
## 🌺 TYPE DE DONNÉES

### 🍧 DÉFINITION

Définition des propriétés d’une valeur : nature, longueur, précision et opérations autorisées.

### 🍧 EXEMPLE

`i`, `string` et `d` sont des types intégrés ABAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Déclarer un type local avec `TYPES` ou réutiliser un type DDIC.

### 🍧 À NE PAS CONFONDRE

Le type n’est pas la variable qui contient la valeur.

<a id="objet-donnees"></a>
## 🌺 OBJET DE DONNÉES

### 🍧 DÉFINITION

Zone de mémoire typée contenant une valeur pendant l’exécution.

### 🍧 EXEMPLE

Une variable déclarée avec `DATA` est un objet de données.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Observer sa valeur dans le débogueur.

### 🍧 À NE PAS CONFONDRE

Une table interne est aussi un objet de données, mais structuré et dynamique.

<a id="structure-abap"></a>
## 🌺 STRUCTURE

### 🍧 DÉFINITION

Objet ou type composé de plusieurs composants nommés.

### 🍧 EXEMPLE

Une structure de commande peut contenir numéro, client, date et montant.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Accéder à un composant avec le tiret : `ls_order-id`.

### 🍧 À NE PAS CONFONDRE

Une structure ne contient qu’une ligne, contrairement à une table interne.

<a id="table-interne"></a>
## 🌺 TABLE INTERNE

### 🍧 DÉFINITION

Collection dynamique de lignes stockée en mémoire dans le programme ABAP.

### 🍧 EXEMPLE

Le résultat d’un `SELECT ... INTO TABLE` est souvent reçu dans une table interne.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Déclarer le type de ligne et la catégorie de table, puis utiliser `LOOP AT`, `READ TABLE` ou une expression de table.

### 🍧 À NE PAS CONFONDRE

Une table interne n’est pas une table de base de données.

<a id="field-symbol"></a>
## 🌺 FIELD-SYMBOL

### 🍧 DÉFINITION

Alias dynamique vers une zone de mémoire existante.

### 🍧 EXEMPLE

`ASSIGNING FIELD-SYMBOL(<ls_row>)` permet de modifier directement une ligne de table interne.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Toujours vérifier qu’un field-symbol est affecté avant de l’utiliser.

### 🍧 À NE PAS CONFONDRE

Il ne possède pas nécessairement sa propre zone mémoire.

<a id="reference"></a>
## 🌺 RÉFÉRENCE

### 🍧 DÉFINITION

Valeur qui pointe vers un objet de données ou une instance de classe.

### 🍧 EXEMPLE

`REF TO` déclare un type de référence.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Tester la référence avec `IS BOUND` avant la déréférenciation lorsque son état est incertain.

### 🍧 À NE PAS CONFONDRE

Une référence initiale ne pointe vers aucun objet utilisable.

<a id="classe"></a>
## 🌺 CLASSE

### 🍧 DÉFINITION

Modèle orienté objet définissant état et comportements.

### 🍧 EXEMPLE

`ZCL_ORDER_SERVICE` peut encapsuler la validation d’une commande.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer une classe globale avec `SE24` ou une classe locale dans un programme.

### 🍧 À NE PAS CONFONDRE

Une classe est une définition ; une instance est un objet créé à l’exécution.

<a id="interface-abap-objects"></a>
## 🌺 INTERFACE ABAP OBJECTS

### 🍧 DÉFINITION

Contrat de méthodes, événements et types qu’une classe peut implémenter.

### 🍧 EXEMPLE

Plusieurs classes peuvent implémenter la même interface de validation.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Déclarer `INTERFACES` dans la classe, puis implémenter les méthodes requises.

### 🍧 À NE PAS CONFONDRE

Une interface ne fournit généralement pas d’état d’instance.

<a id="exception"></a>
## 🌺 EXCEPTION

### 🍧 DÉFINITION

Objet ou signal représentant une situation anormale qu’un appelant peut traiter.

### 🍧 EXEMPLE

Une conversion exacte peut lever une exception si la valeur ne peut pas être représentée.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser `TRY ... CATCH` et documenter les exceptions propagées.

### 🍧 À NE PAS CONFONDRE

`sy-subrc` est un code retour, pas une exception de classe.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — DONNÉES, DICTIONNAIRE ET BASE DE DONNÉES](<./05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md>)
