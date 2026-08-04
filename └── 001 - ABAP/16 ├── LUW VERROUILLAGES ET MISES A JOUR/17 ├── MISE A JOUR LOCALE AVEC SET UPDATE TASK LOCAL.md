# MISE À JOUR LOCALE AVEC `SET UPDATE TASK LOCAL`

## OBJECTIFS

- Comprendre la mise à jour locale
- Identifier ses effets sur l’exécution
- Limiter son usage aux cas maîtrisés

## PRINCIPE

```abap
SET UPDATE TASK LOCAL.

CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK.
```

Après `SET UPDATE TASK LOCAL`, les modules enregistrés sont exécutés dans le processus de travail courant lors du commit, au lieu d’être transmis à un processus d’update distinct.

## EFFETS

- exécution synchrone dans le contexte local ;
- pas de transfert vers un update work process séparé ;
- erreurs directement liées au traitement courant ;
- modification du comportement transactionnel pour le reste de la SAP LUW.

Le mode local est désactivé par défaut au début d’une nouvelle SAP LUW classique. L’instruction doit être exécutée avant l’enregistrement des modules concernés.

## PRUDENCE

Ne pas utiliser la mise à jour locale comme solution automatique à un problème `SM13`. Elle modifie l’architecture d’exécution et peut augmenter la durée du processus de dialogue.

## PROCÉDURE PAS À PAS

1. Saisir `/nSM13`.
2. Rechercher les mises à jour par utilisateur et période.
3. Ouvrir l’entrée en erreur et lire module, message et données de contexte.
4. Identifier la cause avant toute répétition.
5. Vérifier l’idempotence et l’état métier ; une reprise aveugle peut dupliquer une opération.

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
SET UPDATE TASK LOCAL.

CALL FUNCTION 'ZDEV_ORDER_UPDATE' IN UPDATE TASK
  EXPORTING
    is_order = ls_order.

COMMIT WORK.
```

## TERMES DU LEXIQUE

- [Update task](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)
- [SAP LUW](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)

## RÉFÉRENCES OFFICIELLES SAP

- [Local Update — SAP Help Portal](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/41/7af4d7a79e11d1950f0000e82de14a/content.htm)
- [LUWs in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/54f5462a9604498382319304869a4280.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)


---

[Chapitre suivant — `PERFORM ON COMMIT` ET `ON ROLLBACK`](<./18 ├── PERFORM ON COMMIT ET ON ROLLBACK.md>)
