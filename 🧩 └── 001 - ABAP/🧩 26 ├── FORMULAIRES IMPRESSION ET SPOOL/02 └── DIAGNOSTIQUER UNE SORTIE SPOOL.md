# DIAGNOSTIQUER UNE SORTIE SPOOL

## RÉSULTAT ATTENDU

Déterminer si l’échec provient de la génération ABAP, de la requête spool, de la requête de sortie, du périphérique ou du système d’impression externe.

## PRÉREQUIS

- Numéro de requête spool ou utilisateur, date et heure de création.
- Nom du programme ou du formulaire producteur.
- Périphérique de sortie attendu.
- Autorisations d’affichage dans `SP01`.

## PROCÉDURE RAPIDE

1. Rechercher la requête dans `SP01` avec un intervalle de temps limité.
2. Relever numéro, propriétaire, titre, statut, périphérique, format, pages et taille.
3. Afficher le contenu de la requête.
4. Si le contenu est absent ou incorrect, revenir au programme ou formulaire générateur.
5. Si le contenu est correct, afficher les requêtes de sortie associées et leur journal.
6. Contrôler le périphérique, le serveur spool et la méthode d’accès avec l’équipe Basis.
7. Vérifier la file ou le service d’impression externe lorsque SAP confirme l’envoi.
8. Relancer uniquement après avoir déterminé si l’impression précédente a déjà atteint le périphérique.

## ARBRE DE DIAGNOSTIC

| Observation | Domaine probable | Action |
|---|---|---|
| Aucune requête spool | Programme ou paramètres d’impression | Vérifier appel, exceptions et destination |
| Spool vide ou contenu faux | Programme, Smart Form ou Adobe Form | Corriger la génération |
| Spool correct sans requête de sortie | Paramètres de sortie | Vérifier impression immédiate et périphérique |
| Requête de sortie en erreur | Spool/Basis | Lire le journal et contrôler le périphérique |
| Statut SAP terminé, aucune impression | Système externe | Contrôler OS, réseau, file et imprimante |
| Document imprimé deux fois | Relance sans vérification | Rechercher toutes les sorties avant relance |

## VALEURS À COMMUNIQUER À BASIS

- numéro de spool et numéro de requête de sortie ;
- date, heure, mandant et utilisateur ;
- périphérique SAP et serveur spool ;
- statut et texte complet du journal ;
- résultat de l’affichage du contenu dans SAP ;
- présence ou absence du document dans la file externe.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Recherche trop large | Filtres `SP01` insuffisants | Limiter propriétaire, date et titre |
| Mauvais diagnostic | Spool et requête de sortie confondus | Examiner séparément contenu et transmission |
| Format incohérent | Format de page incompatible | Aligner formulaire, périphérique et format |
| Relance en doublon | État externe non vérifié | Confirmer la file d’impression avant répétition |

## COMPATIBILITÉ S/4HANA

Statut : compatible pour les sorties classiques. La chaîne exacte dépend du formulaire, du périphérique et de l’architecture d’impression du système.
