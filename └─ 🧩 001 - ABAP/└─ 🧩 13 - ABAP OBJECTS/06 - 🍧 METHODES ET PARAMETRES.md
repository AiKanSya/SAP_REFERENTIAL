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

## 🌺 CAS D’USAGE

Dans un contexte où une logique métier évolutive doit être encapsulée dans des classes afin de limiter les dépendances et faciliter les tests, le besoin consiste à **modéliser méthodes et paramètres dans une conception ABAP Objects encapsulée et testable**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Exposer des attributs modifiables au lieu d’encapsuler l’état.
- Créer une hiérarchie d’héritage alors qu’une composition suffit.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
IF lo_validator->is_valid( iv_value = lv_value ) = abap_true.
  WRITE / 'Valeur valide'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [Classe](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#classe>)
- [Interface ABAP Objects](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#interface-abap-objects>)
- [Référence](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **modéliser méthodes et paramètres dans une conception ABAP Objects encapsulée et testable**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining and Calling Methods — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/defining-and-calling-methods_bc2d0d2a-d7f4-41bf-84f2-65de61c408ed)
- [METHODS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMETHODS.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)


---

➡️ [Chapitre suivant — INSTANCIATION, RÉFÉRENCES ET IDENTITÉ DES OBJETS](<./07 - 🍧 INSTANCIATION REFERENCES ET IDENTITE DES OBJETS.md>)
