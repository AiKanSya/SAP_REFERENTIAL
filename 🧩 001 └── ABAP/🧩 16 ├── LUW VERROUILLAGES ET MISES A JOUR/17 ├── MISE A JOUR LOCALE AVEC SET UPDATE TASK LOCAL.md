# 17. MISE À JOUR LOCALE AVEC `SET UPDATE TASK LOCAL`

## 17.A RÉSULTAT ATTENDU

- Comprendre la mise à jour locale
- Identifier ses effets sur l’exécution
- Limiter son usage aux cas maîtrisés

## 17.B PRINCIPE

```abap
SET UPDATE TASK LOCAL.

CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK.
```

Après `SET UPDATE TASK LOCAL`, les modules enregistrés sont exécutés dans le processus de travail[^terme-processus-travail] courant lors du commit, au lieu d’être transmis à un processus d’update distinct.

## 17.C EFFETS

- exécution synchrone dans le contexte local ;
- pas de transfert vers un update work process séparé ;
- erreurs directement liées au traitement courant ;
- modification du comportement transactionnel pour le reste de la SAP LUW[^terme-sap-luw].

Le mode local est désactivé par défaut au début d’une nouvelle SAP LUW classique. L’instruction doit être exécutée avant l’enregistrement des modules concernés.

## 17.D PRUDENCE

Ne pas utiliser la mise à jour locale comme solution automatique à un problème `SM13`[^outil-sm13]. Elle modifie l’architecture d’exécution et peut augmenter la durée du processus de dialogue[^terme-processus-dialogue].

## 17.E PROCESS

### 17.E.1 ÉTAPE 1 — JUSTIFIER LA MISE À JOUR LOCALE

Utiliser `SET UPDATE TASK LOCAL` uniquement lorsque les modules de mise à jour doivent s’exécuter dans le processus de travail courant et que ce comportement est compatible avec le scénario. Documenter l’écart par rapport à l’update task[^terme-update-task] habituelle et vérifier les contraintes de performance et de reprise.

### 17.E.2 ÉTAPE 2 — POSITIONNER L’INSTRUCTION AVANT LES ENREGISTREMENTS

Exécuter `SET UPDATE TASK LOCAL` au début de la SAP LUW concernée, avant les appels `CALL FUNCTION ... IN UPDATE TASK`. Ne pas disperser cette décision dans une méthode[^terme-methode] profonde : l’orchestrateur transactionnel doit rendre le mode d’exécution visible.

### 17.E.3 ÉTAPE 3 — ENREGISTRER LES MÊMES MODULES DE MISE À JOUR

Préparer des paramètres complets puis appeler les modules avec `IN UPDATE TASK`. Ne pas appeler directement leur implémentation pour simuler le mode local. Les restrictions propres aux modules de mise à jour restent applicables.

### 17.E.4 ÉTAPE 4 — DÉCLENCHER AVEC LE COMMIT

Exécuter `COMMIT WORK`[^terme-commit-work] au point de validation défini. En mode local, les modules enregistrés sont traités dans le processus courant. Contrôler les erreurs au point d’orchestration et ne pas introduire un second commit dans le module.

### 17.E.5 ÉTAPE 5 — COMPARER LOCAL ET STANDARD

Exécuter le même scénario avec des données distinctes en mode local puis avec l’update task standard. Comparer le résultat métier, l’ordre des écritures, les verrous, les temps de réponse et les informations disponibles dans `SM13`. Toute différence doit être comprise avant livraison.

### 17.E.6 ÉTAPE 6 — TESTER LE ROLLBACK ET L’ÉCHEC

Enregistrer un module puis exécuter `ROLLBACK WORK`[^terme-rollback-work] : aucune écriture ne doit être réalisée. Provoquer aussi une erreur contrôlée pendant l’exécution locale et vérifier l’état complet de la LUW. Une exception[^terme-exception] visible en dialogue ne remplace pas le contrôle des données persistées.

## 17.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 17.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 17.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SET UPDATE TASK LOCAL.

CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK.
```

## 17.I TERMES DU LEXIQUE

- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## 17.J RÉFÉRENCES OFFICIELLES SAP

- [Local Update — SAP Help Portal](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/41/7af4d7a79e11d1950f0000e82de14a/content.htm)
- [LUWs in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/54f5462a9604498382319304869a4280.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

[Chapitre suivant — `PERFORM ON COMMIT` ET `ON ROLLBACK`](<./18 ├── PERFORM ON COMMIT ET ON ROLLBACK.md>)

[^terme-processus-travail]: **PROCESSUS DE TRAVAIL.** Processus serveur exécutant une catégorie de traitement ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-travail>).
[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).
[^terme-processus-dialogue]: **PROCESSUS DE DIALOGUE.** Processus de travail traitant les requêtes interactives SAP GUI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-dialogue>).
[^terme-update-task]: **UPDATE TASK.** Mécanisme différant des mises à jour pour les exécuter lors du `COMMIT WORK` dans des processus de mise à jour. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-rollback-work]: **ROLLBACK WORK.** Instruction annulant les modifications non validées de la LUW courante et les tâches de mise à jour enregistrées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-sm13]: **SM13.** Transaction de surveillance et de reprise des enregistrements de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
