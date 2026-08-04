# RÉCEPT" Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
ION DES RÉSULTATS AVEC INTO

## RÉSULTAT ATTENDU

- Recevoir une ligne dans une structure
- Recevoir plusieurs lignes dans une table interne
- Comprendre l’affectation par position ou par nom
- Utiliser les déclarations inline
- Éviter les incompatibilités de type

## INTO POUR UNE LIGNE

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
DATA ls_carrier TYPE scarr.

SELECT SINGLE carrid, carrname, currcode
  FROM scarr
  WHERE carrid = @p_carrid
  INTO CORRESPONDING FIELDS OF @ls_carrier.
```

La structure cible peut contenir plus de composants que la liste sélectionnée. Seuls les composants correspondants sont alimentés.

## INTO TABLE POUR PLUSIEURS LIGNES

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## DÉCLARATION INLINE

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  INTO TABLE @DATA(lt_carriers).
```

Le type de `lt_carriers` est construit à partir de la liste de sélection.

Cette forme est concise. Un type explicite reste préférable lorsque le résultat constitue une interface réutilisée ou doit rester stable malgré l’évolution de la requête.

## AFFECTATION PAR POSITION

Sans variante `CORRESPONDING FIELDS`, l’affectation suit la structure attendue par la syntaxe et les positions des colonnes.

Une modification de l’ordre des colonnes peut donc modifier l’affectation ou provoquer une incompatibilité.

## AFFECTATION PAR NOM

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE @lt_carriers.
```

Cette variante associe les colonnes aux composants de même nom.

> [!IMPORTANT]
> Un alias dans la liste de sélection change le nom utilisé pour la correspondance.

## APPENDING TABLE

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid, carrname
  FROM scarr
  WHERE currcode = @p_curr
  APPENDING TABLE @lt_carriers.
```

Cette variante conserve les lignes déjà présentes. Elle doit être utilisée seulement lorsque l’accumulation est voulue et que la gestion des doublons est maîtrisée.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## RÉFÉRENCES OFFICIELLES SAP

- [INTO Clause — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINTO_CLAUSE.html)
- [Working with Structured Data Objects — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-structured-data-objects_ca4e0b14-57ad-4993-a83b-cca17980399c)
- [Working with Complex Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-complex-internal-tables_f8c923f3-6f95-4b47-960f-557001f13977)


---

[Chapitre suivant — JOINTURES](<./08 ├── JOINTURES.md>)
