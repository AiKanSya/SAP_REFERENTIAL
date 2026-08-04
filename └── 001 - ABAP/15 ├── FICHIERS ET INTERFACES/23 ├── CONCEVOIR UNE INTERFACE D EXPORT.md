# CONCEVOIR UNE INTERFACE D’EXPORT

## OBJECTIFS

- Produire un fichier cohérent et complet
- Éviter la publication d’un fichier partiel
- Assurer la traçabilité des données extraites

## PIPELINE

```mermaid
flowchart LR
    A["Définir le périmètre"] --> B["Sélectionner les données"]
    B --> C["Construire le format"]
    C --> D["Écrire en zone de travail"]
    D --> E["Contrôler compteurs et taille"]
    E --> F["Publier le fichier"]
    F --> G["Journaliser et marquer le périmètre"]
```

## COHÉRENCE

Définir le point de cohérence des données :

- instant de lancement ;
- plage de dates ;
- numéro de lot ;
- statut d’extraction ;
- mécanisme delta.

Une sélection exécutée pendant des modifications concurrentes peut produire un fichier incohérent si le périmètre n’est pas défini.

## NOMMAGE

Un nom utile contient des éléments contrôlés :

```text
PRODUCTS_20260731_141500_000042.csv
```

Éviter les caractères dépendants du système d’exploitation. Le nom logique `FILE` doit gérer le répertoire ; le programme construit uniquement la partie variable autorisée.

## PUBLICATION

Ne rendre le fichier visible au consommateur qu’après écriture et fermeture réussies. Selon l’architecture, la publication peut être réalisée par :

- un middleware ;
- un script Basis contrôlé ;
- un répertoire de travail distinct ;
- un indicateur ou fichier de contrôle.

## CONTRÔLES

- nombre de lignes attendu ;
- total de contrôle ;
- taille non nulle ;
- encodage ;
- en-tête et version ;
- absence d’erreur d’écriture ;
- journal avec paramètres de sélection.

## PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## TERMES DU LEXIQUE

- [Interface](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)


---

[Chapitre suivant — EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC](<./24 └── EXECUTION ARRIERE PLAN REPRISE ET DIAGNOSTIC.md>)
