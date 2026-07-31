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

## 🌺 CAS D’USAGE

Dans un contexte où un import doit signaler clairement les erreurs, permettre leur traitement et éviter les arrêts non maîtrisés, le besoin consiste à **gérer une situation d’erreur avec codes retour et sy-subrc et produire une information exploitable par l’appelant ou l’utilisateur**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **gérer une situation d’erreur avec codes retour et sy-subrc et produire une information exploitable par l’appelant ou l’utilisateur**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Return Code — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENRETURN_CODE_GUIDL.html)
- [ABAP Statements Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_STATEMENTS_OVERVIEW.html)


---

➡️ [Chapitre suivant — CLASSES D’EXCEPTION ET CATÉGORIES](<./08 - 🍧 CLASSES D EXCEPTION ET CATEGORIES.md>)
