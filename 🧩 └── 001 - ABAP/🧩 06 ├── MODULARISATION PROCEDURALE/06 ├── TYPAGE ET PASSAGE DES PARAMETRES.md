# TYPAGE ET PASSAGE DES PARAMÈTRES

## RÉSULTAT ATTENDU

- Typer les paramètres formels
- Distinguer passage par référence et passage par valeur
- Utiliser `VALUE(...)` lorsque l’isolation est nécessaire
- Comprendre les conversions possibles
- Éviter les interfaces génériques inutiles

## PARAMÈTRE FORMEL ET PARAMÈTRE RÉEL

Le paramètre formel est déclaré dans le `FORM`. Le paramètre réel est fourni au `PERFORM`.

```abap
PERFORM double_value USING lv_input CHANGING lv_output.

FORM double_value
  USING    iv_input  TYPE i
  CHANGING cv_output TYPE i.

  cv_output = iv_input * 2.
ENDFORM.
```

| Élément          | Exemple    |
| ---------------- | ---------- |
| Paramètre réel   | `lv_input` |
| Paramètre formel | `iv_input` |

## TYPAGE EXPLICITE

Préférer des types explicites ou des types nommés.

```abap
TYPES ty_amount TYPE p LENGTH 10 DECIMALS 2.

FORM calculate_discount
  USING    iv_amount   TYPE ty_amount
           iv_rate     TYPE decfloat16
  CHANGING cv_discount TYPE ty_amount.
```

Le typage permet au contrôle de syntaxe et au runtime de vérifier la compatibilité des données.

## PASSAGE PAR RÉFÉRENCE

Le passage par référence donne au paramètre formel un accès à la donnée réelle de l’appelant.

```mermaid
flowchart LR
    A["lv_quantity dans l’appelant"] --> B["Référence utilisée par cv_quantity"]
    B --> C["Modification de la même donnée"]
```

Cette forme évite une copie, mais elle permet une modification directe. Il faut donc respecter strictement l’intention `USING` ou `CHANGING`.

## PASSAGE PAR VALEUR

`VALUE(...)` demande une copie locale du paramètre d’entrée.

```abap
FORM normalize_text
  USING VALUE(iv_text) TYPE string.

  CONDENSE iv_text.
  TRANSLATE iv_text TO UPPER CASE.
  WRITE / iv_text.
ENDFORM.
```

La variable réelle fournie par l’appelant n’est pas modifiée par les changements appliqués à `iv_text`.

## VALUE AVEC CHANGING

Avec un paramètre `CHANGING`, `VALUE(...)` correspond à un passage par valeur et résultat : une copie locale est manipulée, puis la valeur finale est retransmise au paramètre réel lorsque la procédure se termine normalement.

```abap
FORM calculate_next
  CHANGING VALUE(cv_number) TYPE i.

  cv_number = cv_number + 1.
ENDFORM.
```

Cette forme doit être utilisée avec une intention claire ; elle peut introduire une copie coûteuse pour de grands objets de données.

## CONVERSIONS

Lorsqu’un paramètre réel et un paramètre formel ne possèdent pas exactement le même type, ABAP peut effectuer une conversion selon les règles de compatibilité applicables.

Risques :

- perte de décimales ;
- troncature de caractères ;
- dépassement numérique ;
- format inattendu ;
- coût de conversion répété.

Préférer des types identiques pour les données métier importantes.

## TYPES GÉNÉRIQUES

Un paramètre générique accepte plusieurs types réels. Cette flexibilité réduit les contrôles disponibles dans la procédure.

Utiliser un type générique uniquement lorsque le traitement doit réellement fonctionner avec plusieurs types compatibles. Sinon, déclarer un type précis.

## CHOIX PRATIQUE

| Besoin                                               | Forme recommandée                                               |
| ---------------------------------------------------- | --------------------------------------------------------------- |
| Lire une petite valeur sans la modifier              | `USING` typé ; `VALUE(...)` si isolation nécessaire             |
| Modifier une donnée de l’appelant                    | `CHANGING` typé                                                 |
| Traiter une grande table sans copie                  | Référence explicite via `USING` ou `CHANGING` selon l’intention |
| Protéger une donnée contre toute modification locale | `USING VALUE(...)`                                              |

## POINTS À RETENIR

- Typer les paramètres rend l’interface plus sûre.
- Le passage par référence est efficace mais expose la donnée réelle.
- `VALUE(...)` crée une copie locale pour un paramètre d’entrée.
- `CHANGING VALUE(...)` applique un mécanisme valeur-résultat.
- Les copies de grandes tables ou structures doivent être justifiées.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
FORM normalize_text
  USING VALUE(iv_text) TYPE string.

  CONDENSE iv_text.
  TRANSLATE iv_text TO UPPER CASE.
  WRITE / iv_text.
ENDFORM.
```

## TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## RÉFÉRENCES OFFICIELLES SAP

- [FORM — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFORM.html)
- [PERFORM — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPPERFORM.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)


---

[Chapitre suivant — PORTÉE DES DONNÉES ET EFFETS DE BORD](<./07 ├── PORTEE DES DONNEES ET EFFETS DE BORD.md>)
