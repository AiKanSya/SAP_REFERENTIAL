# 🌸 `COMMIT WORK` ET `COMMIT WORK AND WAIT`

## 🌺 OBJECTIFS

- Terminer correctement une SAP LUW
- Distinguer mise à jour asynchrone et synchrone
- Interpréter `sy-subrc`

## 🌺 COMPORTEMENT

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

## 🌺 CHOIX

| Forme                  | Comportement                 | Usage                                                                                     |
| ---------------------- | ---------------------------- | ----------------------------------------------------------------------------------------- |
| `COMMIT WORK`          | Mise à jour asynchrone       | Transaction de dialogue standard lorsque la suite ne dépend pas immédiatement du résultat |
| `COMMIT WORK AND WAIT` | Attente de la mise à jour V1 | Traitement qui doit vérifier immédiatement la réussite de la validation                   |

## 🌺 EFFETS IMPORTANTS

`COMMIT WORK` :

- exécute les routines `PERFORM ... ON COMMIT` ;
- déclenche l’update task ;
- traite les verrous selon `_SCOPE` ;
- effectue un commit sur les connexions ouvertes ;
- ferme les curseurs de base de données.

Ne pas l’exécuter dans un module de mise à jour ni dans une routine `ON COMMIT` ou `ON ROLLBACK`.

## 🌺 CAS D’USAGE

Dans un contexte où plusieurs modifications liées doivent être validées ensemble et protégées contre les accès concurrents, le besoin consiste à **valider la transaction au niveau responsable et attendre la mise à jour lorsque nécessaire**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_msg) WITH 'Échec de la mise à jour'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [COMMIT WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [SAP LUW](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [ROLLBACK WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **valider la transaction au niveau responsable et attendre la mise à jour lorsque nécessaire**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)


---

➡️ [Chapitre suivant — `ROLLBACK WORK` ET ANNULATION](<./05 - 🍧 ROLLBACK WORK ET ANNULATION.md>)
