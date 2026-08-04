# DIAGNOSTIQUER UNE SORTIE SPOOL

## RÉSULTAT ATTENDU

Déterminer si l’échec vient du programme, de la requête spool, du périphérique ou du système d’impression.

## PROCÉDURE RAPIDE

1. Relever le numéro de requête spool dans le traitement appelant ou dans `SP01`.
2. Contrôler statut, propriétaire, périphérique, format, nombre de pages et journal d’erreur.
3. Afficher le contenu pour séparer un défaut de génération d’un défaut d’impression.
4. Vérifier la définition du périphérique et le serveur spool avec l’administration Basis.
5. Relancer uniquement après correction de la cause afin d’éviter les doublons.
