# 2. DIAGNOSTIQUER UNE SORTIE SPOOL

## 2.A RÉSULTAT ATTENDU

Déterminer si l’échec provient de la génération ABAP, de la requête spool, de la requête de sortie, du périphérique ou du système d’impression externe.

## 2.B PRÉREQUIS

- Numéro de requête spool ou utilisateur, date et heure de création.
- Nom du programme ou du formulaire producteur.
- Périphérique de sortie attendu.
- Autorisations d’affichage dans `SP01`.

## 2.C PROCESS

### 2.C.1 ÉTAPE 1 — RECHERCHER LA REQUÊTE DANS SP01

Limiter la sélection à l’utilisateur, au programme, au titre et à l’intervalle du test. Relever le numéro de spool, le propriétaire, le statut, le périphérique, le format, le nombre de pages et la taille.

### 2.C.2 ÉTAPE 2 — VÉRIFIER LE CONTENU GÉNÉRÉ

Afficher le contenu dans SAP. S’il est absent, incomplet ou incorrect, revenir au programme, au Smart Form ou au formulaire Adobe avant d’analyser l’infrastructure d’impression.

### 2.C.3 ÉTAPE 3 — EXAMINER LES REQUÊTES DE SORTIE

Si le contenu est correct, ouvrir les requêtes de sortie associées. Relever leur statut, leur heure, leur tentative, leur périphérique et le texte complet du journal.

### 2.C.4 ÉTAPE 4 — CONTRÔLER LA CONFIGURATION SAP

Avec l’équipe Basis, vérifier le périphérique, le serveur spool, le format de page et la méthode d’accès. Comparer ces valeurs à une sortie réussie utilisant la même chaîne d’impression.

### 2.C.5 ÉTAPE 5 — SUIVRE LA SORTIE HORS DE SAP

Lorsque SAP indique que la requête a été transmise, rechercher le document dans la file du système d’exploitation, du serveur d’impression ou du prestataire externe avec l’identifiant et l’heure relevés.

### 2.C.6 ÉTAPE 6 — DÉCIDER DE LA RELANCE

Ne répéter l’impression qu’après avoir déterminé si la tentative précédente a déjà atteint le périphérique. Une relance sans contrôle peut produire un doublon physique malgré un statut SAP ambigu.

### 2.C.7 ÉTAPE 7 — VALIDER LE RETOUR À LA NORMALE

Relancer une seule sortie contrôlée, confirmer le nouveau statut, l’absence de doublon et la réception physique. Conserver les numéros de spool et de sortie comme preuve du diagnostic.

## 2.D ARBRE DE DIAGNOSTIC

| Observation | Domaine probable | Action |
|---|---|---|
| Aucune requête spool | Programme ou paramètres d’impression | Vérifier appel, exceptions et destination |
| Spool vide ou contenu faux | Programme, Smart Form ou Adobe Form | Corriger la génération |
| Spool correct sans requête de sortie | Paramètres de sortie | Vérifier impression immédiate et périphérique |
| Requête de sortie en erreur | Spool/Basis | Lire le journal et contrôler le périphérique |
| Statut SAP terminé, aucune impression | Système externe | Contrôler OS, réseau, file et imprimante |
| Document imprimé deux fois | Relance sans vérification | Rechercher toutes les sorties avant relance |

## 2.E VALEURS À COMMUNIQUER À BASIS

- numéro de spool et numéro de requête de sortie ;
- date, heure, mandant et utilisateur ;
- périphérique SAP et serveur spool ;
- statut et texte complet du journal ;
- résultat de l’affichage du contenu dans SAP ;
- présence ou absence du document dans la file externe.

## 2.F ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Recherche trop large | Filtres `SP01` insuffisants | Limiter propriétaire, date et titre |
| Mauvais diagnostic | Spool et requête de sortie confondus | Examiner séparément contenu et transmission |
| Format incohérent | Format de page incompatible | Aligner formulaire, périphérique et format |
| Relance en doublon | État externe non vérifié | Confirmer la file d’impression avant répétition |

## 2.G COMPATIBILITÉ S/4HANA

Statut : compatible pour les sorties classiques. La chaîne exacte dépend du formulaire, du périphérique et de l’architecture d’impression du système.
