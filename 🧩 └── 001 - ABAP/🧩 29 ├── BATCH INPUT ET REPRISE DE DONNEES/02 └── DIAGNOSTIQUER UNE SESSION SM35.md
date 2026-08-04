# DIAGNOSTIQUER UNE SESSION `SM35`

## RÉSULTAT ATTENDU

Identifier l’écran, le champ ou la donnée qui bloque une session batch input.

## PROCÉDURE RAPIDE

1. Sélectionner la session en erreur dans `SM35`.
2. Exécuter son analyse ou son traitement au premier plan.
3. Relever programme, dynpro, champ, OK_CODE et message exacts.
4. Comparer la séquence avec un nouvel enregistrement `SHDB` sur la même version.
5. Corriger le générateur de `BDCDATA`, créer une nouvelle session puis archiver la session obsolète selon les règles du projet.
