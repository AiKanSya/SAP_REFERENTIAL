# SAP GUI, NAVIGATION ET TRANSACTIONS

Définitions utiles pour se connecter, naviguer dans SAP GUI et utiliser les transactions classiques.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="aide-f1"></a>
## AIDE F1

**Définition.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé.

**Exemple.** Dans l’éditeur ABAP, `F1` sur `SELECT` ouvre la documentation du mot-clé de la release du système.

**Repère pratique.** Positionner le curseur sur l’élément puis appuyer sur `F1`.

**À distinguer de.** Le contenu dépend du contexte et de la release installée.


---

<a id="aide-f4"></a>
## AIDE F4

**Définition.** Aide à la saisie proposant des valeurs autorisées ou recherchables.

**Exemple.** Un champ de division peut proposer les divisions accessibles à l’utilisateur.

**Repère pratique.** Placer le curseur dans le champ puis appuyer sur `F4`.

**À distinguer de.** La liste F4 n’implique pas que l’utilisateur soit autorisé à utiliser toutes les valeurs.


---

<a id="barre-statut"></a>
## BARRE DE STATUT

**Définition.** Zone inférieure de SAP GUI affichant messages et informations de session.

**Exemple.** Après activation d’un programme, un message de succès ou d’erreur peut y apparaître.

**Repère pratique.** Lire le texte et, si disponible, double-cliquer sur le message pour obtenir des détails.

**À distinguer de.** La couleur ou l’icône ne remplace pas l’analyse du texte du message.


---

<a id="champ-commande"></a>
## CHAMP DE COMMANDE

**Définition.** Zone de SAP GUI utilisée pour saisir des codes de transaction et des commandes système.

**Exemple.** `/h` active le débogage pour l’action suivante.

**Repère pratique.** Placer le curseur dans le champ, saisir la commande puis valider avec Entrée.

**À distinguer de.** Certaines commandes ferment la session ou annulent le traitement ; les utiliser avec précaution.


---

<a id="code-transaction"></a>
## CODE DE TRANSACTION

**Définition.** Identifiant court utilisé pour démarrer une transaction SAP.

**Exemple.** `/nSE80` ouvre l’Object Navigator dans la session courante.

**Repère pratique.** `/oSE80` ouvre une nouvelle session ; `/n` quitte la transaction courante.

**À distinguer de.** Le code peut être différent du nom du programme lancé.


---

<a id="dynpro"></a>
## DYNPRO

**Définition.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI.

**Exemple.** Les transactions de type module pool utilisent généralement des dynpros.

**Repère pratique.** Les informations techniques d’un champ sont accessibles via `F1`, puis **Informations techniques**.

**À distinguer de.** Un écran de sélection généré par un report n’est pas maintenu comme un dynpro classique.


---

<a id="sap-easy-access"></a>
## SAP EASY ACCESS

**Définition.** Écran d’accueil classique de SAP GUI contenant menus, favoris et champ de commande.

**Exemple.** Un développeur peut ouvrir `SE38` depuis le champ de commande.

**Repère pratique.** Utiliser `/n` pour revenir à l’écran initial dans la session courante.

**À distinguer de.** Le menu visible dépend des rôles et de la configuration utilisateur.


---

<a id="sap-gui"></a>
## SAP GUI

**Définition.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP.

**Exemple.** SAP GUI affiche SAP Easy Access, les dynpros, les listes classiques et les messages ABAP.

**Repère pratique.** La version peut être consultée dans **Aide → À propos de SAP GUI**.

**À distinguer de.** SAP GUI n’exécute pas le code ABAP ; le backend l’exécute.


---

<a id="sap-logon"></a>
## SAP LOGON

**Définition.** Application qui répertorie les connexions SAP disponibles sur le poste utilisateur.

**Exemple.** Une entrée SAP Logon peut pointer vers un système de développement ou vers un message server.

**Repère pratique.** Sélectionner une connexion, puis ouvrir une session SAP GUI.

**À distinguer de.** Le libellé de la connexion est configurable et ne suffit pas à prouver l’environnement.


---

<a id="session-sap-gui"></a>
## SESSION SAP GUI

**Définition.** Fenêtre de travail indépendante ouverte pour un même utilisateur et un même système.

**Exemple.** `/oSE11` ouvre `SE11` dans une nouvelle session.

**Repère pratique.** La commande `/o` affiche la liste des sessions ouvertes.

**À distinguer de.** Une session SAP GUI n’est pas une connexion à un autre mandant.


---

<a id="transaction"></a>
## TRANSACTION

**Définition.** Point d’entrée SAP associé à un code et à un objet de démarrage : programme, dynpro, méthode ou autre type pris en charge.

**Exemple.** `SE11` ouvre l’ABAP Dictionary et `SE38` l’éditeur de programmes.

**Repère pratique.** Saisir le code dans le champ de commande ou rechercher la transaction dans les menus.

**À distinguer de.** Une transaction n’est pas nécessairement une transaction de base de données.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [REPOSITORY, PACKAGES ET TRANSPORTS](<./03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md>)
