# 4. `COMMIT WORK` ET `COMMIT WORK AND WAIT`

## 4.A RÉSULTAT ATTENDU

- Terminer correctement une SAP LUW[^terme-sap-luw]
- Distinguer mise à jour asynchrone et synchrone
- Interpréter `sy-subrc`

## 4.B COMPORTEMENT

```abap
COMMIT WORK.
```

`COMMIT WORK`[^terme-commit-work] termine la SAP LUW courante, déclenche les procédures enregistrées et lance les modules de mise à jour. Sans `AND WAIT`, le programme reprend normalement sans attendre la fin de la mise à jour V1.

```abap
COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH 'Échec de la mise à jour'.
ENDIF.
```

Avec `AND WAIT`, le programme attend la fin des modules de mise à jour prioritaires. `sy-subrc` vaut `0` si leur traitement a réussi et `4` s’il a échoué.

## 4.C CHOIX

| Forme                  | Comportement                 | Usage                                                                                     |
| ---------------------- | ---------------------------- | ----------------------------------------------------------------------------------------- |
| `COMMIT WORK`          | Mise à jour asynchrone       | Transaction de dialogue standard lorsque la suite ne dépend pas immédiatement du résultat |
| `COMMIT WORK AND WAIT` | Attente de la mise à jour V1 | Traitement qui doit vérifier immédiatement la réussite de la validation                   |

## 4.D EFFETS IMPORTANTS

`COMMIT WORK` :

- exécute les routines `PERFORM ... ON COMMIT` ;
- déclenche l’update task[^terme-update-task] ;
- traite les verrous selon `_SCOPE` ;
- effectue un commit sur les connexions ouvertes ;
- ferme les curseurs de base de données.

Ne pas l’exécuter dans un module de mise à jour ni dans une routine `ON COMMIT` ou `ON ROLLBACK`.

## 4.E PROCESS

### 4.E.1 ÉTAPE 1 — IDENTIFIER LE PROPRIÉTAIRE DE LA VALIDATION

Placer la décision de commit dans le programme qui orchestre toute l’unité métier. Vérifier que les méthodes et modules appelés ne valident pas eux-mêmes une partie du traitement. Documenter dans l’interface des API[^terme-api] réutilisables si elles enregistrent une update task.

### 4.E.2 ÉTAPE 2 — TERMINER TOUS LES CONTRÔLES AVANT LE COMMIT

Valider les données, acquérir les verrous, relire l’état critique et préparer toutes les écritures. Enregistrer les modules de mise à jour avec leurs paramètres complets. Ne pas utiliser le commit comme mécanisme intermédiaire pour rendre une écriture visible avant la fin de l’unité.

### 4.E.3 ÉTAPE 3 — CHOISIR LA FORME DU COMMIT

Utiliser `COMMIT WORK` lorsque la suite du programme ne dépend pas immédiatement du résultat V1. Utiliser `COMMIT WORK AND WAIT` lorsque l’appelant doit connaître ce résultat avant de poursuivre. Ce choix ne modifie pas la définition de l’unité métier.

### 4.E.4 ÉTAPE 4 — CONTRÔLER LE RETOUR SYNCHRONE

Après `COMMIT WORK AND WAIT`, lire immédiatement `sy-subrc` et traiter une valeur non nulle comme un échec de mise à jour. Ne pas écraser cette valeur par une autre instruction avant le contrôle. Restituer un message exploitable et conserver la clé métier du traitement.

### 4.E.5 ÉTAPE 5 — VÉRIFIER LES EFFETS DE FIN DE LUW

Contrôler les données persistées, l’exécution des routines `ON COMMIT`, l’update task dans `SM13`[^outil-sm13] et la libération des verrous dans `SM12`[^outil-sm12]. Vérifier également les curseurs ou connexions utilisés par le traitement si celui-ci poursuit après le commit.

### 4.E.6 ÉTAPE 6 — TESTER LE SUCCÈS ET L’ÉCHEC

Exécuter un cas nominal puis provoquer une erreur contrôlée dans une update Z. Comparer le comportement de `COMMIT WORK` et de `COMMIT WORK AND WAIT`. Le test doit prouver le résultat métier et la traçabilité de l’échec, pas seulement l’absence de dump.

## 4.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 4.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 4.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH 'Échec de la mise à jour'.
ENDIF.
```

## 4.I TERMES DU LEXIQUE

- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 4.J RÉFÉRENCES OFFICIELLES SAP

- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)

---

[Chapitre suivant — `ROLLBACK WORK`[^terme-rollback-work] ET ANNULATION](<./05 ├── ROLLBACK WORK ET ANNULATION.md>)

[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-update-task]: **UPDATE TASK.** Mécanisme différant des mises à jour pour les exécuter lors du `COMMIT WORK` dans des processus de mise à jour. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-rollback-work]: **ROLLBACK WORK.** Instruction annulant les modifications non validées de la LUW courante et les tâches de mise à jour enregistrées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>).

[^outil-sm13]: **SM13.** Transaction de surveillance et de reprise des enregistrements de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
[^outil-sm12]: **SM12.** Transaction de surveillance et d’administration des entrées de verrouillage SAP. Voir [le chapitre associé](<12 ├── ANALYSER LES VERROUS AVEC SM12.md>).
