# 🌸 DONNÉES, DICTIONNAIRE ET BASE DE DONNÉES

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="abap-dictionary"></a>
## 🌺 ABAP DICTIONARY

### 🍧 DÉFINITION

Référentiel central des définitions de données utilisées par les programmes ABAP et la base de données.

### 🍧 EXEMPLE

Domaines, éléments de données, structures, tables, vues et aides à la recherche sont gérés dans `SE11`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Ouvrir `/nSE11`, choisir le type d’objet puis afficher ou créer l’objet.

### 🍧 À NE PAS CONFONDRE

Le Dictionary décrit les données ; il ne contient pas à lui seul les enregistrements métier.

<a id="domaine"></a>
## 🌺 DOMAINE

### 🍧 DÉFINITION

Objet DDIC définissant les caractéristiques techniques élémentaires et éventuellement des valeurs fixes.

### 🍧 EXEMPLE

Un domaine peut définir un type caractère de longueur 1 avec les valeurs `A` et `I`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Afficher le domaine depuis l’élément de données ou directement dans `SE11`.

### 🍧 À NE PAS CONFONDRE

Le domaine ne porte pas les libellés métier du champ.

<a id="element-donnees"></a>
## 🌺 ÉLÉMENT DE DONNÉES

### 🍧 DÉFINITION

Objet DDIC qui attribue une signification métier, des libellés et une documentation à un type élémentaire ou à un domaine.

### 🍧 EXEMPLE

Un élément de données `ZORDER_ID` peut représenter l’identifiant d’une commande.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer ou afficher l’élément dans `SE11` et vérifier ses libellés.

### 🍧 À NE PAS CONFONDRE

Plusieurs éléments de données peuvent réutiliser le même domaine avec des sens métier différents.

<a id="table-transparente"></a>
## 🌺 TABLE TRANSPARENTE

### 🍧 DÉFINITION

Table DDIC correspondant directement à une table physique de la base de données.

### 🍧 EXEMPLE

Une table Z de paramétrage créée dans `SE11` est généralement transparente.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier champs, clé, paramètres techniques et catégorie de livraison avant activation.

### 🍧 À NE PAS CONFONDRE

Ne pas modifier directement une table standard pour répondre à un besoin client.

<a id="cle-primaire"></a>
## 🌺 CLÉ PRIMAIRE

### 🍧 DÉFINITION

Ensemble minimal de champs identifiant de manière unique une ligne de table.

### 🍧 EXEMPLE

`MANDT` et `ORDER_ID` peuvent former la clé d’une table dépendante du mandant.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Les champs de clé sont marqués dans l’onglet des champs de `SE11`.

### 🍧 À NE PAS CONFONDRE

Un index secondaire n’est pas la clé primaire.

<a id="index-secondaire"></a>
## 🌺 INDEX SECONDAIRE

### 🍧 DÉFINITION

Structure de base de données supplémentaire accélérant certains accès au prix d’un coût de stockage et de maintenance.

### 🍧 EXEMPLE

Un index sur statut et date peut aider une sélection très fréquente.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer un index seulement après mesure et analyse du plan d’accès.

### 🍧 À NE PAS CONFONDRE

Ajouter des index systématiquement peut dégrader les écritures.

<a id="cle-etrangere"></a>
## 🌺 CLÉ ÉTRANGÈRE

### 🍧 DÉFINITION

Relation DDIC entre des champs d’une table et une table de contrôle.

### 🍧 EXEMPLE

Le champ société d’une table Z peut référencer la table de contrôle correspondante.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Maintenir la relation dans `SE11` et tester le contrôle de saisie lorsque l’écran l’utilise.

### 🍧 À NE PAS CONFONDRE

Une clé étrangère DDIC n’est pas toujours une contrainte physique de la base.

<a id="table-controle"></a>
## 🌺 TABLE DE CONTRÔLE

### 🍧 DÉFINITION

Table contenant les valeurs de référence autorisées pour une relation de clé étrangère.

### 🍧 EXEMPLE

La table de contrôle d’un code pays contient la liste des pays valides.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

La relation est visible depuis le champ dans `SE11`.

### 🍧 À NE PAS CONFONDRE

La table de valeurs d’un domaine et la table de contrôle d’une clé étrangère ont des rôles différents.

<a id="table-texte"></a>
## 🌺 TABLE DE TEXTE

### 🍧 DÉFINITION

Table dépendante de la langue contenant les descriptions associées à une table principale.

### 🍧 EXEMPLE

Une table de codes peut avoir une table de textes avec langue et libellé.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier la clé étrangère et le champ langue dans `SE11`.

### 🍧 À NE PAS CONFONDRE

Le texte n’est pas nécessairement stocké dans la table principale.

<a id="buffer-table"></a>
## 🌺 BUFFER DE TABLE

### 🍧 DÉFINITION

Mécanisme mettant en mémoire applicative certaines données de table afin de réduire les accès base.

### 🍧 EXEMPLE

Une petite table de paramétrage rarement modifiée peut être bufferisée.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Consulter les paramètres techniques dans `SE11` et mesurer avant de modifier la stratégie.

### 🍧 À NE PAS CONFONDRE

Le buffer n’est pas adapté à toutes les tables et peut rendre certaines lectures temporairement différentes d’un accès direct base.

<a id="routine-conversion"></a>
## 🌺 ROUTINE DE CONVERSION

### 🍧 DÉFINITION

Mécanisme DDIC convertissant une valeur entre représentation interne et affichage externe.

### 🍧 EXEMPLE

Des zéros initiaux peuvent être ajoutés ou retirés à l’affichage.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

La routine est visible au niveau du domaine ou de l’élément de données selon la définition.

### 🍧 À NE PAS CONFONDRE

La valeur affichée peut différer de la valeur réellement stockée.

<a id="mandt"></a>
## 🌺 MANDT

### 🍧 DÉFINITION

Champ technique de type mandant, généralement placé en première position de clé dans les tables dépendantes du mandant.

### 🍧 EXEMPLE

Une lecture ABAP SQL applique normalement la gestion implicite du mandant courant.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Afficher la table dans `SE11` et vérifier le premier champ.

### 🍧 À NE PAS CONFONDRE

Ne pas ajouter ou contourner la gestion du mandant sans besoin technique explicite et contrôle de sécurité.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — PROGRAMMES, CLASSES ET OBJETS TECHNIQUES](<./06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md>)
