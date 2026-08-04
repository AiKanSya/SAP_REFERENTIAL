# 13. EXCEPTIONS SYSTÈME CX_SY

## 13.A RÉSULTAT ATTENDU

- Identifier les exceptions système interceptables
- Lire la documentation d’une instruction
- Intercepter uniquement les erreurs récupérables
- Préserver les informations techniques
- Éviter de masquer les défauts de programmation

## 13.B PRINCIPE

De nombreuses erreurs du runtime ABAP[^terme-abap] sont représentées par des classes standard commençant par `CX_SY_`.

Exemples courants :

| Domaine                     | Exemples de classes                                      |
| --------------------------- | -------------------------------------------------------- |
| Conversion                  | `CX_SY_CONVERSION_ERROR`, classes spécialisées associées |
| Arithmétique                | `CX_SY_ARITHMETIC_ERROR`, `CX_SY_ZERODIVIDE`             |
| Références                  | `CX_SY_REF_IS_INITIAL`                                   |
| Accès aux tables ou chaînes | classes de dépassement de limites                        |
| Base de données             | `CX_SY_OPEN_SQL_DB`                                      |

La liste exacte dépend de l’instruction et de la version ABAP.

## 13.C CONSULTER LA DOCUMENTATION

La documentation des mots-clés ABAP indique les exceptions pouvant être levées par une instruction.

Ne pas choisir une superclasse au hasard uniquement pour faire disparaître un dump.

## 13.D CONVERSION

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
TRY.
    DATA(lv_number) = CONV i( iv_text ).
  CATCH cx_sy_conversion_no_number INTO DATA(lx_conversion).
    RAISE EXCEPTION TYPE zcx_dev_invalid_input
      EXPORTING
        previous = lx_conversion.
ENDTRY.
```

La couche métier transforme l’exception[^terme-exception] technique en une erreur adaptée à son contrat.

## 13.E DIVISION PAR ZÉRO

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
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
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
IF iv_count = 0.
  RAISE EXCEPTION TYPE zcx_dev_invalid_count.
ENDIF.
```

## 13.F NE PAS TOUT INTERCEPTER

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

## 13.G EXCEPTION NON GÉRÉE

Si aucun gestionnaire compatible n’est trouvé, l’exception conduit à une erreur d’exécution. Le dump contient alors des informations utiles sur la pile d’appels et la cause.

Il est préférable de conserver un dump exploitable plutôt que de poursuivre avec des données incohérentes après une interception vide.

## 13.H CATCH SYSTEM-EXCEPTIONS

Le mécanisme historique `CATCH SYSTEM-EXCEPTIONS` est obsolète pour les nouveaux développements. Utiliser les exceptions basées sur des classes lorsque l’instruction fournit une classe[^terme-classe] interceptable.

## 13.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 13.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 13.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
TRY.
    DATA(lv_number) = CONV i( iv_text ).
  CATCH cx_sy_conversion_no_number INTO DATA(lx_conversion).
    RAISE EXCEPTION TYPE zcx_dev_invalid_input
      EXPORTING
        previous = lx_conversion.
ENDTRY.
```

## 13.L TERMES DU LEXIQUE

- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 13.M RÉFÉRENCES OFFICIELLES SAP

- [Exception Classes for ABAP Statements — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_EXCEPTION_CLASSES.html)
- [System Response After a Class-Based Exception — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTIONS_SYSTEM_RESPONSE.html)
- [Classic and Class-Based Exceptions — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCLASS_EXCEPTION_GUIDL.html)


---

[Chapitre suivant — CLEANUP ET COHÉRENCE DU TRAITEMENT](<./14 ├── CLEANUP ET COHERENCE DU TRAITEMENT.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
