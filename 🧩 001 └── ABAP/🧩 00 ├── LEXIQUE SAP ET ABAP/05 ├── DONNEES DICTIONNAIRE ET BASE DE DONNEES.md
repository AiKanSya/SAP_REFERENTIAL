# 5. DONNÉES, DICTIONNAIRE ET BASE DE DONNÉES

Définitions liées au Dictionnaire ABAP, aux tables et à la représentation technique des données.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="abap-dictionary"></a>
## 5.A ABAP DICTIONARY

**Définition.** Référentiel central des définitions de données utilisées par les programmes ABAP et la base de données.

**Exemple.** Domaines, éléments de données, structures, tables, vues et aides à la recherche sont gérés dans `SE11`.

**Repère pratique.** Ouvrir `/nSE11`, choisir le type d’objet puis afficher ou créer l’objet.

**À distinguer de.** Le Dictionary décrit les données ; il ne contient pas à lui seul les enregistrements métier.


---

<a id="buffer-table"></a>
## 5.B BUFFER DE TABLE

**Définition.** Mécanisme mettant en mémoire applicative certaines données de table afin de réduire les accès base.

**Exemple.** Une petite table de paramétrage rarement modifiée peut être bufferisée.

**Repère pratique.** Consulter les paramètres techniques dans `SE11` et mesurer avant de modifier la stratégie.

**À distinguer de.** Le buffer n’est pas adapté à toutes les tables et peut rendre certaines lectures temporairement différentes d’un accès direct base.


---

<a id="cle-etrangere"></a>
## 5.C CLÉ ÉTRANGÈRE

**Définition.** Relation DDIC entre des champs d’une table et une table de contrôle.

**Exemple.** Le champ société d’une table Z peut référencer la table de contrôle correspondante.

**Repère pratique.** Maintenir la relation dans `SE11` et tester le contrôle de saisie lorsque l’écran l’utilise.

**À distinguer de.** Une clé étrangère DDIC n’est pas toujours une contrainte physique de la base.


---

<a id="cle-primaire"></a>
## 5.D CLÉ PRIMAIRE

**Définition.** Ensemble minimal de champs identifiant de manière unique une ligne de table.

**Exemple.** `MANDT` et `ORDER_ID` peuvent former la clé d’une table dépendante du mandant.

**Repère pratique.** Les champs de clé sont marqués dans l’onglet des champs de `SE11`.

**À distinguer de.** Un index secondaire n’est pas la clé primaire.


---

<a id="domaine"></a>
## 5.E DOMAINE

**Définition.** Objet DDIC définissant les caractéristiques techniques élémentaires et éventuellement des valeurs fixes.

**Exemple.** Un domaine peut définir un type caractère de longueur 1 avec les valeurs `A` et `I`.

**Repère pratique.** Afficher le domaine depuis l’élément de données ou directement dans `SE11`.

**À distinguer de.** Le domaine ne porte pas les libellés métier du champ.


---

<a id="element-donnees"></a>
## 5.F ÉLÉMENT DE DONNÉES

**Définition.** Objet DDIC qui attribue une signification métier, des libellés et une documentation à un type élémentaire ou à un domaine.

**Exemple.** Un élément de données `ZORDER_ID` peut représenter l’identifiant d’une commande.

**Repère pratique.** Créer ou afficher l’élément dans `SE11` et vérifier ses libellés.

**À distinguer de.** Plusieurs éléments de données peuvent réutiliser le même domaine avec des sens métier différents.


---

<a id="index-secondaire"></a>
## 5.G INDEX SECONDAIRE

**Définition.** Structure de base de données supplémentaire accélérant certains accès au prix d’un coût de stockage et de maintenance.

**Exemple.** Un index sur statut et date peut aider une sélection très fréquente.

**Repère pratique.** Créer un index seulement après mesure et analyse du plan d’accès.

**À distinguer de.** Ajouter des index systématiquement peut dégrader les écritures.


---

<a id="mandt"></a>
## 5.H MANDT

**Définition.** Champ technique de type mandant, généralement placé en première position de clé dans les tables dépendantes du mandant.

**Exemple.** Une lecture ABAP SQL applique normalement la gestion implicite du mandant courant.

**Repère pratique.** Afficher la table dans `SE11` et vérifier le premier champ.

**À distinguer de.** Ne pas ajouter ou contourner la gestion du mandant sans besoin technique explicite et contrôle de sécurité.


---

<a id="routine-conversion"></a>
## 5.I ROUTINE DE CONVERSION

**Définition.** Mécanisme DDIC convertissant une valeur entre représentation interne et affichage externe.

**Exemple.** Des zéros initiaux peuvent être ajoutés ou retirés à l’affichage.

**Repère pratique.** La routine est visible au niveau du domaine ou de l’élément de données selon la définition.

**À distinguer de.** La valeur affichée peut différer de la valeur réellement stockée.


---

<a id="table-controle"></a>
## 5.J TABLE DE CONTRÔLE

**Définition.** Table contenant les valeurs de référence autorisées pour une relation de clé étrangère.

**Exemple.** La table de contrôle d’un code pays contient la liste des pays valides.

**Repère pratique.** La relation est visible depuis le champ dans `SE11`.

**À distinguer de.** La table de valeurs d’un domaine et la table de contrôle d’une clé étrangère ont des rôles différents.


---

<a id="table-texte"></a>
## 5.K TABLE DE TEXTE

**Définition.** Table dépendante de la langue contenant les descriptions associées à une table principale.

**Exemple.** Une table de codes peut avoir une table de textes avec langue et libellé.

**Repère pratique.** Vérifier la clé étrangère et le champ langue dans `SE11`.

**À distinguer de.** Le texte n’est pas nécessairement stocké dans la table principale.


---

<a id="table-transparente"></a>
## 5.L TABLE TRANSPARENTE

**Définition.** Table DDIC correspondant directement à une table physique de la base de données.

**Exemple.** Une table Z de paramétrage créée dans `SE11` est généralement transparente.

**Repère pratique.** Vérifier champs, clé, paramètres techniques et catégorie de livraison avant activation.

**À distinguer de.** Ne pas modifier directement une table standard pour répondre à un besoin client.

---

## 5.M Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [PROGRAMMES, CLASSES ET OBJETS TECHNIQUES](<./06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md>)
