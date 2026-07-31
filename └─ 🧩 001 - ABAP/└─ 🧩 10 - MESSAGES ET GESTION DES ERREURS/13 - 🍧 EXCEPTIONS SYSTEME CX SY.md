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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Exception Classes for ABAP Statements — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_EXCEPTION_CLASSES.html)
- [System Response After a Class-Based Exception — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTIONS_SYSTEM_RESPONSE.html)
- [Classic and Class-Based Exceptions — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCLASS_EXCEPTION_GUIDL.html)

---

➡️ [Chapitre suivant — CLEANUP ET COHERENCE DU TRAITEMENT](<./14 - 🍧 CLEANUP ET COHERENCE DU TRAITEMENT.md>)
