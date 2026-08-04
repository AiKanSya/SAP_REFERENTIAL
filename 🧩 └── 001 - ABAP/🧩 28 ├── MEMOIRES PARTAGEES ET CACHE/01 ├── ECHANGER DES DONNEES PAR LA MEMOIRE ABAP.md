# ÉCHANGER DES DONNÉES PAR LA MÉMOIRE ABAP

## RÉSULTAT ATTENDU

Transmettre une valeur entre programmes d’une même session utilisateur avec un identifiant explicite.

## CODE PRÊT À ADAPTER

Programme producteur :

```abap
DATA(lv_document) = CONV char20( '4711' ).
EXPORT document = lv_document TO MEMORY ID 'ZDEMO_DOCUMENT'.
```

Programme consommateur :

```abap
DATA lv_document TYPE char20.

IMPORT document = lv_document FROM MEMORY ID 'ZDEMO_DOCUMENT'.
IF sy-subrc = 0.
  FREE MEMORY ID 'ZDEMO_DOCUMENT'. "Supprime la valeur devenue inutile.
ENDIF.
```

## LIMITES

- Ce mécanisme n’est ni une base de données ni un échange interutilisateur.
- Documenter le producteur, le consommateur, le nom des composants et le nettoyage.
