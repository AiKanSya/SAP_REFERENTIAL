# 6. TRI, FILTRES, TOTAUX ET AGRÉGATIONS SALV

## 6.A RÉSULTAT ATTENDU

- Définir un tri initial
- Créer des sous-totaux
- Ajouter des agrégations
- Préparer des filtres applicatifs

## 6.B TRI INITIAL

```abap
DATA lo_sorts TYPE REF TO cl_salv_sorts.

lo_sorts = go_alv->get_sorts( ).
lo_sorts->add_sort(
  columnname = 'CARRID'
  position   = 1
  sequence   = if_salv_c_sort=>sort_up
  subtotal   = abap_true ).
```

## 6.C AGRÉGATION

```abap
DATA lo_aggregations TYPE REF TO cl_salv_aggregations.

lo_aggregations = go_alv->get_aggregations( ).
lo_aggregations->add_aggregation(
  columnname  = 'PRICE'
  aggregation = if_salv_c_aggregation=>total ).
```

Les agrégations possibles dépendent du type de la colonne. Les champs de quantité et de montant doivent conserver leurs références d’unité ou de devise pour produire une sortie compréhensible.

## 6.D FILTRES

Les filtres ALV n’ont pas le même objectif qu’un `WHERE` SQL :

- `WHERE` réduit les données lues en base ;
- le filtre ALV agit sur les données déjà chargées dans la table de sortie.

Pour des volumes importants, filtrer au plus tôt dans la requête SQL.

## 6.E ORDRE DE CONFIGURATION

```mermaid
flowchart LR
    A["Données chargées"] --> B["Tri"]
    B --> C["Sous-totaux"]
    C --> D["Agrégations"]
    D --> E["Affichage"]
```

## 6.F GESTION DES EXCEPTIONS

Les méthodes de tri et d’agrégation peuvent lever des exceptions SALV en cas de colonne inconnue ou de combinaison non autorisée. Les traiter localement ou les propager selon l’architecture du programme.

## 6.G PROCESS

### 6.G.1 Étape 1 — Créer le SALV sur une table cohérente

Charger les lignes et remplir les colonnes numériques, unités et devises avant toute configuration. Une agrégation sur une colonne mal typée ne peut pas produire un résultat fiable.

### 6.G.2 Étape 2 — Définir les tris dans l’ordre attendu

Récupérer `GET_SORTS`, puis ajouter les colonnes de tri dans leur ordre de priorité. Définir explicitement le sens croissant ou décroissant et les sous-totaux requis.

### 6.G.3 Étape 3 — Ajouter les agrégations compatibles

Récupérer `GET_AGGREGATIONS` et ajouter uniquement des colonnes dont le type et la sémantique permettent le calcul demandé. Conserver les références d’unité ou de devise nécessaires.

### 6.G.4 Étape 4 — Appliquer les filtres initiaux

Récupérer `GET_FILTERS`, puis définir les plages de valeurs prévues. Un filtre d’affichage ne remplace pas un filtre SQL ni un contrôle d’autorisation.

### 6.G.5 Étape 5 — Traiter les exceptions de configuration

Intercepter les exceptions SALV correspondant aux colonnes inconnues, aux tris, aux filtres et aux agrégations non valides. Corriger la configuration avant `DISPLAY`.

### 6.G.6 Étape 6 — Contrôler les résultats calculés

Tester une table vide, un seul groupe, plusieurs groupes et des valeurs initiales. Comparer les totaux et sous-totaux à un calcul de référence.

## 6.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 6.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 6.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lo_sorts TYPE REF TO cl_salv_sorts.

lo_sorts = go_alv->get_sorts( ).
lo_sorts->add_sort(
  columnname = 'CARRID'
  position   = 1
  sequence   = if_salv_c_sort=>sort_up
  subtotal   = abap_true ).
```

## 6.K TERMES DU LEXIQUE

- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 6.L RÉFÉRENCES OFFICIELLES SAP

- [Sorting by Columns — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/a85596deeb19418982bee031d1fd1427/4ec1b299087c2b91e10000000a42189d.html)
- [Making Aggregation Settings — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec2686758e968b9e10000000a42189e.html)

---

[Chapitre suivant — AFFICHAGE, MISE EN FORME ET LAYOUT SALV](<./07 ├── AFFICHAGE MISE EN FORME ET LAYOUT SALV.md>)
