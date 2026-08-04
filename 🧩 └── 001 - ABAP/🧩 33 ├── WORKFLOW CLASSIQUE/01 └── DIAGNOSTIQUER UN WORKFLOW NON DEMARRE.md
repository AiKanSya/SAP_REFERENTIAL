# 1. DIAGNOSTIQUER UN WORKFLOW NON DÉMARRÉ

## 1.A RÉSULTAT ATTENDU

Localiser précisément l’arrêt entre l’application métier, la création de l’événement, le couplage d’événement et la création de l’instance workflow.

Le diagnostic doit aboutir à l’un des résultats suivants :

1. aucun événement n’a été créé ;
2. l’événement existe mais aucun récepteur actif n’est trouvé ;
3. le récepteur est trouvé mais sa condition ou son binding refuse le démarrage ;
4. l’instance workflow est créée puis passe immédiatement en erreur ;
5. le workflow fonctionne mais son premier work item ne possède aucun agent.

## 1.B PRÉREQUIS

- Système non productif ou fenêtre de diagnostic autorisée.
- Identifiant du modèle workflow `WS...` attendu.
- Classe[^terme-classe]/objet BOR, événement et clé d’objet attendus.
- Date, heure, utilisateur et opération métier ayant dû déclencher le workflow.
- Autorisations pour `SWU3`[^outil-swu3], `SWELS`[^outil-swels], `SWEL`[^outil-swel], `SWETYPV`[^outil-swetypv], `SWU0`[^outil-swu0], `SWI1`[^outil-swi1], `SWI2_DIAG`[^outil-swi2-diag] et le journal technique.

## 1.C VALEURS À RELEVER AVANT DE COMMENCER

| Valeur | Exemple | Origine |
|---|---|---|
| Modèle workflow | `WS90000001` | `SWDD`[^outil-swdd] ou spécification |
| Catégorie d’objet | Classe ou BOR | Définition de l’événement |
| Type d’objet/classe | `Z...` | Application ou couplage |
| Événement | `CREATED` | Événement déclencheur |
| Clé d’objet | Identifiant métier | Document créé ou modifié |
| Horodatage | Date et heure précises | Test métier |
| Utilisateur | `SY-UNAME` du déclenchement | Trace[^terme-trace] ou document |

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — VÉRIFIER LA CONFIGURATION TECHNIQUE

1. Ouvrir `SWU3`.
2. Exécuter les contrôles de configuration du workflow.
3. Relever chaque étape rouge ou incomplète.
4. Faire corriger les destinations, jobs ou utilisateurs système par l’équipe responsable.

Ne pas poursuivre un diagnostic applicatif tant que la configuration de base requise par le scénario est invalide.

### 1.D.2 ÉTAPE 2 — RECHERCHER UNE INSTANCE DÉJÀ CRÉÉE

1. Ouvrir `SWI1`.
2. Limiter la recherche à l’intervalle du test et au modèle `WS...` attendu.
3. Si une instance existe, ouvrir son journal technique.
4. Identifier le premier nœud rouge ou le premier work item arrêté.

Si une instance existe, l’événement et le couplage ont déjà produit un récepteur. Passer directement à l’étape 6.

### 1.D.3 ÉTAPE 3 — TRACER LA CRÉATION DE L’ÉVÉNEMENT

1. Activer temporairement la trace des événements avec `SWELS`.
2. Reproduire une seule fois l’opération métier.
3. Ouvrir `SWEL`.
4. Filtrer sur l’objet ou la classe, l’événement, l’horodatage et l’utilisateur.
5. Désactiver la trace avec `SWELS` dès que la capture est terminée.

La trace ne doit pas rester active sans nécessité, particulièrement en production, car elle enregistre les événements du système et peut générer un volume important.

### 1.D.4 ÉTAPE 4 — INTERPRÉTER LE RÉSULTAT DE SWEL

#### 1.D.4.A Aucun événement trouvé

La source applicative ne crée pas l’événement attendu ou le test n’emprunte pas le chemin prévu.

Contrôler :

- la classe ou l’objet réellement instancié ;
- le nom exact de l’événement ;
- la condition applicative qui déclenche l’événement ;
- le moment du `COMMIT WORK`[^terme-commit-work] si l’événement est publié transactionnellement ;
- les enhancements, change documents ou configurations qui doivent lever l’événement.

#### 1.D.4.B Événement trouvé sans récepteur

Le problème se situe généralement dans le couplage ou l’éligibilité du workflow.

1. Ouvrir `SWETYPV`.
2. Rechercher la combinaison exacte type d’objet/classe et événement.
3. Vérifier que le receiver type correspond au modèle `WS...`.
4. Vérifier que le couplage est actif.
5. Contrôler le module de vérification éventuel, la condition de démarrage et le binding.

#### 1.D.4.C Événement trouvé avec erreur de récepteur

Ouvrir les détails du récepteur dans `SWEL`, relever le message complet et contrôler le binding événement vers workflow. Une clé ou un élément obligatoire absent peut empêcher la création de l’instance.

### 1.D.5 ÉTAPE 5 — SIMULER L’ÉLIGIBILITÉ DU RÉCEPTEUR

1. Ouvrir `SWU0`.
2. Saisir le type d’objet ou la classe, l’événement et une clé valide.
3. Exécuter la simulation.
4. Examiner la liste des récepteurs possibles et la raison d’exclusion du modèle attendu.

La simulation vérifie les récepteurs et leurs conditions. Elle ne prouve pas que l’application métier crée réellement l’événement.

`SWUE`[^outil-swue] peut créer un événement de test. Son utilisation peut démarrer un workflow et produire des effets métier ; elle doit être limitée à un environnement[^terme-environnement] de test avec une clé contrôlée.

### 1.D.6 ÉTAPE 6 — ANALYSER UNE INSTANCE CRÉÉE EN ERREUR

1. Rechercher l’instance dans `SWI1` ou les workflows en erreur dans `SWI2_DIAG`.
2. Ouvrir le journal technique, pas uniquement la vue utilisateur.
3. Sélectionner le premier work item en erreur.
4. Relever tâche `TS...`, étape, statut, agent, conteneur, méthode[^terme-methode] et message d’exception[^terme-exception].
5. Contrôler le binding du workflow vers la tâche puis le binding retour.
6. Tester la méthode avec les mêmes données dans l’outil correspondant à sa technologie.

Ne pas redémarrer globalement l’instance avant d’avoir corrigé la cause. Un redémarrage peut répéter une action métier déjà exécutée.

### 1.D.7 ÉTAPE 7 — DISTINGUER UN DÉFAUT D’AGENT

Si le workflow a démarré mais qu’aucun utilisateur ne reçoit la tâche :

1. vérifier les agents possibles de la tâche dans `PFTC`[^outil-pftc] ;
2. contrôler la règle ou l’expression d’agent de l’étape dans `SWDD` ;
3. examiner le résultat de résolution dans le journal technique ;
4. vérifier les exclusions et les restrictions d’agents ;
5. contrôler l’organisation et ses buffers avec l’équipe workflow.

Un défaut d’agent n’est pas un workflow « non démarré ». L’instance et le work item existent déjà.

## 1.E ARBRE DE DÉCISION

| Observation | Conclusion | Action suivante |
|---|---|---|
| Instance trouvée dans `SWI1` | Le workflow a démarré | Lire le journal technique |
| Aucun événement dans `SWEL` | La source ne lève pas l’événement | Diagnostiquer l’application métier |
| Événement sans récepteur | Couplage ou condition invalide | Vérifier `SWETYPV` et `SWU0` |
| Récepteur en erreur | Binding ou module de réception en défaut | Lire le détail dans `SWEL` |
| Instance immédiatement en erreur | Première étape ou binding en défaut | Examiner `SWI1`/`SWI2_DIAG` |
| Work item sans destinataire | Résolution d’agent en défaut | Vérifier `PFTC`, règle et organisation |

## 1.F ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun résultat dans `SWEL` | Trace non active pendant le test | Activer, reproduire une fois, puis désactiver |
| Mauvais événement analysé | Classe BOR et classe ABAP[^terme-abap] confondues | Relever la catégorie et le type exacts |
| Couplage visible mais ignoré | Couplage inactif | Activer dans le transport et le mandant[^terme-mandant] appropriés |
| Workflow exclu par `SWU0` | Condition de démarrage fausse | Examiner la condition avec les données du test |
| Erreur juste après démarrage | Binding incomplet | Comparer les conteneurs événement, workflow et tâche |
| Aucun utilisateur notifié | Aucun agent déterminé | Diagnostiquer la résolution d’agent, pas l’événement |
| Test concluant avec `SWUE`, échec métier | L’application ne crée pas l’événement | Corriger le point de déclenchement applicatif |
| Plusieurs workflows démarrent | Plusieurs couplages actifs | Vérifier tous les récepteurs pour la combinaison événement/type |

## 1.G CONTRÔLE DE SORTIE

Le diagnostic est terminé uniquement lorsque les éléments suivants sont disponibles :

- cause classée dans une étape précise ;
- transaction et écran ayant fourni la preuve ;
- objet, événement, clé et modèle workflow concernés ;
- correction appliquée dans l’objet ou la configuration appropriée ;
- nouveau test montrant l’événement, le récepteur et l’instance sans erreur ;
- trace `SWELS` désactivée.

## 1.H COMPATIBILITÉ S/4HANA

- Statut : compatible pour SAP[^terme-acro-sap] Business Workflow classique sur S/4HANA.
- Les Flexible Workflows et scénarios Fiori disposent d’outils et de configurations supplémentaires hors périmètre de ce chapitre.
- Les transactions disponibles peuvent dépendre du composant et des autorisations du système cible.

## 1.I RÉFÉRENCES OFFICIELLES SAP

- [Troubleshooting in Workflow Processing — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8f3819b0c24149b5959ab31070b64058/4b70c989e19141a9e10000000a421937.html)
- [Workflow Diagnosis — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524076.html)
- [Read the Workflow Technical Log — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/bpmt/3361892490.html)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-environnement]: **ENVIRONNEMENT.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#environnement>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).

[^outil-swu3]: **SWU3.** Transaction de contrôle et de configuration de l’environnement technique du workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swels]: **SWELS.** Transaction d’activation ou de désactivation de la trace des événements du workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swel]: **SWEL.** Transaction d’évaluation de la trace des événements du workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swetypv]: **SWETYPV.** Transaction de maintenance et d’analyse des couplages type-événement du workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swu0]: **SWU0.** Outil de simulation de l’éligibilité des récepteurs d’un événement de workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swi1]: **SWI1.** Transaction de recherche et d’analyse des work items et instances de workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swi2-diag]: **SWI2_DIAG.** Rapport de diagnostic des workflows en erreur. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swdd]: **SWDD.** Workflow Builder utilisé pour afficher et maintenir les modèles de workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-swue]: **SWUE.** Transaction de création manuelle d’un événement de test. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
[^outil-pftc]: **PFTC.** Transaction de maintenance des tâches et modèles du workflow. Voir [le chapitre associé](<01 └── DIAGNOSTIQUER UN WORKFLOW NON DEMARRE.md>).
