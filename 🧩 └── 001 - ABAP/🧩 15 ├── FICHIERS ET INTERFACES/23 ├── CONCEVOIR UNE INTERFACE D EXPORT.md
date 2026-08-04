# 23. CONCEVOIR UNE INTERFACE D’EXPORT

## 23.A RÉSULTAT ATTENDU

- Produire un fichier cohérent et complet
- Éviter la publication d’un fichier partiel
- Assurer la traçabilité des données extraites

## 23.B PIPELINE

```mermaid
flowchart LR
    A["Définir le périmètre"] --> B["Sélectionner les données"]
    B --> C["Construire le format"]
    C --> D["Écrire en zone de travail"]
    D --> E["Contrôler compteurs et taille"]
    E --> F["Publier le fichier"]
    F --> G["Journaliser et marquer le périmètre"]
```

## 23.C COHÉRENCE

Définir le point de cohérence des données :

- instant de lancement ;
- plage de dates ;
- numéro de lot ;
- statut d’extraction ;
- mécanisme delta.

Une sélection exécutée pendant des modifications concurrentes peut produire un fichier incohérent si le périmètre n’est pas défini.

## 23.D NOMMAGE

Un nom utile contient des éléments contrôlés :

```text
PRODUCTS_20260731_141500_000042.csv
```

Éviter les caractères dépendants du système d’exploitation. Le nom logique `FILE`[^outil-file] doit gérer le répertoire ; le programme construit uniquement la partie variable autorisée.

## 23.E PUBLICATION

Ne rendre le fichier visible au consommateur qu’après écriture et fermeture réussies. Selon l’architecture, la publication peut être réalisée par :

- un middleware ;
- un script Basis contrôlé ;
- un répertoire de travail distinct ;
- un indicateur ou fichier de contrôle.

## 23.F CONTRÔLES

- nombre de lignes attendu ;
- total de contrôle ;
- taille non nulle ;
- encodage[^terme-encodage] ;
- en-tête et version ;
- absence d’erreur d’écriture ;
- journal avec paramètres de sélection.

## 23.G PROCESS

### 23.G.1 ÉTAPE 1 — FIGER LE CONTRAT DE SORTIE

Documenter le canal, le répertoire logique, le nom de fichier, l’encodage, le séparateur, la version, l’ordre des champs, la représentation des valeurs initiales et le signal de fin de production. Définir également ce que représente un export vide et comment le consommateur doit le traiter.

### 23.G.2 ÉTAPE 2 — DÉFINIR LE PÉRIMÈTRE DE DONNÉES

Déterminer la sélection initiale, l’horodatage de référence et la règle d’incrément. Stabiliser ce périmètre pour toute l’exécution afin qu’un redémarrage ne mélange pas deux états métier. Trier les données selon une clé déterministe avant de générer le contenu.

### 23.G.3 ÉTAPE 3 — PRODUIRE DANS UN EMPLACEMENT NON PUBLIÉ

Écrire d’abord dans un fichier de travail ou un canal inaccessible au consommateur. Contrôler chaque opération d’écriture et fermer le fichier dans tous les chemins de sortie. Ne jamais utiliser directement le nom final si le consommateur peut lire le fichier pendant sa construction.

### 23.G.4 ÉTAPE 4 — CALCULER LES CONTRÔLES DE SORTIE

Relever le nombre de lignes, la taille, les totaux métier et, si le contrat le prévoit, une empreinte. Comparer ces valeurs à la sélection source. Produire un manifeste ou un journal contenant la version du format, les paramètres, l’horodatage et les compteurs.

### 23.G.5 ÉTAPE 5 — PUBLIER UNIQUEMENT LE FICHIER COMPLET

Après fermeture et contrôles réussis, rendre le fichier visible selon le mécanisme convenu : déplacement atomique assuré par l’infrastructure, indicateur de fin ou prise en charge middleware. En cas d’échec, conserver le fichier de travail hors du périmètre consommable et journaliser sa localisation.

### 23.G.6 ÉTAPE 6 — TESTER LE REJEU ET LA CONSOMMATION

Relancer l’export avec le même périmètre et vérifier la règle attendue : même contenu, remplacement contrôlé ou nouveau numéro de version. Faire lire le fichier par le consommateur ou un validateur indépendant. Tester un export vide, un arrêt pendant l’écriture et une nouvelle exécution après correction.

## 23.H VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 23.I ERREURS FRÉQUENTES

- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 23.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 23.K RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)

---

[Chapitre suivant — EXÉCUTION ARRIÈRE-PLAN, REPRISE ET DIAGNOSTIC](<./24 └── EXECUTION ARRIERE PLAN REPRISE ET DIAGNOSTIC.md>)

[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).

[^outil-file]: **FILE.** Transaction de maintenance des noms et chemins de fichiers logiques. Voir [le chapitre associé](<04 ├── NOMS ET CHEMINS LOGIQUES AVEC FILE.md>).
