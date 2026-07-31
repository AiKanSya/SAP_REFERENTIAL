# 🌸 CRÉER UN MODULE FONCTION DE MISE À JOUR

## 🌺 OBJECTIFS

- Déclarer un module de mise à jour dans `SE37`
- Respecter les contraintes d’interface
- Séparer validation et persistance

## 🌺 CRÉATION DANS `SE37`

1. créer ou ouvrir un module fonction client ;
2. définir son groupe de fonctions ;
3. activer le type de traitement **Module de mise à jour** ;
4. choisir la priorité appropriée ;
5. définir une interface fondée sur des types du Dictionary ;
6. implémenter les écritures persistantes ;
7. activer et tester via un programme appelant.

## 🌺 CONTRAINTES

Un module appelé en update task :

- reçoit des valeurs sérialisées lors de l’enregistrement de l’appel ;
- ne doit pas dépendre de l’état global du programme de dialogue ;
- ne doit pas afficher d’écran ;
- ne doit pas exécuter `COMMIT WORK` ou `ROLLBACK WORK` ;
- doit traiter ses erreurs selon le mécanisme de mise à jour.

## 🌺 EXEMPLE DE RESPONSABILITÉ

```abap
FUNCTION zdev_order_update.
  " Interface fictive : IS_ORDER TYPE ZDEV_ORDER

  MODIFY zdev_order FROM is_order.
  IF sy-subrc <> 0.
    MESSAGE a020(zdev_msg) WITH is_order-order_id.
  ENDIF.
ENDFUNCTION.
```

Le contrôle métier complexe doit être effectué avant l’enregistrement de la mise à jour. Le module persiste un état déjà validé.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

➡️ [Chapitre suivant — CALL FUNCTION IN UPDATE TASK](<./15 - 🍧 CALL FUNCTION IN UPDATE TASK.md>)
