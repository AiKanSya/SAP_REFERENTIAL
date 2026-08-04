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

## PROCESS

### ÉTAPE 1 — ISOLER L’ENVIRONNEMENT DE TEST

Vérifier que les partenaires, ports et destinations ne peuvent pas atteindre un système productif. Utiliser des données dédiées et identifier les documents métier que le test peut créer ou modifier.

### ÉTAPE 2 — CHOISIR UN IDOC MODÈLE

Dans `WE02`, relever le numéro d’un IDoc techniquement proche, son basic type, son extension, son message type, ses partenaires et son document métier. Ne pas modifier l’IDoc original.

### ÉTAPE 3 — CRÉER LA COPIE DANS WE19

Choisir l’utilisation d’un IDoc existant, saisir son numéro et créer la copie de travail. Vérifier le control record avant toute modification de segment.

### ÉTAPE 4 — ADAPTER UNIQUEMENT LE SCÉNARIO

Modifier les champs nécessaires au cas testé en respectant longueurs, formats, hiérarchie et cardinalités. Utiliser une nouvelle clé métier lorsque le traitement interdit ou déduplique les répétitions.

### ÉTAPE 5 — EXÉCUTER LE TRAITEMENT STANDARD

Choisir le traitement inbound standard afin d’utiliser le profil partenaire et le process code réels. Exécuter une fois et relever immédiatement le numéro du nouvel IDoc.

### ÉTAPE 6 — ANALYSER LE NOUVEL IDOC

Ouvrir ce numéro dans `WE02`, lire tous les statuts et vérifier le document applicatif ou l’erreur attendue. Confirmer que le modèle original est resté inchangé.

### ÉTAPE 7 — CONTRÔLER LES EFFETS ET NETTOYER

Rechercher les documents, mises à jour, messages sortants et appels externes produits. Appliquer la procédure de suppression ou d’annulation des données de test sans modifier les tables IDoc directement.

## ISOLER UN MODULE INBOUND IDENTIFIÉ

L’appel direct d’un module contourne une partie de la détermination standard. L’utiliser uniquement pour isoler le code après avoir prouvé que le partner profile et le process code sont corrects.

### ÉTAPE 1 — IDENTIFIER LE MODULE

Relever le module depuis le process code configuré dans le système, puis confirmer sa signature et son rôle avant l’appel direct.

### ÉTAPE 2 — REJOUER LE MÊME CONTENU

Choisir dans `WE19` l’option d’appel adaptée et utiliser exactement les données du test standard afin que la comparaison reste exploitable.

### ÉTAPE 3 — COMPARER LES DEUX CHEMINS

Si l’appel direct réussit alors que le traitement standard échoue, concentrer le diagnostic sur le profil partenaire, le process code ou le couplage. Si les deux échouent de la même façon, analyser la logique applicative ou les données.

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
