# 🌸 LECTURE SIMPLE AVEC SELECT

## 🌺 OBJECTIFS

- Écrire une instruction `SELECT` simple
- Lire plusieurs lignes dans une table interne
- Lire une ligne dans une structure
- Utiliser la syntaxe moderne avec variables hôte
- Interpréter le résultat de la lecture

## 🌺 STRUCTURE GÉNÉRALE

Une lecture contient au minimum :

- une liste de colonnes ;
- une source après `FROM` ;
- une cible après `INTO` ;
- généralement une restriction `WHERE`.

```abap
SELECT carrid, carrname, currcode
  FROM scarr
  WHERE currcode = @p_curr
  INTO TABLE @DATA(lt_carriers).
```

La syntaxe avec `@` distingue explicitement les variables ABAP des colonnes SQL.

## 🌺 LECTURE DE PLUSIEURS LIGNES

```abap
PARAMETERS p_curr TYPE scarr-currcode DEFAULT 'EUR'.

SELECT carrid, carrname, currcode
  FROM scarr
  WHERE currcode = @p_curr
  INTO TABLE @DATA(lt_carriers).
```

`INTO TABLE` remplace le contenu actuel de la table interne cible.

Pour ajouter au contenu existant, certaines variantes utilisent `APPENDING TABLE`. Cette forme doit rester intentionnelle afin d’éviter les doublons ou les résultats mélangés.

## 🌺 LECTURE D’UNE LIGNE

```abap
PARAMETERS p_carrid TYPE scarr-carrid.

SELECT SINGLE carrid, carrname, currcode
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(ls_carrier).
```

Après l’instruction :

- `sy-subrc = 0` si une ligne a été fournie ;
- `sy-subrc <> 0` si aucune ligne n’a été trouvée.

## 🌺 NE PAS LIRE PLUS QUE NÉCESSAIRE

Éviter :

```abap
SELECT *
  FROM scarr
  INTO TABLE @DATA(lt_all_fields).
```

Préférer une liste explicite :

```abap
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_names).
```

La liste explicite :

- réduit les données transférées ;
- documente le besoin ;
- limite l’impact d’une extension de table ;
- facilite le typage du résultat.

## 🌺 SELECT DANS UNE BOUCLE

La forme `SELECT ... ENDSELECT` traite les lignes l’une après l’autre.

```abap
SELECT carrid, carrname
  FROM scarr
  INTO @DATA(ls_carrier).

  WRITE: / ls_carrier-carrid, ls_carrier-carrname.
ENDSELECT.
```

Elle reste valide, mais une lecture en masse dans une table interne est généralement plus claire et plus facile à réutiliser.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire une lecture ABAP SQL déterministe et limitée aux données nécessaires**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
PARAMETERS p_curr TYPE scarr-currcode DEFAULT 'EUR'.

SELECT carrid, carrname, currcode
  FROM scarr
  WHERE currcode = @p_curr
  INTO TABLE @DATA(lt_carriers).
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire une lecture ABAP SQL déterministe et limitée aux données nécessaires**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)
- [SELECT List — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_LIST.html)


---

➡️ [Chapitre suivant — CHAMPS, ALIAS ET EXPRESSIONS SQL](<./04 - 🍧 CHAMPS ALIAS ET EXPRESSIONS SQL.md>)
