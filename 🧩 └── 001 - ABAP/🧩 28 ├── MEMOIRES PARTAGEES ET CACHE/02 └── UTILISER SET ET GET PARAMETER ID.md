# UTILISER `SET PARAMETER ID` ET `GET PARAMETER ID`

## RÉSULTAT ATTENDU

Préremplir un champ compatible avec un paramètre utilisateur SAP.

## PROCESS

### ÉTAPE 1 — IDENTIFIER LE PARAMETER ID RÉEL

Ouvrir l’élément de données du champ dans `SE11` ou utiliser l’aide technique de l’écran. Relever l’identifiant de paramètre exact ; ne pas le déduire du nom du champ.

### ÉTAPE 2 — TYPER LA VALEUR

Déclarer la variable avec le même élément de données que le champ cible. Appliquer les conversions fonctionnelles avant de stocker la valeur.

### ÉTAPE 3 — ÉCRIRE AVEC SET PARAMETER ID

Exécuter `SET PARAMETER ID ... FIELD ...` uniquement lorsque le scénario doit préremplir une navigation ou mémoriser une préférence de session. Une valeur initiale doit être traitée selon une règle explicite.

### ÉTAPE 4 — LIRE AVEC GET PARAMETER ID

Appeler `GET PARAMETER ID ... FIELD ...`, tester immédiatement `SY-SUBRC` et initialiser la cible lorsqu’aucune valeur n’existe.

### ÉTAPE 5 — NE PAS CONFONDRE PRÉREMPLISSAGE ET AUTORISATION

Valider la valeur lue et exécuter les contrôles métier habituels. La mémoire SAP ne garantit ni l’existence de la valeur ni le droit de l’utiliser.

### ÉTAPE 6 — TESTER LE COMPORTEMENT DE SESSION

Tester avec une valeur présente, absente et obsolète, puis ouvrir la transaction cible. Vérifier le comportement après déconnexion et avec un autre utilisateur.

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
