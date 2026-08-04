# 1. CRÉER UN MODULE POOL ET UN PREMIER ÉCRAN

## 1.A RÉSULTAT ATTENDU

Afficher le dynpro[^terme-dynpro] `0100` depuis une transaction SAP[^terme-transaction] GUI[^terme-acro-gui] et permettre sa fermeture sans bloquer l’utilisateur.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — CRÉER LE MODULE POOL

Dans `SE80`[^outil-se80], créer le programme `ZDEMO_DYNPRO` de type module pool[^terme-module-pool]. Affecter le package[^terme-package] et la demande de transport prévus, puis déclarer le champ global `GV_OK_CODE` avec le type `SYUCOMM`.

### 1.B.2 ÉTAPE 2 — CRÉER LE DYNPRO 0100

Créer l’écran `0100`. Définir ses attributs, son écran suivant et son type selon le scénario. Dans la liste des éléments, affecter `GV_OK_CODE` au champ OK_CODE afin que le PAI reçoive les commandes du statut GUI.

### 1.B.3 ÉTAPE 3 — CONSTRUIRE L’ÉCRAN

Dans Screen Painter, ajouter les champs et libellés nécessaires. Chaque champ lié au programme doit posséder le même nom et un type compatible avec la donnée ABAP[^terme-abap] correspondante.

### 1.B.4 ÉTAPE 4 — DÉFINIR LA LOGIQUE DE FLUX

Déclarer dans le flux du dynpro un module PBO pour préparer l’écran et un module PAI pour traiter les commandes. Créer ensuite les implémentations proposées dans le bloc ABAP ci-dessous.

### 1.B.5 ÉTAPE 5 — CRÉER LE STATUT ET LE TITRE GUI

Créer le statut `MAIN` avec les fonctions `BACK`, `EXIT` et `CANCEL`, puis créer le titre `T100`. Les codes de fonction du statut doivent correspondre exactement aux valeurs traitées dans le `CASE` du PAI.

### 1.B.6 ÉTAPE 6 — CRÉER LA TRANSACTION

Dans `SE93`[^terme-transaction-se93], créer une transaction de dialogue qui référence le module pool et le dynpro `0100`. Enregistrer les attributs puis activer le programme, l’écran, le statut, le titre et la transaction.

### 1.B.7 ÉTAPE 7 — TESTER LE CYCLE PBO/PAI

Lancer la transaction avec un breakpoint[^terme-breakpoint] dans les deux modules. Vérifier le passage PBO, l’affichage, le passage PAI après une commande et la sortie correcte pour `BACK`, `CANCEL` et `EXIT`.

## 1.C CODE PRÊT À ADAPTER

```abap
PROGRAM zdemo_dynpro.

DATA gv_ok_code TYPE syucomm.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MAIN'.
  SET TITLEBAR 'T100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code. " Évite de retraiter la commande au prochain cycle PBO/PAI.

  CASE lv_ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
```

Logique du dynpro `0100` :

```text
PROCESS BEFORE OUTPUT.
  MODULE status_0100.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

## 1.D CONTRÔLE

- La transaction affiche l’écran `0100`.
- Les trois commandes permettent de quitter normalement.
- Le débogueur passe par PBO avant l’affichage puis par PAI après une action utilisateur.

## 1.E COMPATIBILITÉ S/4HANA

Statut : compatible, réservé au développement SAP GUI[^terme-sap-gui] classique.

[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-transaction]: **TRANSACTION.** Point d’entrée SAP associé à un code et à un objet de démarrage : programme, dynpro, méthode ou autre type pris en charge. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>).
[^terme-acro-gui]: **GUI.** Graphical User Interface. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-gui>).
[^terme-module-pool]: **MODULE POOL.** Programme ABAP classique pilotant des dynpros au moyen de modules PBO et PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-pool>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-transaction-se93]: **TRANSACTION SE93.** Objet Repository associant un code de transaction à une cible de démarrage. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#transaction-se93>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).

[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
