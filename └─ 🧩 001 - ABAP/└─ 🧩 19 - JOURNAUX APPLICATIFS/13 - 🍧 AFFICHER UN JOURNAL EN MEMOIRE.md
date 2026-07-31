# 🌸 AFFICHER UN JOURNAL EN MÉMOIRE

## 🌺 OBJECTIFS

- Afficher un journal avant sa sauvegarde
- Utiliser un profil standard
- Distinguer l’affichage BAL de `SLG1`

## 🌺 AFFICHAGE SIMPLE

```abap
DATA:
  lt_log_handles TYPE bal_t_logh,
  ls_profile     TYPE bal_s_prof.

APPEND lv_log_handle TO lt_log_handles.

CALL FUNCTION 'BAL_DSP_PROFILE_SINGLE_LOG_GET'
  IMPORTING
    e_s_display_profile = ls_profile.

CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
  EXPORTING
    i_t_log_handle      = lt_log_handles
    i_s_display_profile = ls_profile
  EXCEPTIONS
    OTHERS              = 1.
```

## 🌺 PROFILS FOURNIS

Le framework fournit notamment :

- `BAL_DSP_PROFILE_STANDARD_GET` ;
- `BAL_DSP_PROFILE_SINGLE_LOG_GET` ;
- `BAL_DSP_PROFILE_NO_TREE_GET` ;
- `BAL_DSP_PROFILE_POPUP_GET` ;
- `BAL_DSP_PROFILE_DETLEVEL_GET`.

Le profil BAL est une structure technique `BAL_S_PROF`. Il ne s’agit pas d’une variante utilisateur ALV classique.

## 🌺 LIMITES

L’affichage immédiat exige une session dialogue. Il ne doit pas être utilisé comme dépendance d’un traitement batch. En arrière-plan, sauvegarder le journal et fournir son objet, son sous-objet et son identifiant externe dans le spool ou le journal de job.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Log Display — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/addb96cd90c945dfb3182865363bbc47/4e2102fa35d44180e10000000a15822b.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)

---

➡️ [Chapitre suivant — ENREGISTRER UN JOURNAL EN BASE](<./14 - 🍧 ENREGISTRER UN JOURNAL EN BASE.md>)
