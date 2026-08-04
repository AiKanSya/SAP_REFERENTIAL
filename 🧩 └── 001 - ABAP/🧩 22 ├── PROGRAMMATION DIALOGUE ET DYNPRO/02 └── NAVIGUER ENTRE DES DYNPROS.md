# NAVIGUER ENTRE DES DYNPROS

## RÉSULTAT ATTENDU

Ouvrir un second écran puis revenir à l’écran appelant avec une pile de dynpros maîtrisée.

## CODE PRÊT À ADAPTER

```abap
CASE lv_ok_code.
  WHEN 'DETAIL'.
    CALL SCREEN 0200. "Empile 0200 et revient ici après LEAVE TO SCREEN 0.
  WHEN 'NEXT'.
    SET SCREEN 0200.
    LEAVE SCREEN.     "Remplace l’écran suivant sans créer un appel imbriqué.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
ENDCASE.
```

## CONTRÔLE

- `CALL SCREEN` revient à l’instruction suivante après la fermeture de l’écran appelé.
- `SET SCREEN` seul ne déclenche pas immédiatement la navigation ; `LEAVE SCREEN` termine le dynpro courant.
- Éviter les appels récursifs qui agrandissent inutilement la pile de dynpros.
