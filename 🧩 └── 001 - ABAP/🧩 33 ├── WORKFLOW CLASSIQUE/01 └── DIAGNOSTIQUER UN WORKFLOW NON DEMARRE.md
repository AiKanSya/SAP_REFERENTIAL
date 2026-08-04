# DIAGNOSTIQUER UN WORKFLOW NON DÉMARRÉ

## RÉSULTAT ATTENDU

Localiser précisément l’arrêt entre l’application métier, la création de l’événement, le couplage d’événement et la création de l’instance workflow.

Le diagnostic doit aboutir à l’un des résultats suivants :

1. aucun événement n’a été créé ;
2. l’événement existe mais aucun récepteur actif n’est trouvé ;
3. le récepteur est trouvé mais sa condition ou son binding refuse le démarrage ;
4. l’instance workflow est créée puis passe immédiatement en erreur ;
5. le workflow fonctionne mais son premier work item ne possède aucun agent.

## PRÉREQUIS

- Système non productif ou fenêtre de diagnostic autorisée.
- Identifiant du modèle workflow `WS...` attendu.
- Classe/objet BOR, événement et clé d’objet attendus.
- Date, heure, utilisateur et opération métier ayant dû déclencher le workflow.
- Autorisations pour `SWU3`, `SWELS`, `SWEL`, `SWETYPV`, `SWU0`, `SWI1`, `SWI2_DIAG` et le journal technique.

## VALEURS À RELEVER AVANT DE COMMENCER

| Valeur | Exemple | Origine |
|---|---|---|
| Modèle workflow | `WS90000001` | `SWDD` ou spécification |
| Catégorie d’objet | Classe ou BOR | Définition de l’événement |
| Type d’objet/classe | `Z...` | Application ou couplage |
| Événement | `CREATED` | Événement déclencheur |
| Clé d’objet | Identifiant métier | Document créé ou modifié |
| Horodatage | Date et heure précises | Test métier |
| Utilisateur | `SY-UNAME` du déclenchement | Trace ou document |

## ÉTAPE 1 — VÉRIFIER LA CONFIGURATION TECHNIQUE

1. Ouvrir `SWU3`.
2. Exécuter les contrôles de configuration du workflow.
3. Relever chaque étape rouge ou incomplète.
4. Faire corriger les destinations, jobs ou utilisateurs système par l’équipe responsable.

Ne pas poursuivre un diagnostic applicatif tant que la configuration de base requise par le scénario est invalide.

## ÉTAPE 2 — RECHERCHER UNE INSTANCE DÉJÀ CRÉÉE

1. Ouvrir `SWI1`.
2. Limiter la recherche à l’intervalle du test et au modèle `WS...` attendu.
3. Si une instance existe, ouvrir son journal technique.
4. Identifier le premier nœud rouge ou le premier work item arrêté.

Si une instance existe, l’événement et le couplage ont déjà produit un récepteur. Passer directement à l’étape 6.

## ÉTAPE 3 — TRACER LA CRÉATION DE L’ÉVÉNEMENT

1. Activer temporairement la trace des événements avec `SWELS`.
2. Reproduire une seule fois l’opération métier.
3. Ouvrir `SWEL`.
4. Filtrer sur l’objet ou la classe, l’événement, l’horodatage et l’utilisateur.
5. Désactiver la trace avec `SWELS` dès que la capture est terminée.

La trace ne doit pas rester active sans nécessité, particulièrement en production, car elle enregistre les événements du système et peut générer un volume important.

## ÉTAPE 4 — INTERPRÉTER LE RÉSULTAT DE SWEL

### Aucun événement trouvé

La source applicative ne crée pas l’événement attendu ou le test n’emprunte pas le chemin prévu.

Contrôler :

- la classe ou l’objet réellement instancié ;
- le nom exact de l’événement ;
- la condition applicative qui déclenche l’événement ;
- le moment du `COMMIT WORK` si l’événement est publié transactionnellement ;
- les enhancements, change documents ou configurations qui doivent lever l’événement.

### Événement trouvé sans récepteur

Le problème se situe généralement dans le couplage ou l’éligibilité du workflow.

1. Ouvrir `SWETYPV`.
2. Rechercher la combinaison exacte type d’objet/classe et événement.
3. Vérifier que le receiver type correspond au modèle `WS...`.
4. Vérifier que le couplage est actif.
5. Contrôler le module de vérification éventuel, la condition de démarrage et le binding.

### Événement trouvé avec erreur de récepteur

Ouvrir les détails du récepteur dans `SWEL`, relever le message complet et contrôler le binding événement vers workflow. Une clé ou un élément obligatoire absent peut empêcher la création de l’instance.

## ÉTAPE 5 — SIMULER L’ÉLIGIBILITÉ DU RÉCEPTEUR

1. Ouvrir `SWU0`.
2. Saisir le type d’objet ou la classe, l’événement et une clé valide.
3. Exécuter la simulation.
4. Examiner la liste des récepteurs possibles et la raison d’exclusion du modèle attendu.

La simulation vérifie les récepteurs et leurs conditions. Elle ne prouve pas que l’application métier crée réellement l’événement.

`SWUE` peut créer un événement de test. Son utilisation peut démarrer un workflow et produire des effets métier ; elle doit être limitée à un environnement de test avec une clé contrôlée.

## ÉTAPE 6 — ANALYSER UNE INSTANCE CRÉÉE EN ERREUR

1. Rechercher l’instance dans `SWI1` ou les workflows en erreur dans `SWI2_DIAG`.
2. Ouvrir le journal technique, pas uniquement la vue utilisateur.
3. Sélectionner le premier work item en erreur.
4. Relever tâche `TS...`, étape, statut, agent, conteneur, méthode et message d’exception.
5. Contrôler le binding du workflow vers la tâche puis le binding retour.
6. Tester la méthode avec les mêmes données dans l’outil correspondant à sa technologie.

Ne pas redémarrer globalement l’instance avant d’avoir corrigé la cause. Un redémarrage peut répéter une action métier déjà exécutée.

## ÉTAPE 7 — DISTINGUER UN DÉFAUT D’AGENT

Si le workflow a démarré mais qu’aucun utilisateur ne reçoit la tâche :

1. vérifier les agents possibles de la tâche dans `PFTC` ;
2. contrôler la règle ou l’expression d’agent de l’étape dans `SWDD` ;
3. examiner le résultat de résolution dans le journal technique ;
4. vérifier les exclusions et les restrictions d’agents ;
5. contrôler l’organisation et ses buffers avec l’équipe workflow.

Un défaut d’agent n’est pas un workflow « non démarré ». L’instance et le work item existent déjà.

## ARBRE DE DÉCISION

| Observation | Conclusion | Action suivante |
|---|---|---|
| Instance trouvée dans `SWI1` | Le workflow a démarré | Lire le journal technique |
| Aucun événement dans `SWEL` | La source ne lève pas l’événement | Diagnostiquer l’application métier |
| Événement sans récepteur | Couplage ou condition invalide | Vérifier `SWETYPV` et `SWU0` |
| Récepteur en erreur | Binding ou module de réception en défaut | Lire le détail dans `SWEL` |
| Instance immédiatement en erreur | Première étape ou binding en défaut | Examiner `SWI1`/`SWI2_DIAG` |
| Work item sans destinataire | Résolution d’agent en défaut | Vérifier `PFTC`, règle et organisation |

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Aucun résultat dans `SWEL` | Trace non active pendant le test | Activer, reproduire une fois, puis désactiver |
| Mauvais événement analysé | Classe BOR et classe ABAP confondues | Relever la catégorie et le type exacts |
| Couplage visible mais ignoré | Couplage inactif | Activer dans le transport et le mandant appropriés |
| Workflow exclu par `SWU0` | Condition de démarrage fausse | Examiner la condition avec les données du test |
| Erreur juste après démarrage | Binding incomplet | Comparer les conteneurs événement, workflow et tâche |
| Aucun utilisateur notifié | Aucun agent déterminé | Diagnostiquer la résolution d’agent, pas l’événement |
| Test concluant avec `SWUE`, échec métier | L’application ne crée pas l’événement | Corriger le point de déclenchement applicatif |
| Plusieurs workflows démarrent | Plusieurs couplages actifs | Vérifier tous les récepteurs pour la combinaison événement/type |

## CONTRÔLE DE SORTIE

Le diagnostic est terminé uniquement lorsque les éléments suivants sont disponibles :

- cause classée dans une étape précise ;
- transaction et écran ayant fourni la preuve ;
- objet, événement, clé et modèle workflow concernés ;
- correction appliquée dans l’objet ou la configuration appropriée ;
- nouveau test montrant l’événement, le récepteur et l’instance sans erreur ;
- trace `SWELS` désactivée.

## COMPATIBILITÉ S/4HANA

- Statut : compatible pour SAP Business Workflow classique sur S/4HANA.
- Les Flexible Workflows et scénarios Fiori disposent d’outils et de configurations supplémentaires hors périmètre de ce chapitre.
- Les transactions disponibles peuvent dépendre du composant et des autorisations du système cible.

## RÉFÉRENCES OFFICIELLES SAP

- [Troubleshooting in Workflow Processing — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8f3819b0c24149b5959ab31070b64058/4b70c989e19141a9e10000000a421937.html)
- [Workflow Diagnosis — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524076.html)
- [Read the Workflow Technical Log — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/bpmt/3361892490.html)
