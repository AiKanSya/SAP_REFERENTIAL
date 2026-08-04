# CODES " Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
" Lire uniquement les colonnes et les lignes nécessaires.
RETOUR ET EXCEPTIONS SQL

## RÉSULTAT ATTENDU

- Interpréter `sy-subrc`
- Exploiter `sy-dbcnt`
- Gérer `CX_SY_OPEN_SQL_DB`
- Distinguer absence de résultat et erreur technique
- Produire un traitement fiable après une instruction SQL

## SY-SUBRC

Le sens de `sy-subrc` dépend de l’instruction et de sa variante.

Pour une lecture simple :

- `0` : au moins une ligne a été fournie ;
- `4` : aucune ligne n’a été fournie dans les cas usuels.

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT SINGLE carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(lv_name).

IF sy-subrc <> 0.
  MESSAGE 'Transporteur introuvable' TYPE 'I'.
ENDIF.
```

Ne pas conserver la valeur de `sy-subrc` pendant plusieurs instructions. La tester immédiatement après l’instruction concernée.

## SY-DBCNT

`sy-dbcnt` contient le nombre de lignes traitées par de nombreuses instructions SQL.

```abap
" Modifier uniquement les données de la table cible maîtrisée.
UPDATE zdev_product
  SET active = @abap_false
  WHERE category = @p_category.

DATA(lv_updated_rows) = sy-dbcnt.
```

Copier la valeur immédiatement si elle doit être réutilisée plus tard.

## EXCEPTION CX_SY_OPEN_SQL_DB

Certaines erreurs de base de données sont représentées par l’exception interceptable `CX_SY_OPEN_SQL_DB`.

```abap
" Modifier uniquement les données de la table cible maîtrisée.
TRY.
    INSERT zdev_product FROM TABLE @lt_products.

  CATCH cx_sy_open_sql_db INTO DATA(lx_sql).
    MESSAGE lx_sql->get_text( ) TYPE 'E'.
ENDTRY.
```

Causes possibles :

- clé dupliquée ;
- valeur incompatible ;
- violation d’une contrainte ;
- erreur du système de base de données ;
- problème de connexion.

## ABSENCE MÉTIER OU ERREUR TECHNIQUE

| Situation                           | Traitement                                           |
| ----------------------------------- | ---------------------------------------------------- |
| Aucune ligne ne correspond          | Cas métier à traiter par `sy-subrc` ou résultat vide |
| Clé dupliquée attendue et acceptée  | Code retour ou variante dédiée                       |
| Violation inattendue ou erreur base | Exception et journal technique                       |
| Nombre de lignes incohérent         | Contrôle avec `sy-dbcnt` et arrêt sécurisé           |

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
SELECT SINGLE carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(lv_name).

IF sy-subrc <> 0.
  MESSAGE 'Transporteur introuvable' TYPE 'I'.
ENDIF.
```

## TERMES DU LEXIQUE

- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## RÉFÉRENCES OFFICIELLES SAP

- [Predefined Data Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/43e4215eb12c497daaa58382a0411b17/41fd5d4c66654ab99620a5ee2857d9ee.html)
- [CX_SY_OPEN_SQL_DB — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)


---

[Chapitre suivant — LUW, COMMIT WORK ET ROLLBACK WORK](<./17 ├── LUW COMMIT WORK ET ROLLBACK WORK.md>)
