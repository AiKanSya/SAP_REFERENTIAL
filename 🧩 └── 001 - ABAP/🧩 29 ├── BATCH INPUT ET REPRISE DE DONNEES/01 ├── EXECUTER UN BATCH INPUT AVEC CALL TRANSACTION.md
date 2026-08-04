# EXÉCUTER UN BATCH INPUT AVEC `CALL TRANSACTION`

## RÉSULTAT ATTENDU

Rejouer une séquence d’écran contrôlée et récupérer tous les messages produits.

## CODE PRÊT À ADAPTER

Fragment : la table `LT_BDCDATA` doit être construite depuis un enregistrement `SHDB` validé sur le système cible.

```abap
DATA lt_bdcdata  TYPE STANDARD TABLE OF bdcdata WITH EMPTY KEY.
DATA lt_messages TYPE STANDARD TABLE OF bdcmsgcoll WITH EMPTY KEY.

"Ajouter chaque dynpro et chaque champ dans l’ordre exact enregistré par SHDB.
APPEND VALUE #( program = 'SAPLZDEMO' dynpro = '0100' dynbegin = abap_true ) TO lt_bdcdata.
APPEND VALUE #( fnam = 'BDC_OKCODE' fval = '=SAVE' ) TO lt_bdcdata.

CALL TRANSACTION 'ZDEMO'
  USING lt_bdcdata
  MODE 'N'
  UPDATE 'S'
  MESSAGES INTO lt_messages.

IF sy-subrc <> 0.
  "Conserver LT_MESSAGES : il contient le diagnostic détaillé du traitement.
  MESSAGE e001(zdemo) WITH sy-subrc.
ENDIF.
```

## CONTRÔLE

- Tester d’abord en mode `A`, puis `E`, avant le mode invisible `N`.
- La transaction, les écrans et les OK_CODE existent dans la version S/4HANA cible.
- Le document métier est recherché après l’appel afin de détecter un succès partiel.
