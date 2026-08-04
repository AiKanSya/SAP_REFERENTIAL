# ANALYSER UN IDOC EN ERREUR

## RÉSULTAT ATTENDU

Identifier la cause exacte d’un IDoc entrant ou sortant en erreur, corriger la cause puis retraiter sans créer de doublon métier.

## PRÉREQUIS

- Numéro de l’IDoc ou intervalle précis de création.
- Sens du flux : entrant ou sortant.
- Message type, partenaire et système émetteur/récepteur attendus.
- Autorisations d’affichage `WE02`, de configuration `WE20`/`WE21` et, si nécessaire, de retraitement `BD87`.

## DONNÉES À RELEVER DANS WE02

| Zone | Valeur à relever | Utilité |
|---|---|---|
| Control record | Direction `1` ou `2` | Distinguer outbound et inbound |
| Basic type | Type IDoc | Valider la structure attendue |
| Extension | Extension client | Vérifier les segments supplémentaires |
| Message type | Message métier | Retrouver la configuration |
| Sender/receiver | Type, numéro, rôle, port | Contrôler les partenaires |
| Current status | Code et texte long | Localiser l’étape en défaut |
| Segments | Segment, occurrence, valeur | Identifier la donnée fautive |

## PROCÉDURE RAPIDE

1. Ouvrir l’IDoc dans `WE02` ou `WE05`.
2. Afficher le dernier statut en erreur et son texte long.
3. Identifier si l’erreur précède ou suit l’appel applicatif.
4. Examiner le control record et les segments sans modifier les tables techniques.
5. Pour l’outbound, contrôler le partner profile dans `WE20`, le port dans `WE21`, le process code et le modèle de distribution si ALE est utilisé.
6. Pour l’inbound, identifier dans `WE20` le process code, son mode de traitement et le module fonction ou workflow associé.
7. Corriger la donnée source, le Customizing ou le code responsable.
8. Vérifier si un document métier a déjà été créé avant tout retraitement.
9. Retraiter avec `BD87` uniquement si le statut et la procédure métier le permettent.
10. Contrôler le nouveau statut et le document métier résultant.

## CLASSER LE STATUT

Les codes exacts doivent être interprétés avec leur texte et la documentation du système. La séparation opérationnelle reste :

- erreur de génération ou de détermination du partenaire ;
- erreur de transmission ou de port ;
- IDoc reçu mais non encore traité ;
- erreur de syntaxe ou de structure IDoc ;
- erreur applicative pendant la création du document ;
- traitement terminé avec succès.

## CONTRÔLE POSITIF

- Le statut final correspond à un traitement réussi pour le sens du flux.
- Le document applicatif attendu existe une seule fois.
- La relation entre IDoc et document métier est consultable.
- Aucun IDoc parallèle du même message reste en erreur pour la même cause.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun partenaire trouvé | Profil `WE20` absent ou clé différente | Comparer type, numéro, rôle et message du control record |
| Segment inconnu | Basic type ou extension incohérent | Vérifier `WE30`, `WE31` et `WE82` |
| Erreur applicative | Donnée obligatoire absente ou Customizing incomplet | Lire le texte long et corriger la source |
| Même erreur après `BD87` | Cause non corrigée | Ne pas multiplier les retraitements |
| Doublon métier | Document créé avant l’erreur de statut | Rechercher le document avant retraitement |
| IDoc modifié directement | Intervention dans `EDIDC`, `EDID4` ou `EDIDS` | Utiliser les outils IDoc et corriger la source |

## COMPATIBILITÉ S/4HANA

Statut : compatible. Vérifier que le message et le basic type restent ceux officiellement prévus par l’application S/4HANA concernée.

## RÉFÉRENCES OFFICIELLES SAP

- [ALE Distribution — Transactions — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/erpscm/3362167812.html)
