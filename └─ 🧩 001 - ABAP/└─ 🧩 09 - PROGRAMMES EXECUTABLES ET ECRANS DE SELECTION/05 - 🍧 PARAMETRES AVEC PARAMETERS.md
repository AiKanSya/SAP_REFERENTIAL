# 🌸 PARAMÈTRES AVEC PARAMETERS

## 🌺 OBJECTIFS

- Déclarer une valeur unique sur l’écran de sélection
- Utiliser un type ABAP ou DDIC adapté
- Définir une valeur par défaut
- Créer une case à cocher ou des boutons radio
- Comprendre la variable globale générée

## 🌺 DÉCLARATION SIMPLE

```abap
PARAMETERS p_carr TYPE scarr-carrid.
```

Cette instruction crée :

- un objet de données global `p_carr` ;
- un champ de saisie sur l’écran de sélection ;
- les contrôles techniques associés au type.

La longueur du nom est limitée par les règles du langage pour les paramètres de sélection. Utiliser une convention courte et explicite, généralement préfixée par `p_`.

## 🌺 TYPAGE DDIC

```abap
PARAMETERS:
  p_bukrs TYPE bukrs,
  p_date  TYPE sy-datum.
```

Un type DDIC apporte selon sa définition :

- format de sortie ;
- aide à la saisie ;
- conversion ;
- documentation ;
- contrôle de valeurs fixes.

Ne pas utiliser un type générique `c` lorsque le champ possède une sémantique DDIC connue.

## 🌺 VALEUR PAR DÉFAUT

```abap
PARAMETERS p_limit TYPE i DEFAULT 100.
```

`DEFAULT` convient à une valeur statique ou directement disponible lors de la déclaration. Pour une valeur calculée ou dépendante du contexte, utiliser `INITIALIZATION`.

## 🌺 CHAMP OBLIGATOIRE

```abap
PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
```

`OBLIGATORY` impose une valeur avant l’exécution. Cette option ne remplace pas la validation métier.

## 🌺 CASE À COCHER

```abap
PARAMETERS p_test AS CHECKBOX DEFAULT abap_true.
```

La valeur cochée est généralement `X`, compatible avec `abap_true`.

```abap
IF p_test = abap_true.
  " Mode test
ENDIF.
```

## 🌺 BOUTONS RADIO

```abap
PARAMETERS:
  p_sum RADIOBUTTON GROUP out DEFAULT 'X',
  p_det RADIOBUTTON GROUP out.
```

Tous les boutons d’un même groupe sont exclusifs. Prévoir une valeur par défaut pour éviter un état ambigu.

## 🌺 PARAMÈTRE TECHNIQUE MASQUÉ

```abap
PARAMETERS p_mode TYPE c LENGTH 1 NO-DISPLAY.
```

Un champ masqué peut être alimenté par variante ou par `SUBMIT`. Ne pas y stocker un secret : la valeur reste une donnée du programme.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [PARAMETERS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPPARAMETERS.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)

---

➡️ [Chapitre suivant — CRITERES AVEC SELECT OPTIONS](<./06 - 🍧 CRITERES AVEC SELECT OPTIONS.md>)
