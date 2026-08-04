# 🌸 JOINTURES

## 🌺 OBJECTIFS

- Combiner plusieurs sources dans une seule requête
- Utiliser `INNER JOIN` et `LEFT OUTER JOIN`
- Écrire une condition `ON`
- Employer des alias de sources
- Éviter les lectures imbriquées inutiles

## 🌺 INNER JOIN

Un `INNER JOIN` conserve seulement les combinaisons pour lesquelles la condition `ON` est satisfaite des deux côtés.

```abap
SELECT a~carrid,
       a~carrname,
       c~connid,
       c~cityfrom,
       c~cityto
  FROM scarr AS a
  INNER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_connections).
```

Le séparateur entre alias de source et colonne est `~` en ABAP SQL.

## 🌺 LEFT OUTER JOIN

Un `LEFT OUTER JOIN` conserve toutes les lignes de la source gauche, même lorsqu’aucune ligne correspondante n’existe à droite.

```abap
SELECT a~carrid,
       a~carrname,
       c~connid
  FROM scarr AS a
  LEFT OUTER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_carriers_connections).
```

Pour une ligne gauche sans correspondance, les colonnes provenant de la droite résultent de valeurs nulles en base, ensuite converties ou gérées selon la cible ABAP SQL.

## 🌺 ALIAS DE SOURCES

Les alias :

- raccourcissent les noms ;
- rendent les colonnes non ambiguës ;
- sont obligatoires pour distinguer deux utilisations de la même source.

## 🌺 AUTO-JOINTURE

```abap
SELECT first~carrid,
       first~connid AS first_connection,
       next~connid  AS next_connection
  FROM spfli AS first
  INNER JOIN spfli AS next
    ON next~cityfrom = first~cityto
  INTO TABLE @DATA(lt_routes).
```

## 🌺 JOINTURE OU SELECT DANS UNE BOUCLE

Éviter :

```abap
LOOP AT lt_carriers INTO DATA(ls_carrier).
  SELECT * FROM spfli
    WHERE carrid = @ls_carrier-carrid
    INTO TABLE @DATA(lt_connections).
ENDLOOP.
```

Préférer une jointure ou une lecture groupée afin de réduire le nombre d’allers-retours vers la base.

## 🌺 CONDITION ON ET FILTRE WHERE

- `ON` définit la relation entre les sources ;
- `WHERE` filtre le résultat produit par cette relation.

Dans une jointure externe, déplacer une condition de `ON` vers `WHERE` peut supprimer les lignes sans correspondance et modifier le résultat métier.

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
SELECT a~carrid,
       a~carrname,
       c~connid
  FROM scarr AS a
  LEFT OUTER JOIN spfli AS c
    ON c~carrid = a~carrid
  INTO TABLE @DATA(lt_carriers_connections).
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Joins — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-joins_a053e03d-f11e-4bee-8f63-5129b0590029)
- [FROM Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFROM_CLAUSE.html)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)


---

➡️ [Chapitre suivant — AGRÉGATIONS, GROUP BY ET HAVING](<./09 - 🍧 AGREGATIONS GROUP BY ET HAVING.md>)
