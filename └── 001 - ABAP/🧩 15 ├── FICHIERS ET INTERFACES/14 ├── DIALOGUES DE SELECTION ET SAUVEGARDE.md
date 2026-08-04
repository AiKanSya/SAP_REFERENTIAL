# DIALOGUES DE SÉLECTION ET SAUVEGARDE

## OBJECTIFS

- Ouvrir une boîte de dialogue locale
- Distinguer sélection et traitement du fichier
- Gérer l’annulation utilisateur

## SÉLECTION D’UN FICHIER

```abap
DATA lt_files       TYPE filetable.
DATA lv_count       TYPE i.
DATA lv_user_action TYPE i.
DATA lv_filename    TYPE string.

cl_gui_frontend_services=>file_open_dialog(
  EXPORTING
    window_title   = 'Sélectionner un fichier CSV'
    default_extension = 'csv'
    multiselection = abap_false
  CHANGING
    file_table     = lt_files
    rc             = lv_count
    user_action    = lv_user_action ).

IF lv_user_action = cl_gui_frontend_services=>action_ok
   AND lv_count > 0.
  lv_filename = lt_files[ 1 ]-filename.
ENDIF.
```

La boîte de dialogue sélectionne uniquement un chemin. Elle ne lit pas le fichier.

## SAUVEGARDE

`FILE_SAVE_DIALOG` retourne généralement le chemin, le nom et le nom complet choisis. Le programme doit ensuite appeler `GUI_DOWNLOAD`.

## SCRIPTABILITÉ

La documentation SAP indique que les dialogues natifs du système d’exploitation ne sont pas toujours scriptables. Pour certains scénarios d’automatisation SAP GUI, SAP recommande les modules fonction de dialogue dédiés lorsque leurs contraintes conviennent.

## ANNULATION

Une annulation est un comportement normal, pas une erreur technique. Le programme doit revenir proprement sans message d’erreur bloquant.

## BONNES PRATIQUES

- Proposer une extension et un filtre cohérents.
- Ne pas imposer un répertoire non accessible.
- Ne pas déclencher le traitement si l’utilisateur annule.
- Revalider l’extension et le contenu après sélection.
- Ne pas déduire la nature réelle du fichier à partir de l’extension seule.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lt_files       TYPE filetable.
DATA lv_count       TYPE i.
DATA lv_user_action TYPE i.
DATA lv_filename    TYPE string.

cl_gui_frontend_services=>file_open_dialog(
  EXPORTING
    window_title   = 'Sélectionner un fichier CSV'
    default_extension = 'csv'
    multiselection = abap_false
  CHANGING
    file_table     = lt_files
    rc             = lv_count
    user_action    = lv_user_action ).

IF lv_user_action = cl_gui_frontend_services=>action_ok
   AND lv_count > 0.
  lv_filename = lt_files[ 1 ]-filename.
ENDIF.
```

## TERMES DU LEXIQUE

- [Interface](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [FILE_OPEN_DIALOG — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/dd66b1a76d7044ff8fd46c04fdaec220.html)
- [FILE_SAVE_DIALOG — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/d00754b08a6947c19ce3f43add7696cb.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)


---

[Chapitre suivant — IMPORTER UN FICHIER DU POSTE UTILISATEUR](<./15 ├── IMPORTER UN FICHIER DU POSTE UTILISATEUR.md>)
