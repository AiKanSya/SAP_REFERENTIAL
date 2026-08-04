# DIAGNOSTIQUER UNE SESSION `SM35`

## RÉSULTAT ATTENDU

Identifier le dynpro, le champ, la commande ou la donnée qui bloque une session batch input, puis valider une nouvelle session corrigée.

## PRÉREQUIS

- Nom de la session, utilisateur créateur et date de création.
- Transaction cible et programme qui génère la session.
- Autorisation de traiter la session dans `SM35`.
- Données métier permettant de vérifier les documents déjà créés.

## PROCÉDURE RAPIDE

1. Rechercher la session dans `SM35` avec son nom et sa date.
2. Consulter son journal avant toute nouvelle exécution.
3. Relever transaction, programme, dynpro et message du premier échec.
4. Traiter la session au premier plan pour observer l’écran exact.
5. Noter le champ positionné, le contenu transmis et le `BDC_OKCODE`.
6. Créer un nouvel enregistrement `SHDB` sur la même version S/4HANA.
7. Comparer chaque entrée `BDCDATA` avec l’enregistrement actuel.
8. Corriger le générateur, pas la table technique de la session.
9. Rechercher les documents déjà créés par les étapes réussies.
10. Générer une nouvelle session avec un petit échantillon et la traiter au premier plan.
11. Passer au mode erreur puis au traitement de fond uniquement après validation.

## DONNÉES À COMPARER

| Élément BDC | Contrôle |
|---|---|
| `PROGRAM` | Programme du dynpro actuellement affiché |
| `DYNPRO` | Numéro d’écran exact |
| `DYNBEGIN` | Première ligne de chaque écran |
| `FNAM` | Nom technique du champ ou `BDC_OKCODE` |
| `FVAL` | Valeur au format externe attendu par l’écran |

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Dynpro inattendu | Écran modifié ou branche fonctionnelle différente | Refaire `SHDB` avec les mêmes données |
| Champ inexistant | Nom technique obsolète | Relever le champ dans le nouvel enregistrement |
| Valeur non acceptée | Format date/nombre ou code externe incorrect | Transmettre le format attendu par l’écran |
| OK_CODE inconnu | Bouton ou statut GUI modifié | Relever la commande actuelle dans `SHDB` |
| Document déjà créé | Échec après sauvegarde partielle | Rechercher le résultat avant retraitement |
| Fonctionne au premier plan seulement | Popup ou message non géré | Ajouter le dynpro réel ou remplacer la technique |

## CONTRÔLE DE SORTIE

- La nouvelle session termine sans erreur sur l’échantillon.
- Chaque entrée source produit au maximum un document métier attendu.
- Les messages sont archivés avec la clé source.
- La session défaillante est conservée ou supprimée selon la procédure d’exploitation, après preuve qu’elle n’est plus nécessaire.

## COMPATIBILITÉ S/4HANA

Statut : compatible mais historique. Un changement d’écran S/4HANA peut casser la séquence ; une API ou l’outil de migration officiel doit être privilégié pour un nouveau flux.
