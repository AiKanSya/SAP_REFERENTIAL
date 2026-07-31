# 🌸 DÉMARRER LE DÉBOGUEUR DANS SAP GUI

## 🌺 OBJECTIFS

- Démarrer le débogueur depuis un programme ou une transaction
- Utiliser un breakpoint ou la commande de débogage SAP GUI
- Comprendre la création d’une session de débogage
- Identifier les limites d’un contexte non dialogué

## 🌺 DEPUIS LE CODE SOURCE

Dans l’éditeur ABAP, placer un breakpoint sur une instruction exécutable, activer le programme, puis lancer le scénario.

```abap
REPORT zdev_debug_demo.

DATA(lv_total) = 10 + 5. " Point d’arrêt sur cette ligne
WRITE lv_total.
```

Le débogueur s’ouvre lorsque le processeur ABAP atteint un breakpoint actif pour l’utilisateur et le contexte concernés.

## 🌺 DEPUIS UNE TRANSACTION SAP GUI

Pour un traitement dialogué classique, saisir `/h` dans le champ de commande SAP GUI, valider, puis déclencher l’action à analyser. Le débogueur démarre au prochain point approprié du traitement ABAP.

Cette méthode est utile lorsque :

- le programme exact n’est pas encore connu ;
- le traitement est déclenché par un bouton ;
- plusieurs programmes ou écrans s’enchaînent ;
- le code standard appelle une extension client.

Ne pas confondre `/h` avec une analyse complète. La commande permet d’entrer dans le débogueur ; il faut ensuite localiser le traitement pertinent.

## 🌺 DEPUIS SE38 OU SE80

Selon l’outil et la version du système, un programme exécutable peut être lancé directement en mode débogage depuis les fonctions de test ou d’exécution.

Le point d’entrée initial peut se trouver avant l’événement recherché. Utiliser alors :

- un breakpoint sur une ligne précise ;
- un breakpoint sur une instruction ;
- la fonction **Continuer** jusqu’au prochain arrêt.

## 🌺 DEPUIS UNE TRANSACTION SE93

La maintenance des transactions permet de tester une transaction en mode débogage. Cette approche est utile pour vérifier le programme de démarrage et le type de transaction configuré.

## 🌺 CONTEXTE DE SESSION

Le débogueur standard s’exécute dans une session distincte de la session applicative. Le programme analysé reste suspendu tant que l’exécution n’est pas poursuivie ou terminée.

```mermaid
flowchart LR
    A["Action dans SAP GUI"] --> B["Breakpoint atteint"]
    B --> C["Session du débogueur"]
    C --> D["Inspection ou pas à pas"]
    D --> E["Reprise de l’application"]
```

## 🌺 CAS OÙ LE DÉBOGUEUR NE S OUVRE PAS

Vérifier :

- que le breakpoint est actif ;
- que le code exécuté correspond à la bonne version active ;
- que l’utilisateur du traitement est bien celui du breakpoint ;
- que le traitement ne s’exécute pas en tâche de fond, en mise à jour ou via un appel externe ;
- que le système et le mandant sont corrects ;
- que les autorisations de débogage sont présentes.

## 🌺 ARRÊTER PROPREMENT

Éviter de fermer brutalement la fenêtre. Utiliser les fonctions du débogueur pour :

- poursuivre l’exécution ;
- revenir au programme appelant ;
- terminer le traitement lorsque cela est nécessaire.

Une transaction interrompue peut conserver des verrous ou laisser une opération métier inachevée jusqu’à la fin de la session.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Starting and Directly Debugging ABAP Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)
- [Switching Directly to the ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/e4fc840c8c09403c87501c68f80fa716.html)
- [Standard ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/ba879a6e2ea04d9bb94c7ccd7cdac446/49250c884d7216b5e10000000a42189d.html)

---

➡️ [Chapitre suivant — BREAKPOINTS DE SESSION EXTERNES ET DU DEBUGGER](<./03 - 🍧 BREAKPOINTS DE SESSION EXTERNES ET DU DEBUGGER.md>)
