# 🌸 CONCEVOIR UNE INTERFACE D’EXPORT

## 🌺 OBJECTIFS

- Produire un fichier cohérent et complet
- Éviter la publication d’un fichier partiel
- Assurer la traçabilité des données extraites

## 🌺 PIPELINE

```mermaid
flowchart LR
    A["Définir le périmètre"] --> B["Sélectionner les données"]
    B --> C["Construire le format"]
    C --> D["Écrire en zone de travail"]
    D --> E["Contrôler compteurs et taille"]
    E --> F["Publier le fichier"]
    F --> G["Journaliser et marquer le périmètre"]
```

## 🌺 COHÉRENCE

Définir le point de cohérence des données :

- instant de lancement ;
- plage de dates ;
- numéro de lot ;
- statut d’extraction ;
- mécanisme delta.

Une sélection exécutée pendant des modifications concurrentes peut produire un fichier incohérent si le périmètre n’est pas défini.

## 🌺 NOMMAGE

Un nom utile contient des éléments contrôlés :

```text
PRODUCTS_20260731_141500_000042.csv
```

Éviter les caractères dépendants du système d’exploitation. Le nom logique `FILE` doit gérer le répertoire ; le programme construit uniquement la partie variable autorisée.

## 🌺 PUBLICATION

Ne rendre le fichier visible au consommateur qu’après écriture et fermeture réussies. Selon l’architecture, la publication peut être réalisée par :

- un middleware ;
- un script Basis contrôlé ;
- un répertoire de travail distinct ;
- un indicateur ou fichier de contrôle.

## 🌺 CONTRÔLES

- nombre de lignes attendu ;
- total de contrôle ;
- taille non nulle ;
- encodage ;
- en-tête et version ;
- absence d’erreur d’écriture ;
- journal avec paramètres de sélection.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)

---

➡️ [Chapitre suivant — EXECUTION ARRIERE PLAN REPRISE ET DIAGNOSTIC](<./24 - 🍧 EXECUTION ARRIERE PLAN REPRISE ET DIAGNOSTIC.md>)
