# 🌸 MACROS AVEC DEFINE

## 🌺 OBJECTIFS

- Comprendre le fonctionnement d’une macro ABAP
- Définir une macro avec `DEFINE`
- Utiliser les paramètres positionnels `&1` à `&9`
- Identifier les limites de ce mécanisme
- Choisir une procédure lorsque l’interface doit être robuste

## 🌺 DÉFINITION

Une macro est un bloc source défini avec `DEFINE ... END-OF-DEFINITION`.

Lorsqu’elle est utilisée, son code est développé dans le contexte de l’appel. Il ne s’agit pas d’un appel de procédure avec pile et interface typée.

```mermaid
flowchart LR
    A["Définition de la macro"] --> B["Utilisation dans le code"]
    B --> C["Substitution textuelle"]
    C --> D["Code développé dans le programme"]
```

## 🌺 SYNTAXE

```abap
DEFINE macro_name.
  " Instructions utilisant &1 à &9
END-OF-DEFINITION.
```

## 🌺 EXEMPLE

```abap
REPORT z_demo_macro_01.

DATA lt_messages TYPE STANDARD TABLE OF string
                 WITH EMPTY KEY.

DEFINE add_message.
  APPEND &1 TO lt_messages.
END-OF-DEFINITION.

START-OF-SELECTION.
  add_message 'Début du traitement'.
  add_message 'Fin du traitement'.

  LOOP AT lt_messages INTO DATA(lv_message).
    WRITE / lv_message.
  ENDLOOP.
```

## 🌺 PLUSIEURS PARAMÈTRES

```abap
DEFINE write_pair.
  WRITE: / &1, &2.
END-OF-DEFINITION.

write_pair 'Utilisateur' sy-uname.
```

Les paramètres sont positionnels et ne possèdent pas d’interface typée propre à la macro.

## 🌺 DIFFÉRENCE AVEC UN SOUS-PROGRAMME

| Macro                                    | Sous-programme               |
| ---------------------------------------- | ---------------------------- |
| Substitution source                      | Appel d’une procédure        |
| Paramètres `&1` à `&9`                   | Paramètres formels typés     |
| Pas de portée locale autonome comparable | Données locales possibles    |
| Débogage moins direct                    | Pile d’appels visible        |
| Forte dépendance au contexte             | Interface explicite possible |

## 🌺 RISQUES

Une macro peut dépendre d’objets qui ne sont pas visibles dans son appel :

```abap
DEFINE reset_state.
  CLEAR: gv_error, gt_messages.
END-OF-DEFINITION.
```

L’appel `reset_state.` ne montre pas les objets modifiés.

Autres risques :

- erreurs difficiles à localiser après développement de la macro ;
- collisions de noms ;
- effets de bord cachés ;
- absence de typage des paramètres ;
- duplication du code généré à chaque utilisation.

## 🌺 QUAND EN RENCONTRER

Les macros existent dans du code classique, des frameworks historiques et certaines constructions techniques. Elles doivent être comprises pour maintenir ce code.

Pour du nouveau code métier, préférer :

- une méthode ;
- un sous-programme local dans un programme procédural existant ;
- un module fonction lorsqu’une interface globale est réellement requise.

## 🌺 POINTS À RETENIR

- Une macro est développée par substitution textuelle.
- Elle accepte jusqu’à neuf paramètres positionnels `&1` à `&9`.
- Elle ne fournit pas d’interface typée comparable à une procédure.
- Son comportement dépend du contexte source.
- Les macros doivent rester rares, courtes et parfaitement explicites.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Créer des sous-programmes avec trop de paramètres globaux.
- Utiliser des appels externes ou dynamiques sans contrôle du nom et de l’existence.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
REPORT z_demo_macro_01.

DATA lt_messages TYPE STANDARD TABLE OF string
                 WITH EMPTY KEY.

DEFINE add_message.
  APPEND &1 TO lt_messages.
END-OF-DEFINITION.

START-OF-SELECTION.
  add_message 'Début du traitement'.
  add_message 'Fin du traitement'.

  LOOP AT lt_messages INTO DATA(lv_message).
    WRITE / lv_message.
  ENDLOOP.
```

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [DEFINE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDEFINE.html)
- [Macros — ABAP Programming Guidelines](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENMACROS_GUIDL.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)


---

➡️ [Chapitre suivant — APPELS DYNAMIQUES ET EXTERNES](<./10 - 🍧 APPELS DYNAMIQUES ET EXTERNES.md>)
