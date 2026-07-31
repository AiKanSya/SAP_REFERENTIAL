# 🌸 DÉCLARATIONS INLINE ET INFÉRENCE

## 🌺 OBJECTIFS

- Comprendre le principe d’une déclaration inline
- Déclarer une variable avec `DATA(...)`
- Identifier les positions de déclaration autorisées
- Comprendre les limites de l’inférence de type
- Choisir entre déclaration explicite et inline

## 🌺 PRINCIPE

Une déclaration inline crée un objet directement à une position où son type peut être déterminé par le contexte.

```abap
DATA(lv_total) = 10 + 20.
```

Cette instruction déclare `lv_total` et lui affecte le résultat de l’expression.

```mermaid
flowchart LR
    A[Expression ou contexte typé] --> B[Inférence du type]
    B --> C["Création de DATA(...)"]
    C --> D[Affectation de la valeur]
```

> [!IMPORTANT]
> La syntaxe disponible dépend de la version du serveur ABAP et du niveau de syntaxe configuré. SAP GUI n’impose pas la version du langage : il ne fait qu’éditer du code exécuté par le système ABAP.

## 🌺 DÉCLARATION EXPLICITE

```abap
DATA lv_total TYPE i.

lv_total = 10 + 20.
```

## 🌺 DÉCLARATION INLINE

```abap
DATA(lv_total) = 10 + 20.
```

La version inline est concise et place la déclaration au premier usage.

## 🌺 INFÉRENCE À PARTIR D’UN OBJET

```abap
DATA lv_source TYPE string VALUE `ABAP`.
DATA(lv_copy) = lv_source.
```

Le type de `lv_copy` est déterminé à partir de l’expression à droite.

## 🌺 INFÉRENCE À PARTIR D’UN LITTÉRAL

```abap
DATA(lv_code) = 'ABC'.
```

Le type inféré provient du littéral caractère et possède une longueur déterminée par celui-ci. Ce résultat peut être trop spécifique si la variable doit ensuite contenir une valeur plus longue.

Déclaration explicite plus stable :

```abap
DATA lv_code TYPE string VALUE `ABC`.
```

> [!CAUTION]
> Ne déduire pas qu’une déclaration inline produit automatiquement un `string`. Le type dépend du contexte et de l’expression.

## 🌺 POSITIONS DE DÉCLARATION

Les déclarations inline sont possibles uniquement aux positions prévues par la syntaxe ABAP.

Exemples courants :

```abap
DATA(lv_result) = lv_value_1 + lv_value_2.
```

```abap
FIND FIRST OCCURRENCE OF 'SAP'
  IN lv_text
  MATCH OFFSET DATA(lv_offset).
```

```abap
ASSIGN lv_value TO FIELD-SYMBOL(<lv_alias>).
```

Les déclarations inline dans les instructions SQL, les boucles et les appels de méthodes seront présentées dans les dossiers correspondants.

## 🌺 PORTÉE

Une déclaration inline ne crée pas automatiquement une portée limitée au bloc `IF`, `LOOP` ou `TRY` qui la contient.

Dans une procédure, la variable déclarée inline appartient généralement au contexte local de la procédure et peut rester visible après l’instruction de déclaration.

```abap
IF iv_active = abap_true.
  DATA(lv_message) = `Actif`.
ELSE.
  lv_message = `Inactif`.
ENDIF.

rv_message = lv_message.
```

Le code est syntaxiquement possible lorsque la déclaration est visible dans le contexte. Cette forme peut néanmoins être moins lisible qu’une déclaration explicite avant la condition.

## 🌺 QUAND UTILISER `DATA(...)`

Approprié lorsque :

- le type est évident ;
- la variable sert dans une zone courte ;
- la déclaration se trouve au premier usage ;
- aucun contrat métier spécifique ne doit être affiché dans la déclaration.

Préférer une déclaration explicite lorsque :

- le type métier doit être visible ;
- l’inférence depuis un littéral serait trop étroite ;
- la variable est utilisée dans une longue procédure ;
- une conversion ou un arrondi implicite serait difficile à identifier ;
- le système cible ne supporte pas la syntaxe.

## 🌺 EXEMPLE COMPARATIF

```abap
REPORT zdemo_inline_data.

DATA lv_net_amount TYPE p LENGTH 8 DECIMALS 2 VALUE '100.00'.
DATA lv_tax_amount TYPE p LENGTH 8 DECIMALS 2 VALUE '20.00'.

DATA(lv_total_amount) = lv_net_amount + lv_tax_amount.

WRITE / lv_total_amount.
```

Le type de `lv_total_amount` est déterminé à partir de l’expression arithmétique. Pour un traitement financier réel, un type métier explicite peut rester préférable afin de maîtriser la précision et la sémantique.

## 🌺 ERREURS FRÉQUENTES

| Erreur                                                  | Risque                                    |
| ------------------------------------------------------- | ----------------------------------------- |
| Inférer depuis un littéral court                        | Longueur trop restrictive                 |
| Supposer une portée limitée au bloc                     | Réutilisation involontaire de la variable |
| Utiliser l’inline pour masquer un type métier important | Contrat moins lisible                     |
| Employer une syntaxe non supportée par la version cible | Erreur syntaxique                         |
| Déclarer la même variable dans plusieurs branches       | Conflit ou code difficile à comprendre    |

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Inline Declarations — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDECLARATION_INLINE.html)
- [Declaration Expressions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDECLARATION_EXPRESSIONS.html)
- [Inline Declarations, Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDECLARATION_INLINE_GUIDL.html)

---

➡️ [Chapitre suivant — SYMBOLES DE CHAMP](<./10 - 🍧 SYMBOLES DE CHAMP.md>)
