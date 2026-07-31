# 🌸 SOUS-PROGRAMMES AVEC FORM ET ENDFORM

## 🌺 OBJECTIFS

- Définir un sous-programme local
- Comprendre le rôle de `FORM` et `ENDFORM`
- Nommer un sous-programme selon sa responsabilité
- Déclarer des données locales
- Identifier les limites de ce mécanisme

## 🌺 SYNTAXE MINIMALE

```abap
FORM form_name.
  " Instructions
ENDFORM.
```

`FORM` ouvre la définition du sous-programme. `ENDFORM` la termine.

Le sous-programme doit être défini dans un programme qui autorise les sous-programmes, directement ou au moyen d’un include rattaché à ce programme.

## 🌺 PREMIER EXEMPLE

```abap
REPORT z_demo_form_01.

START-OF-SELECTION.
  PERFORM display_message.

FORM display_message.
  WRITE / 'Sous-programme exécuté'.
ENDFORM.
```

## 🌺 DONNÉES LOCALES

```abap
FORM build_label.
  DATA lv_label TYPE string.

  lv_label = |Utilisateur : { sy-uname }|.
  WRITE / lv_label.
ENDFORM.
```

`lv_label` est créé lors de l’appel et n’est accessible qu’à l’intérieur du sous-programme.

## 🌺 NOMMER PAR UNE ACTION

Un sous-programme réalise un traitement. Son nom doit donc exprimer une action.

| Nom faible  | Nom plus précis           |
| ----------- | ------------------------- |
| `data`      | `read_customer_data`      |
| `treatment` | `calculate_net_amount`    |
| `output`    | `display_application_log` |
| `check`     | `validate_selection`      |

La longueur maximale et les conventions exactes dépendent de la version ABAP et des règles du projet. La priorité reste un nom non ambigu.

## 🌺 PAS D’IMBRICATION

Une définition `FORM ... ENDFORM` ne doit pas être placée à l’intérieur d’un autre bloc de traitement.

Incorrect :

```abap
START-OF-SELECTION.
  FORM display_message.
    WRITE / 'Texte'.
  ENDFORM.
```

Correct :

```abap
START-OF-SELECTION.
  PERFORM display_message.

FORM display_message.
  WRITE / 'Texte'.
ENDFORM.
```

## 🌺 POSITION DANS LE PROGRAMME

Dans un petit programme exécutable, les blocs d’événements apparaissent généralement avant les sous-programmes afin que le flux principal soit visible rapidement.

```abap
REPORT z_demo_form_02.

START-OF-SELECTION.
  PERFORM validate_data.
  PERFORM execute_process.

FORM validate_data.
  " Contrôles
ENDFORM.

FORM execute_process.
  " Traitement
ENDFORM.
```

Dans un programme plus volumineux, les sous-programmes peuvent être regroupés dans un include dédié.

## 🌺 LIMITES

Les sous-programmes :

- appartiennent au programme principal ;
- peuvent accéder aux données globales de ce programme ;
- ne proposent pas les mécanismes d’encapsulation des classes ;
- sont moins adaptés à la réutilisation transversale que les méthodes ou modules fonction ;
- restent fréquents dans les applications classiques existantes.

## 🌺 POINTS À RETENIR

- `FORM` définit une procédure locale et `ENDFORM` la termine.
- Une définition ne s’exécute pas sans appel `PERFORM`.
- Les données locales doivent être préférées aux données globales quand elles suffisent.
- Le nom doit exprimer une responsabilité précise.
- Les nouvelles architectures doivent éviter de multiplier les sous-programmes fortement couplés aux données globales.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [FORM — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPFORM.html)
- [Source Code Modularization — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSOURCE_CODE_MODULAR_GUIDL.html)
- [Naming — ABAP Programming Guidelines](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENNAMING_GDL.html)

---

➡️ [Chapitre suivant — APPELS AVEC PERFORM](<./04 - 🍧 APPELS AVEC PERFORM.md>)
