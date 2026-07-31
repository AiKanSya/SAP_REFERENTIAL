# 🌸 INITIALISATION DES VALEURS

## 🌺 OBJECTIFS

- Distinguer `DEFAULT` et `INITIALIZATION`
- Calculer des valeurs initiales dynamiques
- Alimenter plusieurs lignes de sélection
- Respecter les variantes et la mémoire utilisateur
- Éviter de réinitialiser les saisies à chaque affichage

## 🌺 ÉVÉNEMENT INITIALIZATION

`INITIALIZATION` est déclenché avant le premier traitement de l’écran de sélection standard.

```abap
INITIALIZATION.
  p_date = sy-datum.
```

Il convient aux valeurs dépendant du contexte d’exécution.

## 🌺 DEFAULT OU INITIALIZATION

| Besoin                              | Technique                              |
| ----------------------------------- | -------------------------------------- |
| Valeur littérale fixe               | `DEFAULT`                              |
| Date système                        | `INITIALIZATION`                       |
| Calcul de période                   | `INITIALIZATION`                       |
| Plusieurs lignes d’un select-option | `INITIALIZATION`                       |
| Valeur pilotée par variante         | Laisser la variante alimenter le champ |

## 🌺 INTERVALLE DE DATES INITIAL

```abap
SELECT-OPTIONS s_date FOR sy-datum.

INITIALIZATION.
  APPEND VALUE #(
    sign   = 'I'
    option = 'BT'
    low    = sy-datum - 30
    high   = sy-datum
  ) TO s_date.
```

Le calcul de date doit rester cohérent avec le besoin métier. Une période de 30 jours n’est pas équivalente au mois civil précédent.

## 🌺 NE PAS ÉCRASER LES VALEURS

`AT SELECTION-SCREEN OUTPUT` est déclenché avant chaque affichage. Une affectation inconditionnelle dans cet événement peut écraser :

- la saisie utilisateur ;
- une valeur de variante ;
- une valeur passée par `SUBMIT` ;
- une correction après message d’erreur.

```abap
AT SELECTION-SCREEN OUTPUT.
  p_date = sy-datum. " À éviter
```

Utiliser cet événement pour les propriétés d’écran, pas pour réinitialiser systématiquement les données.

## 🌺 INITIALISATION CONDITIONNELLE

Lorsque l’objet peut déjà être alimenté, contrôler son état :

```abap
INITIALIZATION.
  IF s_date[] IS INITIAL.
    APPEND VALUE #(
      sign   = 'I'
      option = 'EQ'
      low    = sy-datum
    ) TO s_date.
  ENDIF.
```

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [INITIALIZATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINITIALIZATION.html)
- [Selection Screen Processing — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/a85596deeb19418982bee031d1fd1427/4a43c40d5a503f04e10000000a421937.html)
- [SELECT-OPTIONS, Value Options — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapselect-options_value.htm)

---

➡️ [Chapitre suivant — VALIDATION AVEC AT SELECTION SCREEN](<./11 - 🍧 VALIDATION AVEC AT SELECTION SCREEN.md>)
