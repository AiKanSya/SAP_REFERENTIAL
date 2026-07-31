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

## 🌺 CAS D’USAGE

Dans un contexte où plusieurs modifications liées doivent être validées ensemble et protégées contre les accès concurrents, le besoin consiste à **appliquer créer un module fonction de mise à jour dans une transaction cohérente et vérifier verrous, validation et annulation**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE37`.
2. Entrer le nom du module fonction puis choisir **Afficher**, **Modifier** ou **Créer** selon l’autorisation.
3. Analyser les onglets Import, Export, Changing, Tables et Exceptions.
4. Lire la documentation et le code source avant tout appel.
5. Utiliser **Test/Exécuter** avec des données non destructives.
6. Pour un module Z, contrôler, activer puis tester les cas nominal et d’erreur.

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
FUNCTION zdev_order_update.
  " Interface fictive : IS_ORDER TYPE ZDEV_ORDER

  MODIFY zdev_order FROM is_order.
  IF sy-subrc <> 0.
    MESSAGE a020(zdev_msg) WITH is_order-order_id.
  ENDIF.
ENDFUNCTION.
```

## 🌺 TERMES DU LEXIQUE

- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [SAP LUW](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer créer un module fonction de mise à jour dans une transaction cohérente et vérifier verrous, validation et annulation**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)


---

➡️ [Chapitre suivant — `CALL FUNCTION ... IN UPDATE TASK`](<./15 - 🍧 CALL FUNCTION IN UPDATE TASK.md>)
