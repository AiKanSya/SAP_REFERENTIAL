# CONSTANTES ET LITTÉRAUX

## OBJECTIFS

- Déclarer une constante avec `CONSTANTS`
- Distinguer une constante d’un littéral
- Identifier les principales formes de littéraux
- Remplacer les valeurs significatives répétées par des constantes nommées
- Éviter les constantes locales inutiles ou trompeuses

## CONSTANTE

Une constante est un objet de données nommé dont la valeur ne peut pas être modifiée après sa déclaration.

```abap
CONSTANTS lc_max_retries TYPE i VALUE 3.
```

La syntaxe générale est :

```abap
CONSTANTS constante TYPE type VALUE valeur.
```

La valeur doit être compatible avec le type déclaré.

## POURQUOI UTILISER UNE CONSTANTE

```abap
IF lv_retry_count >= 3.
  " ...
ENDIF.
```

La valeur `3` ne décrit pas sa signification. Une constante rend la règle explicite :

```abap
CONSTANTS lc_max_retries TYPE i VALUE 3.

IF lv_retry_count >= lc_max_retries.
  " ...
ENDIF.
```

Une constante est utile lorsque la valeur :

- possède un sens métier ou technique ;
- est réutilisée ;
- ne doit pas être modifiée pendant l’exécution ;
- améliore réellement la compréhension du code.

## CONSTANTE INITIALE

Une constante peut être définie avec la valeur initiale de son type :

```abap
CONSTANTS lc_empty_status TYPE c LENGTH 1 VALUE IS INITIAL.
```

Cette forme est rarement nécessaire. Un test `IS INITIAL` est généralement plus explicite lorsqu’il s’agit uniquement de contrôler l’absence de valeur.

## LITTÉRAUX TEXTE

### LITTÉRAL CARACTÈRE

```abap
DATA lv_text TYPE c LENGTH 20.

lv_text = 'ABAP'.
```

Les apostrophes délimitent un littéral texte de type caractère.

Pour inclure une apostrophe dans le texte, elle est doublée :

```abap
WRITE / 'L''objet est actif'.
```

### LITTÉRAL `string`

```abap
DATA lv_message TYPE string.

lv_message = `Traitement terminé`.
```

Les accents graves délimitent un littéral de type `string`.

### MODÈLE DE CHAÎNE

```abap
DATA lv_name TYPE string VALUE `SAP`.
DATA lv_text TYPE string.

lv_text = |Technologie : { lv_name }|.
```

Les modèles de chaîne permettent d’insérer des expressions et d’appliquer des options de formatage. Ils seront détaillés avec les traitements de chaînes.

## LITTÉRAUX NUMÉRIQUES

```abap
DATA lv_count  TYPE i.
DATA lv_amount TYPE p LENGTH 5 DECIMALS 2.

lv_count  = 10.
lv_amount = '12.50'.
```

Le contexte de l’affectation détermine les conversions effectuées. Pour les valeurs décimales portables dans le code, la notation sous forme de texte est fréquente avec les nombres compactés.

## LITTÉRAUX HEXADÉCIMAUX

```abap
DATA lv_byte TYPE x LENGTH 1.

lv_byte = 'FF'.
```

La chaîne fournie est convertie selon le type cible. Le contenu doit représenter une suite hexadécimale valide et respecter la capacité du champ.

## CONSTANTES LOCALES ET GLOBALES

Une constante locale à une procédure limite les dépendances :

```abap
METHOD validate_quantity.
  CONSTANTS lc_min_quantity TYPE i VALUE 1.

  IF iv_quantity < lc_min_quantity.
    " ...
  ENDIF.
ENDMETHOD.
```

Une constante globale peut être justifiée lorsqu’elle représente une règle commune à plusieurs procédures du même objet. Une constante publique de classe crée une dépendance d’interface et doit être stable.

## ENUMÉRATIONS ET VALEURS CODÉES

Pour plusieurs valeurs liées, regrouper les constantes de manière cohérente :

```abap
CONSTANTS:
  BEGIN OF lc_status,
    new       TYPE c LENGTH 1 VALUE 'N',
    processed TYPE c LENGTH 1 VALUE 'P',
    error     TYPE c LENGTH 1 VALUE 'E',
  END OF lc_status.
```

Utilisation :

```abap
IF lv_status = lc_status-error.
  WRITE / 'Traitement en erreur'.
ENDIF.
```

Cette construction fournit un regroupement lisible. Les types énumérés disponibles dans certaines versions ABAP ne sont pas abordés ici afin de conserver une compatibilité large avec les environnements SAP GUI classiques.

## ERREURS FRÉQUENTES

| Erreur                                                | Conséquence                                |
| ----------------------------------------------------- | ------------------------------------------ |
| Répéter une valeur métier sans nom                    | Règle difficile à comprendre et à modifier |
| Déclarer une constante pour chaque littéral évident   | Code inutilement verbeux                   |
| Utiliser une constante globale pour un besoin local   | Couplage excessif                          |
| Utiliser un texte codé en dur destiné à l’utilisateur | Traduction et maintenance difficiles       |
| Donner un type trop court à la constante              | Troncature ou activation impossible        |

> [!NOTE]
> Les textes affichés à l’utilisateur doivent généralement être gérés avec les mécanismes de traduction adaptés : symboles de texte, classes de messages ou ressources de l’interface concernée.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
METHOD validate_quantity.
  CONSTANTS lc_min_quantity TYPE i VALUE 1.

  IF iv_quantity < lc_min_quantity.
    " ...
  ENDIF.
ENDMETHOD.
```

## TERMES DU LEXIQUE

- [Type de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)
- [Objet de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>)
- [Structure](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Table interne](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)
- [Field-symbol](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>)
- [Référence](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)

## RÉFÉRENCES OFFICIELLES SAP

- [CONSTANTS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCONSTANTS.html)
- [Literals — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENLITERALS.html)
- [String Templates — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTRING_TEMPLATES.html)


---

[Chapitre suivant — TYPES LOCAUX AVEC `TYPES`](<./06 ├── TYPES LOCAUX AVEC TYPES.md>)
