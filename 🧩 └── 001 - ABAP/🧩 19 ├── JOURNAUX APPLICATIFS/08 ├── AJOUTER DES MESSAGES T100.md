# 8. AJOUTER DES MESSAGES T100

## 8.A RÉSULTAT ATTENDU

- Ajouter un message issu d’une classe `SE91`
- Réutiliser les champs système `sy-msg*`
- Conserver traduction et texte long

## 8.B STRUCTURE BAL_S_MSG

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

## 8.C AJOUTER LE DERNIER MESSAGE SYSTÈME

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

## 8.D AVANTAGES DES MESSAGES T100

- traduction centralisée ;
- texte court stable ;
- texte long disponible dans `SLG1` ;
- données techniques exploitables ;
- variables structurées ;
- recherche plus précise par classe et numéro.

## 8.E PROCESS

### 8.E.1 ÉTAPE 1 — CRÉER LE MESSAGE DANS `SE91`

Créer ou ouvrir une classe Z, choisir un numéro libre et rédiger un texte stable avec au maximum les variables prévues. Maintenir les traductions nécessaires. Éviter d’insérer directement un texte sensible dans une variable.

### 8.E.2 ÉTAPE 2 — CRÉER LE JOURNAL ET CONSERVER SON HANDLE

Construire l’en-tête, appeler `BAL_LOG_CREATE` et vérifier le handle. Le message ne doit être ajouté qu’après une création réussie. Utiliser un objet et un sous-objet configurés dans `SLG0`.

### 8.E.3 ÉTAPE 3 — CONSTRUIRE `BAL_S_MSG`

Renseigner `MSGTY`, `MSGID`, `MSGNO` et `MSGV1` à `MSGV4` avec les types attendus. Définir la classe de problème et le niveau de détail si le scénario les utilise. Ne pas transformer un succès en erreur uniquement pour le rendre visible.

### 8.E.4 ÉTAPE 4 — APPELER `BAL_LOG_MSG_ADD`

Passer le handle et la structure de message, puis traiter `LOG_NOT_FOUND`, `MSG_INCONSISTENT` et `LOG_IS_FULL`. Contrôler `sy-subrc` avant d’ajouter le message suivant.

### 8.E.5 ÉTAPE 5 — SAUVEGARDER LE JOURNAL

Ajouter le handle à une table `BAL_T_LOGH` et appeler `BAL_DB_SAVE`. Aligner la sauvegarde sur la LUW du traitement. Ne pas utiliser `I_SAVE_ALL` dans un composant qui ne possède pas tous les logs de la session.

### 8.E.6 ÉTAPE 6 — VÉRIFIER TEXTE ET VARIABLES

Ouvrir le journal dans `SLG1` avec plusieurs langues de connexion si elles sont supportées. Vérifier gravité, texte, variables, texte long et recherche. Tester aussi une classe, un numéro ou un type de message incohérents.

## 8.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 8.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 8.H SNIPPET À RÉUTILISER

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

## 8.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 8.J RÉFÉRENCES OFFICIELLES SAP

- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)
- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)

---

[Chapitre suivant — AJOUTER DU TEXTE LIBRE ET DES MESSAGES SYSTÈME](<./09 ├── AJOUTER DU TEXTE LIBRE ET DES MESSAGES SYSTEME.md>)
