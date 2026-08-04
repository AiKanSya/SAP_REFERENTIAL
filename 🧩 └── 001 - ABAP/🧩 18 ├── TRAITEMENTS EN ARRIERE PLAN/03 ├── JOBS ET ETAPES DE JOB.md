# 3. JOBS ET ÉTAPES DE JOB

## 3.A RÉSULTAT ATTENDU

- Distinguer le job de ses étapes
- Comprendre l’ordre d’exécution
- Identifier les paramètres propres à chaque étape

## 3.B MODÈLE

Un job est une unité de planification. Il contient une ou plusieurs étapes exécutées dans l’ordre défini.

```mermaid
flowchart LR
    A["Job"] --> B["Étape 1"]
    B --> C["Étape 2"]
    C --> D["Étape 3"]
```

Une étape peut exécuter :

- un programme ABAP ;
- une commande externe définie dans SAP ;
- un programme externe, sous réserve des autorisations nécessaires.

## 3.C PROPRIÉTÉS D’UNE ÉTAPE ABAP

- nom du programme ;
- variante ;
- utilisateur d’exécution ;
- langue ;
- paramètres de spool et d’archivage.

Le job possède ses propres propriétés : nom, numéro interne, classe, condition de démarrage, périodicité et éventuellement serveur cible.

## 3.D ÉCHEC D’UNE ÉTAPE

Les étapes ne constituent pas automatiquement une transaction métier unique. Si l’étape 2 échoue après la validation de l’étape 1, les données écrites par la première étape ne sont pas annulées. Une chaîne doit donc être conçue avec une stratégie de reprise explicite.

## 3.E RECOMMANDATION

Utiliser plusieurs étapes lorsque l’enchaînement est réellement indissociable et simple. Pour une orchestration complexe, préférer des jobs distincts reliés par une condition « après job » ou par un événement documenté.

## 3.F PROCESS

### 3.F.1 ÉTAPE 1 — DÉFINIR LE RÉSULTAT DE CHAQUE ÉTAPE

Décrire pour chaque étape son programme, ses entrées, son utilisateur, ses sorties et sa condition de succès. Ne regrouper dans un même job que les étapes dont la séquence et le cycle d’exploitation sont communs.

### 3.F.2 ÉTAPE 2 — CONFIGURER L’ORDRE DANS `SM36`

Créer ou modifier le job, puis ajouter les étapes dans l’ordre exact. Pour une étape ABAP, renseigner programme et variante ; pour une commande externe, utiliser la définition Basis prévue. Vérifier l’utilisateur d’exécution de chaque étape.

### 3.F.3 ÉTAPE 3 — CONTRÔLER LA PROPAGATION DES DONNÉES

Une étape ne doit pas dépendre implicitement de la mémoire de la précédente. Utiliser des données persistantes, fichiers, événements ou statuts documentés pour transmettre le résultat. Définir comment l’étape suivante détecte un résultat absent ou incomplet.

### 3.F.4 ÉTAPE 4 — LIBÉRER LE JOB

Définir la condition de démarrage puis enregistrer. Dans `SM37`, vérifier que le job est libéré, que toutes les étapes sont présentes et que les variantes actives sont celles attendues. Conserver le numéro de job et l’horodatage de la vérification.

### 3.F.5 ÉTAPE 5 — SUIVRE L’EXÉCUTION PAR ÉTAPE

Après démarrage, ouvrir le journal et les spools. Identifier l’étape en cours ou la première étape en erreur. Relever son programme, ses paramètres et son heure ; le statut global ne suffit pas à localiser la cause.

### 3.F.6 ÉTAPE 6 — TESTER UNE ÉTAPE INTERMÉDIAIRE EN ÉCHEC

Provoquer un échec contrôlé dans un environnement de test et vérifier que les étapes suivantes ne produisent pas un résultat invalide. Documenter la procédure de reprise : job complet, copie à partir d’une étape ou nouveau job dédié avec état persistant contrôlé.

## 3.G VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 3.H ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

## 3.I FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 3.J TERMES DU LEXIQUE

- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Jobs and Job Steps Explained — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc12b4c594ba2e10000000a42189c.html)
- [Scheduling Background Jobs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b2954365474fee10000000a421937.html)

---

[Chapitre suivant — PRÉPARER UN PROGRAMME ABAP POUR LE BATCH](<./04 ├── PREPARER UN PROGRAMME ABAP POUR LE BATCH.md>)
