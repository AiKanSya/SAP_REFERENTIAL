# TESTER UN IDOC AVEC WE19

## RÉSULTAT ATTENDU

Reproduire un flux entrant ou sortant à partir d’une copie contrôlée d’un IDoc existant.

## PROCÉDURE RAPIDE

1. Sélectionner un IDoc représentatif dans `WE02`.
2. Ouvrir `WE19` et charger cet IDoc comme modèle.
3. Modifier uniquement les données nécessaires au scénario.
4. Exécuter le traitement entrant standard ou le module explicitement identifié.
5. Noter le nouvel IDoc créé et l’analyser dans `WE02`.

## SÉCURITÉ

Exécuter le test dans un système non productif. Un test IDoc peut déclencher un traitement métier réel, un appel distant ou la création d’un document applicatif.
