# 🌸 SOUS-REQUÊTES ET OPÉRATIONS D’ENSEMBLE

## 🌺 OBJECTIFS

- Utiliser une sous-requête pour filtrer un résultat
- Employer `EXISTS` pour tester une existence
- Comprendre `UNION` et `UNION ALL`
- Connaître les contraintes de compatibilité des colonnes
- Choisir une construction lisible et performante

## 🌺 SOUS-REQUÊTE AVEC IN

```abap
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN (
    SELECT carrid
      FROM spfli
      WHERE cityfrom = @p_city )
  INTO TABLE @DATA(lt_carriers).
```

La sous-requête produit un ensemble utilisé par la requête principale.

## 🌺 TEST D’EXISTENCE

```abap
SELECT carrid, carrname
  FROM scarr AS a
  WHERE EXISTS (
    SELECT carrid
      FROM spfli AS c
      WHERE c~carrid = a~carrid )
  INTO TABLE @DATA(lt_carriers).
```

`EXISTS` est adapté lorsque seule l’existence d’au moins une ligne correspondante importe.

## 🌺 UNION ET UNION ALL

`UNION` combine plusieurs résultats et élimine les doublons complets. `UNION ALL` conserve les doublons.

```abap
SELECT cityfrom AS city
  FROM spfli
  UNION
SELECT cityto AS city
  FROM spfli
  INTO TABLE @DATA(lt_cities).
```

Conditions principales :

- même nombre de colonnes dans chaque branche ;
- types compatibles pour les colonnes de même position ;
- ordre et clauses finales conformes à la syntaxe de la release.

## 🌺 CHOIX ENTRE JOIN ET SOUS-REQUÊTE

- une jointure est adaptée lorsqu’il faut retourner des colonnes des deux sources ;
- `EXISTS` est adapté pour un test d’existence ;
- une sous-requête scalaire peut produire une valeur ;
- la lisibilité et le plan d’exécution doivent être vérifiés sur le cas réel.

## 🌺 COMPATIBILITÉ DE VERSION

Les opérations `INTERSECT`, `EXCEPT`, les expressions de table communes et certaines formes avancées dépendent de la version ABAP.

> [!IMPORTANT]
> Vérifier la documentation de la release et le contrôle de syntaxe SAP GUI avant intégration.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire et vérifier une instruction ABAP SQL utilisant sous-requêtes et opérations d’ensemble sur un jeu de données maîtrisé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN (
    SELECT carrid
      FROM spfli
      WHERE cityfrom = @p_city )
  INTO TABLE @DATA(lt_carriers).
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire et vérifier une instruction ABAP SQL utilisant sous-requêtes et opérations d’ensemble sur un jeu de données maîtrisé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Subqueries — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSUBQUERY_SHORTREF.html)
- [UNION, INTERSECT and EXCEPT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPUNION.html)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)


---

➡️ [Chapitre suivant — SELECT FOR ALL ENTRIES](<./11 - 🍧 SELECT FOR ALL ENTRIES.md>)
