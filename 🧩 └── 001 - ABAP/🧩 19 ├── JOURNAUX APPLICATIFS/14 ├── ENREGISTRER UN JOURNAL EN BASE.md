# ENREGISTRER UN JOURNAL EN BASE

## RÉSULTAT ATTENDU

- Persister un ou plusieurs journaux
- Sauvegarder uniquement les handles concernés
- Intégrer la sauvegarde à la stratégie transactionnelle

## SAUVEGARDE CIBLÉE

```abap
DATA lt_log_handles TYPE bal_t_logh.
APPEND lv_log_handle TO lt_log_handles.

CALL FUNCTION 'BAL_DB_SAVE'
  EXPORTING
    i_t_log_handle = lt_log_handles
  EXCEPTIONS
    OTHERS         = 1.

IF sy-subrc <> 0.
  " Gérer l'échec de journalisation selon la criticité
ENDIF.
```

`BAL_DB_SAVE` peut aussi sauvegarder tous les journaux présents en mémoire avec `I_SAVE_ALL`. Cette option est déconseillée dans un composant réutilisable : elle peut persister des journaux créés par d’autres parties du traitement.

## NUMÉROS DÉFINITIFS

Lors de la sauvegarde, le framework attribue un numéro interne définitif. Le paramètre `E_NEW_LOGNUMBERS` permet de rapprocher handle, identifiant externe, numéro temporaire et numéro persistant.

## UPDATE TASK

Le framework permet une sauvegarde en update task. Ce choix doit être aligné sur la SAP LUW :

- journal métier atomique avec la transaction ;
- journal technique qui doit survivre à un rollback ;
- journal d’échec créé après interception de l’erreur.

Ces objectifs sont différents. Aucun mode unique ne convient à tous les traitements.

## RÈGLE

Ne pas ajouter un `COMMIT WORK` uniquement pour sauvegarder le journal sans analyser son impact sur la transaction métier. Un commit mal placé découpe la SAP LUW et peut rendre un rollback impossible.

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
DATA lt_log_handles TYPE bal_t_logh.
APPEND lv_log_handle TO lt_log_handles.

CALL FUNCTION 'BAL_DB_SAVE'
  EXPORTING
    i_t_log_handle = lt_log_handles
  EXCEPTIONS
    OTHERS         = 1.

IF sy-subrc <> 0.
  " Gérer l'échec de journalisation selon la criticité
ENDIF.
```

## TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Writing Application Logs to the Database — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/d15d974dfca34671ae3b62ddf0baf8ae.html)


---

[Chapitre suivant — RECHERCHER ET CHARGER DES JOURNAUX](<./15 ├── RECHERCHER ET CHARGER DES JOURNAUX.md>)
