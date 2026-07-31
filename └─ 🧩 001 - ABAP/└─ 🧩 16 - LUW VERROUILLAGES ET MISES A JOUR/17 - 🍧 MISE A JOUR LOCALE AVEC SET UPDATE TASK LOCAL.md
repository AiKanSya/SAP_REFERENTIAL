# 🌸 MISE À JOUR LOCALE AVEC `SET UPDATE TASK LOCAL`

## 🌺 OBJECTIFS

- Comprendre la mise à jour locale
- Identifier ses effets sur l’exécution
- Limiter son usage aux cas maîtrisés

## 🌺 PRINCIPE

```abap
SET UPDATE TASK LOCAL.

CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK.
```

Après `SET UPDATE TASK LOCAL`, les modules enregistrés sont exécutés dans le processus de travail courant lors du commit, au lieu d’être transmis à un processus d’update distinct.

## 🌺 EFFETS

- exécution synchrone dans le contexte local ;
- pas de transfert vers un update work process séparé ;
- erreurs directement liées au traitement courant ;
- modification du comportement transactionnel pour le reste de la SAP LUW.

Le mode local est désactivé par défaut au début d’une nouvelle SAP LUW classique. L’instruction doit être exécutée avant l’enregistrement des modules concernés.

## 🌺 PRUDENCE

Ne pas utiliser la mise à jour locale comme solution automatique à un problème `SM13`. Elle modifie l’architecture d’exécution et peut augmenter la durée du processus de dialogue.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Local Update — SAP Help Portal](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/41/7af4d7a79e11d1950f0000e82de14a/content.htm)
- [LUWs in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/54f5462a9604498382319304869a4280.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

➡️ [Chapitre suivant — PERFORM ON COMMIT ET ON ROLLBACK](<./18 - 🍧 PERFORM ON COMMIT ET ON ROLLBACK.md>)
