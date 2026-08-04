# `COMMIT WORK` ET `COMMIT WORK AND WAIT`

## RÉSULTAT ATTENDU

- Terminer correctement une SAP LUW
- Distinguer mise à jour asynchrone et synchrone
- Interpréter `sy-subrc`

## COMPORTEMENT

```abap
COMMIT WORK.
```

`COMMIT WORK` termine la SAP LUW courante, déclenche les procédures enregistrées et lance les modules de mise à jour. Sans `AND WAIT`, le programme reprend normalement sans attendre la fin de la mise à jour V1.

```abap
COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH 'Échec de la mise à jour'.
ENDIF.
```

Avec `AND WAIT`, le programme attend la fin des modules de mise à jour prioritaires. `sy-subrc` vaut `0` si leur traitement a réussi et `4` s’il a échoué.

## CHOIX

| Forme                  | Comportement                 | Usage                                                                                     |
| ---------------------- | ---------------------------- | ----------------------------------------------------------------------------------------- |
| `COMMIT WORK`          | Mise à jour asynchrone       | Transaction de dialogue standard lorsque la suite ne dépend pas immédiatement du résultat |
| `COMMIT WORK AND WAIT` | Attente de la mise à jour V1 | Traitement qui doit vérifier immédiatement la réussite de la validation                   |

## EFFETS IMPORTANTS

`COMMIT WORK` :

- exécute les routines `PERFORM ... ON COMMIT` ;
- déclenche l’update task ;
- traite les verrous selon `_SCOPE` ;
- effectue un commit sur les connexions ouvertes ;
- ferme les curseurs de base de données.

Ne pas l’exécuter dans un module de mise à jour ni dans une routine `ON COMMIT` ou `ON ROLLBACK`.

## PROCESS

### ÉTAPE 1 — IDENTIFIER LE PROPRIÉTAIRE DE LA VALIDATION

Placer la décision de commit dans le programme qui orchestre toute l’unité métier. Vérifier que les méthodes et modules appelés ne valident pas eux-mêmes une partie du traitement. Documenter dans l’interface des API réutilisables si elles enregistrent une update task.

### ÉTAPE 2 — TERMINER TOUS LES CONTRÔLES AVANT LE COMMIT

Valider les données, acquérir les verrous, relire l’état critique et préparer toutes les écritures. Enregistrer les modules de mise à jour avec leurs paramètres complets. Ne pas utiliser le commit comme mécanisme intermédiaire pour rendre une écriture visible avant la fin de l’unité.

### ÉTAPE 3 — CHOISIR LA FORME DU COMMIT

Utiliser `COMMIT WORK` lorsque la suite du programme ne dépend pas immédiatement du résultat V1. Utiliser `COMMIT WORK AND WAIT` lorsque l’appelant doit connaître ce résultat avant de poursuivre. Ce choix ne modifie pas la définition de l’unité métier.

### ÉTAPE 4 — CONTRÔLER LE RETOUR SYNCHRONE

Après `COMMIT WORK AND WAIT`, lire immédiatement `sy-subrc` et traiter une valeur non nulle comme un échec de mise à jour. Ne pas écraser cette valeur par une autre instruction avant le contrôle. Restituer un message exploitable et conserver la clé métier du traitement.

### ÉTAPE 5 — VÉRIFIER LES EFFETS DE FIN DE LUW

Contrôler les données persistées, l’exécution des routines `ON COMMIT`, l’update task dans `SM13` et la libération des verrous dans `SM12`. Vérifier également les curseurs ou connexions utilisés par le traitement si celui-ci poursuit après le commit.

### ÉTAPE 6 — TESTER LE SUCCÈS ET L’ÉCHEC

Exécuter un cas nominal puis provoquer une erreur contrôlée dans une update Z. Comparer le comportement de `COMMIT WORK` et de `COMMIT WORK AND WAIT`. Le test doit prouver le résultat métier et la traçabilité de l’échec, pas seulement l’absence de dump.

## VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH 'Échec de la mise à jour'.
ENDIF.
```

## TERMES DU LEXIQUE

- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## RÉFÉRENCES OFFICIELLES SAP

- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)

---

[Chapitre suivant — `ROLLBACK WORK` ET ANNULATION](<./05 ├── ROLLBACK WORK ET ANNULATION.md>)
