# 2. TRACER UNE MODIFICATION AVEC SCDO

## 2.A RÉSULTAT ATTENDU

Créer un document de modification contenant l’auteur, l’horodatage, la transaction et les valeurs anciennes/nouvelles d’un objet métier client.

## 2.B PRÉREQUIS

- Tables et clés de l’objet métier stabilisées dans le Dictionnaire ABAP.
- Champs à tracer identifiés avec le responsable fonctionnel.
- Indicateur de document de modification activé sur les éléments de données concernés.
- Objet de modification client créé dans `SCDO`.

## 2.C PROCESS

### 2.C.1 ÉTAPE 1 — IDENTIFIER LES CHAMPS À TRACER

Avec le responsable fonctionnel, lister les créations, modifications et suppressions devant produire une trace. Dans `SE11`, vérifier l’indicateur de document de modification sur l’élément de données de chaque champ retenu.

### 2.C.2 ÉTAPE 2 — CRÉER L’OBJET DANS SCDO

Créer l’objet client dans `SCDO`. Déclarer la table racine, les tables dépendantes et leurs relations de clés sans ajouter de table étrangère au périmètre métier.

### 2.C.3 ÉTAPE 3 — GÉNÉRER LES OBJETS TECHNIQUES

Lancer la génération depuis `SCDO`, activer les objets produits et examiner le journal. Régénérer après toute évolution DDIC qui modifie les tables ou champs suivis.

### 2.C.4 ÉTAPE 4 — RELEVER LA SIGNATURE RÉELLE

Ouvrir dans `SE37` le module généré dont le nom se termine par `_WRITE_DOCUMENT`. Insérer son modèle d’appel dans le service de sauvegarde ; les paramètres varient selon les tables déclarées et ne doivent pas être inventés.

### 2.C.5 ÉTAPE 5 — CONSERVER LES IMAGES AVANT ET APRÈS

Lire l’état initial avant de le modifier et le conserver dans une structure distincte. Préparer ensuite l’état final et les indicateurs d’insertion, modification ou suppression attendus par la signature générée.

### 2.C.6 ÉTAPE 6 — APPELER LE MODULE DANS LA MÊME LUW

Après validation de l’écriture métier, appeler le module généré avec la clé stable, le contexte de transaction et les images ancienne et nouvelle. Ne pas déclencher un commit séparé pour le document de modification.

### 2.C.7 ÉTAPE 7 — TESTER COMMIT ET ROLLBACK

Créer un changement réel, vérifier la trace et ses positions, puis provoquer un rollback contrôlé. Le document de modification ne doit pas survivre seul à l’annulation de l’écriture métier.

### 2.C.8 ÉTAPE 8 — CONTRÔLER LA CONSULTATION

Rechercher la trace par clé métier et vérifier l’auteur, l’horodatage, la transaction, l’ancien contenu et le nouveau contenu. Tester aussi un champ non marqué et une sauvegarde sans changement.

## 2.D POURQUOI LE CODE N’EST PAS GÉNÉRIQUE

La signature est produite depuis les tables déclarées dans l’objet `SCDO`. Les noms et types des paramètres varient donc selon l’objet. Un exemple inventant ces paramètres serait non compilable.

Utiliser ce fragment uniquement comme emplacement d’intégration :

```abap
" La modification métier et le document de modification appartiennent à la même LUW.
UPDATE zdemo_header FROM @ls_header_new.
IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH ls_header_new-id.
ENDIF.

" Insérer ici le modèle exact du module Z..._WRITE_DOCUMENT généré par SCDO.
" Fournir les images ancienne et nouvelle déjà conservées par le service appelant.
```

## 2.E DONNÉES À CONSERVER AVANT L’UPDATE

- image complète avant modification ;
- image complète après modification ;
- clé stable de l’objet ;
- indicateur d’insertion, modification ou suppression ;
- transaction ou contexte applicatif ;
- utilisateur et date/heure, sauf lorsqu’ils sont déterminés par l’API générée.

## 2.F CONTRÔLE POSITIF

1. Modifier un seul champ marqué.
2. Vérifier qu’un document est créé pour la bonne clé.
3. Contrôler que l’ancienne et la nouvelle valeur sont correctes.
4. Vérifier auteur, date, heure et transaction.

## 2.G CONTRÔLE NÉGATIF

- Sauvegarder sans changement : aucune position artificielle ne doit être créée.
- Modifier un champ non marqué : il ne doit pas apparaître comme champ tracé.
- Provoquer un rollback métier : le document de modification ne doit pas survivre seul.

## 2.H ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun détail de champ | Indicateur absent sur l’élément de données | Activer puis régénérer selon la procédure projet |
| Ancienne valeur identique à la nouvelle | Image ancienne écrasée avant l’appel | Lire et conserver l’état initial avant modification |
| Document sans positions | Indicateurs de modification mal alimentés | Utiliser la signature et les structures générées |
| Trace créée après rollback | LUW séparée ou commit incorrect | Garder écriture métier et trace dans la même LUW |
| Erreur après évolution DDIC | Génération SCDO obsolète | Régénérer et adapter tous les appelants |

## 2.I COMPATIBILITÉ S/4HANA

Statut : compatible pour les objets classiques. Vérifier d’abord si l’objet standard possède déjà son propre mécanisme de journalisation.
