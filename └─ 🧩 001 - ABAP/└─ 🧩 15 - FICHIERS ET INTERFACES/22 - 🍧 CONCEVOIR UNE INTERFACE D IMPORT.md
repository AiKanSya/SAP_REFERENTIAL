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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Authorization for File Access — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/dc545b5a743047b6b468bbadd0085ce2.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)

---

➡️ [Chapitre suivant — CONCEVOIR UNE INTERFACE D EXPORT](<./23 - 🍧 CONCEVOIR UNE INTERFACE D EXPORT.md>)
