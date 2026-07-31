# 🌸 CODES RETOUR ET SY-SUBRC

## 🌺 OBJECTIFS

- Comprendre le rôle de `sy-subrc`
- Contrôler un code retour immédiatement
- Lire la documentation propre à chaque instruction
- Éviter les tests génériques incorrects
- Choisir entre code retour et exception

## 🌺 PRINCIPE

Certaines instructions ABAP renseignent le champ système `sy-subrc` afin d’indiquer leur résultat.

```abap
READ TABLE lt_product
  WITH KEY matnr = lv_matnr
  INTO DATA(ls_product).

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH lv_matnr.
ENDIF.
```

La signification des valeurs dépend de l’instruction. `0` signifie généralement que l’opération a réussi, mais les autres valeurs ne sont pas universelles.

## 🌺 CONTRÔLE IMMÉDIAT

```mermaid
flowchart LR
    A["Instruction"] --> B["sy-subrc renseigné"]
    B --> C["Contrôle immédiat"]
    C --> D["Réaction"]
```

Mauvais :

```abap
READ TABLE lt_product WITH KEY matnr = lv_matnr INTO ls_product.
PERFORM calculate_price.
IF sy-subrc <> 0.
  " Le code retour peut maintenant appartenir au PERFORM ou à une instruction interne
ENDIF.
```

Le code retour doit être testé avant toute instruction susceptible de le modifier.

## 🌺 VALEURS SPÉCIFIQUES

Certaines instructions distinguent plusieurs résultats non nuls.

Exemple conceptuel :

```abap
CASE sy-subrc.
  WHEN 0.
    " Succès
  WHEN 4.
    " Cas documenté numéro 1
  WHEN 8.
    " Cas documenté numéro 2
  WHEN OTHERS.
    " Cas inattendu
ENDCASE.
```

Ne pas inventer la signification de `4`, `8` ou d’une autre valeur. Vérifier la documentation de l’instruction concernée.

## 🌺 CONSERVER LE CODE RETOUR

```abap
DATA lv_subrc TYPE sysubrc.

AUTHORITY-CHECK OBJECT 'S_TCODE'
  ID 'TCD' FIELD sy-tcode.

lv_subrc = sy-subrc.
```

La copie permet de différer le traitement sans dépendre de la valeur volatile de `sy-subrc`.

## 🌺 CODE RETOUR OU EXCEPTION

| Situation                                         | Mécanisme adapté                                |
| ------------------------------------------------- | ----------------------------------------------- |
| Résultat normal avec présence ou absence          | Code retour                                     |
| Plusieurs états simples d’une instruction         | Code retour documenté                           |
| Erreur nécessitant une propagation entre méthodes | Exception                                       |
| Échec technique avec contexte et cause            | Exception                                       |
| API classique imposant `sy-subrc`                 | Contrôle immédiat puis conversion si nécessaire |

Une interface moderne réutilisable ne doit pas obliger l’appelant à deviner un code numérique non documenté.

## 🌺 ERREUR À ÉVITER

```abap
IF sy-subrc = 0.
  " traitement
ENDIF.
```

Sans instruction immédiatement identifiable avant ce test, le code est ambigu et fragile.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Return Code — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENRETURN_CODE_GUIDL.html)
- [ABAP Statements Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_STATEMENTS_OVERVIEW.html)

---

➡️ [Chapitre suivant — CLASSES D EXCEPTION ET CATEGORIES](<./08 - 🍧 CLASSES D EXCEPTION ET CATEGORIES.md>)
