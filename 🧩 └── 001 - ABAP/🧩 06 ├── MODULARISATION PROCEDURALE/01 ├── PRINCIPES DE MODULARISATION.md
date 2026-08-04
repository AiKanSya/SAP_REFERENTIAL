# PRINCIPES DE MODULARISATION

## RÉSULTAT ATTENDU

- Comprendre pourquoi découper un programme ABAP
- Distinguer organisation du code et modularisation fonctionnelle
- Identifier les principales unités de modularisation ABAP
- Réduire la duplication et les dépendances implicites
- Choisir un niveau de découpage adapté au traitement

## POURQUOI MODULARISER

Un programme monolithique concentre les déclarations, les contrôles, les calculs et les sorties dans un même bloc. Cette organisation rend les modifications risquées et les tests difficiles.

La modularisation consiste à isoler un traitement cohérent derrière une interface identifiable.

```mermaid
flowchart LR
    A["Traitement monolithique"] --> B["Identifier les responsabilités"]
    B --> C["Extraire des unités cohérentes"]
    C --> D["Définir les entrées et sorties"]
    D --> E["Réutiliser et tester plus facilement"]
```

## BÉNÉFICES ATTENDUS

| Bénéfice      | Effet concret                                           |
| ------------- | ------------------------------------------------------- |
| Lisibilité    | Le programme principal décrit l’enchaînement métier     |
| Maintenance   | Une règle est modifiée à un seul endroit                |
| Réutilisation | Un même traitement peut être appelé plusieurs fois      |
| Testabilité   | Les entrées et sorties sont identifiables               |
| Débogage      | La pile d’appels permet de suivre le chemin d’exécution |

## UNITÉS DISPONIBLES EN ABAP

ABAP propose plusieurs mécanismes :

- sous-programmes `FORM ... ENDFORM` ;
- modules fonction ;
- méthodes de classes ;
- modules de dialogue ;
- blocs d’événements exécutés par l’environnement d’exécution.

Ce dossier traite uniquement la modularisation procédurale locale avec les sous-programmes, les includes et les macros. Les modules fonction et les méthodes seront abordés dans des dossiers dédiés.

## ORGANISATION ET MODULARISATION

Un `INCLUDE` sépare physiquement le code source, mais ne crée pas d’interface d’appel.

Un sous-programme crée une unité appelée avec `PERFORM` et peut exposer des paramètres.

| Mécanisme          | Sépare le fichier source | Définit une interface | Appelé explicitement |
| ------------------ | -----------------------: | --------------------: | -------------------: |
| `INCLUDE`          |                      Oui |                   Non |                  Non |
| `FORM` / `PERFORM` |           Éventuellement |                   Oui |                  Oui |
| Macro `DEFINE`     |       Non nécessairement |             Non typée | Remplacement textuel |

## EXEMPLE AVANT MODULARISATION

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

## RÈGLE DE BASE

Une unité doit répondre à une responsabilité clairement nommée. Un nom vague comme `process_data` masque généralement plusieurs traitements.

Préférer :

- `validate_input` ;
- `calculate_total` ;
- `build_output` ;
- `display_result`.

## POINTS À RETENIR

- Modulariser signifie isoler une responsabilité derrière une interface.
- Un include organise le code sans créer de véritable abstraction.
- Un sous-programme est une unité de traitement locale appelée avec `PERFORM`.
- Les dépendances globales réduisent l’intérêt de la modularisation.
- Pour du nouveau développement, les méthodes offrent généralement une interface plus robuste ; elles seront étudiées dans le dossier ABAP Objects.

## PROCESS

### Étape 1 — Identifier les responsabilités du bloc

Ouvrir le traitement et séparer sur papier ses actions : validation, lecture, calcul, mise à jour, journalisation et présentation. Une responsabilité doit pouvoir être nommée par un verbe précis.

Si un bloc mélange plusieurs actions, ne choisir pas encore le mécanisme ABAP ; définir d’abord les frontières métier.

### Étape 2 — Définir les entrées et sorties

Pour chaque responsabilité, relever les données réellement lues, les valeurs produites et les erreurs possibles. Distinguer une entrée nécessaire d’une variable globale accessible par facilité.

Une unité dont les entrées ou sorties ne peuvent pas être listées reste trop couplée pour être extraite proprement.

### Étape 3 — Choisir l’unité adaptée

Dans du code procédural existant, utiliser un `FORM` local uniquement pour maintenir ce modèle. Pour un nouveau service réutilisable et testable, préférer une méthode. Un `INCLUDE` organise le source mais ne définit pas d’interface.

### Étape 4 — Extraire une responsabilité à la fois

Créer l’unité avec un nom orienté action, déclarer ses paramètres et déplacer uniquement le bloc correspondant. Remplacer l’ancien bloc par l’appel puis exécuter contrôle syntaxique et test ciblé.

### Étape 5 — Vérifier le découpage

Comparer le résultat avant/après, rechercher la duplication supprimée et examiner les accès globaux restants. Le découpage est valide lorsque le programme principal exprime l’enchaînement métier et que chaque unité possède un contrat identifiable.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## SNIPPET À RÉUTILISER

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

## TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)

## RÉFÉRENCES OFFICIELLES SAP

- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Source Code Organization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_ORGA_GDL.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)

---

[Chapitre suivant — BLOCS DE TRAITEMENT ET PROCÉDURES](<./02 ├── BLOCS DE TRAITEMENT ET PROCEDURES.md>)
