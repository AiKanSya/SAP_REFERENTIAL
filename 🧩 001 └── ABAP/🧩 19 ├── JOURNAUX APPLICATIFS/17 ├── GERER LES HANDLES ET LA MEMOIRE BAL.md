# 17. GÉRER LES HANDLES ET LA MÉMOIRE BAL

## 17.A RÉSULTAT ATTENDU

- Comprendre la mémoire globale utilisée par le framework
- Éviter les mélanges de journaux
- Libérer les données devenues inutiles

## 17.B MÉMOIRE GLOBALE

Le framework BAL[^terme-acro-bal] maintient des journaux et messages en mémoire. Cette mémoire peut contenir plusieurs journaux créés ou chargés par différents composants exécutés dans la même session interne.

## 17.C FONCTIONS UTILES

| Fonction                 | Usage                                              |
| ------------------------ | -------------------------------------------------- |
| `BAL_LOG_EXIST`          | Vérifier qu’un journal existe en mémoire           |
| `BAL_LOG_REFRESH`        | Retirer un journal de la mémoire                   |
| `BAL_GLB_MEMORY_REFRESH` | Réinitialiser tout ou partie de la mémoire globale |
| `BAL_GLB_SEARCH_LOG`     | Rechercher les journaux en mémoire                 |
| `BAL_GLB_SEARCH_MSG`     | Rechercher les messages en mémoire                 |
| `BAL_LOG_HDR_READ`       | Lire l’en-tête                                     |
| `BAL_LOG_MSG_READ`       | Lire un message                                    |

## 17.D RÈGLE D’ISOLATION

Toujours transmettre explicitement le handle. Plusieurs fonctions acceptent un handle facultatif et utilisent alors un journal par défaut. Cette simplification devient dangereuse dès que plusieurs journaux coexistent.

```abap
CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle = mv_log_handle
    i_s_msg      = ls_msg
  EXCEPTIONS
    OTHERS       = 1.
```

## 17.E NETTOYAGE

Après sauvegarde et affichage, retirer le journal de la mémoire lorsqu’il n’est plus utile. Ne pas appeler `BAL_GLB_MEMORY_REFRESH` depuis une bibliothèque générique sans connaître les autres journaux chargés par l’application.

## 17.F PROCESS

### 17.F.1 ÉTAPE 1 — ATTRIBUER LA PROPRIÉTÉ DES HANDLES

Le composant qui crée ou charge un journal conserve son `BALLOGHNDL`. Stocker les handles dans une instance ou un contexte d’exécution, pas dans une variable globale partagée sans cycle de vie défini.

### 17.F.2 ÉTAPE 2 — TRANSMETTRE LE HANDLE EXPLICITEMENT

Passer `I_LOG_HANDLE` à chaque ajout, lecture, affichage et sauvegarde. Refuser un handle initial. Ne pas dépendre du journal implicite par défaut dès que plusieurs composants peuvent utiliser BAL dans la même session.

### 17.F.3 ÉTAPE 3 — VÉRIFIER L’EXISTENCE EN MÉMOIRE

Avant une opération tardive, utiliser `BAL_LOG_EXIST` ou la recherche globale adaptée pour confirmer que le journal est encore chargé. Traiter l’absence comme une erreur de cycle de vie, pas en créant silencieusement un nouveau log.

### 17.F.4 ÉTAPE 4 — RECHERCHER ET LIRE CIBLÉ

Utiliser `BAL_GLB_SEARCH_LOG`, `BAL_GLB_SEARCH_MSG`, `BAL_LOG_HDR_READ` ou `BAL_LOG_MSG_READ` avec des critères et handles précis. Vérifier que le résultat appartient à l’exécution courante avant de le modifier ou de l’afficher.

### 17.F.5 ÉTAPE 5 — SAUVEGARDER AVANT LE NETTOYAGE

Persister les handles requis selon la stratégie de LUW[^terme-acro-luw], puis vérifier le retour. Retirer ensuite un journal avec `BAL_LOG_REFRESH` lorsqu’il n’est plus utile. Le nettoyage mémoire n’équivaut pas à une suppression en base.

### 17.F.6 ÉTAPE 6 — TESTER PLUSIEURS JOURNAUX DANS LA MÊME SESSION

Créer deux logs avec des identifiants distincts, ajouter des messages alternés, sauvegarder et afficher chaque handle séparément. Nettoyer le premier puis vérifier que le second reste intact. Ce test détecte les usages dangereux de la mémoire globale.

## 17.G VÉRIFICATION

- Le journal est retrouvable dans `SLG1`[^outil-slg1] avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 17.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 17.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'BAL_LOG_MSG_ADD'
  EXPORTING
    i_log_handle = mv_log_handle
    i_s_msg      = ls_msg
  EXCEPTIONS
    OTHERS       = 1.
```

## 17.J TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 17.K RÉFÉRENCES OFFICIELLES SAP

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Basics — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21029235d44180e10000000a15822b.html)

---

[Chapitre suivant — INTÉGRER LE JOURNAL AUX JOBS ET PROGRAMMES BATCH](<./18 ├── INTEGRER LE JOURNAL AUX JOBS ET PROGRAMMES BATCH.md>)

[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-acro-luw]: **LUW.** Logical Unit of Work. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-luw>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
