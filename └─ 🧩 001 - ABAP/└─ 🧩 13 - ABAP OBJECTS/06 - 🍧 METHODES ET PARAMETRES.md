# 🌸 MÉTHODES ET PARAMÈTRES

## 🌺 OBJECTIFS

- Déclarer et implémenter une méthode
- Maîtriser `IMPORTING`, `EXPORTING`, `CHANGING` et `RETURNING`
- Distinguer méthode fonctionnelle et méthode à effets de bord
- Appeler une méthode avec une syntaxe lisible

## 🌺 MÉTHODE D INSTANCE

```abap
METHODS calculate_total
  IMPORTING
    iv_quantity     TYPE i
    iv_unit_price   TYPE decfloat34
  RETURNING
    VALUE(rv_total) TYPE decfloat34.
```

Implémentation :

```abap
METHOD calculate_total.
  rv_total = iv_quantity * iv_unit_price.
ENDMETHOD.
```

Appel :

```abap
lv_total = lo_service->calculate_total(
  iv_quantity   = 3
  iv_unit_price = '12.50' ).
```

## 🌺 TYPES DE PARAMÈTRES

| Catégorie   | Sens principal                                |
| ----------- | --------------------------------------------- |
| `IMPORTING` | Donnée fournie à la méthode                   |
| `EXPORTING` | Résultat fourni par la méthode                |
| `CHANGING`  | Donnée reçue puis potentiellement modifiée    |
| `RETURNING` | Résultat unique d’une méthode fonctionnelle   |
| `RAISING`   | Exceptions de classe déclarées par la méthode |

Les paramètres `IMPORTING` ne doivent pas être modifiés dans la méthode. Pour produire un résultat, utiliser `RETURNING`, `EXPORTING` ou `CHANGING` selon le contrat recherché.

## 🌺 MÉTHODE FONCTIONNELLE

Une méthode possédant un unique paramètre `RETURNING` peut être utilisée dans une expression.

```abap
IF lo_validator->is_valid( iv_value = lv_value ) = abap_true.
  WRITE / 'Valeur valide'.
ENDIF.
```

Une méthode fonctionnelle doit idéalement calculer et retourner une valeur sans modifier un état externe caché.

## 🌺 PARAMÈTRES FACULTATIFS ET VALEURS PAR DÉFAUT

```abap
METHODS format_name
  IMPORTING
    iv_name           TYPE string
    iv_uppercase      TYPE abap_bool DEFAULT abap_false
  RETURNING
    VALUE(rv_name)    TYPE string.
```

L’ajout `OPTIONAL` ou `DEFAULT` doit correspondre à un comportement métier clairement défini. Un paramètre facultatif ambigu rend l’appel difficile à comprendre.

## 🌺 PASSAGE PAR VALEUR

L’ajout `VALUE(...)` crée une sémantique de passage par valeur adaptée au paramètre concerné. Sans cet ajout, le passage utilise généralement une référence technique gérée par le runtime ABAP.

Ne choisir le passage par valeur que pour une raison explicite : isolation contre les modifications, contrat fonctionnel ou compatibilité d’interface.

## 🌺 NOMMAGE DES APPELS

Utiliser les noms de paramètres dans les appels dès que plusieurs valeurs sont transmises. La lecture reste correcte même si plusieurs paramètres partagent le même type technique.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [METHODS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMETHODS.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)

---

➡️ [Chapitre suivant — INSTANCIATION, RÉFÉRENCES ET IDENTITÉ DES OBJETS](<./07 - 🍧 INSTANCIATION REFERENCES ET IDENTITE DES OBJETS.md>)
