# ANALYSER UN OBJET D’ARCHIVAGE AVEC `SARA`

## RÉSULTAT ATTENDU

Déterminer comment un objet d’archivage sélectionne, écrit, vérifie puis supprime les données avant toute exécution productive.

## PRÉREQUIS

- Nom exact de l’objet d’archivage.
- Règles métier de résidence et de conservation validées.
- Accès à `SARA` et aux journaux de jobs/spool.
- Environnement de test contenant des données vérifiables.

## ÉLÉMENTS À RELEVER DANS SARA

| Élément | Question à résoudre |
|---|---|
| Documentation | Quelles données et dépendances sont couvertes ? |
| Customizing | Quelles règles de résidence et variantes s’appliquent ? |
| Prétraitement | Un statut doit-il être préparé avant écriture ? |
| Programme d’écriture | Quelles données sont placées dans le fichier archive ? |
| Programme de suppression | Quand les données en base sont-elles supprimées ? |
| Post-traitement | Quelles opérations suivent la suppression ? |
| Lecture | Comment l’utilisateur retrouve-t-il une donnée archivée ? |
| Information structure | Quelle recherche Archive Information System est disponible ? |

## PROCÉDURE RAPIDE

1. Ouvrir l’objet dans `SARA` et lire sa documentation complète.
2. Examiner le Customizing et les dépendances avec d’autres objets.
3. Identifier tous les programmes associés et leurs variantes existantes.
4. Contrôler les sessions antérieures : statut, fichier, job, spool et journal.
5. Définir un périmètre de test minimal dont les clés métier sont connues.
6. Exécuter d’abord le mode test du programme d’écriture lorsqu’il existe.
7. Exécuter l’écriture réelle dans le système de test.
8. Vérifier le fichier et le journal avant toute suppression.
9. Tester l’affichage ou la lecture des objets archivés.
10. Exécuter la suppression uniquement après validation formelle du fichier.
11. Vérifier l’absence en base, la présence dans l’archive et l’accès fonctionnel.

## CONTRÔLE AVANT SUPPRESSION

- job d’écriture terminé sans erreur ;
- nombre d’objets attendu cohérent avec la sélection ;
- fichier d’archive enregistré dans le stockage prévu ;
- lecture de contrôle réussie ;
- aucun objet dépendant bloquant oublié ;
- autorisation d’exécuter la suppression obtenue selon la gouvernance du système.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun objet sélectionné | Résidence non atteinte ou statut métier invalide | Lire le journal de sélection et le Customizing |
| Objets rejetés | Dépendances encore actives | Identifier les objets liés dans la documentation |
| Écriture réussie, lecture impossible | Structure d’information ou accès non préparé | Configurer et tester la lecture avant suppression |
| Suppression non lancée | Fichier non validé ou job non planifié | Contrôler le statut de session et les variantes |
| Données métier encore visibles | Lecture transparente des archives | Vérifier physiquement la source de lecture avant de conclure |

## SÉCURITÉ

Ne jamais supprimer directement les tables métier pour reproduire le programme de suppression. L’objet d’archivage porte les contrôles de cohérence et l’ordre de traitement.

## COMPATIBILITÉ S/4HANA

Statut : compatible pour les objets d’archivage disponibles dans la version S/4HANA cible. Vérifier la documentation spécifique de chaque objet et les éventuels changements de modèle de données.
