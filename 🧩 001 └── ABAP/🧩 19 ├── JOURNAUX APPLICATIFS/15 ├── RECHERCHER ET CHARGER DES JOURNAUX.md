# 15. RECHERCHER ET CHARGER DES JOURNAUX

## 15.A RÉSULTAT ATTENDU

- Rechercher des journaux persistés par critères
- Charger leur contenu en mémoire
- Réutiliser l’affichage BAL[^terme-acro-bal] dans un programme

## 15.B RECHERCHE

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

## 15.C CHARGEMENT

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

## 15.D PERFORMANCE

Toujours fournir des filtres sélectifs :

- objet ;
- sous-objet ;
- période ;
- identifiant externe ;
- utilisateur ou programme lorsque pertinent.

Une recherche générique sur l’ensemble des journaux n’est pas une stratégie de monitoring acceptable.

## 15.E PROCESS

### 15.E.1 ÉTAPE 1 — DÉFINIR DES CRITÈRES SÉLECTIFS

Exiger au minimum l’objet et une période bornée. Ajouter sous-objet, identifiant externe, programme ou utilisateur lorsque disponibles. Refuser dans un programme opérationnel une recherche sans limite susceptible de charger tout l’historique.

### 15.E.2 ÉTAPE 2 — CONSTRUIRE `BAL_S_LFIL`

Initialiser une structure de filtre neuve. Remplir les tables de ranges avec `SIGN`, `OPTION`, `LOW` et `HIGH` cohérents. Utiliser `CP` uniquement lorsqu’un motif est réellement nécessaire et contrôlé.

### 15.E.3 ÉTAPE 3 — APPELER `BAL_DB_SEARCH`

Passer le filtre et récupérer `BALHDR_T`. Contrôler le retour avant d’examiner les résultats. Limiter ou arrêter le traitement si le nombre d’en-têtes dépasse le seuil prévu par l’outil.

### 15.E.4 ÉTAPE 4 — SÉLECTIONNER LES EN-TÊTES UTILES

Comparer numéro, identifiant, objet, date, utilisateur et programme. Ne charger que les journaux appartenant au scénario. Conserver leur numéro pour le diagnostic et l’affichage.

### 15.E.5 ÉTAPE 5 — CHARGER AVEC `BAL_DB_LOAD`

Passer les en-têtes sélectionnés et contrôler le retour. Après chargement, rechercher les handles en mémoire ou utiliser les API[^terme-api] de lecture adaptées. Ne pas supposer qu’un en-tête trouvé signifie que tous ses messages sont déjà chargés.

### 15.E.6 ÉTAPE 6 — AFFICHER ET NETTOYER LA MÉMOIRE

Afficher les handles chargés avec un profil BAL ou lire leurs messages. Vérifier le résultat attendu, puis retirer uniquement ces journaux de la mémoire globale lorsqu’ils ne sont plus utiles. Tester une recherche sans résultat et une recherche retournant plusieurs exécutions.

## 15.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1`[^outil-slg1] avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 15.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 15.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 15.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 15.J RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)

---

[Chapitre suivant — MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS](<./16 ├── MODIFIER UN JOURNAL PERSISTE ET GERER LES VERROUS.md>)

[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
