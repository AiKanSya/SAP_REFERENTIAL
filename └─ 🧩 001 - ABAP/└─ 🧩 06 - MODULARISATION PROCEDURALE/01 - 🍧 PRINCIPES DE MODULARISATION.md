# 🌸 PRINCIPES DE MODULARISATION

## 🌺 OBJECTIFS

- Comprendre pourquoi découper un programme ABAP
- Distinguer organisation du code et modularisation fonctionnelle
- Identifier les principales unités de modularisation ABAP
- Réduire la duplication et les dépendances implicites
- Choisir un niveau de découpage adapté au traitement

## 🌺 POURQUOI MODULARISER

Un programme monolithique concentre les déclarations, les contrôles, les calculs et les sorties dans un même bloc. Cette organisation rend les modifications risquées et les tests difficiles.

La modularisation consiste à isoler un traitement cohérent derrière une interface identifiable.

```mermaid
flowchart LR
    A["Traitement monolithique"] --> B["Identifier les responsabilités"]
    B --> C["Extraire des unités cohérentes"]
    C --> D["Définir les entrées et sorties"]
    D --> E["Réutiliser et tester plus facilement"]
```

## 🌺 BÉNÉFICES ATTENDUS

| Bénéfice      | Effet concret                                           |
| ------------- | ------------------------------------------------------- |
| Lisibilité    | Le programme principal décrit l’enchaînement métier     |
| Maintenance   | Une règle est modifiée à un seul endroit                |
| Réutilisation | Un même traitement peut être appelé plusieurs fois      |
| Testabilité   | Les entrées et sorties sont identifiables               |
| Débogage      | La pile d’appels permet de suivre le chemin d’exécution |

## 🌺 UNITÉS DISPONIBLES EN ABAP

ABAP propose plusieurs mécanismes :

- sous-programmes `FORM ... ENDFORM` ;
- modules fonction ;
- méthodes de classes ;
- modules de dialogue ;
- blocs d’événements exécutés par l’environnement d’exécution.

Ce dossier traite uniquement la modularisation procédurale locale avec les sous-programmes, les includes et les macros. Les modules fonction et les méthodes seront abordés dans des dossiers dédiés.

## 🌺 ORGANISATION ET MODULARISATION

Un `INCLUDE` sépare physiquement le code source, mais ne crée pas d’interface d’appel.

Un sous-programme crée une unité appelée avec `PERFORM` et peut exposer des paramètres.

| Mécanisme          | Sépare le fichier source | Définit une interface | Appelé explicitement |
| ------------------ | -----------------------: | --------------------: | -------------------: |
| `INCLUDE`          |                      Oui |                   Non |                  Non |
| `FORM` / `PERFORM` |           Éventuellement |                   Oui |                  Oui |
| Macro `DEFINE`     |       Non nécessairement |             Non typée | Remplacement textuel |

## 🌺 EXEMPLE AVANT MODULARISATION

```abap
REPORT z_demo_modular_01.

PARAMETERS: p_qty   TYPE i,
            p_price TYPE p LENGTH 8 DECIMALS 2.

DATA lv_total TYPE p LENGTH 10 DECIMALS 2.

START-OF-SELECTION.
  IF p_qty < 0 OR p_price < 0.
    MESSAGE 'Valeurs négatives interdites' TYPE 'E'.
  ENDIF.

  lv_total = p_qty * p_price.
  WRITE: / 'Total :', lv_total.
```

Après découpage, le bloc principal peut exprimer l’intention :

```abap
START-OF-SELECTION.
  PERFORM validate_input.
  PERFORM calculate_total CHANGING lv_total.
  PERFORM display_result USING lv_total.
```

## 🌺 RÈGLE DE BASE

Une unité doit répondre à une responsabilité clairement nommée. Un nom vague comme `process_data` masque généralement plusieurs traitements.

Préférer :

- `validate_input` ;
- `calculate_total` ;
- `build_output` ;
- `display_result`.

## 🌺 POINTS À RETENIR

- Modulariser signifie isoler une responsabilité derrière une interface.
- Un include organise le code sans créer de véritable abstraction.
- Un sous-programme est une unité de traitement locale appelée avec `PERFORM`.
- Les dépendances globales réduisent l’intérêt de la modularisation.
- Pour du nouveau développement, les méthodes offrent généralement une interface plus robuste ; elles seront étudiées dans le dossier ABAP Objects.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)

---

➡️ [Chapitre suivant — BLOCS DE TRAITEMENT ET PROCEDURES](<./02 - 🍧 BLOCS DE TRAITEMENT ET PROCEDURES.md>)
