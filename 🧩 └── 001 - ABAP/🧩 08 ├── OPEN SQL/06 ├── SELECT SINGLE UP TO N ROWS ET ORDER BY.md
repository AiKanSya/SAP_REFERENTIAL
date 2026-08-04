# 6. SELECT SINGLE, UP TO N ROWS ET ORDER BY

## 6.A RÉSULTAT ATTENDU

- Choisir entre `SELECT SINGLE` et `UP TO 1 ROWS`
- Garantir un résultat déterministe avec `ORDER BY`
- Limiter le nombre de lignes retournées
- Éviter de dépendre d’un ordre implicite
- Utiliser `OFFSET` avec prudence

## 6.B SELECT SINGLE

Utiliser `SELECT SINGLE` lorsqu’une seule ligne doit être lue, généralement à partir d’une clé complète ou d’une condition qui garantit fonctionnellement l’unicité.

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
SELECT SINGLE carrid, carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(ls_carrier).
```

## 6.C UP TO 1 ROWS

Utiliser `UP TO 1 ROWS` lorsqu’il faut choisir une ligne parmi plusieurs selon un ordre explicite.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT fldate, price, currency
  FROM sflight
  WHERE carrid = @p_carrid
    AND connid = @p_connid
  ORDER BY fldate DESCENDING
  INTO TABLE @DATA(lt_latest)
  UP TO 1 ROWS.
```

L’ordre exact des clauses dépend de la syntaxe prise en charge par la release. Le contrôle de syntaxe de l’éditeur fait foi.

## 6.D ORDRE NON GARANTI

Sans `ORDER BY`, l’ordre des lignes d’un résultat SQL n’est pas garanti.

```mermaid
flowchart LR
    A["SELECT sans ORDER BY"] --> B["Ordre dépendant du plan d’exécution"]
    B --> C["Résultat potentiellement différent après migration ou optimisation"]
```

Ne jamais supposer que la base renvoie les lignes selon la clé primaire ou l’ordre physique.

## 6.E ORDER BY

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, connid, cityfrom, cityto
  FROM spfli
  WHERE carrid = @p_carrid
  ORDER BY cityfrom ASCENDING, cityto ASCENDING
  INTO TABLE @DATA(lt_connections).
```

`ORDER BY` est justifié lorsque l’ordre est nécessaire au résultat. Un tri inutile impose un travail supplémentaire à la base.

## 6.F LIMITATION ET PAGINATION

`UP TO n ROWS` limite le volume retourné. `OFFSET` permet de sauter un nombre de lignes sur les versions qui le prennent en charge.

Une pagination stable exige :

- un `ORDER BY` déterministe ;
- une clé de tri suffisamment unique ;
- une stratégie compatible avec les modifications concurrentes.

## 6.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 6.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 6.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT fldate, price, currency
  FROM sflight
  WHERE carrid = @p_carrid
    AND connid = @p_connid
  ORDER BY fldate DESCENDING
  INTO TABLE @DATA(lt_latest)
  UP TO 1 ROWS.
```

## 6.J TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 6.K MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 6.L RÉFÉRENCES OFFICIELLES SAP

- [SELECT SINGLE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SINGLE.html)
- [UP TO and OFFSET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_UP_TO_OFFSET.html)
- [ORDER BY — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPORDERBY_CLAUSE.html)
- [Sorting and Condensing Data Sets in ABAP SQL — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/sorting-and-condensing-data-sets-in-abap-sql_cd074ff4-ebc9-4b68-8708-7fa6043bf34c)


---

[Chapitre suivant — RÉCEPTION DES RÉSULTATS AVEC INTO](<./07 ├── RECEPTION DES RESULTATS AVEC INTO.md>)
