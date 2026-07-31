# 🌸 NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="donnee-base"></a>
## 🌺 DONNÉE DE BASE

### 🍧 DÉFINITION

Donnée relativement stable réutilisée par plusieurs processus métier.

### 🍧 EXEMPLE

Article, client ou fournisseur sont des données de base courantes.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier l’objet métier, son cycle de vie et l’organisation responsable.

### 🍧 À NE PAS CONFONDRE

Une donnée de base peut tout de même évoluer et être historisée.

<a id="donnee-transactionnelle"></a>
## 🌺 DONNÉE TRANSACTIONNELLE

### 🍧 DÉFINITION

Donnée créée par l’exécution d’un processus métier.

### 🍧 EXEMPLE

Commande, livraison, facture ou mouvement de stock.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser le document, ses postes, statuts et références.

### 🍧 À NE PAS CONFONDRE

Elle dépend souvent de données de base et de paramétrage.

<a id="customizing"></a>
## 🌺 CUSTOMIZING

### 🍧 DÉFINITION

Paramétrage permettant d’adapter le comportement standard SAP à l’organisation.

### 🍧 EXEMPLE

Définir des types de documents ou des règles de détermination.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier le chemin IMG, les dépendances et le type de transport.

### 🍧 À NE PAS CONFONDRE

Le Customizing n’est pas du code ABAP, même s’il influence son comportement.

<a id="unite-organisationnelle"></a>
## 🌺 UNITÉ ORGANISATIONNELLE

### 🍧 DÉFINITION

Élément structurant l’entreprise dans SAP.

### 🍧 EXEMPLE

Société, division, organisation commerciale ou organisation d’achats.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Demander la définition fonctionnelle exacte et les règles d’affectation.

### 🍧 À NE PAS CONFONDRE

Les noms et niveaux pertinents varient selon le module SAP.

<a id="societe"></a>
## 🌺 SOCIÉTÉ

### 🍧 DÉFINITION

Unité comptable légale souvent représentée par le company code.

### 🍧 EXEMPLE

Une écriture FI est comptabilisée dans une société.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier le code société et les périodes comptables concernées.

### 🍧 À NE PAS CONFONDRE

La société n’est pas nécessairement identique à une entité commerciale ou à un site.

<a id="division"></a>
## 🌺 DIVISION

### 🍧 DÉFINITION

Unité organisationnelle logistique couramment appelée plant dans les modèles SAP.

### 🍧 EXEMPLE

Un article peut être géré en stock dans plusieurs divisions.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier le champ technique et le module concerné, car le terme métier peut être ambigu.

### 🍧 À NE PAS CONFONDRE

En français SAP, « division » peut prêter à confusion avec d’autres notions organisationnelles.

<a id="organisation-commerciale"></a>
## 🌺 ORGANISATION COMMERCIALE

### 🍧 DÉFINITION

Unité responsable de la vente et de la distribution dans le modèle SD.

### 🍧 EXEMPLE

Une commande client est créée pour une organisation commerciale donnée.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier aussi canal de distribution et secteur d’activité lorsque le processus les utilise.

### 🍧 À NE PAS CONFONDRE

Ce concept ne correspond pas directement à une société juridique.

<a id="organisation-achats"></a>
## 🌺 ORGANISATION D’ACHATS

### 🍧 DÉFINITION

Unité responsable des activités d’approvisionnement.

### 🍧 EXEMPLE

Un contrat fournisseur peut être géré par une organisation d’achats.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier ses affectations aux sociétés et divisions.

### 🍧 À NE PAS CONFONDRE

Elle peut être centralisée ou spécifique selon le modèle de l’entreprise.

<a id="business-object"></a>
## 🌺 BUSINESS OBJECT

### 🍧 DÉFINITION

Représentation métier d’une entité avec données, opérations et cycle de vie.

### 🍧 EXEMPLE

Commande client, fournisseur ou demande d’achat.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier clés, statuts, API disponibles et règles transactionnelles.

### 🍧 À NE PAS CONFONDRE

Un Business Object n’est pas seulement une table de base de données.

<a id="document-sap"></a>
## 🌺 DOCUMENT SAP

### 🍧 DÉFINITION

Objet transactionnel enregistré avec en-tête, postes, statuts et références.

### 🍧 EXEMPLE

Une commande d’achat comprend un en-tête et plusieurs postes.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Toujours distinguer numéro externe, numéro interne, année et poste lorsque nécessaire.

### 🍧 À NE PAS CONFONDRE

Le terme document peut désigner des objets différents selon le module.

<a id="regle-metier"></a>
## 🌺 RÈGLE MÉTIER

### 🍧 DÉFINITION

Condition ou calcul imposé par le processus fonctionnel.

### 🍧 EXEMPLE

Refuser une quantité qui ne respecte pas le conditionnement.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Formaliser entrées, résultat attendu, exceptions et message utilisateur.

### 🍧 À NE PAS CONFONDRE

Une règle technique ne doit pas être présentée comme une règle métier sans validation fonctionnelle.

<a id="role-utilisateur"></a>
## 🌺 RÔLE UTILISATEUR

### 🍧 DÉFINITION

Regroupement d’autorisations et de menus attribué à un utilisateur.

### 🍧 EXEMPLE

Un rôle développeur donne accès à certaines transactions techniques en DEV.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser l’échec d’autorisation avec les outils prévus par l’organisation.

### 🍧 À NE PAS CONFONDRE

Disposer d’une transaction dans le menu ne garantit pas toutes les autorisations internes.

<a id="objet-autorisation"></a>
## 🌺 OBJET D’AUTORISATION

### 🍧 DÉFINITION

Structure de contrôle contenant des champs vérifiés lors d’une action.

### 🍧 EXEMPLE

`S_DATASET` contrôle certains accès fichiers serveur.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Identifier l’objet, l’activité et les valeurs contrôlées ; ne pas contourner le contrôle dans le code.

### 🍧 À NE PAS CONFONDRE

Un contrôle d’autorisation doit être conçu avec l’équipe sécurité.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — ACRONYMES SAP](<./10 - 🍧 ACRONYMES SAP.md>)
