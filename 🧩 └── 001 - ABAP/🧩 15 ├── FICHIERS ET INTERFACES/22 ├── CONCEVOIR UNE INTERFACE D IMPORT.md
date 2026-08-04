# 22. CONCEVOIR UNE INTERFACE D’IMPORT

## 22.A RÉSULTAT ATTENDU

- Structurer un import relançable
- Séparer contrôles techniques et métier
- Gérer les succès partiels

## 22.B PIPELINE

```mermaid
flowchart LR
    A["Détecter le fichier"] --> B["Réserver ou copier en travail"]
    B --> C["Valider le format"]
    C --> D["Mapper les données"]
    D --> E["Contrôler le métier"]
    E --> F["Exécuter les API SAP"]
    F --> G["Journaliser"]
    G --> H["Archiver ou classer en erreur"]
```

## 22.C ZONES

| Zone    | Rôle                                         |
| ------- | -------------------------------------------- |
| Entrée  | Fichiers déposés par le producteur           |
| Travail | Fichier réservé par une exécution            |
| Archive | Fichiers traités avec succès                 |
| Erreur  | Fichiers non traitables                      |
| Rejet   | Détail des lignes rejetées si succès partiel |

## 22.D IDENTIFICATION

Utiliser un identifiant stable : nom complet, empreinte, identifiant métier ou numéro de lot. Enregistrer cet identifiant avant les modifications métier permet de détecter une nouvelle présentation du même fichier.

## 22.E VALIDATIONS

1. fichier attendu et taille autorisée ;
2. encodage[^terme-encodage] et format ;
3. en-tête et version ;
4. champs obligatoires ;
5. conversions ;
6. références SAP[^terme-acro-sap] ;
7. autorisations métier ;
8. doublons internes et historiques.

## 22.F TRANSACTION

Éviter un `COMMIT WORK`[^terme-commit-work] par ligne. Définir une unité de traitement cohérente et connaître le comportement transactionnel des BAPI[^terme-bapi] ou APIs appelées. Pour un succès partiel, enregistrer précisément les lignes validées et rejetées.

## 22.G REPRISE

Une reprise doit décider explicitement :

- ignorer les éléments déjà confirmés ;
- annuler puis rejouer ;
- ou rejouer uniquement les erreurs.

Cette décision est métier et doit être documentée.

## 22.H PROCESS

### 22.H.1 ÉTAPE 1 — FIGER LE CONTRAT D’ENTRÉE

Documenter le canal, le répertoire logique, la convention de nommage, l’encodage, le séparateur, l’en-tête, la version, les champs obligatoires et la règle signalant qu’un fichier est complet. Obtenir un fichier d’exemple accepté et plusieurs exemples rejetés avant de coder le parseur.

### 22.H.2 ÉTAPE 2 — SÉCURISER LA PRISE EN CHARGE

Ne lire qu’un fichier déclaré complet par le producteur. Identifier chaque dépôt par un nom, une empreinte ou un identifiant métier stable. Déplacer ou marquer le fichier dès sa prise en charge selon le protocole convenu afin que deux exécutions ne traitent pas simultanément la même entrée.

### 22.H.3 ÉTAPE 3 — LIRE VERS UNE ZONE DE STAGING

Conserver le fichier brut, son identifiant et le numéro de chaque ligne. Transformer d’abord chaque ligne dans une structure de staging sans mise à jour métier. Une erreur de lecture ou de format doit arrêter ou rejeter l’unité prévue par le contrat, sans laisser de données métier partielles non tracées.

### 22.H.4 ÉTAPE 4 — APPLIQUER DEUX NIVEAUX DE VALIDATION

Valider d’abord la syntaxe : encodage, nombre de colonnes, types, longueurs et valeurs obligatoires. Valider ensuite le métier : existence des références, statut, cohérence et autorisation. Journaliser pour chaque rejet la ligne, le champ, la valeur et le message explicatif.

### 22.H.5 ÉTAPE 5 — TRAITER PAR UNITÉ TRANSACTIONNELLE

Définir l’unité de validation et de `COMMIT WORK` : fichier complet, document métier ou paquet. Marquer chaque unité réussie avec une clé idempotente. En cas d’erreur, annuler uniquement ce que le contrat autorise et conserver un statut permettant d’identifier la première unité non validée.

### 22.H.6 ÉTAPE 6 — ARCHIVER ET RENDRE LA REPRISE DÉTERMINISTE

Après succès, archiver le fichier avec son journal et ses compteurs. Après échec, conserver l’original et les rejets sans les confondre avec un nouveau dépôt. Rejouer le même fichier en test : les unités déjà validées doivent être reconnues, et la reprise ne doit créer aucun doublon.

## 22.I VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 22.J ERREURS FRÉQUENTES

- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 22.K TERMES DU LEXIQUE

- [Import](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#import-transport>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## 22.L RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)

---

[Chapitre suivant — CONCEVOIR UNE INTERFACE D’EXPORT](<./23 ├── CONCEVOIR UNE INTERFACE D EXPORT.md>)

[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-bapi]: **BAPI.** Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#bapi>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
