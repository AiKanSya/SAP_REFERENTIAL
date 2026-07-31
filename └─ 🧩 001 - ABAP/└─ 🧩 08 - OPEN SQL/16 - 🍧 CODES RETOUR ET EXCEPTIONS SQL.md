# 🌸 CODES RETOUR ET EXCEPTIONS SQL

## 🌺 OBJECTIFS

- Interpréter `sy-subrc`
- Exploiter `sy-dbcnt`
- Gérer `CX_SY_OPEN_SQL_DB`
- Distinguer absence de résultat et erreur technique
- Produire un traitement fiable après une instruction SQL

## 🌺 SY-SUBRC

Le sens de `sy-subrc` dépend de l’instruction et de sa variante.

Pour une lecture simple :

- `0` : au moins une ligne a été fournie ;
- `4` : aucune ligne n’a été fournie dans les cas usuels.

```abap
SELECT SINGLE carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(lv_name).

IF sy-subrc <> 0.
  MESSAGE 'Transporteur introuvable' TYPE 'I'.
ENDIF.
```

Ne pas conserver la valeur de `sy-subrc` pendant plusieurs instructions. La tester immédiatement après l’instruction concernée.

## 🌺 SY-DBCNT

`sy-dbcnt` contient le nombre de lignes traitées par de nombreuses instructions SQL.

```abap
UPDATE zdev_product
  SET active = @abap_false
  WHERE category = @p_category.

DATA(lv_updated_rows) = sy-dbcnt.
```

Copier la valeur immédiatement si elle doit être réutilisée plus tard.

## 🌺 EXCEPTION CX_SY_OPEN_SQL_DB

Certaines erreurs de base de données sont représentées par l’exception interceptable `CX_SY_OPEN_SQL_DB`.

```abap
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

## 🌺 ABSENCE MÉTIER OU ERREUR TECHNIQUE

| Situation                           | Traitement                                           |
| ----------------------------------- | ---------------------------------------------------- |
| Aucune ligne ne correspond          | Cas métier à traiter par `sy-subrc` ou résultat vide |
| Clé dupliquée attendue et acceptée  | Code retour ou variante dédiée                       |
| Violation inattendue ou erreur base | Exception et journal technique                       |
| Nombre de lignes incohérent         | Contrôle avec `sy-dbcnt` et arrêt sécurisé           |

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Predefined Data Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/43e4215eb12c497daaa58382a0411b17/41fd5d4c66654ab99620a5ee2857d9ee.html)
- [CX_SY_OPEN_SQL_DB — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)

---

➡️ [Chapitre suivant — LUW COMMIT WORK ET ROLLBACK WORK](<./17 - 🍧 LUW COMMIT WORK ET ROLLBACK WORK.md>)
