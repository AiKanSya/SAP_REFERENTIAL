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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)

---

➡️ [Chapitre suivant — ROLLBACK WORK ET ANNULATION](<./05 - 🍧 ROLLBACK WORK ET ANNULATION.md>)
