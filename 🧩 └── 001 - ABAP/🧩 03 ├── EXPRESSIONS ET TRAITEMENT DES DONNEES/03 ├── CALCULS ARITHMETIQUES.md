# 3. CALCULS ARITHMÉTIQUES

## 3.A RÉSULTAT ATTENDU

- Utiliser les opérateurs arithmétiques ABAP
- Comprendre la priorité des opérations
- Choisir des types numériques adaptés
- Gérer division entière, reste et puissance
- Détecter les risques de division par zéro et de dépassement

## 3.B OPÉRATEURS PRINCIPAUX

| Opérateur | Rôle                      | Exemple   |
| --------- | ------------------------- | --------- |
| `+`       | Addition                  | `a + b`   |
| `-`       | Soustraction              | `a - b`   |
| `*`       | Multiplication            | `a * b`   |
| `/`       | Division                  | `a / b`   |
| `DIV`     | Quotient entier           | `a DIV b` |
| `MOD`     | Reste de division entière | `a MOD b` |
| `**`      | Puissance                 | `a ** b`  |

Exemple :

```abap
DATA lv_quantity   TYPE i VALUE 3.
DATA lv_unit_price TYPE p LENGTH 8 DECIMALS 2 VALUE '12.50'.
DATA lv_total      TYPE p LENGTH 10 DECIMALS 2.

lv_total = lv_quantity * lv_unit_price.
```

## 3.C PRIORITÉ DES OPÉRATIONS

L’ordre général est :

1. parenthèses ;
2. puissance ;
3. multiplication, division, `DIV`, `MOD` ;
4. addition et soustraction.

```abap
DATA(lv_result_1) = 2 + 3 * 4.       " 14
DATA(lv_result_2) = ( 2 + 3 ) * 4.   " 20
```

Utiliser des parenthèses lorsque l’intention métier ne doit pas dépendre de la lecture des priorités.

## 3.D DIVISION CLASSIQUE ET DIVISION ENTIÈRE

```abap
DATA lv_dividend TYPE i VALUE 17.
DATA lv_divisor  TYPE i VALUE 5.
DATA lv_quotient TYPE i.
DATA lv_rest     TYPE i.

lv_quotient = lv_dividend DIV lv_divisor.
lv_rest     = lv_dividend MOD lv_divisor.
```

Résultat :

| Calcul     | Valeur |
| ---------- | -----: |
| `17 DIV 5` |    `3` |
| `17 MOD 5` |    `2` |

Pour obtenir une valeur décimale, utiliser un type décimal dans le calcul :

```abap
DATA lv_ratio TYPE decfloat34.

lv_ratio = CONV decfloat34( lv_dividend ) / lv_divisor.
```

## 3.E SIGNE UNAIRE

Les opérateurs `+` et `-` peuvent s’appliquer à un seul opérande :

```abap
DATA lv_amount TYPE i VALUE 10.
DATA lv_reverse TYPE i.

lv_reverse = - lv_amount.
```

## 3.F DÉPASSEMENT ET DIVISION PAR ZÉRO

Une opération peut produire une exception d’exécution :

- division par zéro ;
- valeur hors de la plage du type cible ;
- dépassement pendant un calcul intermédiaire ;
- conversion numérique impossible.

```abap
TRY.
    lv_ratio = lv_dividend / lv_divisor.
  CATCH cx_sy_zerodivide INTO DATA(lx_zero_divide).
    WRITE / lx_zero_divide->get_text( ).
ENDTRY.
```

Le traitement des exceptions sera détaillé dans un dossier dédié.

## 3.G TYPES ADAPTÉS AUX CALCULS

| Besoin                                | Type habituel                | Point d’attention                    |
| ------------------------------------- | ---------------------------- | ------------------------------------ |
| Compteur                              | `i` ou `int8`                | Plage de valeurs                     |
| Montant ou quantité à décimales fixes | `p` ou type DDIC métier      | Longueur et décimales                |
| Calcul décimal avec grande plage      | `decfloat16` ou `decfloat34` | Règles d’arrondi                     |
| Calcul scientifique approximatif      | `f`                          | Représentation binaire approximative |

> [!IMPORTANT]
> Pour les montants et quantités SAP, utiliser de préférence les types métier du Dictionnaire ABAP, avec leurs champs de référence pour devise ou unité.

## 3.H EXEMPLE MÉTIER

```abap
DATA lv_net_amount   TYPE p LENGTH 8 DECIMALS 2 VALUE '149.90'.
DATA lv_discount     TYPE p LENGTH 5 DECIMALS 2 VALUE '10.00'.
DATA lv_tax_rate     TYPE p LENGTH 5 DECIMALS 2 VALUE '20.00'.
DATA lv_discounted   TYPE p LENGTH 8 DECIMALS 2.
DATA lv_gross_amount TYPE p LENGTH 8 DECIMALS 2.

lv_discounted = lv_net_amount * ( 1 - lv_discount / 100 ).
lv_gross_amount = lv_discounted * ( 1 + lv_tax_rate / 100 ).
```

Chaque étape métier est conservée dans une variable distincte afin de faciliter le contrôle du résultat.

## 3.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 3.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage et les formats externes.

## 3.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TRY.
    lv_ratio = lv_dividend / lv_divisor.
  CATCH cx_sy_zerodivide INTO DATA(lx_zero_divide).
    WRITE / lx_zero_divide->get_text( ).
ENDTRY.
```

## 3.L TERMES DU LEXIQUE

- [Instruction ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## 3.M RÉFÉRENCES OFFICIELLES SAP

- [Arithmetic Expressions — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENARITHMETIC_EXPRESSION_GLOSRY.html)
- [Processing Data — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/processing-data_b025c9e3-697d-423f-977a-43b9051a7c15)
- [Avoiding the Pitfalls of Type Conversions — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/avoiding-the-pitfalls-of-type-conversions_e1feca3f-d704-4cd4-aa4e-3072af1659c6)


---

[Chapitre suivant — FONCTIONS NUMÉRIQUES ET ARRONDIS](<./04 ├── FONCTIONS NUMERIQUES ET ARRONDIS.md>)
