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

## 🌺 CAS D’USAGE

Dans un contexte où un traitement automatique doit produire un historique exploitable par le support avec contexte, messages et identifiants, le besoin consiste à **obtenir et interpréter le résultat attendu pour « rechercher et charger des journaux »**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 🌺 SNIPPET À RÉUTILISER

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

## 🌺 TERMES DU LEXIQUE

- [Application Log](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bal>)
- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **obtenir et interpréter le résultat attendu pour « rechercher et charger des journaux »**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Application Log Methodology Part II — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524102.html)


---

➡️ [Chapitre suivant — MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS](<./16 - 🍧 MODIFIER UN JOURNAL PERSISTE ET GERER LES VERROUS.md>)
