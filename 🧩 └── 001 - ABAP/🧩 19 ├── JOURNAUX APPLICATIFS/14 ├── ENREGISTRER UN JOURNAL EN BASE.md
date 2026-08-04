# 14. ENREGISTRER UN JOURNAL EN BASE

## 14.A RÉSULTAT ATTENDU

- Persister un ou plusieurs journaux
- Sauvegarder uniquement les handles concernés
- Intégrer la sauvegarde à la stratégie transactionnelle

## 14.B SAUVEGARDE CIBLÉE

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

## 14.C NUMÉROS DÉFINITIFS

Lors de la sauvegarde, le framework attribue un numéro interne définitif. Le paramètre `E_NEW_LOGNUMBERS` permet de rapprocher handle, identifiant externe, numéro temporaire et numéro persistant.

## 14.D UPDATE TASK

Le framework permet une sauvegarde en update task[^terme-update-task]. Ce choix doit être aligné sur la SAP LUW[^terme-sap-luw] :

- journal métier atomique avec la transaction ;
- journal technique qui doit survivre à un rollback ;
- journal d’échec créé après interception de l’erreur.

Ces objectifs sont différents. Aucun mode unique ne convient à tous les traitements.

## 14.E RÈGLE

Ne pas ajouter un `COMMIT WORK`[^terme-commit-work] uniquement pour sauvegarder le journal sans analyser son impact sur la transaction métier. Un commit mal placé découpe la SAP LUW et peut rendre un rollback impossible.

## 14.F PROCESS

### 14.F.1 ÉTAPE 1 — DÉFINIR LA RELATION AVEC LA TRANSACTION MÉTIER

Décider si le journal doit être validé avec les données métier, être sauvegardé en update task ou survivre à un rollback. Documenter ce comportement pour les succès et les erreurs. Ne pas choisir le mode uniquement pour rendre `SLG1`[^outil-slg1] immédiatement visible.

### 14.F.2 ÉTAPE 2 — CONSTITUER LA TABLE DE HANDLES

Ajouter à `BAL_T_LOGH` uniquement les journaux créés par le composant. Vérifier chaque handle et éliminer les doublons. Éviter `I_SAVE_ALL` dans une bibliothèque réutilisable.

### 14.F.3 ÉTAPE 3 — APPELER `BAL_DB_SAVE`

Passer la table dans `I_T_LOG_HANDLE` et récupérer les numéros créés si l’appelant doit les conserver. Contrôler `sy-subrc` immédiatement. Restituer une erreur de journalisation distincte de l’erreur métier initiale.

### 14.F.4 ÉTAPE 4 — GÉRER L’ÉCHEC DE SAUVEGARDE

Selon la criticité, écrire un message dans le journal de job[^terme-job], le spool[^terme-spool] ou une trace[^terme-trace] de secours. Ne pas lancer un commit supplémentaire ni masquer l’échec du traitement principal. Conserver l’identifiant externe afin de corréler une tentative ultérieure.

### 14.F.5 ÉTAPE 5 — TERMINER LA LUW AU BON NIVEAU

Laisser l’orchestrateur métier exécuter commit ou rollback conformément au contrat. Vérifier le comportement de la sauvegarde BAL[^terme-acro-bal] dans les deux chemins. Une API[^terme-api] de journalisation ne doit pas posséder implicitement le commit global.

### 14.F.6 ÉTAPE 6 — CONTRÔLER NUMÉRO ET VISIBILITÉ

Après validation, rechercher le journal dans `SLG1` et rapprocher handle, identifiant externe et numéro persistant. Tester un succès, un rollback métier et un échec de sauvegarde simulé dans un scénario Z contrôlé.

## 14.G VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 14.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 14.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 14.J TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 14.K RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Writing Application Logs to the Database — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/d15d974dfca34671ae3b62ddf0baf8ae.html)

---

[Chapitre suivant — RECHERCHER ET CHARGER DES JOURNAUX](<./15 ├── RECHERCHER ET CHARGER DES JOURNAUX.md>)

[^terme-update-task]: **UPDATE TASK.** Mécanisme différant des mises à jour pour les exécuter lors du `COMMIT WORK` dans des processus de mise à jour. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>).
[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
