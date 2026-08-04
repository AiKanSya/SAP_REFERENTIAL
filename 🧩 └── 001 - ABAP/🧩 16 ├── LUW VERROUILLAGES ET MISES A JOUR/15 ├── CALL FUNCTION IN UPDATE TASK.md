# 15. `CALL FUNCTION ... IN UPDATE TASK`

## 15.A RÉSULTAT ATTENDU

- Enregistrer une mise à jour différée
- Comprendre le moment de copie des paramètres
- Déclencher l’exécution avec le commit

## 15.B ENREGISTREMENT

```abap
CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK AND WAIT.
IF sy-subrc <> 0.
  MESSAGE e021(zdev_msg) WITH ls_order-order_id.
ENDIF.
```

L’appel n’exécute pas immédiatement le module. Il enregistre son nom et ses paramètres pour la SAP LUW[^terme-sap-luw] courante. L’exécution est déclenchée par `COMMIT WORK`[^terme-commit-work].

## 15.C CONSÉQUENCES

- modifier `ls_order` après l’appel ne modifie pas les valeurs déjà enregistrées ;
- plusieurs appels peuvent être regroupés dans la même demande ;
- `ROLLBACK WORK`[^terme-rollback-work] supprime les appels enregistrés qui ne sont pas encore exécutés ;
- sans commit approprié, la mise à jour ne doit pas être considérée comme réalisée.

## 15.D GESTION DU COMMIT

Le module ou la méthode[^terme-methode] qui enregistre l’update ne doit pas forcément exécuter le commit. Dans une API[^terme-api] réutilisable, le commit appartient généralement au programme orchestrateur afin de préserver l’unité transactionnelle globale.

## 15.E PROCESS

### 15.E.1 ÉTAPE 1 — VÉRIFIER LE MODULE DE MISE À JOUR

Afficher le module dans `SE37`[^outil-se37]. Contrôler son attribut[^terme-attribut] V1 ou V2, sa signature active et son implémentation. Vérifier que ses paramètres sont compatibles avec l’update task[^terme-update-task] et qu’il n’exécute aucun commit ou dialogue utilisateur.

### 15.E.2 ÉTAPE 2 — PRÉPARER DES PARAMÈTRES COMPLETS

Construire les structures typées avec toutes les valeurs nécessaires à la persistance. Valider les données avant l’enregistrement. Ne pas compter sur une variable globale ou sur une modification ultérieure de la structure appelante.

### 15.E.3 ÉTAPE 3 — ENREGISTRER L’APPEL

Utiliser `CALL FUNCTION '<module>' IN UPDATE TASK` et renseigner les paramètres d’export. Considérer cette instruction comme un enregistrement dans la SAP LUW, pas comme une exécution réussie du code de mise à jour.

### 15.E.4 ÉTAPE 4 — ENREGISTRER LES AUTRES ÉCRITURES DE LA MÊME UNITÉ

Ajouter les autres modules nécessaires avant la borne finale. Conserver l’ordre logique défini et la cohérence entre V1 et V2. Si une erreur de validation survient encore, exécuter `ROLLBACK WORK` afin d’abandonner les appels non déclenchés.

### 15.E.5 ÉTAPE 5 — DÉCLENCHER DEPUIS L’ORCHESTRATEUR

Exécuter `COMMIT WORK` ou `COMMIT WORK AND WAIT` au niveau qui possède l’unité métier complète. Avec `AND WAIT`, contrôler immédiatement `sy-subrc`. Sans attente, prévoir un suivi dans `SM13`[^outil-sm13] ou le journal applicatif.

### 15.E.6 ÉTAPE 6 — TESTER LES TROIS ÉTATS

Tester un commit réussi, un rollback avant commit et un module en échec. Vérifier respectivement la persistance, l’absence d’exécution et l’entrée d’erreur dans `SM13`. Rejouer uniquement après avoir contrôlé l’état métier et l’idempotence.

## 15.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 15.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 15.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK AND WAIT.
IF sy-subrc <> 0.
  MESSAGE e021(zdev_msg) WITH ls_order-order_id.
ENDIF.
```

## 15.I TERMES DU LEXIQUE

- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)
- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## 15.J RÉFÉRENCES OFFICIELLES SAP

- [CALL FUNCTION IN UPDATE TASK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapcall_function.htm)
- [Calling Update Functions — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4dda79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

[Chapitre suivant — MISES À JOUR `V1` ET `V2`](<./16 ├── MISES A JOUR V1 ET V2.md>)

[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-rollback-work]: **ROLLBACK WORK.** Instruction annulant les modifications non validées de la LUW courante et les tâches de mise à jour enregistrées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-update-task]: **UPDATE TASK.** Mécanisme différant des mises à jour pour les exécuter lors du `COMMIT WORK` dans des processus de mise à jour. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
[^outil-sm13]: **SM13.** Transaction de surveillance et de reprise des enregistrements de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
