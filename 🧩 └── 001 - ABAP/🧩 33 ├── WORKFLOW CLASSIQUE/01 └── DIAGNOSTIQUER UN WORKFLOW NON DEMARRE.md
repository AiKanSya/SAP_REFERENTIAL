# DIAGNOSTIQUER UN WORKFLOW NON DÉMARRÉ

## RÉSULTAT ATTENDU

Déterminer si l’échec vient de l’événement, de son couplage, de la condition de démarrage ou de l’exécution du workflow.

## PROCÉDURE RAPIDE

1. Vérifier la configuration générale du runtime workflow.
2. Activer temporairement la trace des événements avec `SWELS` dans un environnement contrôlé.
3. Reproduire le scénario puis analyser `SWEL`.
4. Contrôler objet, événement, clé, conteneur et couplage de type.
5. Si l’événement est reçu, contrôler condition de démarrage et journal dans `SWI1`.
6. Désactiver la trace après le diagnostic.
