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

## 🌺 CAS D’USAGE

Dans un contexte où plusieurs modifications liées doivent être validées ensemble et protégées contre les accès concurrents, le besoin consiste à **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

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
PERFORM prepare_update ON COMMIT.
PERFORM cleanup_buffer ON ROLLBACK.

FORM prepare_update.
  CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
    EXPORTING
      is_order = gs_order.
ENDFORM.
```

## 🌺 TERMES DU LEXIQUE

- [SAP LUW](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [PERFORM ON COMMIT — ABAP Keyword Documentation](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)
- [Adding Update-Task Calls to a Subroutine — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4e3a79e11d1950f0000e82de14a.html)


---

➡️ [Chapitre suivant — ANALYSER ET REPRENDRE LES UPDATES AVEC `SM13`](<./19 - 🍧 ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>)
