# 2. NAVIGUER ENTRE DES DYNPROS

## 2.A RÉSULTAT ATTENDU

Choisir entre appel empilé, remplacement de l’écran suivant et retour à l’appelant sans créer de boucle ou de pile de dynpros incontrôlée.

## 2.B PRÉREQUIS

- Dynpros `0100` et `0200` créés dans le même programme.
- Champ OK_CODE déclaré et affecté à chaque écran.
- Fonctions `DETAIL`, `NEXT` et `BACK` présentes dans le statut GUI[^terme-acro-gui].

## 2.C PROCESS

### 2.C.1 ÉTAPE 1 — DESSINER LE PARCOURS DES ÉCRANS

Lister pour chaque commande l’écran source, l’écran cible et le retour attendu. Choisir un appel empilé uniquement lorsque l’utilisateur doit revenir au point qui suit `CALL SCREEN`.

### 2.C.2 ÉTAPE 2 — PRÉPARER LES STATUTS GUI

Créer les fonctions `DETAIL`, `NEXT`, `BACK`, `CANCEL` et `EXIT` dans les statuts concernés. Vérifier que le champ OK_CODE de chaque dynpro[^terme-dynpro] alimente la variable traitée dans son module PAI.

### 2.C.3 ÉTAPE 3 — IMPLÉMENTER L’APPEL EMPILÉ

Pour ouvrir le détail `0200` puis reprendre le traitement de `0100`, utiliser `CALL SCREEN 0200`. Dans `0200`, exécuter `LEAVE TO SCREEN 0` pour revenir à l’appelant.

### 2.C.4 ÉTAPE 4 — IMPLÉMENTER LE REMPLACEMENT D’ÉCRAN

Pour terminer immédiatement `0100` et poursuivre sur `0200`, exécuter `SET SCREEN 0200` puis `LEAVE SCREEN`. Ne pas utiliser `CALL SCREEN` si aucun retour sur la ligne suivante n’est attendu.

### 2.C.5 ÉTAPE 5 — TRAITER LES COMMANDES DE SORTIE

Copier `GV_OK_CODE` dans une variable locale, vider immédiatement la variable globale puis traiter la copie. Utiliser `LEAVE TO SCREEN 0` pour fermer le niveau courant et `LEAVE PROGRAM` uniquement pour terminer l’application.

### 2.C.6 ÉTAPE 6 — ACTIVER ET TESTER LA PILE

Activer les deux dynpros, leurs flux, statuts et modules. Poser des breakpoints PBO/PAI, exécuter plusieurs cycles `DETAIL`/`BACK` puis `NEXT`/`BACK` et vérifier que la pile ne croît pas à chaque navigation.

## 2.D CODE PRÊT À ADAPTER

```abap
MODULE user_command_0100 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code.

  CASE lv_ok_code.
    WHEN 'DETAIL'.
      " Empile 0200 ; son retour reprend après CALL SCREEN.
      CALL SCREEN 0200.

    WHEN 'NEXT'.
      " Définit le prochain écran puis termine immédiatement 0100.
      SET SCREEN 0200.
      LEAVE SCREEN.

    WHEN 'BACK'.
      " Retourne à l’écran qui a appelé le dynpro courant.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code.

  CASE lv_ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
```

## 2.E CHOISIR LA BONNE INSTRUCTION

| Besoin | Instruction | Effet |
|---|---|---|
| Ouvrir un détail puis revenir | `CALL SCREEN 0200` | Ajoute un niveau à la pile |
| Remplacer le prochain écran | `SET SCREEN 0200` puis `LEAVE SCREEN` | Termine le dynpro courant |
| Revenir à l’appelant | `LEAVE TO SCREEN 0` | Ferme le niveau courant |
| Terminer l’application | `LEAVE PROGRAM` | Quitte le programme sans retour |

## 2.F CONTRÔLE

1. Poser un breakpoint[^terme-breakpoint] dans chaque module PBO et PAI.
2. Tester `DETAIL` : après `BACK` sur `0200`, l’exécution reprend après `CALL SCREEN`.
3. Tester `NEXT` : `0100` n’est pas ajouté comme nouvel appel.
4. Tester plusieurs allers-retours et vérifier l’absence de boucle.
5. Vérifier que `GV_OK_CODE` est vidé après copie.

## 2.G ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Même commande retraitée | OK_CODE non vidé | Copier puis `CLEAR GV_OK_CODE` au début du PAI |
| Écran impossible à quitter | Fonctions retour absentes du statut | Ajouter et traiter `BACK`, `EXIT`, `CANCEL` |
| Retour au mauvais écran | `CALL SCREEN` imbriqués inutilement | Réserver l’appel empilé au détail modal/logique |
| `SET SCREEN` semble sans effet | Dynpro courant non terminé | Ajouter `LEAVE SCREEN` si navigation immédiate requise |

## 2.H COMPATIBILITÉ S/4HANA

Statut : compatible pour les transactions SAP GUI[^terme-sap-gui] classiques.

[^terme-acro-gui]: **GUI.** Graphical User Interface. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-gui>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
