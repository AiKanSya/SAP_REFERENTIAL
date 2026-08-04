# `CALL FUNCTION ... IN UPDATE TASK`

## OBJECTIFS

- Enregistrer une mise à jour différée
- Comprendre le moment de copie des paramètres
- Déclencher l’exécution avec le commit

## ENREGISTREMENT

```abap
CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK AND WAIT.
IF sy-subrc <> 0.
  MESSAGE e021(zdev_msg) WITH ls_order-order_id.
ENDIF.
```

L’appel n’exécute pas immédiatement le module. Il enregistre son nom et ses paramètres pour la SAP LUW courante. L’exécution est déclenchée par `COMMIT WORK`.

## CONSÉQUENCES

- modifier `ls_order` après l’appel ne modifie pas les valeurs déjà enregistrées ;
- plusieurs appels peuvent être regroupés dans la même demande ;
- `ROLLBACK WORK` supprime les appels enregistrés qui ne sont pas encore exécutés ;
- sans commit approprié, la mise à jour ne doit pas être considérée comme réalisée.

## GESTION DU COMMIT

Le module ou la méthode qui enregistre l’update ne doit pas forcément exécuter le commit. Dans une API réutilisable, le commit appartient généralement au programme orchestrateur afin de préserver l’unité transactionnelle globale.

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
CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK AND WAIT.
IF sy-subrc <> 0.
  MESSAGE e021(zdev_msg) WITH ls_order-order_id.
ENDIF.
```

## TERMES DU LEXIQUE

- [Update task](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)
- [SAP LUW](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## RÉFÉRENCES OFFICIELLES SAP

- [CALL FUNCTION IN UPDATE TASK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapcall_function.htm)
- [Calling Update Functions — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4dda79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)


---

[Chapitre suivant — MISES À JOUR `V1` ET `V2`](<./16 ├── MISES A JOUR V1 ET V2.md>)
