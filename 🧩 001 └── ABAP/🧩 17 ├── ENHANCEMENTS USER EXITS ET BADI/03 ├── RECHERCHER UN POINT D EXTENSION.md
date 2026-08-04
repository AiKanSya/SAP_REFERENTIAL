# 3. RECHERCHER UN POINT D’EXTENSION

## 3.A RÉSULTAT ATTENDU

- Partir de la transaction ou du programme réellement exécuté
- Utiliser les outils du Repository plutôt qu’une recherche approximative
- Prouver le point d’appel par le débogage

## 3.B DÉMARCHE

1. Reproduire le cas métier avec des données de test.
2. Identifier la transaction, le programme, la classe[^terme-classe] ou le groupe de fonctions.
3. Rechercher les BAdI[^terme-acro-badi], customer exits et enhancement spots du package[^terme-package].
4. Inspecter le code appelant et la documentation du point.
5. Placer un breakpoint[^terme-breakpoint] dans l’interface candidate.
6. Vérifier les paramètres réellement disponibles.
7. Contrôler le moment de l’appel par rapport aux validations et au commit.

## 3.C OUTILS SAP GUI

| Outil    | Usage                                                        |
| -------- | ------------------------------------------------------------ |
| `SE84`[^outil-se84]   | Repository Information System et recherche par package       |
| `SE80`[^outil-se80]   | Navigation dans les objets et Enhancement Information System |
| `SMOD`[^outil-smod]   | Recherche d’enhancements classiques                          |
| `SE18`[^outil-se18]   | Recherche et analyse des définitions BAdI                    |
| `SE19`[^outil-se19]   | Analyse des implémentations BAdI                             |
| `SE24`[^terme-class-builder-se24]   | Analyse des interfaces et classes d’implémentation           |
| `SE37`[^outil-se37]   | Analyse des function module exits                            |
| Debugger | Preuve du point d’appel et du contexte                       |

## 3.D RECHERCHE DANS LE CODE

Rechercher notamment :

```abap
CALL CUSTOMER-FUNCTION
GET BADI
CALL BADI
ENHANCEMENT-POINT
ENHANCEMENT-SECTION
```

Les routines historiques peuvent porter des noms tels que `USEREXIT_*`, mais le nom seul ne prouve ni leur activation ni leur pertinence.

## 3.E VALIDATION

Un point d’extension n’est valide que si :

- il est exécuté dans le scénario cible ;
- les données nécessaires sont disponibles ;
- le résultat attendu peut être produit sans détourner le contrat ;
- l’implémentation ne crée pas de commit ou de verrou incohérent ;
- le point existe dans les versions cibles.

## 3.F PROCESS

### 3.F.1 ÉTAPE 1 — CAPTURER LE SCÉNARIO EXACT

Relever la transaction ou l’application, l’action utilisateur, la clé métier, l’utilisateur, le mandant[^terme-mandant] et le résultat attendu. Réduire le scénario à une reproduction unique afin de limiter les appels observés.

### 3.F.2 ÉTAPE 2 — IDENTIFIER LES OBJETS EXÉCUTÉS

Utiliser les informations système, la pile d’appels du débogueur et le Repository pour retrouver programme, classes, groupes de fonctions et package. Distinguer le programme de lancement du code métier réellement exécuté.

### 3.F.3 ÉTAPE 3 — RECHERCHER LES POINTS CANDIDATS

Rechercher dans le code et le Repository les appels de BAdI, enhancement points/sections, `CALL CUSTOMER-FUNCTION`, user exits et mécanismes propres au domaine. Pour FI, compléter par les événements BTE[^terme-acro-bte] lorsque le processus le prévoit.

### 3.F.4 ÉTAPE 4 — ANALYSER LE CONTRAT DE CHAQUE POINT

Lire la documentation et les interfaces. Relever les données importées, modifiables ou retournées, les filtres, l’usage multiple et les restrictions transactionnelles. Écarter tout point ne fournissant pas les données ou le moment nécessaires.

### 3.F.5 ÉTAPE 5 — PROUVER L’APPEL PAR DEBUG

Placer un breakpoint dans les candidats les plus pertinents et reproduire le scénario. Relever l’ordre d’appel, la pile, les paramètres et les validations standard exécutées après le retour. Désactiver les breakpoints non utiles après la preuve.

### 3.F.6 ÉTAPE 6 — VÉRIFIER L’ACTIVATION EXISTANTE

Contrôler les implémentations BAdI, projets CMOD[^outil-cmod] ou enhancements déjà actifs dans le système. Comparer leurs filtres et leur périmètre au besoin. Conserver le nom technique et la preuve runtime du point finalement retenu.

## 3.G VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP[^terme-acro-sap] standard n’a été créée.

## 3.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 3.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL CUSTOMER-FUNCTION
GET BADI
CALL BADI
ENHANCEMENT-POINT
ENHANCEMENT-SECTION
```

## 3.J TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Ways to Find a User Exit — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525969.html)
- [Enhancement Information System — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_750/46a2cfc13d25463b8b9a3d2a3c3ba0d9/29503e423a95b36be10000000a155106.html)
- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)

---

[Chapitre suivant — USER EXITS DANS LES PROGRAMMES STANDARD](<./04 ├── USER EXITS DANS LES PROGRAMMES STANDARD.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-acro-badi]: **BADI.** Business Add-In, mécanisme d’extension orienté objet du standard SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-acro-bte]: **BTE.** Business Transaction Event, mécanisme d’extension utilisé notamment dans certains domaines financiers. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se84]: **SE84.** Repository Information System utilisé pour rechercher des objets et analyser leurs utilisations. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/02 ├── OBJETS DU REPOSITORY ABAP.md>).
[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-smod]: **SMOD.** Transaction de recherche et d’analyse des enhancements SAP classiques. Voir [le chapitre associé](<06 ├── ANALYSER UN ENHANCEMENT AVEC SMOD.md>).
[^outil-se18]: **SE18.** BAdI Builder utilisé pour rechercher et analyser les définitions de BAdI. Voir [le chapitre associé](<14 ├── ANALYSER UNE DEFINITION BADI AVEC SE18.md>).
[^outil-se19]: **SE19.** BAdI Builder utilisé pour créer et maintenir les implémentations de BAdI. Voir [le chapitre associé](<15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>).
[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
[^outil-cmod]: **CMOD.** Transaction de gestion des projets d’extensions client classiques. Voir [le chapitre associé](<07 ├── CREER ET ACTIVER UN PROJET CMOD.md>).
