# 🌸 MODIFIER DES DONNÉES AVEC UPDATE ET MODIFY

## 🌺 OBJECTIFS

- Modifier des lignes avec `UPDATE`
- Comprendre la différence entre `UPDATE` et `MODIFY`
- Modifier une ligne ou un ensemble de lignes
- Contrôler strictement la condition `WHERE`
- Éviter les modifications directes des données métier SAP

## 🌺 UPDATE PAR CLÉ

```abap
UPDATE zdev_product
  SET description = @p_desc,
      active      = @abap_true
  WHERE product_id = @p_product.
```

Après l’instruction, `sy-dbcnt` indique le nombre de lignes traitées.

## 🌺 DANGER D’UN WHERE ABSENT

```abap
UPDATE zdev_product
  SET active = @abap_false.
```

Cette instruction modifie toutes les lignes accessibles de la table.

> [!CAUTION]
> Pour une modification de masse, la condition doit être relue, testée et limitée explicitement. Prévoir une simulation ou une sélection préalable lorsque l’impact est important.

## 🌺 UPDATE DEPUIS UNE STRUCTURE

```abap
DATA ls_product TYPE zdev_product.

ls_product-product_id = p_product.
ls_product-description = p_desc.
ls_product-active = abap_true.

UPDATE zdev_product FROM @ls_product.
```

Selon la variante, les composants de la structure sont utilisés pour identifier et remplacer la ligne correspondante.

## 🌺 MODIFY

`MODIFY` combine deux comportements :

- si une ligne de même clé existe, elle est modifiée ;
- sinon, une nouvelle ligne est insérée.

```abap
MODIFY zdev_product FROM @ls_product.
```

Ce comportement est parfois pratique, mais il peut masquer une erreur fonctionnelle : une ligne attendue comme existante est créée silencieusement.

## 🌺 CHOIX ENTRE UPDATE ET MODIFY

| Besoin                                             | Instruction |
| -------------------------------------------------- | ----------- |
| La ligne doit déjà exister                         | `UPDATE`    |
| Insérer ou remplacer explicitement selon la clé    | `MODIFY`    |
| Une nouvelle ligne doit obligatoirement être créée | `INSERT`    |

## 🌺 API MÉTIER

Pour une donnée applicative SAP, une mise à jour SQL directe peut contourner :

- validations métier ;
- documents liés ;
- change documents ;
- update tasks ;
- extensions ;
- contrôles d’autorisation ;
- synchronisations et index applicatifs.

Utiliser l’API officielle du domaine.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [UPDATE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPUPDATE_DB_TAB.html)
- [MODIFY — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMODIFY_DB_TAB.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)

---

➡️ [Chapitre suivant — SUPPRIMER DES DONNEES AVEC DELETE](<./15 - 🍧 SUPPRIMER DES DONNEES AVEC DELETE.md>)
