# TRACER UNE MODIFICATION AVEC SCDO

## RÉSULTAT ATTENDU

Créer un document de modification contenant l’auteur, l’horodatage, la transaction et les valeurs anciennes/nouvelles d’un objet métier client.

## PRÉREQUIS

- Tables et clés de l’objet métier stabilisées dans le Dictionnaire ABAP.
- Champs à tracer identifiés avec le responsable fonctionnel.
- Indicateur de document de modification activé sur les éléments de données concernés.
- Objet de modification client créé dans `SCDO`.

## PROCÉDURE RAPIDE

1. Dans `SE11`, vérifier l’indicateur de document de modification sur chaque élément de données à tracer.
2. Ouvrir `SCDO` et créer l’objet `Z...`.
3. Affecter les tables en respectant la table racine et les relations de clés.
4. Générer les objets de mise à jour.
5. Ouvrir dans `SE37` le module généré dont le nom se termine par `_WRITE_DOCUMENT`.
6. Insérer son modèle d’appel dans le service de sauvegarde.
7. Alimenter l’identifiant d’objet, la transaction, les tables anciennes et nouvelles et les indicateurs de modification exigés par la signature.
8. Appeler le module dans la même LUW que la modification métier.
9. Sauvegarder, puis rechercher le document de modification produit.

## POURQUOI LE CODE N’EST PAS GÉNÉRIQUE

La signature est produite depuis les tables déclarées dans l’objet `SCDO`. Les noms et types des paramètres varient donc selon l’objet. Un exemple inventant ces paramètres serait non compilable.

Utiliser ce fragment uniquement comme emplacement d’intégration :

```abap
"La modification métier et le document de modification appartiennent à la même LUW.
UPDATE zdemo_header FROM @ls_header_new.
IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH ls_header_new-id.
ENDIF.

"Insérer ici le modèle exact du module Z..._WRITE_DOCUMENT généré par SCDO.
"Fournir les images ancienne et nouvelle déjà conservées par le service appelant.
```

## DONNÉES À CONSERVER AVANT L’UPDATE

- image complète avant modification ;
- image complète après modification ;
- clé stable de l’objet ;
- indicateur d’insertion, modification ou suppression ;
- transaction ou contexte applicatif ;
- utilisateur et date/heure, sauf lorsqu’ils sont déterminés par l’API générée.

## CONTRÔLE POSITIF

1. Modifier un seul champ marqué.
2. Vérifier qu’un document est créé pour la bonne clé.
3. Contrôler que l’ancienne et la nouvelle valeur sont correctes.
4. Vérifier auteur, date, heure et transaction.

## CONTRÔLE NÉGATIF

- Sauvegarder sans changement : aucune position artificielle ne doit être créée.
- Modifier un champ non marqué : il ne doit pas apparaître comme champ tracé.
- Provoquer un rollback métier : le document de modification ne doit pas survivre seul.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun détail de champ | Indicateur absent sur l’élément de données | Activer puis régénérer selon la procédure projet |
| Ancienne valeur identique à la nouvelle | Image ancienne écrasée avant l’appel | Lire et conserver l’état initial avant modification |
| Document sans positions | Indicateurs de modification mal alimentés | Utiliser la signature et les structures générées |
| Trace créée après rollback | LUW séparée ou commit incorrect | Garder écriture métier et trace dans la même LUW |
| Erreur après évolution DDIC | Génération SCDO obsolète | Régénérer et adapter tous les appelants |

## COMPATIBILITÉ S/4HANA

Statut : compatible pour les objets classiques. Vérifier d’abord si l’objet standard possède déjà son propre mécanisme de journalisation.
