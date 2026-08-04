# 12. ANALYSER LES VERROUS AVEC `SM12`

## 12.A RÉSULTAT ATTENDU

- Rechercher une entrée de verrou
- Identifier son propriétaire et sa portée
- Supprimer un verrou uniquement après analyse

## 12.B DONNÉES À EXAMINER

Dans `SM12`, filtrer par :

- utilisateur ;
- table ou argument de verrou ;
- mandant ;
- heure de création ;
- objet de verrouillage ;
- mode.

Une entrée permet généralement d’identifier le propriétaire, la clé verrouillée et le mode `S`, `E`, `X` ou `O`.

## 12.C MÉTHODE DE DIAGNOSTIC

1. reproduire la collision ;
2. rechercher l’entrée dans `SM12` ;
3. identifier la session ou le traitement propriétaire ;
4. vérifier si la transaction est toujours active ;
5. examiner les erreurs associées dans `ST22`, `SM13`, jobs ou logs ;
6. supprimer uniquement si l’entrée est réellement orpheline et si l’impact métier est compris.

## 12.D RISQUE DE SUPPRESSION MANUELLE

Supprimer un verrou ne restaure pas la cohérence des données. Le programme propriétaire peut encore poursuivre et écrire comme s’il détenait le verrou. La suppression manuelle est une opération d’administration, pas une solution applicative normale.

## 12.E PROCESS

### 12.E.1 ÉTAPE 1 — RELEVER LE CONTEXTE DE LA COLLISION

Noter l’utilisateur, le mandant, l’heure, la transaction, le document métier et le message exact. Identifier si la collision est reproductible ou seulement historique. Sans cette clé de corrélation, une liste globale de verrous ne permet pas d’identifier le propriétaire utile.

### 12.E.2 ÉTAPE 2 — FILTRER DANS `SM12`

Saisir `/nSM12`, puis filtrer avec l’utilisateur, l’objet de verrouillage ou l’argument connus. Limiter la recherche au périmètre nécessaire. Afficher les entrées et relever l’objet, la clé, le mode, le propriétaire et l’âge du verrou suspect.

### 12.E.3 ÉTAPE 3 — IDENTIFIER LE TRAITEMENT PROPRIÉTAIRE

Corréler l’entrée avec les sessions de l’utilisateur, les jobs dans `SM37` et les mises à jour dans `SM13`. Vérifier si la transaction, le job ou l’update task est encore actif. Un verrou ancien n’est pas nécessairement orphelin tant que son propriétaire poursuit une opération valide.

### 12.E.4 ÉTAPE 4 — VÉRIFIER LA CAUSE APPLICATIVE

Examiner la clé passée au module `ENQUEUE_*`, la valeur de `_SCOPE` et tous les chemins de sortie. Rechercher un retour anticipé, une exception gérée sans dequeue, une attente utilisateur trop longue ou une update bloquée. Corriger la durée ou la granularité plutôt que de traiter uniquement le symptôme dans `SM12`.

### 12.E.5 ÉTAPE 5 — DÉCIDER D’UNE SUPPRESSION MANUELLE

Supprimer une entrée seulement après confirmation que son traitement propriétaire est terminé ou irrécupérable et qu’aucune mise à jour dépendante ne reste active. Obtenir la validation opérationnelle prévue par l’organisation. La suppression libère la concurrence ; elle n’annule ni ne restaure les données métier.

### 12.E.6 ÉTAPE 6 — REJOUER ET CONTRÔLER

Relancer l’opération avec la même clé. Vérifier le résultat métier, la disparition normale du verrou et l’absence d’update en erreur. Conserver l’objet, l’argument, le propriétaire et la cause dans le diagnostic afin de rendre une récidive identifiable.

## 12.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 12.G ERREURS FRÉQUENTES

- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 12.H FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 12.I TERMES DU LEXIQUE

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 12.J RÉFÉRENCES OFFICIELLES SAP

- [SM12 - Lock Concept — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/basis/3354611556.html)
- [Select and Display Lock Entries — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/d0739d980ecf42ae9f3b4c19e21a4b6e/47ea3bcee97f486ee10000000a42189d.html)
- [Lock Table — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/6568469cf5a1460a8d85c58b83d21ec2/47daae4038793c85e10000000a42189c.html)

---

[Chapitre suivant — ARCHITECTURE DE LA MISE À JOUR SAP](<./13 ├── ARCHITECTURE DE LA MISE A JOUR SAP.md>)
