# 🌸 LEVER UNE EXCEPTION AVEC RAISE EXCEPTION

## 🌺 OBJECTIFS

- Déclencher explicitement une exception
- Utiliser `RAISE EXCEPTION TYPE`
- Transmettre des valeurs au constructeur
- Chaîner une cause avec `PREVIOUS`
- Éviter les exceptions sans contexte

## 🌺 FORME DIRECTE

```abap
IF iv_matnr IS INITIAL.
  RAISE EXCEPTION TYPE zcx_dev_invalid_input.
ENDIF.
```

L’instruction crée un objet de la classe indiquée et interrompt le bloc de traitement courant.

## 🌺 PARAMÈTRES DU CONSTRUCTEUR

Une classe d’exception peut exposer des paramètres permettant de conserver les données utiles.

```abap
RAISE EXCEPTION TYPE zcx_dev_product_not_found
  EXPORTING
    matnr = iv_matnr
    werks = iv_werks.
```

Le texte de l’erreur peut ensuite utiliser ces attributs.

## 🌺 LEVER UN OBJET EXISTANT

```abap
DATA lx_error TYPE REF TO zcx_dev_error.

CREATE OBJECT lx_error
  EXPORTING
    textid = zcx_dev_error=>invalid_state.

RAISE EXCEPTION lx_error.
```

La forme directe avec `TYPE` est généralement plus concise. La référence explicite est utile lorsque l’objet doit être préparé ou enrichi avant d’être levé.

## 🌺 CHAÎNER LA CAUSE

```abap
TRY.
    lv_value = CONV i( iv_text ).
  CATCH cx_sy_conversion_no_number INTO DATA(lx_conversion).
    RAISE EXCEPTION TYPE zcx_dev_invalid_input
      EXPORTING
        previous = lx_conversion.
ENDTRY.
```

L’attribut `PREVIOUS` conserve la cause technique initiale. Le niveau supérieur peut présenter une erreur métier tout en préservant le diagnostic complet.

```mermaid
flowchart LR
    A["CX_SY_CONVERSION_NO_NUMBER"] --> B["PREVIOUS"]
    B --> C["ZCX_DEV_INVALID_INPUT"]
```

## 🌺 MESSAGE ET EXCEPTION

Une exception peut être associée à un texte de classe de messages. Cette association est traitée dans le chapitre dédié aux interfaces `IF_T100_MESSAGE` et `IF_T100_DYN_MSG`.

Éviter de lever une exception dont le seul contenu est une chaîne générique sans attribut ni identifiant stable.

## 🌺 ERREUR ATTENDUE

```abap
IF iv_quantity <= 0.
  RAISE EXCEPTION TYPE zcx_dev_invalid_quantity
    EXPORTING
      quantity = iv_quantity.
ENDIF.
```

Le nom de la classe doit exprimer la nature de l’erreur. L’appelant peut alors intercepter précisément cette situation.

## 🌺 CAS D’USAGE

Dans un contexte où un import doit signaler clairement les erreurs, permettre leur traitement et éviter les arrêts non maîtrisés, le besoin consiste à **signaler une erreur au niveau qui la détecte sans terminer arbitrairement le programme**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
TRY.
    lv_value = CONV i( iv_text ).
  CATCH cx_sy_conversion_no_number INTO DATA(lx_conversion).
    RAISE EXCEPTION TYPE zcx_dev_invalid_input
      EXPORTING
        previous = lx_conversion.
ENDTRY.
```

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **signaler une erreur au niveau qui la détecte sans terminer arbitrairement le programme**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [RAISE EXCEPTION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPRAISE_EXCEPTION_CLASS.html)
- [System Response After a Class-Based Exception — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTIONS_SYSTEM_RESPONSE.html)
- [Creating an Exception Class — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/92823e6017aa11d5969b00a0c94260a5.html)


---

➡️ [Chapitre suivant — PROPAGER UNE EXCEPTION AVEC RAISING](<./11 - 🍧 PROPAGER UNE EXCEPTION AVEC RAISING.md>)
