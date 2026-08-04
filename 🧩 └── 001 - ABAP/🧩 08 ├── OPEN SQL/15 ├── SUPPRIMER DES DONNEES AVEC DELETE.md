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

## PROCESS

Avant une suppression de masse :

### Étape 1 — Figer le prédicat de suppression

Écrire la condition dans une forme unique et contrôler les variables utilisées. Interdire une condition vide ou une sélection globale non explicitement autorisée.

### Étape 2 — Mesurer le périmètre

Exécuter un `SELECT COUNT( * )` avec exactement le même prédicat. Si le nombre est nul, terminer sans `DELETE`. S’il dépasse le seuil validé, interrompre et faire confirmer le périmètre.

### Étape 3 — Rendre les lignes vérifiables

Lire les clés qui seront supprimées et les afficher ou les journaliser selon la sensibilité des données. Conserver un identifiant de traitement permettant de relier validation, suppression et résultat.

### Étape 4 — Contrôler autorisation et reprise

Exécuter l’autorisation métier avant la suppression. Vérifier l’existence d’une source de reprise, d’un archivage ou d’une procédure de reconstruction. Sans mécanisme validé, ne pas poursuivre une suppression irréversible.

### Étape 5 — Supprimer dans la LUW responsable

Exécuter `DELETE`, contrôler `SY-SUBRC` et comparer `SY-DBCNT` au nombre validé. Ne lancer `COMMIT WORK` que dans la couche propriétaire de la transaction ; sinon retourner le résultat à l’appelant.

### Étape 6 — Contrôler après suppression

Relire les clés ciblées. Aucune ne doit subsister et aucune clé hors périmètre ne doit avoir disparu. En cas d’écart avant commit, exécuter le rollback prévu et conserver le diagnostic.

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
