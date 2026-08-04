# 🌸 CONCEVOIR UNE INTERFACE D’IMPORT

## 🌺 OBJECTIFS

- Structurer un import relançable
- Séparer contrôles techniques et métier
- Gérer les succès partiels

## 🌺 PIPELINE

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

## 🌺 ZONES

| Zone    | Rôle                                         |
| ------- | -------------------------------------------- |
| Entrée  | Fichiers déposés par le producteur           |
| Travail | Fichier réservé par une exécution            |
| Archive | Fichiers traités avec succès                 |
| Erreur  | Fichiers non traitables                      |
| Rejet   | Détail des lignes rejetées si succès partiel |

## 🌺 IDENTIFICATION

Utiliser un identifiant stable : nom complet, empreinte, identifiant métier ou numéro de lot. Enregistrer cet identifiant avant les modifications métier permet de détecter une nouvelle présentation du même fichier.

## 🌺 VALIDATIONS

1. fichier attendu et taille autorisée ;
2. encodage et format ;
3. en-tête et version ;
4. champs obligatoires ;
5. conversions ;
6. références SAP ;
7. autorisations métier ;
8. doublons internes et historiques.

## 🌺 TRANSACTION

Éviter un `COMMIT WORK` par ligne. Définir une unité de traitement cohérente et connaître le comportement transactionnel des BAPI ou APIs appelées. Pour un succès partiel, enregistrer précisément les lignes validées et rejetées.

## 🌺 REPRISE

Une reprise doit décider explicitement :

- ignorer les éléments déjà confirmés ;
- annuler puis rejouer ;
- ou rejouer uniquement les erreurs.

Cette décision est métier et doit être documentée.

## 🌺 PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## 🌺 VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 🌺 ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 🌺 TERMES DU LEXIQUE

- [Import](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/03 - 🍧 REPOSITORY PACKAGES ET TRANSPORTS.md#import-transport>)
- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)


---

➡️ [Chapitre suivant — CONCEVOIR UNE INTERFACE D’EXPORT](<./23 - 🍧 CONCEVOIR UNE INTERFACE D EXPORT.md>)
