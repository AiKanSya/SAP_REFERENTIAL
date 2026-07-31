# 🌸 SUPPRIMER DES DONNÉES AVEC DELETE

## 🌺 OBJECTIFS

- Supprimer une ligne par clé
- Supprimer plusieurs lignes avec `WHERE`
- Contrôler le nombre de lignes supprimées
- Comprendre les risques transactionnels
- Appliquer des mesures de protection avant suppression

## 🌺 SUPPRESSION PAR CONDITION

```abap
DELETE FROM zdev_product
  WHERE product_id = @p_product.

IF sy-dbcnt = 1.
  MESSAGE 'Produit supprimé' TYPE 'S'.
ELSE.
  MESSAGE 'Produit introuvable' TYPE 'I'.
ENDIF.
```

## 🌺 SUPPRESSION PAR STRUCTURE

```abap
DATA ls_product TYPE zdev_product.
ls_product-product_id = p_product.

DELETE zdev_product FROM @ls_product.
```

La clé de la structure identifie la ligne visée selon la variante utilisée.

## 🌺 SUPPRESSION DE MASSE

```abap
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

## 🌺 WHERE ABSENT

```abap
DELETE FROM zdev_product.
```

Cette instruction supprime toutes les lignes accessibles.

> [!CAUTION]
> Ne jamais générer ou exécuter cette forme dans un programme applicatif sans cas d’usage technique explicite et protections fortes.

## 🌺 SUPPRESSION LOGIQUE

Pour certaines données, une désactivation avec un indicateur d’état est préférable à une suppression physique. Ce choix dépend du modèle métier, des obligations d’audit et des règles de rétention.

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **supprimer des données Z avec une condition restrictive et une validation transactionnelle maîtrisée**. Cette notion est pertinente lorsque la suppression est destructive et doit être précédée d’une sélection et d’un contrôle explicites.

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
DELETE FROM zdev_product
  WHERE product_id = @p_product.

IF sy-dbcnt = 1.
  MESSAGE 'Produit supprimé' TYPE 'S'.
ELSE.
  MESSAGE 'Produit introuvable' TYPE 'I'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **supprimer des données Z avec une condition restrictive et une validation transactionnelle maîtrisée**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [DELETE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_DB_TAB.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)
- [Database Locks — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDB_LOCK.html)


---

➡️ [Chapitre suivant — CODES RETOUR ET EXCEPTIONS SQL](<./16 - 🍧 CODES RETOUR ET EXCEPTIONS SQL.md>)
