# NAVIGUER ENTRE DES DYNPROS

## RÉSULTAT ATTENDU

Choisir entre appel empilé, remplacement de l’écran suivant et retour à l’appelant sans créer de boucle ou de pile de dynpros incontrôlée.

## PRÉREQUIS

- Dynpros `0100` et `0200` créés dans le même programme.
- Champ OK_CODE déclaré et affecté à chaque écran.
- Fonctions `DETAIL`, `NEXT` et `BACK` présentes dans le statut GUI.

## CODE PRÊT À ADAPTER

```abap
MODULE user_command_0100 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code.

  CASE lv_ok_code.
    WHEN 'DETAIL'.
      "Empile 0200 ; son retour reprend après CALL SCREEN.
      CALL SCREEN 0200.

    WHEN 'NEXT'.
      "Définit le prochain écran puis termine immédiatement 0100.
      SET SCREEN 0200.
      LEAVE SCREEN.

    WHEN 'BACK'.
      "Retourne à l’écran qui a appelé le dynpro courant.
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

## CHOISIR LA BONNE INSTRUCTION

| Besoin | Instruction | Effet |
|---|---|---|
| Ouvrir un détail puis revenir | `CALL SCREEN 0200` | Ajoute un niveau à la pile |
| Remplacer le prochain écran | `SET SCREEN 0200` puis `LEAVE SCREEN` | Termine le dynpro courant |
| Revenir à l’appelant | `LEAVE TO SCREEN 0` | Ferme le niveau courant |
| Terminer l’application | `LEAVE PROGRAM` | Quitte le programme sans retour |

## CONTRÔLE

1. Poser un breakpoint dans chaque module PBO et PAI.
2. Tester `DETAIL` : après `BACK` sur `0200`, l’exécution reprend après `CALL SCREEN`.
3. Tester `NEXT` : `0100` n’est pas ajouté comme nouvel appel.
4. Tester plusieurs allers-retours et vérifier l’absence de boucle.
5. Vérifier que `GV_OK_CODE` est vidé après copie.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Même commande retraitée | OK_CODE non vidé | Copier puis `CLEAR GV_OK_CODE` au début du PAI |
| Écran impossible à quitter | Fonctions retour absentes du statut | Ajouter et traiter `BACK`, `EXIT`, `CANCEL` |
| Retour au mauvais écran | `CALL SCREEN` imbriqués inutilement | Réserver l’appel empilé au détail modal/logique |
| `SET SCREEN` semble sans effet | Dynpro courant non terminé | Ajouter `LEAVE SCREEN` si navigation immédiate requise |

## COMPATIBILITÉ S/4HANA

Statut : compatible pour les transactions SAP GUI classiques.
