# SÉCURISER LES FICHIERS SUR LE SERVEUR

## RÉSULTAT ATTENDU

Limiter une lecture ou écriture applicative aux chemins logiques autorisés et aux contrôles d’autorisation du système.

## PROCÉDURE RAPIDE

1. Définir un nom et un chemin logiques avec `FILE`.
2. Résoudre le fichier physique au moyen des API standard de noms de fichiers logiques.
3. Vérifier l’objet d’autorisation applicable au scénario et à l’installation.
4. Utiliser `OPEN DATASET` uniquement sur le chemin résolu.
5. Traiter chaque valeur de `SY-SUBRC` et fermer le dataset.

## CONTRÔLE

- Aucun chemin fourni par l’utilisateur n’est concaténé directement.
- Le fichier reste dans le répertoire autorisé après résolution.
- Le programme ne journalise ni secret ni contenu personnel inutile.
