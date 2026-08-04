# PRINCIPES DE COHÉRENCE TRANSACTIONNELLE

## RÉSULTAT ATTENDU

- Comprendre pourquoi plusieurs écritures doivent être traitées comme une seule opération métier
- Identifier les trois mécanismes classiques : LUW, verrouillage et mise à jour
- Concevoir un traitement suivant le principe « tout ou rien »

## PROBLÈME À RÉSOUDRE

Une opération métier modifie souvent plusieurs objets persistants. Une commande peut nécessiter la création d’un en-tête, de postes, de statuts et d’un historique. En cas d’échec, la base ne doit pas conserver un état partiel incohérent.

```mermaid
flowchart LR
    A["État cohérent initial"] --> B["Modifications liées"]
    B --> C{"Traitement réussi ?"}
    C -->|"Oui"| D["Validation globale"]
    C -->|"Non"| E["Annulation globale"]
    D --> F["Nouvel état cohérent"]
    E --> A
```

## TROIS MÉCANISMES COMPLÉMENTAIRES

| Mécanisme        | Rôle                                                                |
| ---------------- | ------------------------------------------------------------------- |
| SAP LUW          | Regrouper les modifications d’une opération métier                  |
| Verrouillage SAP | Empêcher des modifications concurrentes incompatibles               |
| Mise à jour SAP  | Reporter et regrouper les écritures exécutées lors de la validation |

Une écriture SQL réussie ne signifie pas encore que toute l’opération métier est validée. La frontière transactionnelle appartient au traitement appelant.

## RÈGLE DIRECTRICE

Le programme doit définir explicitement :

1. le début logique de l’opération ;
2. les données à verrouiller ;
3. les contrôles effectués avant l’écriture ;
4. le point unique de validation ;
5. le comportement en cas d’erreur ;
6. la méthode de diagnostic et de reprise.

## PROCESS

### ÉTAPE 1 — DÉFINIR L’UNITÉ MÉTIER ATOMIQUE

Lister les écritures qui doivent réussir ou échouer ensemble. Identifier la clé métier, les tables concernées et les effets externes éventuels. Une unité transactionnelle ne se déduit pas du découpage technique en méthodes : elle se déduit de l’état métier qui doit rester cohérent.

### ÉTAPE 2 — RECENSER LES BORNES TRANSACTIONNELLES

Rechercher les `COMMIT WORK`, `ROLLBACK WORK`, appels de BAPI avec gestion de commit, appels RFC et traitements qui quittent le contexte courant. Vérifier aussi les commits effectués par les API appelées. Aucun composant interne ne doit valider une partie de l’unité sans contrat explicite.

### ÉTAPE 3 — PROTÉGER LA DONNÉE PARTAGÉE

Déterminer la clé de verrouillage la plus fine couvrant l’invariant métier. Poser le verrou SAP avant la décision de mise à jour, puis relire l’état persistant déterminant. Traiter une collision comme un résultat fonctionnel contrôlé, pas comme une autorisation de poursuivre sans protection.

### ÉTAPE 4 — ORDONNER CONTRÔLES ET ÉCRITURES

Effectuer les validations structurelles et métier avant les effets irréversibles. Regrouper les écritures de la même unité et vérifier chaque retour d’API. Enregistrer les modules de mise à jour seulement lorsque leurs paramètres sont complets et cohérents.

### ÉTAPE 5 — CENTRALISER LA DÉCISION FINALE

L’orchestrateur exécute un seul `COMMIT WORK` lorsque toute l’unité est prête, ou `ROLLBACK WORK` tant qu’aucun effet externe irréversible n’a eu lieu. Libérer les verrous selon la propriété définie par `_SCOPE` et les chemins d’erreur prévus.

### ÉTAPE 6 — PROUVER LA COHÉRENCE

Tester le succès, une erreur avant écriture, une erreur après une première écriture, une collision concurrente et une update task en échec. Après chaque test, contrôler les tables, `SM12`, `SM13` et le journal applicatif. Aucun scénario ne doit laisser un état métier partiellement validé sans statut de reprise.

## VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## ERREURS FRÉQUENTES

- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## TERMES DU LEXIQUE

- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## RÉFÉRENCES OFFICIELLES SAP

- [LUWs in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/54f5462a9604498382319304869a4280.html)
- [LUW and Transactional Phases — SAP Help Portal](https://help.sap.com/docs/abap-cloud/abap-concepts/luw-and-transactional-phases)

---

[Chapitre suivant — LUW BASE DE DONNÉES ET SAP LUW](<./02 ├── LUW BASE DE DONNEES ET SAP LUW.md>)
