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

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## 🌺 VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)


---

➡️ [Chapitre suivant — BLOCS DE TRAITEMENT ET PROCÉDURES](<./02 - 🍧 BLOCS DE TRAITEMENT ET PROCEDURES.md>)
