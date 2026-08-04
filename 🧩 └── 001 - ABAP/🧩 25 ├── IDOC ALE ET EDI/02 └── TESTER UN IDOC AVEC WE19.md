# TESTER UN IDOC AVEC WE19

## RÉSULTAT ATTENDU

Créer une copie de test d’un IDoc représentatif, modifier les données du scénario puis exécuter le traitement entrant ou sortant en conservant la preuve du nouvel IDoc.

## PRÉREQUIS

- Système de développement ou de test isolé.
- IDoc modèle techniquement proche du scénario.
- Connaissance du basic type, de l’extension, du message type et du process code.
- Données métier de test sans impact productif.

## RISQUE

`WE19` peut appeler le traitement applicatif réel. Un test entrant peut créer ou modifier un document ; un test sortant peut transmettre un message à un système connecté. Ne pas l’utiliser en production pour une expérimentation.

## PROCÉDURE — TEST INBOUND STANDARD

1. Relever dans `WE02` le numéro de l’IDoc modèle et son document métier.
2. Ouvrir `WE19` et choisir l’utilisation d’un IDoc existant comme modèle.
3. Saisir le numéro puis créer la copie de travail.
4. Vérifier le control record : message type, basic type, extension, émetteur et récepteur.
5. Modifier uniquement les segments nécessaires au scénario.
6. Utiliser une nouvelle clé métier lorsque le traitement n’accepte pas les doublons.
7. Choisir le traitement entrant standard afin d’utiliser la configuration réelle du partner profile.
8. Exécuter et relever le numéro du nouvel IDoc.
9. Ouvrir ce nouvel IDoc dans `WE02` et lire tous ses statuts.
10. Contrôler le document applicatif créé ou l’erreur attendue.

## PROCÉDURE — TESTER UN MODULE INBOUND IDENTIFIÉ

L’appel direct d’un module contourne une partie de la détermination standard. L’utiliser uniquement pour isoler le code après avoir prouvé que le partner profile et le process code sont corrects.

1. Identifier le module depuis le process code configuré.
2. Choisir dans `WE19` l’option d’appel adaptée.
3. Exécuter avec le même contenu que le test standard.
4. Comparer les résultats afin de séparer configuration et logique applicative.

## POINTS À MODIFIER

| Élément | Règle |
|---|---|
| Clé métier | Utiliser une valeur dédiée au test |
| Dates | Respecter le format du segment |
| Partenaire | Ne modifier que si le scénario le teste |
| Extension | Doit être compatible avec le basic type |
| Segments | Respecter hiérarchie, cardinalité et longueurs |

## CONTRÔLE

- Le nouvel IDoc possède un numéro différent du modèle.
- Le modèle original n’est pas modifié.
- Les statuts correspondent au chemin exécuté.
- Le document métier ou le message d’erreur attendu est observable.
- Aucun appel n’a été envoyé vers un système productif.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Doublon refusé | Clé du modèle réutilisée | Remplacer la clé métier dans les segments concernés |
| Segment ignoré | Hiérarchie ou extension incorrecte | Comparer avec `WE30` et `WE60` |
| Test direct réussi, standard en échec | Configuration partenaire/process code | Vérifier `WE20` et le process code |
| Message envoyé hors du système | Port réel conservé pour un outbound | Isoler la destination avant le test |
| Résultat différent du flux réel | Option `WE19` contournant la détermination | Répéter avec le traitement standard |

## COMPATIBILITÉ S/4HANA

Statut : outil classique compatible pour tester les IDocs encore supportés par le processus S/4HANA cible.

## RÉFÉRENCE OFFICIELLE SAP

- [ALE Business Process — SAP Help Portal](https://help.sap.com/docs/en/home/3361892122.html)
