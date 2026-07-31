# 🌸 SAP GUI, NAVIGATION ET TRANSACTIONS

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="sap-logon"></a>
## 🌺 SAP LOGON

### 🍧 DÉFINITION

Application qui répertorie les connexions SAP disponibles sur le poste utilisateur.

### 🍧 EXEMPLE

Une entrée SAP Logon peut pointer vers un système de développement ou vers un message server.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Sélectionner une connexion, puis ouvrir une session SAP GUI.

### 🍧 À NE PAS CONFONDRE

Le libellé de la connexion est configurable et ne suffit pas à prouver l’environnement.

<a id="sap-gui"></a>
## 🌺 SAP GUI

### 🍧 DÉFINITION

Client graphique permettant d’utiliser les transactions et écrans d’un système SAP.

### 🍧 EXEMPLE

SAP GUI affiche SAP Easy Access, les dynpros, les listes classiques et les messages ABAP.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

La version peut être consultée dans **Aide → À propos de SAP GUI**.

### 🍧 À NE PAS CONFONDRE

SAP GUI n’exécute pas le code ABAP ; le backend l’exécute.

<a id="sap-easy-access"></a>
## 🌺 SAP EASY ACCESS

### 🍧 DÉFINITION

Écran d’accueil classique de SAP GUI contenant menus, favoris et champ de commande.

### 🍧 EXEMPLE

Un développeur peut ouvrir `SE38` depuis le champ de commande.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Utiliser `/n` pour revenir à l’écran initial dans la session courante.

### 🍧 À NE PAS CONFONDRE

Le menu visible dépend des rôles et de la configuration utilisateur.

<a id="transaction"></a>
## 🌺 TRANSACTION

### 🍧 DÉFINITION

Point d’entrée SAP associé à un code et à un objet de démarrage : programme, dynpro, méthode ou autre type pris en charge.

### 🍧 EXEMPLE

`SE11` ouvre l’ABAP Dictionary et `SE38` l’éditeur de programmes.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Saisir le code dans le champ de commande ou rechercher la transaction dans les menus.

### 🍧 À NE PAS CONFONDRE

Une transaction n’est pas nécessairement une transaction de base de données.

<a id="code-transaction"></a>
## 🌺 CODE DE TRANSACTION

### 🍧 DÉFINITION

Identifiant court utilisé pour démarrer une transaction SAP.

### 🍧 EXEMPLE

`/nSE80` ouvre l’Object Navigator dans la session courante.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

`/oSE80` ouvre une nouvelle session ; `/n` quitte la transaction courante.

### 🍧 À NE PAS CONFONDRE

Le code peut être différent du nom du programme lancé.

<a id="champ-commande"></a>
## 🌺 CHAMP DE COMMANDE

### 🍧 DÉFINITION

Zone de SAP GUI utilisée pour saisir des codes de transaction et des commandes système.

### 🍧 EXEMPLE

`/h` active le débogage pour l’action suivante.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Placer le curseur dans le champ, saisir la commande puis valider avec Entrée.

### 🍧 À NE PAS CONFONDRE

Certaines commandes ferment la session ou annulent le traitement ; les utiliser avec précaution.

<a id="session-sap-gui"></a>
## 🌺 SESSION SAP GUI

### 🍧 DÉFINITION

Fenêtre de travail indépendante ouverte pour un même utilisateur et un même système.

### 🍧 EXEMPLE

`/oSE11` ouvre `SE11` dans une nouvelle session.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

La commande `/o` affiche la liste des sessions ouvertes.

### 🍧 À NE PAS CONFONDRE

Une session SAP GUI n’est pas une connexion à un autre mandant.

<a id="dynpro"></a>
## 🌺 DYNPRO

### 🍧 DÉFINITION

Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI.

### 🍧 EXEMPLE

Les transactions de type module pool utilisent généralement des dynpros.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Les informations techniques d’un champ sont accessibles via `F1`, puis **Informations techniques**.

### 🍧 À NE PAS CONFONDRE

Un écran de sélection généré par un report n’est pas maintenu comme un dynpro classique.

<a id="aide-f1"></a>
## 🌺 AIDE F1

### 🍧 DÉFINITION

Aide contextuelle expliquant un champ, une fonction ou un mot-clé.

### 🍧 EXEMPLE

Dans l’éditeur ABAP, `F1` sur `SELECT` ouvre la documentation du mot-clé de la release du système.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Positionner le curseur sur l’élément puis appuyer sur `F1`.

### 🍧 À NE PAS CONFONDRE

Le contenu dépend du contexte et de la release installée.

<a id="aide-f4"></a>
## 🌺 AIDE F4

### 🍧 DÉFINITION

Aide à la saisie proposant des valeurs autorisées ou recherchables.

### 🍧 EXEMPLE

Un champ de division peut proposer les divisions accessibles à l’utilisateur.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Placer le curseur dans le champ puis appuyer sur `F4`.

### 🍧 À NE PAS CONFONDRE

La liste F4 n’implique pas que l’utilisateur soit autorisé à utiliser toutes les valeurs.

<a id="barre-statut"></a>
## 🌺 BARRE DE STATUT

### 🍧 DÉFINITION

Zone inférieure de SAP GUI affichant messages et informations de session.

### 🍧 EXEMPLE

Après activation d’un programme, un message de succès ou d’erreur peut y apparaître.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Lire le texte et, si disponible, double-cliquer sur le message pour obtenir des détails.

### 🍧 À NE PAS CONFONDRE

La couleur ou l’icône ne remplace pas l’analyse du texte du message.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — REPOSITORY, PACKAGES ET TRANSPORTS](<./03 - 🍧 REPOSITORY PACKAGES ET TRANSPORTS.md>)
