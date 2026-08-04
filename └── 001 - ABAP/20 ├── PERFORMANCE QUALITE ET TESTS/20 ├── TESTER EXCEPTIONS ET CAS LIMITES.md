# TESTER EXCEPTIONS ET CAS LIMITES

## Objectif

Vérifier les chemins d’erreur, les limites et les entrées invalides, pas seulement le scénario nominal.

## Tester une exception

```abap
METHOD rejects_negative_quantity.
  TRY.
      zcl_quantity=>validate( -1 ).
      cl_abap_unit_assert=>fail(
        msg = 'Une exception était attendue' ).
    CATCH zcx_invalid_quantity INTO DATA(lx_error).
      cl_abap_unit_assert=>assert_equals(
        exp = 'NEGATIVE_QUANTITY'
        act = lx_error->reason ).
  ENDTRY.
ENDMETHOD.
```

## Cas limites à identifier

- valeur initiale ;
- minimum et maximum ;
- juste avant et juste après une borne ;
- table vide et table contenant une ligne ;
- doublons ;
- chaînes vides, espaces et caractères spéciaux ;
- date de changement de période ;
- division par zéro ;
- référence non liée ;
- erreur de conversion.

## Équivalence

Il n’est pas nécessaire de tester toutes les valeurs. Regrouper les entrées qui doivent produire le même comportement, puis sélectionner une valeur représentative et les bornes.

## Test d’un message

Lorsque le comportement utilise des messages classiques, préférer isoler la logique métier dans une méthode qui retourne un résultat ou lève une exception. Les tests deviennent plus simples et moins dépendants du contexte Dynpro.

## Références SAP officielles

- [SAP Help Portal — ABAP Unit](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491cfd8926bc14cde10000000a42189b.html)
- [SAP Help Portal — Unit Test Class Structure](https://help.sap.com/docs/ABAP_PLATFORM_2021/fc4c71aa50014fd1b43721701471913d/4338feeef5c444e3be05f5e672e1a954.html)

## VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
METHOD rejects_negative_quantity.
  TRY.
      zcl_quantity=>validate( -1 ).
      cl_abap_unit_assert=>fail(
        msg = 'Une exception était attendue' ).
    CATCH zcx_invalid_quantity INTO DATA(lx_error).
      cl_abap_unit_assert=>assert_equals(
        exp = 'NEGATIVE_QUANTITY'
        act = lx_error->reason ).
  ENDTRY.
ENDMETHOD.
```

## TERMES DU LEXIQUE

- [Exception](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [ATC](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)
