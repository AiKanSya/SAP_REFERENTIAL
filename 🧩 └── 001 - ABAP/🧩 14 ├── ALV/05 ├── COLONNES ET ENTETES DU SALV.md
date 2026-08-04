# 5. COLONNES ET ENTÊTES DU SALV

## 5.A RÉSULTAT ATTENDU

- Accéder aux objets colonne
- Modifier textes, visibilité[^terme-visibilite] et largeur
- Exploiter les informations DDIC[^terme-acro-ddic]

## 5.B RÉCUPÉRER LES COLONNES

```abap
DATA:
  lo_columns TYPE REF TO cl_salv_columns_table,
  lo_column  TYPE REF TO cl_salv_column_table.

lo_columns = go_alv->get_columns( ).
lo_columns->set_optimize( abap_true ).

TRY.
    lo_column ?= lo_columns->get_column( 'PRICE' ).
    lo_column->set_short_text( 'Prix' ).
    lo_column->set_medium_text( 'Prix du vol' ).
    lo_column->set_long_text( 'Prix du vol sélectionné' ).
  CATCH cx_salv_not_found.
ENDTRY.
```

## 5.C PROPRIÉTÉS COURANTES

| Besoin                          | Méthode[^terme-methode] typique                                      |
| ------------------------------- | ---------------------------------------------------- |
| Ajuster les largeurs            | `SET_OPTIMIZE`                                       |
| Masquer une colonne             | `SET_VISIBLE`                                        |
| Définir la colonne technique    | `SET_TECHNICAL`                                      |
| Fixer un texte                  | `SET_SHORT_TEXT`, `SET_MEDIUM_TEXT`, `SET_LONG_TEXT` |
| Définir une cellule interactive | `SET_CELL_TYPE`                                      |

## 5.D DDIC ET SÉMANTIQUE

Lorsque les champs de la table interne[^terme-table-interne] sont typés à partir du Dictionary ABAP[^terme-abap], SALV[^terme-acro-salv] peut récupérer davantage d’informations : libellés, type de données[^terme-type-donnees], référence de devise ou d’unité. Une structure locale non référencée au DDIC oblige souvent à compléter manuellement ces propriétés.

## 5.E COLONNES TECHNIQUES

Une colonne technique est exclue de l’ensemble de colonnes manipulables par l’utilisateur. Une colonne seulement invisible peut généralement être réaffichée via la personnalisation.

Utiliser une colonne technique pour une donnée exclusivement interne, jamais pour masquer une information sensible sans contrôle d’autorisation.

## 5.F PROCESS

### 5.F.1 Étape 1 — Stabiliser la structure de sortie

Nommer et typer les composants avant de configurer les colonnes. Réutiliser des éléments de données DDIC lorsque leurs libellés, unités et conversions correspondent au besoin.

### 5.F.2 Étape 2 — Récupérer la collection des colonnes

Appeler `GET_COLUMNS` après `FACTORY`. Activer l’optimisation globale uniquement si elle convient à la mise en page attendue.

### 5.F.3 Étape 3 — Récupérer chaque colonne par son nom technique

Appeler `GET_COLUMN` avec le nom exact du composant de la table de sortie. Intercepter `CX_SALV_NOT_FOUND` lorsqu’une colonne peut être absente selon la variante de structure.

### 5.F.4 Étape 4 — Appliquer les propriétés nécessaires

Définir les textes court, moyen et long, la visibilité, la longueur de sortie, l’alignement et le comportement interactif. Masquer les clés purement techniques qui ne servent pas au lecteur.

### 5.F.5 Étape 5 — Vérifier le rendu avec les données réelles

Tester les valeurs courtes, longues, initiales et négatives. Contrôler les unités, devises, zéros initiaux et textes traduits avant de valider le chapitre.

## 5.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 5.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un volume non borné dans l’ALV[^terme-alv].
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 5.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA:
  lo_columns TYPE REF TO cl_salv_columns_table,
  lo_column  TYPE REF TO cl_salv_column_table.

lo_columns = go_alv->get_columns( ).
lo_columns->set_optimize( abap_true ).

TRY.
    lo_column ?= lo_columns->get_column( 'PRICE' ).
    lo_column->set_short_text( 'Prix' ).
    lo_column->set_medium_text( 'Prix du vol' ).
    lo_column->set_long_text( 'Prix du vol sélectionné' ).
  CATCH cx_salv_not_found.
ENDTRY.
```

## 5.J TERMES DU LEXIQUE

- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 5.K RÉFÉRENCES OFFICIELLES SAP

- [Columns (General) — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1e9df087c2b91e10000000a42189d.html)
- [Displaying Interactive Elements — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b1c834a22d05483b8a75710743b5ff26/4ec1afd0087c2b91e10000000a42189d.html)

---

[Chapitre suivant — TRI, FILTRES, TOTAUX ET AGRÉGATIONS SALV](<./06 ├── TRI FILTRES TOTAUX ET AGREGATIONS SALV.md>)

[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-salv]: **SALV.** Simple ALV / famille de classes `CL_SALV_*`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>).
[^terme-type-donnees]: **TYPE DE DONNÉES.** Définition des propriétés d’une valeur : nature, longueur, précision et opérations autorisées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
