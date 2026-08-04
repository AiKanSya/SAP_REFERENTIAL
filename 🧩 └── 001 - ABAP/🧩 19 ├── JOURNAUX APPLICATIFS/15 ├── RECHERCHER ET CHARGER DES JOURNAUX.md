# RECHERCHER ET CHARGER DES JOURNAUX

## RÉSULTAT ATTENDU

- Rechercher des journaux persistés par critères
- Charger leur contenu en mémoire
- Réutiliser l’affichage BAL dans un programme

## RECHERCHE

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

## CHARGEMENT

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

## PERFORMANCE

Toujours fournir des filtres sélectifs :

- objet ;
- sous-objet ;
- période ;
- identifiant externe ;
- utilisateur ou programme lorsque pertinent.

Une recherche générique sur l’ensemble des journaux n’est pas une stratégie de monitoring acceptable.

## PROCESS

### ÉTAPE 1 — DÉFINIR DES CRITÈRES SÉLECTIFS

Exiger au minimum l’objet et une période bornée. Ajouter sous-objet, identifiant externe, programme ou utilisateur lorsque disponibles. Refuser dans un programme opérationnel une recherche sans limite susceptible de charger tout l’historique.

### ÉTAPE 2 — CONSTRUIRE `BAL_S_LFIL`

Initialiser une structure de filtre neuve. Remplir les tables de ranges avec `SIGN`, `OPTION`, `LOW` et `HIGH` cohérents. Utiliser `CP` uniquement lorsqu’un motif est réellement nécessaire et contrôlé.

### ÉTAPE 3 — APPELER `BAL_DB_SEARCH`

Passer le filtre et récupérer `BALHDR_T`. Contrôler le retour avant d’examiner les résultats. Limiter ou arrêter le traitement si le nombre d’en-têtes dépasse le seuil prévu par l’outil.

### ÉTAPE 4 — SÉLECTIONNER LES EN-TÊTES UTILES

Comparer numéro, identifiant, objet, date, utilisateur et programme. Ne charger que les journaux appartenant au scénario. Conserver leur numéro pour le diagnostic et l’affichage.

### ÉTAPE 5 — CHARGER AVEC `BAL_DB_LOAD`

Passer les en-têtes sélectionnés et contrôler le retour. Après chargement, rechercher les handles en mémoire ou utiliser les API de lecture adaptées. Ne pas supposer qu’un en-tête trouvé signifie que tous ses messages sont déjà chargés.

### ÉTAPE 6 — AFFICHER ET NETTOYER LA MÉMOIRE

Afficher les handles chargés avec un profil BAL ou lire leurs messages. Vérifier le résultat attendu, puis retirer uniquement ces journaux de la mémoire globale lorsqu’ils ne sont plus utiles. Tester une recherche sans résultat et une recherche retournant plusieurs exécutions.

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

## TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)

---

[Chapitre suivant — MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS](<./16 ├── MODIFIER UN JOURNAL PERSISTE ET GERER LES VERROUS.md>)
