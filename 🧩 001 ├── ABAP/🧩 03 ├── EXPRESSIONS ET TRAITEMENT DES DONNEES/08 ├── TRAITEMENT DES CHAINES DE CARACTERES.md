# 8. TRAITEMENT DES CHAÎNES DE CARACTÈRES

## 8.A RÉSULTAT ATTENDU

- Distinguer champs caractère fixes et chaînes variables
- Nettoyer et normaliser un texte
- Utiliser les principales instructions historiques de traitement
- Utiliser des fonctions intégrées dans une expression
- Choisir entre modification directe et production d’une nouvelle valeur

## 8.B TYPES CARACTÈRE

| Type     | Longueur | Comportement principal             |
| -------- | -------- | ---------------------------------- |
| `c`      | Fixe     | Complété avec des espaces à droite |
| `string` | Variable | Longueur adaptée au contenu        |
| `n`      | Fixe     | Texte numérique                    |
| `d`      | 8        | Date interne                       |
| `t`      | 6        | Heure interne                      |

```abap
DATA lv_fixed  TYPE c LENGTH 10 VALUE 'ABAP'.
DATA lv_string TYPE string      VALUE `ABAP`.
```

`lv_fixed` occupe dix caractères. `lv_string` contient quatre caractères utiles.

## 8.C LONGUEUR D’UN TEXTE

```abap
DATA lv_text TYPE string VALUE `ABAP SAP GUI`.
DATA(lv_length) = strlen( lv_text ).
```

Pour les champs de longueur fixe, les espaces de fin peuvent influencer le résultat selon la fonction utilisée et le type de l’argument. Vérifier la fonction adaptée au besoin.

## 8.D CONDENSE

`CONDENSE` réduit les suites d’espaces et supprime les espaces de début et de fin.

```abap
DATA lv_text TYPE string VALUE `  Consultant   technique   SAP  `.

CONDENSE lv_text.
```

Résultat :

```text
Consultant technique SAP
```

Pour supprimer tous les espaces :

```abap
CONDENSE lv_text NO-GAPS.
```

## 8.E TRANSLATE

```abap
TRANSLATE lv_text TO UPPER CASE.
TRANSLATE lv_text TO LOWER CASE.
```

Fonctions équivalentes produisant une nouvelle valeur :

```abap
DATA(lv_upper) = to_upper( lv_text ).
DATA(lv_lower) = to_lower( lv_text ).
```

La différence principale :

- `TRANSLATE` modifie l’objet fourni ;
- `to_upper( )` et `to_lower( )` retournent une valeur.

## 8.F SHIFT

`SHIFT` déplace le contenu d’un objet caractère.

```abap
DATA lv_code TYPE c LENGTH 10 VALUE '0000123456'.

SHIFT lv_code LEFT DELETING LEADING '0'.
```

Autres usages :

```abap
SHIFT lv_text LEFT.
SHIFT lv_text RIGHT.
SHIFT lv_text BY 3 PLACES LEFT.
```

Pour un identifiant SAP[^terme-acro-sap] avec conversion exit, ne pas remplacer systématiquement la conversion ALPHA par une suppression manuelle de zéros.

## 8.G FONCTIONS DE TRANSFORMATION

Exemples usuels :

```abap
DATA(lv_clean) = condense( val = lv_text ).
DATA(lv_upper) = to_upper( lv_text ).
DATA(lv_lower) = to_lower( lv_text ).
DATA(lv_repeated) = repeat( val = `-` occ = 20 ).
```

Les fonctions peuvent être combinées :

```abap
DATA(lv_normalized) = to_upper( condense( val = lv_text ) ).
```

Ne pas imbriquer trop de fonctions lorsque le traitement devient difficile à tester.

## 8.H NORMALISATION D’UNE SAISIE

```abap
PARAMETERS p_code TYPE c LENGTH 20.

START-OF-SELECTION.
  DATA(lv_code) = to_upper( condense( val = CONV string( p_code ) ) ).

  WRITE / lv_code.
```

Ce traitement :

1. convertit la saisie en `string` ;
2. normalise les espaces ;
3. convertit le texte en majuscules.

## 8.I INSTRUCTIONS OU FONCTIONS

| Besoin                                           | Forme adaptée                                       |
| ------------------------------------------------ | --------------------------------------------------- |
| Modifier directement une variable existante      | `CONDENSE`, `TRANSLATE`, `SHIFT`                    |
| Produire une nouvelle valeur dans une expression | `condense( )`, `to_upper( )`, `substring( )`        |
| Enchaîner plusieurs transformations lisibles     | Fonctions avec variables intermédiaires             |
| Maintenir du code ancien                         | Respecter la forme existante si elle reste correcte |

## 8.J VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 8.K ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage[^terme-encodage] et les formats externes.

## 8.L SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
PARAMETERS p_code TYPE c LENGTH 20.

START-OF-SELECTION.
  DATA(lv_code) = to_upper( condense( val = CONV string( p_code ) ) ).

  WRITE / lv_code.
```

## 8.M TERMES DU LEXIQUE

- [Instruction ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## 8.N RÉFÉRENCES OFFICIELLES SAP

- [Character String and Byte String Processing — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSTRING_FUNCTIONS.html)
- [Processing Functions for Character-Like Arguments — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENPROCESS_FUNCTIONS.html)
- [Processing Data — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/processing-data_b025c9e3-697d-423f-977a-43b9051a7c15)


---

[Chapitre suivant — CONCATÉNATION ET MODÈLES DE CHAÎNES](<./09 ├── CONCATENATION ET MODELES DE CHAINES.md>)

[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
