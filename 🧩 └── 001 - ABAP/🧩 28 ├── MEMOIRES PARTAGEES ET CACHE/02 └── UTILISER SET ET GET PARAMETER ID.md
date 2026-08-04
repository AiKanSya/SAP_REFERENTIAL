# UTILISER `SET PARAMETER ID` ET `GET PARAMETER ID`

## RÉSULTAT ATTENDU

Préremplir un champ compatible avec un paramètre utilisateur SAP.

## CODE PRÊT À ADAPTER

```abap
PARAMETERS p_bukrs TYPE bukrs.

SET PARAMETER ID 'BUK' FIELD p_bukrs.

DATA lv_bukrs TYPE bukrs.
GET PARAMETER ID 'BUK' FIELD lv_bukrs.
IF sy-subrc <> 0.
  CLEAR lv_bukrs.
ENDIF.
```

## CONTRÔLE

- Confirmer l’identifiant de paramètre dans l’élément de données ou l’aide du champ.
- Ne pas utiliser la mémoire SAP pour transporter des données sensibles ou un état transactionnel.
