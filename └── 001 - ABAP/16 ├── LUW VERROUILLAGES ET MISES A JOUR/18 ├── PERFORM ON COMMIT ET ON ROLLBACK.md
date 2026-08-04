# `PERFORM ON COMMIT` ET `ON ROLLBACK`

## OBJECTIFS

- Comprendre les routines enregistrées pour la fin de LUW
- Maintenir du code procédural existant
- Préférer des mécanismes à interface explicite pour les nouveaux développements

## ENREGISTREMENT

```abap
PERFORM prepare_update ON COMMIT.
PERFORM cleanup_buffer ON ROLLBACK.

FORM prepare_update.
  CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
    EXPORTING
      is_order = gs_order.
ENDFORM.
```

La routine `ON COMMIT` est exécutée lorsque `COMMIT WORK` traite les procédures enregistrées. La routine `ON ROLLBACK` est exécutée lors d’un `ROLLBACK WORK`.

## RESTRICTIONS

Dans ces routines, certaines instructions transactionnelles sont interdites, notamment un nouveau `COMMIT WORK` ou `ROLLBACK WORK`. La dépendance aux données globales rend également le code plus difficile à comprendre et à tester.

## POSITIONNEMENT

Ce mécanisme reste important pour analyser des applications classiques. Pour un nouveau développement, préférer une orchestration explicite et des modules de mise à jour à interface claire lorsque l’update task est réellement nécessaire.

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
PERFORM prepare_update ON COMMIT.
PERFORM cleanup_buffer ON ROLLBACK.

FORM prepare_update.
  CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
    EXPORTING
      is_order = gs_order.
ENDFORM.
```

## TERMES DU LEXIQUE

- [SAP LUW](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## RÉFÉRENCES OFFICIELLES SAP

- [PERFORM ON COMMIT — ABAP Keyword Documentation](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Adding Update-Task Calls to a Subroutine — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)


---

[Chapitre suivant — ANALYSER ET REPRENDRE LES UPDATES AVEC `SM13`](<./19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>)
