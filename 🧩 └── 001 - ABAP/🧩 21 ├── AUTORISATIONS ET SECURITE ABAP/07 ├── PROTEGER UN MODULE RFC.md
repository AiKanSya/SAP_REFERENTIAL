# PROTÉGER UN MODULE RFC

## RÉSULTAT ATTENDU

Appliquer les contrôles techniques et métier dans le module appelé, indépendamment de la confiance accordée à la destination RFC.

## CONTRÔLES À IMPLÉMENTER

1. Déclarer le module RFC uniquement si l’appel distant est requis.
2. Utiliser des types d’interface compatibles RFC.
3. Valider format, longueur, domaine et volume de chaque entrée.
4. Exécuter les `AUTHORITY-CHECK` métier dans le système cible.
5. Ne pas accepter un nom d’objet exécutable arbitraire.
6. Retourner des erreurs explicites sans divulguer de données sensibles.
7. Vérifier les autorisations RFC et la configuration `SM59` avec les équipes sécurité et Basis.

## CONTRÔLE

Tester avec l’utilisateur réellement configuré sur la destination, pas seulement avec un compte développeur disposant de droits étendus.
