# ANALYSER UN IDOC EN ERREUR

## RÉSULTAT ATTENDU

Identifier la cause applicative ou technique d’un IDoc en erreur sans modifier directement ses tables techniques.

## PROCÉDURE RAPIDE

1. Ouvrir l’IDoc dans `WE02` ou `WE05`.
2. Relever type de base, extension, message, partenaire, port, process code et statut courant.
3. Lire le texte long du dernier statut en erreur.
4. Contrôler la configuration du partenaire dans `WE20` et du port dans `WE21`.
5. Pour l’inbound, identifier le module ou workflow affecté au process code.
6. Corriger la cause puis retraiter avec `BD87` lorsque le statut l’autorise.

## CONTRÔLE

- Le nouveau statut confirme le traitement fonctionnel.
- Aucun enregistrement `EDIDC`, `EDID4` ou `EDIDS` n’a été modifié directement.
- Le retraitement n’a pas créé de doublon métier.
