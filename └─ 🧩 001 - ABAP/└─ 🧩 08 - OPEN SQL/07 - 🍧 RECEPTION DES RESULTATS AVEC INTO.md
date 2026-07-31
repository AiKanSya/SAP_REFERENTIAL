# 🌸 RÉCEPTION DES RÉSULTATS AVEC INTO

## 🌺 OBJECTIFS

- Recevoir une ligne dans une structure
- Recevoir plusieurs lignes dans une table interne
- Comprendre l’affectation par position ou par nom
- Utiliser les déclarations inline
- Éviter les incompatibilités de type

## 🌺 INTO POUR UNE LIGNE

```abap
DATA ls_carrier TYPE scarr.

SELECT SINGLE carrid, carrname, currcode
  FROM scarr
  WHERE carrid = @p_carrid
  INTO CORRESPONDING FIELDS OF @ls_carrier.
```

La structure cible peut contenir plus de composants que la liste sélectionnée. Seuls les composants correspondants sont alimentés.

## 🌺 INTO TABLE POUR PLUSIEURS LIGNES

```abap
TYPES: BEGIN OF ty_carrier,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
       END OF ty_carrier.

DATA lt_carriers TYPE STANDARD TABLE OF ty_carrier
                 WITH EMPTY KEY.

SELECT carrid, carrname
  FROM scarr
  INTO TABLE @lt_carriers.
```

## 🌺 DÉCLARATION INLINE

```abap
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

Le type de `lt_carriers` est construit à partir de la liste de sélection.

Cette forme est concise. Un type explicite reste préférable lorsque le résultat constitue une interface réutilisée ou doit rester stable malgré l’évolution de la requête.

## 🌺 AFFECTATION PAR POSITION

Sans variante `CORRESPONDING FIELDS`, l’affectation suit la structure attendue par la syntaxe et les positions des colonnes.

Une modification de l’ordre des colonnes peut donc modifier l’affectation ou provoquer une incompatibilité.

## 🌺 AFFECTATION PAR NOM

```abap
SELECT carrid, carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE @lt_carriers.
```

Cette variante associe les colonnes aux composants de même nom.

> [!IMPORTANT]
> Un alias dans la liste de sélection change le nom utilisé pour la correspondance.

## 🌺 APPENDING TABLE

```abap
SELECT carrid, carrname
  FROM scarr
  WHERE currcode = @p_curr
  APPENDING TABLE @lt_carriers.
```

Cette variante conserve les lignes déjà présentes. Elle doit être utilisée seulement lorsque l’accumulation est voulue et que la gestion des doublons est maîtrisée.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire et vérifier une instruction ABAP SQL utilisant réception des résultats avec into sur un jeu de données maîtrisé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
TYPES: BEGIN OF ty_carrier,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
       END OF ty_carrier.

DATA lt_carriers TYPE STANDARD TABLE OF ty_carrier
                 WITH EMPTY KEY.

SELECT carrid, carrname
  FROM scarr
  INTO TABLE @lt_carriers.
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire et vérifier une instruction ABAP SQL utilisant réception des résultats avec into sur un jeu de données maîtrisé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [INTO Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINTO_CLAUSE.html)
- [Working with Structured Data Objects — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-structured-data-objects_ca4e0b14-57ad-4993-a83b-cca17980399c)
- [Working with Complex Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-complex-internal-tables_f8c923f3-6f95-4b47-960f-557001f13977)


---

➡️ [Chapitre suivant — JOINTURES](<./08 - 🍧 JOINTURES.md>)
