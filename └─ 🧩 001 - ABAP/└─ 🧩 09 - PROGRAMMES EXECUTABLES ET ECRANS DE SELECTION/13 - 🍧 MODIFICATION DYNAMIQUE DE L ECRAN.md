# 🌸 MODIFICATION DYNAMIQUE DE L’ÉCRAN

## 🌺 OBJECTIFS

- Grouper des champs avec `MODIF ID`
- Modifier les propriétés avant affichage
- Utiliser la table système `SCREEN`
- Rafraîchir l’écran après une action utilisateur
- Éviter les écrans incohérents ou inaccessibles

## 🌺 GROUPE DE MODIFICATION

```abap
PARAMETERS:
  p_detail AS CHECKBOX USER-COMMAND refresh,
  p_limit  TYPE i MODIF ID det.
```

`MODIF ID det` affecte le champ au groupe `DET`. L’identifiant comporte au maximum trois caractères significatifs pour le groupe d’écran.

## 🌺 AT SELECTION-SCREEN OUTPUT

```abap
AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'DET'.
      IF p_detail = abap_true.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
```

Cet événement correspond à la préparation de l’écran avant son affichage.

## 🌺 PROPRIÉTÉS COURANTES

| Composant `SCREEN` | Effet général                                    |
| ------------------ | ------------------------------------------------ |
| `ACTIVE`           | Active ou désactive l’élément                    |
| `INPUT`            | Autorise ou interdit la saisie                   |
| `OUTPUT`           | Contrôle la restitution                          |
| `INVISIBLE`        | Masque le contenu ou l’élément selon le contexte |
| `REQUIRED`         | Marque le champ comme obligatoire                |
| `INTENSIFIED`      | Accentue l’affichage                             |
| `GROUP1`           | Groupe issu de `MODIF ID`                        |
| `NAME`             | Nom technique de l’élément                       |

Les interactions entre propriétés dépendent du type d’élément. Tester le comportement réel dans SAP GUI.

## 🌺 RAFRAÎCHISSEMENT

`USER-COMMAND` sur une case à cocher ou un bouton radio déclenche un aller-retour vers le programme. Le prochain `AT SELECTION-SCREEN OUTPUT` peut alors reconstruire l’état des champs.

```mermaid
flowchart LR
    A["Modification utilisateur"] --> B["USER-COMMAND"]
    B --> C["Traitement PAI de sélection"]
    C --> D["AT SELECTION-SCREEN OUTPUT"]
    D --> E["Nouvel affichage"]
```

## 🌺 RÈGLES DE SÉCURITÉ

- un champ masqué ne doit pas être considéré comme sécurisé ;
- une valeur désactivée doit encore être validée avant traitement ;
- ne pas rendre obligatoire un champ simultanément inactif ;
- conserver une logique déterministe ;
- éviter de modifier les éléments par leur nom si un groupe suffit ;
- ne pas réinitialiser les valeurs à chaque PBO.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [SELECTION-SCREEN, MODIF ID — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECTION-SCREEN_MODIF_ID.html)
- [Modifying Input Fields — SAP Help Portal](https://help.sap.com/saphelp_autoid2007/helpdata/EN/9f/dba70535c111d1829f0000e829fbfe/content.htm?no_cache=true)
- [Selection Screen Processing — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/a85596deeb19418982bee031d1fd1427/4a43c40d5a503f04e10000000a421937.html)

---

➡️ [Chapitre suivant — VARIANTES DE SELECTION](<./14 - 🍧 VARIANTES DE SELECTION.md>)
