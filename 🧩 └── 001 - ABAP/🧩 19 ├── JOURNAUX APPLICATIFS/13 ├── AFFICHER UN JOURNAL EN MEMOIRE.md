# AFFICHER UN JOURNAL EN MÉMOIRE

## RÉSULTAT ATTENDU

- Afficher un journal avant sa sauvegarde
- Utiliser un profil standard
- Distinguer l’affichage BAL de `SLG1`

## AFFICHAGE SIMPLE

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

## PROFILS FOURNIS

Le framework fournit notamment :

- `BAL_DSP_PROFILE_STANDARD_GET` ;
- `BAL_DSP_PROFILE_SINGLE_LOG_GET` ;
- `BAL_DSP_PROFILE_NO_TREE_GET` ;
- `BAL_DSP_PROFILE_POPUP_GET` ;
- `BAL_DSP_PROFILE_DETLEVEL_GET`.

Le profil BAL est une structure technique `BAL_S_PROF`. Il ne s’agit pas d’une variante utilisateur ALV classique.

## LIMITES

L’affichage immédiat exige une session dialogue. Il ne doit pas être utilisé comme dépendance d’un traitement batch. En arrière-plan, sauvegarder le journal et fournir son objet, son sous-objet et son identifiant externe dans le spool ou le journal de job.

## PROCÉDURE PAS À PAS

1. Saisir `/nSLG1`.
2. Renseigner objet, sous-objet, identifiant externe, utilisateur et période selon les informations du traitement.
3. Exécuter la recherche.
4. Ouvrir le journal correspondant au bon horodatage.
5. Analyser l’en-tête, les niveaux de gravité et le contexte des messages.
6. Exporter ou transmettre uniquement les informations nécessaires, sans données sensibles inutiles.

## VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Log Display — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/addb96cd90c945dfb3182865363bbc47/4e2102fa35d44180e10000000a15822b.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)


---

[Chapitre suivant — ENREGISTRER UN JOURNAL EN BASE](<./14 ├── ENREGISTRER UN JOURNAL EN BASE.md>)
