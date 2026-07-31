# PROGRAMMES, CLASSES ET OBJETS TECHNIQUES

Définitions des principaux objets techniques exécutables ou réutilisables dans un système ABAP.

Chaque entrée présente une définition concise, un exemple, un repère pratique et, lorsque nécessaire, une distinction avec une notion proche.

<a id="alv"></a>
## ALV

**Définition.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes.

**Exemple.** `CL_SALV_TABLE` affiche rapidement une table interne en lecture seule.

**Repère pratique.** Choisir SALV pour un affichage simple ou `CL_GUI_ALV_GRID` pour des interactions avancées.

**À distinguer de.** ALV n’est pas une source de données ; il affiche une table interne préparée par le programme.


---

<a id="bapi"></a>
## BAPI

**Définition.** Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC.

**Exemple.** Une BAPI peut créer ou modifier un objet métier avec une structure `RETURN`.

**Repère pratique.** Rechercher la BAPI dans le BAPI Explorer ou analyser son module fonction dans `SE37`.

**À distinguer de.** Une BAPI ne doit pas être confondue avec n’importe quel module fonction commençant par `BAPI_`.


---

<a id="classe-globale"></a>
## CLASSE GLOBALE

**Définition.** Classe Repository réutilisable dans le système ABAP.

**Exemple.** `ZCL_FILE_IMPORT` encapsule un traitement d’import.

**Repère pratique.** Créer et tester la classe dans `SE24` ou `SE80`.

**À distinguer de.** Une classe locale n’est visible que dans son programme principal.


---

<a id="function-group"></a>
## FUNCTION GROUP

**Définition.** Programme conteneur regroupant des modules fonction et des données globales partagées.

**Exemple.** Les modules fonction d’une API technique sont stockés dans un même groupe.

**Repère pratique.** Créer ou afficher le groupe depuis `SE37` ou `SE80`.

**À distinguer de.** Les données globales du groupe persistent dans la session interne et peuvent créer des effets de bord.


---

<a id="job"></a>
## JOB

**Définition.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes.

**Exemple.** Un job nocturne exécute un report avec une variante.

**Repère pratique.** Planifier dans `SM36` et surveiller dans `SM37`.

**À distinguer de.** Le job est le conteneur ; le programme est une étape.


---

<a id="classe-messages"></a>
## MESSAGE CLASS

**Définition.** Objet `SE91` contenant des messages numérotés et traduisibles.

**Exemple.** `ZDEV_MSG` peut contenir le message 001 « Fichier &1 introuvable ».

**Repère pratique.** Créer la classe dans `SE91`, maintenir le texte puis l’utiliser avec `MESSAGE`.

**À distinguer de.** Le type du message est déterminé lors de l’appel, pas dans la classe elle-même.


---

<a id="module-fonction"></a>
## MODULE FONCTION

**Définition.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions.

**Exemple.** Un module fonction peut encapsuler une lecture ou une opération métier réutilisable.

**Repère pratique.** Analyser l’interface, les exceptions et le code source dans `SE37`.

**À distinguer de.** Tous les modules fonction ne sont pas RFC ni BAPI.


---

<a id="module-pool"></a>
## MODULE POOL

**Définition.** Programme ABAP classique pilotant des dynpros au moyen de modules PBO et PAI.

**Exemple.** Une transaction dialoguée historique peut être basée sur un module pool.

**Repère pratique.** L’objet est généralement analysé dans `SE80` avec ses écrans et GUI statuses.

**À distinguer de.** Il ne possède pas le même cycle événementiel qu’un report exécutable.


---

<a id="programme-executable"></a>
## PROGRAMME EXÉCUTABLE

**Définition.** Programme ABAP de type report pouvant être lancé directement, généralement avec `F8` ou par une transaction.

**Exemple.** Un report de contrôle affiche les anomalies d’un fichier importé.

**Repère pratique.** Créer le programme dans `SE38` ou `SE80`, l’activer puis l’exécuter.

**À distinguer de.** Un programme exécutable n’est pas un module pool.


---

<a id="rfc"></a>
## RFC

**Définition.** Remote Function Call, mécanisme permettant d’appeler un module fonction compatible dans un autre contexte ou système.

**Exemple.** Un système SAP appelle un module distant via une destination `SM59`.

**Repère pratique.** Vérifier que le module est remote-enabled et tester la destination.

**À distinguer de.** RFC désigne le mécanisme ; BAPI désigne une API métier normalisée pouvant utiliser RFC.


---

<a id="spool"></a>
## SPOOL

**Définition.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP.

**Exemple.** Un report exécuté en arrière-plan peut générer une demande spool.

**Repère pratique.** Consulter la sortie depuis `SM37` ou les transactions spool autorisées.

**À distinguer de.** Le journal de job et la sortie spool sont deux éléments distincts.


---

<a id="transaction-se93"></a>
## TRANSACTION SE93

**Définition.** Objet Repository associant un code de transaction à une cible de démarrage.

**Exemple.** `ZORDER_REPORT` peut lancer un programme exécutable avec un écran de sélection.

**Repère pratique.** Afficher ou créer la transaction dans `SE93` et tester son démarrage.

**À distinguer de.** Créer un code de transaction ne crée pas le programme appelé.


---

<a id="variante"></a>
## VARIANTE

**Définition.** Enregistrement réutilisable des valeurs d’un écran de sélection.

**Exemple.** Une variante quotidienne fixe la société, la date relative et le mode test.

**Repère pratique.** Depuis l’écran de sélection, utiliser **Variantes → Sauvegarder**.

**À distinguer de.** Une variante peut contenir des attributs de protection et des variables dynamiques.

---

## Références SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)

---

Chapitre suivant : [INTERFACES ET INTÉGRATION](<./07 - 🍧 INTERFACES ET INTEGRATION.md>)
