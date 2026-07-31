# 🌸 PROGRAMMES, CLASSES ET OBJETS TECHNIQUES

## 🌺 OBJECTIF

Fournir des définitions courtes mais opérationnelles. Chaque terme précise son sens, un exemple, une méthode d’identification ou d’utilisation et les confusions fréquentes.

<a id="programme-executable"></a>
## 🌺 PROGRAMME EXÉCUTABLE

### 🍧 DÉFINITION

Programme ABAP de type report pouvant être lancé directement, généralement avec `F8` ou par une transaction.

### 🍧 EXEMPLE

Un report de contrôle affiche les anomalies d’un fichier importé.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer le programme dans `SE38` ou `SE80`, l’activer puis l’exécuter.

### 🍧 À NE PAS CONFONDRE

Un programme exécutable n’est pas un module pool.

<a id="module-pool"></a>
## 🌺 MODULE POOL

### 🍧 DÉFINITION

Programme ABAP classique pilotant des dynpros au moyen de modules PBO et PAI.

### 🍧 EXEMPLE

Une transaction dialoguée historique peut être basée sur un module pool.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

L’objet est généralement analysé dans `SE80` avec ses écrans et GUI statuses.

### 🍧 À NE PAS CONFONDRE

Il ne possède pas le même cycle événementiel qu’un report exécutable.

<a id="function-group"></a>
## 🌺 FUNCTION GROUP

### 🍧 DÉFINITION

Programme conteneur regroupant des modules fonction et des données globales partagées.

### 🍧 EXEMPLE

Les modules fonction d’une API technique sont stockés dans un même groupe.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer ou afficher le groupe depuis `SE37` ou `SE80`.

### 🍧 À NE PAS CONFONDRE

Les données globales du groupe persistent dans la session interne et peuvent créer des effets de bord.

<a id="module-fonction"></a>
## 🌺 MODULE FONCTION

### 🍧 DÉFINITION

Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions.

### 🍧 EXEMPLE

Un module fonction peut encapsuler une lecture ou une opération métier réutilisable.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Analyser l’interface, les exceptions et le code source dans `SE37`.

### 🍧 À NE PAS CONFONDRE

Tous les modules fonction ne sont pas RFC ni BAPI.

<a id="rfc"></a>
## 🌺 RFC

### 🍧 DÉFINITION

Remote Function Call, mécanisme permettant d’appeler un module fonction compatible dans un autre contexte ou système.

### 🍧 EXEMPLE

Un système SAP appelle un module distant via une destination `SM59`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Vérifier que le module est remote-enabled et tester la destination.

### 🍧 À NE PAS CONFONDRE

RFC désigne le mécanisme ; BAPI désigne une API métier normalisée pouvant utiliser RFC.

<a id="bapi"></a>
## 🌺 BAPI

### 🍧 DÉFINITION

Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC.

### 🍧 EXEMPLE

Une BAPI peut créer ou modifier un objet métier avec une structure `RETURN`.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Rechercher la BAPI dans le BAPI Explorer ou analyser son module fonction dans `SE37`.

### 🍧 À NE PAS CONFONDRE

Une BAPI ne doit pas être confondue avec n’importe quel module fonction commençant par `BAPI_`.

<a id="classe-globale"></a>
## 🌺 CLASSE GLOBALE

### 🍧 DÉFINITION

Classe Repository réutilisable dans le système ABAP.

### 🍧 EXEMPLE

`ZCL_FILE_IMPORT` encapsule un traitement d’import.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer et tester la classe dans `SE24` ou `SE80`.

### 🍧 À NE PAS CONFONDRE

Une classe locale n’est visible que dans son programme principal.

<a id="classe-messages"></a>
## 🌺 MESSAGE CLASS

### 🍧 DÉFINITION

Objet `SE91` contenant des messages numérotés et traduisibles.

### 🍧 EXEMPLE

`ZDEV_MSG` peut contenir le message 001 « Fichier &1 introuvable ».

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Créer la classe dans `SE91`, maintenir le texte puis l’utiliser avec `MESSAGE`.

### 🍧 À NE PAS CONFONDRE

Le type du message est déterminé lors de l’appel, pas dans la classe elle-même.

<a id="transaction-se93"></a>
## 🌺 TRANSACTION SE93

### 🍧 DÉFINITION

Objet Repository associant un code de transaction à une cible de démarrage.

### 🍧 EXEMPLE

`ZORDER_REPORT` peut lancer un programme exécutable avec un écran de sélection.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Afficher ou créer la transaction dans `SE93` et tester son démarrage.

### 🍧 À NE PAS CONFONDRE

Créer un code de transaction ne crée pas le programme appelé.

<a id="variante"></a>
## 🌺 VARIANTE

### 🍧 DÉFINITION

Enregistrement réutilisable des valeurs d’un écran de sélection.

### 🍧 EXEMPLE

Une variante quotidienne fixe la société, la date relative et le mode test.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Depuis l’écran de sélection, utiliser **Variantes → Sauvegarder**.

### 🍧 À NE PAS CONFONDRE

Une variante peut contenir des attributs de protection et des variables dynamiques.

<a id="job"></a>
## 🌺 JOB

### 🍧 DÉFINITION

Traitement planifié en arrière-plan composé d’une ou plusieurs étapes.

### 🍧 EXEMPLE

Un job nocturne exécute un report avec une variante.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Planifier dans `SM36` et surveiller dans `SM37`.

### 🍧 À NE PAS CONFONDRE

Le job est le conteneur ; le programme est une étape.

<a id="spool"></a>
## 🌺 SPOOL

### 🍧 DÉFINITION

Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP.

### 🍧 EXEMPLE

Un report exécuté en arrière-plan peut générer une demande spool.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Consulter la sortie depuis `SM37` ou les transactions spool autorisées.

### 🍧 À NE PAS CONFONDRE

Le journal de job et la sortie spool sont deux éléments distincts.

<a id="alv"></a>
## 🌺 ALV

### 🍧 DÉFINITION

ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes.

### 🍧 EXEMPLE

`CL_SALV_TABLE` affiche rapidement une table interne en lecture seule.

### 🍧 COMMENT L’IDENTIFIER OU L’UTILISER

Choisir SALV pour un affichage simple ou `CL_GUI_ALV_GRID` pour des interactions avancées.

### 🍧 À NE PAS CONFONDRE

ALV n’est pas une source de données ; il affiche une table interne préparée par le programme.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Programming Language — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM/66906ae3920c4fc684cf588290fb9267/d3d5c132973b404db980ba6ae0889be7.html)
- [SAP GUI for Windows — SAP Help Portal](https://help.sap.com/docs/r/product/sap_gui_for_windows)
- [ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/4f991f82446d11d189700000e8322d00.html)


---

➡️ [Chapitre suivant — INTERFACES ET INTÉGRATION](<./07 - 🍧 INTERFACES ET INTEGRATION.md>)
