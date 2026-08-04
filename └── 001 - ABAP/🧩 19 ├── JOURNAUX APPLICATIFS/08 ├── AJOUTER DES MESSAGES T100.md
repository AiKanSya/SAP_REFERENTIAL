# AJOUTER DES MESSAGES T100

## OBJECTIFS

- Ajouter un message issu d’une classe `SE91`
- Réutiliser les champs système `sy-msg*`
- Conserver traduction et texte long

## STRUCTURE BAL_S_MSG

```abap
DATA ls_msg TYPE bal_s_msg.

ls_msg-msgty = 'I'.
ls_msg-msgid = 'ZDEV_LOG'.
ls_msg-msgno = '001'.
ls_msg-msgv1 = lv_run_id.

CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle     = lv_log_handle
    i_s_msg          = ls_msg
  EXCEPTIONS
    log_not_found    = 1
    msg_inconsistent = 2
    log_is_full      = 3
    OTHERS           = 4.
```

## AJOUTER LE DERNIER MESSAGE SYSTÈME

```abap
MESSAGE e004(zdev_log) WITH lv_document INTO DATA(lv_text).

ls_msg = VALUE #(
  msgty = sy-msgty
  msgid = sy-msgid
  msgno = sy-msgno
  msgv1 = sy-msgv1
  msgv2 = sy-msgv2
  msgv3 = sy-msgv3
  msgv4 = sy-msgv4 ).

CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle = lv_log_handle
    i_s_msg      = ls_msg
  EXCEPTIONS
    OTHERS       = 1.
```

L’instruction `MESSAGE ... INTO` formate le texte sans interrompre le traitement et alimente les champs `sy-msgid`, `sy-msgno`, `sy-msgty` et `sy-msgv1` à `sy-msgv4`.

## AVANTAGES DES MESSAGES T100

- traduction centralisée ;
- texte court stable ;
- texte long disponible dans `SLG1` ;
- données techniques exploitables ;
- variables structurées ;
- recherche plus précise par classe et numéro.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE91`.
2. Entrer une classe de messages Z puis choisir **Créer** ou **Modifier**.
3. Ajouter un numéro libre et un texte court ; utiliser `&1` à `&4` pour les variables.
4. Enregistrer dans le package et l’ordre appropriés.
5. Activer si le système le demande.
6. Appeler le message depuis un report de test et vérifier le texte dans la langue de connexion.

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
MESSAGE e004(zdev_log) WITH lv_document INTO DATA(lv_text).

ls_msg = VALUE #(
  msgty = sy-msgty
  msgid = sy-msgid
  msgno = sy-msgno
  msgv1 = sy-msgv1
  msgv2 = sy-msgv2
  msgv3 = sy-msgv3
  msgv4 = sy-msgv4 ).

CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle = lv_log_handle
    i_s_msg      = ls_msg
  EXCEPTIONS
    OTHERS       = 1.
```

## TERMES DU LEXIQUE

- [Application Log](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)
- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)


---

[Chapitre suivant — AJOUTER DU TEXTE LIBRE ET DES MESSAGES SYSTÈME](<./09 ├── AJOUTER DU TEXTE LIBRE ET DES MESSAGES SYSTEME.md>)
