# 14. CRÉER UN MODULE FONCTION DE MISE À JOUR

## 14.A RÉSULTAT ATTENDU

- Déclarer un module de mise à jour dans `SE37`[^outil-se37]
- Respecter les contraintes d’interface
- Séparer validation et persistance

## 14.B CRÉATION DANS `SE37`

1. créer ou ouvrir un module fonction[^terme-module-fonction] client ;
2. définir son groupe de fonctions ;
3. activer le type de traitement **Module de mise à jour** ;
4. choisir la priorité appropriée ;
5. définir une interface fondée sur des types du Dictionary ;
6. implémenter les écritures persistantes ;
7. activer et tester via un programme appelant.

## 14.C CONTRAINTES

Un module appelé en update task[^terme-update-task] :

- reçoit des valeurs sérialisées lors de l’enregistrement de l’appel ;
- ne doit pas dépendre de l’état global du programme de dialogue ;
- ne doit pas afficher d’écran ;
- ne doit pas exécuter `COMMIT WORK`[^terme-commit-work] ou `ROLLBACK WORK`[^terme-rollback-work] ;
- doit traiter ses erreurs selon le mécanisme de mise à jour.

## 14.D EXEMPLE DE RESPONSABILITÉ

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

## 14.E PROCESS

### 14.E.1 ÉTAPE 1 — DÉFINIR L’ÉCRITURE ATOMIQUE

Lister les modifications qui doivent être exécutées ensemble par l’update task. Définir les données d’entrée complètes nécessaires à ces écritures. Le module ne doit pas dépendre d’une variable globale du programme de dialogue ni demander une interaction utilisateur.

### 14.E.2 ÉTAPE 2 — CRÉER LE MODULE DANS `SE37`

Saisir `/nSE37`, entrer un nom Z et choisir **Créer**. Affecter le module à un groupe de fonctions et renseigner sa description. Dans les attributs, sélectionner le traitement de mise à jour correspondant à la criticité V1 ou V2 définie par l’architecture.

### 14.E.3 ÉTAPE 3 — CONSTRUIRE UNE INTERFACE COMPATIBLE

Déclarer des paramètres d’import fondés sur des types DDIC[^terme-acro-ddic] sérialisables et suffisants pour la persistance. Respecter les restrictions affichées par `SE37` pour un module de mise à jour. Éviter toute référence d’objet[^terme-reference] ou dépendance au contexte frontend[^terme-frontend].

### 14.E.4 ÉTAPE 4 — IMPLÉMENTER LA PERSISTANCE

Écrire les instructions Open SQL[^terme-acro-sql] nécessaires et contrôler leurs résultats. Ne pas exécuter `COMMIT WORK`, `ROLLBACK WORK`, dialogue utilisateur ou appel impropre à l’update task dans le module. Produire un message ou une exception[^terme-exception] exploitable par le mécanisme de mise à jour en cas d’incohérence technique.

### 14.E.5 ÉTAPE 5 — ACTIVER LE GROUPE DE FONCTIONS

Contrôler la syntaxe du module, puis activer le module et les objets inactifs du groupe. Vérifier la signature active dans `SE37`. Le test direct de `SE37` ne reproduit pas à lui seul l’enregistrement et le déclenchement par une SAP LUW[^terme-sap-luw].

### 14.E.6 ÉTAPE 6 — TESTER DEPUIS UN PROGRAMME APPELANT

Créer un report Z qui prépare les paramètres, appelle le module `IN UPDATE TASK`, puis exécute `COMMIT WORK AND WAIT`. Vérifier les données et `sy-subrc`. Tester ensuite un `ROLLBACK WORK` avant le commit et un échec contrôlé du module ; analyser ce dernier dans `SM13`[^outil-sm13].

## 14.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 14.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 14.H SNIPPET À RÉUTILISER

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

## 14.I TERMES DU LEXIQUE

- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## 14.J RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

[Chapitre suivant — `CALL FUNCTION ... IN UPDATE TASK`](<./15 ├── CALL FUNCTION IN UPDATE TASK.md>)

[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-update-task]: **UPDATE TASK.** Mécanisme différant des mises à jour pour les exécuter lors du `COMMIT WORK` dans des processus de mise à jour. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-rollback-work]: **ROLLBACK WORK.** Instruction annulant les modifications non validées de la LUW courante et les tâches de mise à jour enregistrées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-reference]: **RÉFÉRENCE.** Valeur qui pointe vers un objet de données ou une instance de classe. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).

[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
[^outil-sm13]: **SM13.** Transaction de surveillance et de reprise des enregistrements de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
