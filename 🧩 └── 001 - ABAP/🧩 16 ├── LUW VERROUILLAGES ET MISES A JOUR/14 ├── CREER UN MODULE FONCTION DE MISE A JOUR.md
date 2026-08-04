# CRÉER UN MODULE FONCTION DE MISE À JOUR

## RÉSULTAT ATTENDU

- Déclarer un module de mise à jour dans `SE37`
- Respecter les contraintes d’interface
- Séparer validation et persistance

## CRÉATION DANS `SE37`

1. créer ou ouvrir un module fonction client ;
2. définir son groupe de fonctions ;
3. activer le type de traitement **Module de mise à jour** ;
4. choisir la priorité appropriée ;
5. définir une interface fondée sur des types du Dictionary ;
6. implémenter les écritures persistantes ;
7. activer et tester via un programme appelant.

## CONTRAINTES

Un module appelé en update task :

- reçoit des valeurs sérialisées lors de l’enregistrement de l’appel ;
- ne doit pas dépendre de l’état global du programme de dialogue ;
- ne doit pas afficher d’écran ;
- ne doit pas exécuter `COMMIT WORK` ou `ROLLBACK WORK` ;
- doit traiter ses erreurs selon le mécanisme de mise à jour.

## EXEMPLE DE RESPONSABILITÉ

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

## PROCESS

### ÉTAPE 1 — DÉFINIR L’ÉCRITURE ATOMIQUE

Lister les modifications qui doivent être exécutées ensemble par l’update task. Définir les données d’entrée complètes nécessaires à ces écritures. Le module ne doit pas dépendre d’une variable globale du programme de dialogue ni demander une interaction utilisateur.

### ÉTAPE 2 — CRÉER LE MODULE DANS `SE37`

Saisir `/nSE37`, entrer un nom Z et choisir **Créer**. Affecter le module à un groupe de fonctions et renseigner sa description. Dans les attributs, sélectionner le traitement de mise à jour correspondant à la criticité V1 ou V2 définie par l’architecture.

### ÉTAPE 3 — CONSTRUIRE UNE INTERFACE COMPATIBLE

Déclarer des paramètres d’import fondés sur des types DDIC sérialisables et suffisants pour la persistance. Respecter les restrictions affichées par `SE37` pour un module de mise à jour. Éviter toute référence d’objet ou dépendance au contexte frontend.

### ÉTAPE 4 — IMPLÉMENTER LA PERSISTANCE

Écrire les instructions Open SQL nécessaires et contrôler leurs résultats. Ne pas exécuter `COMMIT WORK`, `ROLLBACK WORK`, dialogue utilisateur ou appel impropre à l’update task dans le module. Produire un message ou une exception exploitable par le mécanisme de mise à jour en cas d’incohérence technique.

### ÉTAPE 5 — ACTIVER LE GROUPE DE FONCTIONS

Contrôler la syntaxe du module, puis activer le module et les objets inactifs du groupe. Vérifier la signature active dans `SE37`. Le test direct de `SE37` ne reproduit pas à lui seul l’enregistrement et le déclenchement par une SAP LUW.

### ÉTAPE 6 — TESTER DEPUIS UN PROGRAMME APPELANT

Créer un report Z qui prépare les paramètres, appelle le module `IN UPDATE TASK`, puis exécute `COMMIT WORK AND WAIT`. Vérifier les données et `sy-subrc`. Tester ensuite un `ROLLBACK WORK` avant le commit et un échec contrôlé du module ; analyser ce dernier dans `SM13`.

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
FUNCTION zdev_order_update.
  " Interface fictive : IS_ORDER TYPE ZDEV_ORDER

  MODIFY zdev_order FROM is_order.
  IF sy-subrc <> 0.
    MESSAGE a020(zdev_msg) WITH is_order-order_id.
  ENDIF.
ENDFUNCTION.
```

## TERMES DU LEXIQUE

- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

[Chapitre suivant — `CALL FUNCTION ... IN UPDATE TASK`](<./15 ├── CALL FUNCTION IN UPDATE TASK.md>)
