# 1. ANALYSER UN OBJET D’ARCHIVAGE AVEC `SARA`

## 1.A RÉSULTAT ATTENDU

Déterminer comment un objet d’archivage sélectionne, écrit, vérifie puis supprime les données avant toute exécution productive.

## 1.B PRÉREQUIS

- Nom exact de l’objet d’archivage.
- Règles métier de résidence et de conservation validées.
- Accès à `SARA` et aux journaux de jobs/spool.
- Environnement de test contenant des données vérifiables.

## 1.C ÉLÉMENTS À RELEVER DANS SARA

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

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — LIRE LE CONTRAT DE L’OBJET

Ouvrir l’objet dans `SARA` et lire sa documentation complète. Relever les tables couvertes, les dépendances, les règles de résidence, les statuts métier et l’ordre des programmes.

### 1.D.2 ÉTAPE 2 — EXAMINER LE CUSTOMIZING

Contrôler les paramètres, les variantes, le stockage, les structures d’information et les objets dépendants. Ne pas réutiliser une variante existante sans vérifier sa sélection et son propriétaire.

### 1.D.3 ÉTAPE 3 — ANALYSER LES SESSIONS ANTÉRIEURES

Relever pour les dernières sessions le statut, le fichier d’archive, le job, le spool, les journaux et l’état de suppression. Une écriture terminée ne signifie pas que les données ont déjà été supprimées.

### 1.D.4 ÉTAPE 4 — DÉFINIR UN ÉCHANTILLON TRAÇABLE

Choisir un petit ensemble de clés métier dont l’état en base et les dépendances sont connus. Documenter le nombre attendu avant toute exécution.

### 1.D.5 ÉTAPE 5 — EXÉCUTER LE TEST D’ÉCRITURE

Lancer le mode test lorsqu’il existe et analyser chaque objet sélectionné ou rejeté. Corriger les règles de résidence, statuts ou dépendances avant l’écriture réelle.

### 1.D.6 ÉTAPE 6 — CRÉER LE FICHIER D’ARCHIVE

Exécuter le programme d’écriture en environnement de test. Vérifier le job, le journal, le nombre d’objets et le stockage effectif du fichier.

### 1.D.7 ÉTAPE 7 — TESTER LA LECTURE AVANT SUPPRESSION

Utiliser l’outil de lecture ou l’Archive Information System prévu par l’objet. Confirmer que les clés de l’échantillon sont consultables dans le fichier produit.

### 1.D.8 ÉTAPE 8 — AUTORISER ET EXÉCUTER LA SUPPRESSION

Lancer le programme de suppression uniquement après validation formelle du fichier, de la lecture et du journal. Conserver la variante et la preuve d’autorisation selon la gouvernance du système.

### 1.D.9 ÉTAPE 9 — CONTRÔLER L’ÉTAT FINAL

Vérifier l’absence des données dans les tables actives, leur présence dans l’archive, leur accessibilité fonctionnelle et l’absence d’objet dépendant incohérent.

## 1.E CONTRÔLE AVANT SUPPRESSION

- job d’écriture terminé sans erreur ;
- nombre d’objets attendu cohérent avec la sélection ;
- fichier d’archive enregistré dans le stockage prévu ;
- lecture de contrôle réussie ;
- aucun objet dépendant bloquant oublié ;
- autorisation d’exécuter la suppression obtenue selon la gouvernance du système.

## 1.F ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun objet sélectionné | Résidence non atteinte ou statut métier invalide | Lire le journal de sélection et le Customizing |
| Objets rejetés | Dépendances encore actives | Identifier les objets liés dans la documentation |
| Écriture réussie, lecture impossible | Structure d’information ou accès non préparé | Configurer et tester la lecture avant suppression |
| Suppression non lancée | Fichier non validé ou job non planifié | Contrôler le statut de session et les variantes |
| Données métier encore visibles | Lecture transparente des archives | Vérifier physiquement la source de lecture avant de conclure |

## 1.G SÉCURITÉ

Ne jamais supprimer directement les tables métier pour reproduire le programme de suppression. L’objet d’archivage porte les contrôles de cohérence et l’ordre de traitement.

## 1.H COMPATIBILITÉ S/4HANA

Statut : compatible pour les objets d’archivage disponibles dans la version S/4HANA cible. Vérifier la documentation spécifique de chaque objet et les éventuels changements de modèle de données.
