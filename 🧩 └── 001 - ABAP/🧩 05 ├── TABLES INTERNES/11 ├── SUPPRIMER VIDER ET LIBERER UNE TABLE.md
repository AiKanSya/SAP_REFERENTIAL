# SUPPRIMER, VIDER ET LIBÉRER UNE TABLE

## RÉSULTAT ATTENDU

- Supprimer une ou plusieurs lignes
- Distinguer `DELETE`, `CLEAR`, `REFRESH` et `FREE`
- Supprimer par index, clé ou condition
- Comprendre l’impact sur le contenu et la mémoire
- Éviter les suppressions dépendantes d’un index instable

## SUPPRIMER PAR INDEX

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
DELETE lt_products INDEX 1.

IF sy-subrc <> 0.
  WRITE: / 'Index inexistant'.
ENDIF.
```

Cette variante concerne les tables d’index.

## SUPPRIMER PAR CLÉ

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
DELETE TABLE lt_products
  WITH TABLE KEY matnr = 'MAT-001'.
```

Pour une clé libre :

```abap
DELETE lt_products WHERE category = 'OBSOLETE'.
```

## SUPPRIMER LA LIGNE COURANTE

Dans une boucle :

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_products INTO DATA(ls_product).
  IF ls_product-obsolete = abap_true.
    DELETE lt_products.
  ENDIF.
ENDLOOP.
```

Cette syntaxe agit sur la ligne actuellement traitée. Les règles exactes dépendent de la forme du parcours et de la catégorie de table.

Une variante souvent plus lisible consiste à supprimer directement avec `WHERE` :

```abap
DELETE lt_products WHERE obsolete = abap_true.
```

## CLEAR

```abap
CLEAR lt_products.
```

Pour une table interne, `CLEAR` supprime toutes les lignes et place la table dans son état initial.

## REFRESH

```abap
REFRESH lt_products.
```

`REFRESH` vide également la table. Pour du nouveau code, `CLEAR` est généralement plus homogène avec les autres objets de données.

## FREE

```abap
FREE lt_products.
```

`FREE` vide la table et demande la libération de la mémoire qu’elle occupait, au-delà de la simple remise à l’état initial.

## COMPARAISON

| Instruction |       Lignes supprimées | Intention principale                                |
| ----------- | ----------------------: | --------------------------------------------------- |
| `DELETE`    | Une sélection de lignes | Supprimer des enregistrements ciblés                |
| `CLEAR`     |                  Toutes | Réinitialiser l’objet de données                    |
| `REFRESH`   |                  Toutes | Ancienne instruction spécifique aux tables internes |
| `FREE`      |                  Toutes | Réinitialiser et libérer la mémoire occupée         |

## QUAND UTILISER FREE

`FREE` peut être pertinent lorsqu’une table très volumineuse ne sera plus utilisée pendant une longue suite du traitement.

Ne pas appeler systématiquement `FREE` après chaque utilisation. La gestion mémoire doit répondre à un besoin réel et mesuré.

## EXEMPLE SÉCURISÉ

```abap
DELETE lt_products WHERE stock = 0 AND obsolete = abap_true.

IF sy-subrc = 0.
  WRITE: / 'Au moins une ligne a été supprimée'.
ENDIF.
```

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Utiliser une table standard pour des recherches massives par clé sans mesure.
- Modifier une copie de ligne alors que la table devait être mise à jour.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DELETE lt_products WHERE stock = 0 AND obsolete = abap_true.

IF sy-subrc = 0.
  WRITE: / 'Au moins une ligne a été supprimée'.
ENDIF.
```

## TERMES DU LEXIQUE

- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Field-symbol](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [DELETE itab — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_ITAB.html)
- [CLEAR — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLEAR.html)
- [FREE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFREE.html)


---

[Chapitre suivant — TRIER ET ÉLIMINER LES DOUBLONS](<./12 ├── TRIER ET ELIMINER LES DOUBLONS.md>)
