# 10. SOUS-REQUÊTES ET OPÉRATIONS D’ENSEMBLE

## 10.A RÉSULTAT ATTENDU

- Utiliser une sous-requête pour filtrer un résultat
- Employer `EXISTS` pour tester une existence
- Comprendre `UNION` et `UNION ALL`
- Connaître les contraintes de compatibilité des colonnes
- Choisir une construction lisible et performante

## 10.B SOUS-REQUÊTE AVEC IN

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN (
    SELECT carrid
      FROM spfli
      WHERE cityfrom = @p_city )
  INTO TABLE @DATA(lt_carriers).
```

La sous-requête produit un ensemble utilisé par la requête principale.

## 10.C TEST D’EXISTENCE

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr AS a
  WHERE EXISTS (
    SELECT carrid
      FROM spfli AS c
      WHERE c~carrid = a~carrid )
  INTO TABLE @DATA(lt_carriers).
```

`EXISTS` est adapté lorsque seule l’existence d’au moins une ligne correspondante importe.

## 10.D UNION ET UNION ALL

`UNION` combine plusieurs résultats et élimine les doublons complets. `UNION ALL` conserve les doublons.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## 10.E CHOIX ENTRE JOIN ET SOUS-REQUÊTE

- une jointure est adaptée lorsqu’il faut retourner des colonnes des deux sources ;
- `EXISTS` est adapté pour un test d’existence ;
- une sous-requête scalaire peut produire une valeur ;
- la lisibilité et le plan d’exécution doivent être vérifiés sur le cas réel.

## 10.F COMPATIBILITÉ DE VERSION

Les opérations `INTERSECT`, `EXCEPT`, les expressions de table communes et certaines formes avancées dépendent de la version ABAP[^terme-abap].

> [!IMPORTANT]
> Vérifier la documentation de la release et le contrôle de syntaxe SAP GUI[^terme-sap-gui] avant intégration.

## 10.G VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 10.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode[^terme-methode] réutilisable sans contrat explicite.

## 10.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN (
    SELECT carrid
      FROM spfli
      WHERE cityfrom = @p_city )
  INTO TABLE @DATA(lt_carriers).
```

## 10.J TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 10.K MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 10.L RÉFÉRENCES OFFICIELLES SAP

- [Subqueries — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSUBQUERY_SHORTREF.html)
- [UNION, INTERSECT and EXCEPT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPUNION.html)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)


---

[Chapitre suivant — SELECT FOR ALL ENTRIES](<./11 ├── SELECT FOR ALL ENTRIES.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
