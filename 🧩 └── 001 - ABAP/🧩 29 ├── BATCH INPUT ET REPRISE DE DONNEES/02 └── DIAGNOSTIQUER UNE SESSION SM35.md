# 2. DIAGNOSTIQUER UNE SESSION `SM35`

## 2.A RÉSULTAT ATTENDU

Identifier le dynpro, le champ, la commande ou la donnée qui bloque une session batch input, puis valider une nouvelle session corrigée.

## 2.B PRÉREQUIS

- Nom de la session, utilisateur créateur et date de création.
- Transaction cible et programme qui génère la session.
- Autorisation de traiter la session dans `SM35`.
- Données métier permettant de vérifier les documents déjà créés.

## 2.C PROCESS

### 2.C.1 ÉTAPE 1 — IDENTIFIER LA SESSION

Rechercher dans `SM35` le nom, l’utilisateur créateur et la date attendus. Relever son statut, le nombre de transactions et l’heure du dernier traitement.

### 2.C.2 ÉTAPE 2 — LIRE LE JOURNAL AVANT TOUTE RELANCE

Ouvrir le journal et identifier le premier échec. Relever la transaction, le programme, le dynpro, le message complet et la clé source correspondante.

### 2.C.3 ÉTAPE 3 — REJOUER AU PREMIER PLAN

Traiter uniquement l’entrée concernée au premier plan. Observer l’écran exact, le champ positionné, la valeur transmise, les popups éventuels et le `BDC_OKCODE` refusé.

### 2.C.4 ÉTAPE 4 — PRODUIRE UN NOUVEL ENREGISTREMENT SHDB

Enregistrer le même scénario et les mêmes données sur la version S/4HANA cible. Comparer chaque `PROGRAM`, `DYNPRO`, `FNAM`, `FVAL` et marqueur `DYNBEGIN` avec le générateur actuel.

### 2.C.5 ÉTAPE 5 — CORRIGER LE GÉNÉRATEUR

Adapter le programme qui construit `BDCDATA`, les conversions externes ou la branche fonctionnelle. Ne pas modifier directement les tables techniques de la session défaillante.

### 2.C.6 ÉTAPE 6 — RECHERCHER LES SUCCÈS PARTIELS

Contrôler les documents déjà créés par les étapes précédentes et associer chaque document à sa clé source. Déterminer si la reprise doit ignorer, annuler ou compléter ces résultats.

### 2.C.7 ÉTAPE 7 — CRÉER UNE NOUVELLE SESSION DE TEST

Générer une session distincte contenant un petit échantillon. La traiter d’abord au premier plan, puis en affichage sur erreur après validation.

### 2.C.8 ÉTAPE 8 — VALIDER LE TRAITEMENT DE FOND

Passer au mode de fond uniquement lorsque l’échantillon termine sans erreur. Vérifier les journaux, les documents créés et l’absence de doublon avant de traiter le volume complet.

## 2.D DONNÉES À COMPARER

| Élément BDC | Contrôle |
|---|---|
| `PROGRAM` | Programme du dynpro actuellement affiché |
| `DYNPRO` | Numéro d’écran exact |
| `DYNBEGIN` | Première ligne de chaque écran |
| `FNAM` | Nom technique du champ ou `BDC_OKCODE` |
| `FVAL` | Valeur au format externe attendu par l’écran |

## 2.E ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Dynpro inattendu | Écran modifié ou branche fonctionnelle différente | Refaire `SHDB` avec les mêmes données |
| Champ inexistant | Nom technique obsolète | Relever le champ dans le nouvel enregistrement |
| Valeur non acceptée | Format date/nombre ou code externe incorrect | Transmettre le format attendu par l’écran |
| OK_CODE inconnu | Bouton ou statut GUI modifié | Relever la commande actuelle dans `SHDB` |
| Document déjà créé | Échec après sauvegarde partielle | Rechercher le résultat avant retraitement |
| Fonctionne au premier plan seulement | Popup ou message non géré | Ajouter le dynpro réel ou remplacer la technique |

## 2.F CONTRÔLE DE SORTIE

- La nouvelle session termine sans erreur sur l’échantillon.
- Chaque entrée source produit au maximum un document métier attendu.
- Les messages sont archivés avec la clé source.
- La session défaillante est conservée ou supprimée selon la procédure d’exploitation, après preuve qu’elle n’est plus nécessaire.

## 2.G COMPATIBILITÉ S/4HANA

Statut : compatible mais historique. Un changement d’écran S/4HANA peut casser la séquence ; une API ou l’outil de migration officiel doit être privilégié pour un nouveau flux.
