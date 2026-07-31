# 🌸 `PERFORM ON COMMIT` ET `ON ROLLBACK`

## 🌺 OBJECTIFS

- Comprendre les routines enregistrées pour la fin de LUW
- Maintenir du code procédural existant
- Préférer des mécanismes à interface explicite pour les nouveaux développements

## 🌺 ENREGISTREMENT

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

## 🌺 RESTRICTIONS

Dans ces routines, certaines instructions transactionnelles sont interdites, notamment un nouveau `COMMIT WORK` ou `ROLLBACK WORK`. La dépendance aux données globales rend également le code plus difficile à comprendre et à tester.

## 🌺 POSITIONNEMENT

Ce mécanisme reste important pour analyser des applications classiques. Pour un nouveau développement, préférer une orchestration explicite et des modules de mise à jour à interface claire lorsque l’update task est réellement nécessaire.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [PERFORM ON COMMIT — ABAP Keyword Documentation](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Adding Update-Task Calls to a Subroutine — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)

---

➡️ [Chapitre suivant — ANALYSER ET REPRENDRE LES UPDATES AVEC SM13](<./19 - 🍧 ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>)
