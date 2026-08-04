# 13. AFFICHER UN JOURNAL EN MÉMOIRE

## 13.A RÉSULTAT ATTENDU

- Afficher un journal avant sa sauvegarde
- Utiliser un profil standard
- Distinguer l’affichage BAL[^terme-acro-bal] de `SLG1`[^outil-slg1]

## 13.B AFFICHAGE SIMPLE

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

## 13.C PROFILS FOURNIS

Le framework fournit notamment :

- `BAL_DSP_PROFILE_STANDARD_GET` ;
- `BAL_DSP_PROFILE_SINGLE_LOG_GET` ;
- `BAL_DSP_PROFILE_NO_TREE_GET` ;
- `BAL_DSP_PROFILE_POPUP_GET` ;
- `BAL_DSP_PROFILE_DETLEVEL_GET`.

Le profil BAL est une structure technique `BAL_S_PROF`. Il ne s’agit pas d’une variante utilisateur ALV[^terme-alv] classique.

## 13.D LIMITES

L’affichage immédiat exige une session dialogue. Il ne doit pas être utilisé comme dépendance d’un traitement batch. En arrière-plan, sauvegarder le journal et fournir son objet, son sous-objet et son identifiant externe dans le spool[^terme-spool] ou le journal de job[^terme-job].

## 13.E PROCESS

### 13.E.1 ÉTAPE 1 — VÉRIFIER LE CONTEXTE DIALOGUE

Réserver l’affichage immédiat à une session SAP GUI[^terme-session-sap-gui]. En batch, ne pas appeler l’API[^terme-api] d’affichage ; sauvegarder le journal et écrire ses critères de recherche dans le spool ou le journal de job.

### 13.E.2 ÉTAPE 2 — PRÉPARER LES HANDLES CIBLÉS

Ajouter à `BAL_T_LOGH` uniquement les handles à afficher. Vérifier leur existence en mémoire. Ne pas afficher implicitement tous les journaux chargés par d’autres composants de la session.

### 13.E.3 ÉTAPE 3 — CHOISIR LE PROFIL

Appeler la fonction de profil correspondant au besoin : journal unique, sans arbre, popup ou niveau de détail. Récupérer `BAL_S_PROF` puis modifier seulement les attributs compris et nécessaires.

### 13.E.4 ÉTAPE 4 — APPELER `BAL_DSP_LOG_DISPLAY`

Passer la table de handles et le profil. Traiter les exceptions de l’API. L’affichage ne persiste pas le journal ; il montre l’état actuellement présent dans la mémoire BAL.

### 13.E.5 ÉTAPE 5 — TESTER L’INTERACTION UTILISATEUR

Vérifier navigation, texte long, contexte, niveaux de détail et retour au programme. Tester un journal vide, plusieurs messages et plusieurs handles. Ne pas supposer qu’une fermeture de popup signifie une sauvegarde.

### 13.E.6 ÉTAPE 6 — SAUVEGARDER SELON LE CONTRAT

Après ou avant l’affichage selon le flux, appeler explicitement `BAL_DB_SAVE` si le journal doit être conservé. Rechercher ensuite dans `SLG1`. Tester aussi le programme comme job pour confirmer l’absence d’appel GUI.

## 13.F VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 13.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 13.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 13.I TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 13.J RÉFÉRENCES OFFICIELLES SAP

- [Log Display — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/addb96cd90c945dfb3182865363bbc47/4e2102fa35d44180e10000000a15822b.html)
- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)

---

[Chapitre suivant — ENREGISTRER UN JOURNAL EN BASE](<./14 ├── ENREGISTRER UN JOURNAL EN BASE.md>)

[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-session-sap-gui]: **SESSION SAP GUI.** Fenêtre de travail indépendante ouverte pour un même utilisateur et un même système. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#session-sap-gui>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
