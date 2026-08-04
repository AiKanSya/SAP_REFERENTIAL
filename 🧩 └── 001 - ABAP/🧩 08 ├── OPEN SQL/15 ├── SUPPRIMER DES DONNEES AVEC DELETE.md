# SUPPRI" Modifier uniquement les données de la table cible maîtrisée.
" Modifier uniquement les données de la table cible maîtrisée.
" Modifier uniquement les données de la table cible maîtrisée.
" Modifier uniquement les données de la table cible maîtrisée.
MER DES DONNÉES AVEC DELETE

## RÉSULTAT ATTENDU

- Supprimer une ligne par clé
- Supprimer plusieurs lignes avec `WHERE`
- Contrôler le nombre de lignes supprimées
- Comprendre les risques transactionnels
- Appliquer des mesures de protection avant suppression

## SUPPRESSION PAR CONDITION

```abap
" Modifier uniquement les données de la table cible maîtrisée.
DELETE FROM zdev_product
  WHERE product_id = @p_product.

IF sy-dbcnt = 1.
  MESSAGE 'Produit supprimé' TYPE 'S'.
ELSE.
  MESSAGE 'Produit introuvable' TYPE 'I'.
ENDIF.
```

## SUPPRESSION PAR STRUCTURE

```abap
" Modifier uniquement les données de la table cible maîtrisée.
DATA ls_product TYPE zdev_product.
ls_product-product_id = p_product.

DELETE zdev_product FROM @ls_product.
```

La clé de la structure identifie la ligne visée selon la variante utilisée.

## SUPPRESSION DE MASSE

```abap
" Modifier uniquement les données de la table cible maîtrisée.
DELETE FROM zdev_product
  WHERE category = @p_category
    AND active   = @abap_false.
```

Avant une suppression de masse :

1. exécuter un `SELECT COUNT( * )` avec la même condition ;
2. afficher ou journaliser le périmètre ;
3. contrôler les autorisations ;
4. vérifier la possibilité de reprise ;
5. valider la transaction au niveau approprié.

## WHERE ABSENT

```abap
" Modifier uniquement les données de la table cible maîtrisée.
DELETE FROM zdev_product.
```

Cette instruction supprime toutes les lignes accessibles.

> [!CAUTION]
> Ne jamais générer ou exécuter cette forme dans un programme applicatif sans cas d’usage technique explicite et protections fortes.

## SUPPRESSION LOGIQUE

Pour certaines données, une désactivation avec un indicateur d’état est préférable à une suppression physique. Ce choix dépend du modèle métier, des obligations d’audit et des règles de rétention.

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
" Modifier uniquement les données de la table cible maîtrisée.
DELETE FROM zdev_product
  WHERE product_id = @p_product.

IF sy-dbcnt = 1.
  MESSAGE 'Produit supprimé' TYPE 'S'.
ELSE.
  MESSAGE 'Produit introuvable' TYPE 'I'.
ENDIF.
```

## TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## RÉFÉRENCES OFFICIELLES SAP

- [DELETE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_DB_TAB.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Database Locks — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDB_LOCK.html)


---

[Chapitre suivant — CODES RETOUR ET EXCEPTIONS SQL](<./16 ├── CODES RETOUR ET EXCEPTIONS SQL.md>)
