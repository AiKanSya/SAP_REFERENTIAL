# `PERFORM ON COMMIT` ET `ON ROLLBACK`

## RÉSULTAT ATTENDU

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

## PROCESS

### ÉTAPE 1 — LOCALISER L’ENREGISTREMENT ET LES ROUTINES

Rechercher `PERFORM ... ON COMMIT`, `PERFORM ... ON ROLLBACK` et les `FORM` correspondants dans le programme principal et ses includes. Relever les données globales lues ou modifiées par chaque routine et l’ordre d’enregistrement.

### ÉTAPE 2 — IDENTIFIER LA BORNE QUI DÉCLENCHE LA ROUTINE

Suivre le flux jusqu’au `COMMIT WORK` ou `ROLLBACK WORK` effectif. Vérifier les appels intermédiaires susceptibles de terminer la LUW. Une routine enregistrée n’est pas exécutée au moment du `PERFORM`, mais lors de la borne correspondante.

### ÉTAPE 3 — CONTRÔLER LES RESTRICTIONS

Vérifier que les routines ne déclenchent pas elles-mêmes un nouveau commit ou rollback et n’ouvrent pas de dialogue. Examiner leurs appels de modules de mise à jour et leurs dépendances globales. Toute valeur nécessaire doit être stable au moment de l’exécution différée.

### ÉTAPE 4 — TESTER LE CHEMIN COMMIT

Enregistrer les routines puis exécuter un commit dans un report Z contrôlé. Poser des points d’arrêt dans les `FORM` et vérifier leur ordre, les valeurs globales observées et les modules de mise à jour enregistrés. Contrôler ensuite les données et `SM13`.

### ÉTAPE 5 — TESTER LE CHEMIN ROLLBACK

Exécuter le même scénario avec un rollback avant la borne finale. Vérifier que seules les routines prévues pour l’annulation s’exécutent et qu’aucune écriture destinée au commit n’est persistée.

### ÉTAPE 6 — ENCADRER LA MAINTENANCE

Pour une correction, préserver l’ordre et les dépendances tant que des tests de non-régression ne prouvent pas une refonte sûre. Pour un nouveau développement, isoler l’orchestration dans des méthodes explicites et réserver ce mécanisme à la compatibilité avec le code classique existant.

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

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## RÉFÉRENCES OFFICIELLES SAP

- [PERFORM ON COMMIT — ABAP Keyword Documentation](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Adding Update-Task Calls to a Subroutine — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)

---

[Chapitre suivant — ANALYSER ET REPRENDRE LES UPDATES AVEC `SM13`](<./19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>)
