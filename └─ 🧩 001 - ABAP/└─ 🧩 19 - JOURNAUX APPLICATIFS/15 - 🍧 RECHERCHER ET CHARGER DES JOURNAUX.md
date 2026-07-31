# 🌸 RECHERCHER ET CHARGER DES JOURNAUX

## 🌺 OBJECTIFS

- Rechercher des journaux persistés par critères
- Charger leur contenu en mémoire
- Réutiliser l’affichage BAL dans un programme

## 🌺 RECHERCHE

```abap
DATA:
  ls_filter     TYPE bal_s_lfil,
  ls_object_rng TYPE bal_s_obj,
  ls_ext_rng    TYPE bal_s_extn,
  lt_headers    TYPE balhdr_t.

ls_object_rng-sign   = 'I'.
ls_object_rng-option = 'EQ'.
ls_object_rng-low    = 'ZDEV_LOG'.
APPEND ls_object_rng TO ls_filter-object.

ls_ext_rng-sign   = 'I'.
ls_ext_rng-option = 'CP'.
ls_ext_rng-low    = 'RUN_*'.
APPEND ls_ext_rng TO ls_filter-extnumber.

CALL FUNCTION 'BAL_DB_SEARCH'
  EXPORTING
    i_s_log_filter = ls_filter
  IMPORTING
    e_t_log_header = lt_headers
  EXCEPTIONS
    OTHERS         = 1.
```

## 🌺 CHARGEMENT

```abap
IF lt_headers IS NOT INITIAL.
  CALL FUNCTION 'BAL_DB_LOAD'
    EXPORTING
      i_t_log_header = lt_headers
    EXCEPTIONS
      OTHERS         = 1.
ENDIF.
```

Après chargement, les journaux sont présents dans la mémoire BAL et peuvent être lus ou affichés avec `BAL_DSP_LOG_DISPLAY`.

## 🌺 PERFORMANCE

Toujours fournir des filtres sélectifs :

- objet ;
- sous-objet ;
- période ;
- identifiant externe ;
- utilisateur ou programme lorsque pertinent.

Une recherche générique sur l’ensemble des journaux n’est pas une stratégie de monitoring acceptable.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)

---

➡️ [Chapitre suivant — MODIFIER UN JOURNAL PERSISTE ET GERER LES VERROUS](<./16 - 🍧 MODIFIER UN JOURNAL PERSISTE ET GERER LES VERROUS.md>)
