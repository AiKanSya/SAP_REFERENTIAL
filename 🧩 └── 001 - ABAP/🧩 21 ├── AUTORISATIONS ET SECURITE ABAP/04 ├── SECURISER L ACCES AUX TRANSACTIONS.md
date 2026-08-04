# SÉCURISER L’ACCÈS AUX TRANSACTIONS

## RÉSULTAT ATTENDU

Vérifier l’autorisation de démarrer une transaction appelée dynamiquement, sans confondre ce contrôle avec les autorisations métier internes.

## CODE PRÊT À ADAPTER

```abap
TYPES ty_allowed_tcodes TYPE HASHED TABLE OF tcode
  WITH UNIQUE KEY table_line.

DATA(lt_allowed_tcodes) = VALUE ty_allowed_tcodes(
  ( 'ZDEMO' )
  ( 'ZDISPLAY' ) ).

DATA(lv_tcode) = CONV tcode( to_upper( val = p_tcode ) ).

IF NOT line_exists( lt_allowed_tcodes[ table_line = lv_tcode ] ).
  MESSAGE e002(zdemo) WITH lv_tcode.
ENDIF.

CALL FUNCTION 'AUTHORITY_CHECK_TCODE'
  EXPORTING
    tcode  = lv_tcode
  EXCEPTIONS
    ok     = 0
    not_ok = 1
    OTHERS = 2.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH lv_tcode.
ENDIF.

CALL TRANSACTION lv_tcode WITH AUTHORITY-CHECK.
```

## PROCESS

### Étape 1 — Déterminer si l’appel dynamique est nécessaire

Utiliser une transaction fixe lorsque le scénario le permet. Si la cible dépend d’une entrée ou d’une configuration, limiter les transactions possibles à une liste maîtrisée par l’application.

### Étape 2 — Valider le code transaction

Normaliser la valeur dans le type `TCODE`, puis vérifier son appartenance à la liste autorisée. Ne jamais transmettre directement une saisie libre à `CALL TRANSACTION`.

La liste autorisée doit être définie dans le code ou dans un paramétrage dont la modification est elle-même protégée.

### Étape 3 — Exécuter le contrôle de démarrage

Appeler `AUTHORITY_CHECK_TCODE` lorsque l’application doit produire son propre message avant le démarrage. Tester immédiatement `SY-SUBRC` et interrompre le traitement en cas de refus.

### Étape 4 — Conserver le contrôle sur `CALL TRANSACTION`

Utiliser explicitement `WITH AUTHORITY-CHECK`. Cette addition évite que l’appel repose sur un comportement implicite ou dépendant d’un paramétrage non visible dans le code.

Le précontrôle par fonction ne justifie pas l’utilisation de `WITHOUT AUTHORITY-CHECK`.

### Étape 5 — Contrôler les autorisations métier dans la cible

`S_TCODE` protège le démarrage de la transaction. La transaction appelée doit encore contrôler les activités, objets et valeurs organisationnelles nécessaires avant chaque opération sensible.

### Étape 6 — Tester les refus distinctement

Tester au minimum :

1. transaction absente de la liste autorisée ;
2. transaction autorisée mais `S_TCODE` refusé ;
3. démarrage autorisé mais autorisation métier refusée dans la cible ;
4. scénario entièrement autorisé.

Utiliser `SU53` ou `STAUTHTRACE` pour distinguer le refus de démarrage du refus métier.

## CONTRÔLE

La vérification de `S_TCODE` autorise le démarrage. Le programme appelé doit toujours exécuter ses propres contrôles sur les données et opérations métier.

## RÉFÉRENCE OFFICIELLE SAP

- [Authorization Checks in Your Own Developments — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)
