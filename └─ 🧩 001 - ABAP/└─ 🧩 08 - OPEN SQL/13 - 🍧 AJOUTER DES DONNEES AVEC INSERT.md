# 🌸 AJOUTER DES DONNÉES AVEC INSERT

## 🌺 OBJECTIFS

- Insérer une ligne dans une table client
- Insérer plusieurs lignes depuis une table interne
- Gérer une clé déjà existante
- Comprendre `sy-subrc` et `sy-dbcnt`
- Éviter les écritures directes dans les tables applicatives SAP

## 🌺 TABLE D’EXEMPLE

Les exemples supposent une table client fictive `ZDEV_PRODUCT` contenant notamment :

- `MANDT` ;
- `PRODUCT_ID` comme clé métier ;
- `DESCRIPTION` ;
- `CATEGORY` ;
- `PRICE` ;
- `CURRENCY` ;
- `ACTIVE`.

> [!CAUTION]
> Ne jamais transposer cet exemple à une table applicative SAP standard. Utiliser l’API métier, la BAPI ou l’objet de service prévu par SAP.

## 🌺 INSÉRER UNE LIGNE

```abap
DATA ls_product TYPE zdev_product.

ls_product-product_id = 'P000000001'.
ls_product-description = 'Produit de démonstration'.
ls_product-category = 'DEMO'.
ls_product-price = '10.00'.
ls_product-currency = 'EUR'.
ls_product-active = abap_true.

INSERT zdev_product FROM @ls_product.

IF sy-subrc = 0.
  MESSAGE 'Ligne insérée' TYPE 'S'.
ELSE.
  MESSAGE 'Clé déjà existante' TYPE 'E'.
ENDIF.
```

## 🌺 INSÉRER PLUSIEURS LIGNES

```abap
DATA lt_products TYPE STANDARD TABLE OF zdev_product
                 WITH EMPTY KEY.

lt_products = VALUE #(
  ( product_id = 'P000000001' description = 'Produit 1' category = 'DEMO' )
  ( product_id = 'P000000002' description = 'Produit 2' category = 'DEMO' ) ).

INSERT zdev_product FROM TABLE @lt_products.
```

## 🌺 CLÉ EN DOUBLE

Lorsqu’une clé primaire ou un index unique existe déjà :

- une insertion simple échoue avec un code retour approprié ;
- une insertion en masse peut lever `CX_SY_OPEN_SQL_DB` selon la variante ;
- `ACCEPTING DUPLICATE KEYS` ignore les lignes en double et fixe le code retour selon le résultat.

```abap
INSERT zdev_product FROM TABLE @lt_products
  ACCEPTING DUPLICATE KEYS.
```

Cette addition ne met pas à jour les lignes existantes. Elle ignore seulement les doublons impossibles à insérer.

## 🌺 MANDANT

Pour une table dépendante du mandant, la gestion implicite utilise le mandant courant. Une valeur de `MANDT` fournie dans la structure source n’est normalement pas utilisée comme un champ métier ordinaire.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **ajouter des lignes dans une table Z en contrôlant les doublons et le résultat**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_product TYPE zdev_product.

ls_product-product_id = 'P000000001'.
ls_product-description = 'Produit de démonstration'.
ls_product-category = 'DEMO'.
ls_product-price = '10.00'.
ls_product-currency = 'EUR'.
ls_product-active = abap_true.

INSERT zdev_product FROM @ls_product.

IF sy-subrc = 0.
  MESSAGE 'Ligne insérée' TYPE 'S'.
ELSE.
  MESSAGE 'Clé déjà existante' TYPE 'E'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **ajouter des lignes dans une table Z en contrôlant les doublons et le résultat**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [INSERT, Data Source — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Database Locks — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDB_LOCK.html)


---

➡️ [Chapitre suivant — MODIFIER DES DONNÉES AVEC UPDATE ET MODIFY](<./14 - 🍧 MODIFIER DES DONNEES AVEC UPDATE ET MODIFY.md>)
