# 🌸 EXCEPTIONS SYSTÈME CX_SY

## 🌺 OBJECTIFS

- Identifier les exceptions système interceptables
- Lire la documentation d’une instruction
- Intercepter uniquement les erreurs récupérables
- Préserver les informations techniques
- Éviter de masquer les défauts de programmation

## 🌺 PRINCIPE

De nombreuses erreurs du runtime ABAP sont représentées par des classes standard commençant par `CX_SY_`.

Exemples courants :

| Domaine                     | Exemples de classes                                      |
| --------------------------- | -------------------------------------------------------- |
| Conversion                  | `CX_SY_CONVERSION_ERROR`, classes spécialisées associées |
| Arithmétique                | `CX_SY_ARITHMETIC_ERROR`, `CX_SY_ZERODIVIDE`             |
| Références                  | `CX_SY_REF_IS_INITIAL`                                   |
| Accès aux tables ou chaînes | classes de dépassement de limites                        |
| Base de données             | `CX_SY_OPEN_SQL_DB`                                      |

La liste exacte dépend de l’instruction et de la version ABAP.

## 🌺 CONSULTER LA DOCUMENTATION

La documentation des mots-clés ABAP indique les exceptions pouvant être levées par une instruction.

Ne pas choisir une superclasse au hasard uniquement pour faire disparaître un dump.

## 🌺 CONVERSION

```abap
TRY.
    DATA(lv_number) = CONV i( iv_text ).
  CATCH cx_sy_conversion_no_number INTO DATA(lx_conversion).
    RAISE EXCEPTION TYPE zcx_dev_invalid_input
      EXPORTING
        previous = lx_conversion.
ENDTRY.
```

La couche métier transforme l’exception technique en une erreur adaptée à son contrat.

## 🌺 DIVISION PAR ZÉRO

```abap
TRY.
    rv_average = iv_total / iv_count.
  CATCH cx_sy_zerodivide INTO DATA(lx_zerodivide).
    RAISE EXCEPTION TYPE zcx_dev_calculation_error
      EXPORTING
        previous = lx_zerodivide.
ENDTRY.
```

Une validation préalable peut être préférable lorsque zéro est une donnée métier prévisible.

```abap
IF iv_count = 0.
  RAISE EXCEPTION TYPE zcx_dev_invalid_count.
ENDIF.
```

## 🌺 NE PAS TOUT INTERCEPTER

```abap
CATCH cx_root.
  " Ignorer
```

Cette pratique masque potentiellement :

- un défaut de programmation ;
- une référence initiale inattendue ;
- une incohérence de données ;
- une erreur technique nécessitant une analyse.

Une exception ne doit être interceptée que si le programme sait produire une réaction correcte.

## 🌺 EXCEPTION NON GÉRÉE

Si aucun gestionnaire compatible n’est trouvé, l’exception conduit à une erreur d’exécution. Le dump contient alors des informations utiles sur la pile d’appels et la cause.

Il est préférable de conserver un dump exploitable plutôt que de poursuivre avec des données incohérentes après une interception vide.

## 🌺 CATCH SYSTEM-EXCEPTIONS

Le mécanisme historique `CATCH SYSTEM-EXCEPTIONS` est obsolète pour les nouveaux développements. Utiliser les exceptions basées sur des classes lorsque l’instruction fournit une classe interceptable.

## 🌺 CAS D’USAGE

Dans un contexte où un import doit signaler clairement les erreurs, permettre leur traitement et éviter les arrêts non maîtrisés, le besoin consiste à **gérer une situation d’erreur avec exceptions système cx_sy et produire une information exploitable par l’appelant ou l’utilisateur**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
    DATA(lv_number) = CONV i( iv_text ).
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

- À l’issue du chapitre, le lecteur sait **gérer une situation d’erreur avec exceptions système cx_sy et produire une information exploitable par l’appelant ou l’utilisateur**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Exception Classes for ABAP Statements — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_EXCEPTION_CLASSES.html)
- [System Response After a Class-Based Exception — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTIONS_SYSTEM_RESPONSE.html)
- [Classic and Class-Based Exceptions — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCLASS_EXCEPTION_GUIDL.html)


---

➡️ [Chapitre suivant — CLEANUP ET COHÉRENCE DU TRAITEMENT](<./14 - 🍧 CLEANUP ET COHERENCE DU TRAITEMENT.md>)
