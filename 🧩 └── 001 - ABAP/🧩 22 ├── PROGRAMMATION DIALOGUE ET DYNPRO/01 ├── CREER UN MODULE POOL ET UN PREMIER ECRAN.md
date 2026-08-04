# CRÉER UN MODULE POOL ET UN PREMIER ÉCRAN

## RÉSULTAT ATTENDU

Afficher le dynpro `0100` depuis une transaction SAP GUI et permettre sa fermeture sans bloquer l’utilisateur.

## PROCÉDURE RAPIDE

1. Créer le programme de type module pool `ZDEMO_DYNPRO` dans `SE80`.
2. Créer le dynpro `0100` avec un champ OK_CODE nommé `GV_OK_CODE`.
3. Créer un statut GUI `MAIN` contenant les fonctions `BACK`, `EXIT` et `CANCEL`.
4. Affecter une transaction de dialogue au programme et au dynpro `0100` dans `SE93`.

## CODE PRÊT À ADAPTER

```abap
PROGRAM zdemo_dynpro.

DATA gv_ok_code TYPE syucomm.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MAIN'.
  SET TITLEBAR 'T100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  DATA(lv_ok_code) = gv_ok_code.
  CLEAR gv_ok_code. "Évite de retraiter la commande au prochain cycle PBO/PAI.

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

## CONTRÔLE

- La transaction affiche l’écran `0100`.
- Les trois commandes permettent de quitter normalement.
- Le débogueur passe par PBO avant l’affichage puis par PAI après une action utilisateur.

## COMPATIBILITÉ S/4HANA

Statut : compatible, réservé au développement SAP GUI classique.
