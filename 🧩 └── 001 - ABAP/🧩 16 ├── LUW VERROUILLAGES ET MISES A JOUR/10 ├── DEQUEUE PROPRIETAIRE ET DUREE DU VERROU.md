# 10. `DEQUEUE`, PROPRIÉTAIRE ET DURÉE DU VERROU

## 10.A RÉSULTAT ATTENDU

- Libérer un verrou au moment correct
- Comprendre le rôle du propriétaire
- Utiliser `_SCOPE` avec prudence

## 10.B LIBÉRATION EXPLICITE

```abap
CALL FUNCTION 'DEQUEUE_EZDEV_ORDER'
  EXPORTING
    mode_zdev_order = 'E'
    mandt           = sy-mandt
    order_id        = lv_order_id.
```

La libération doit utiliser une clé compatible avec celle de l’enqueue. Une clé différente peut laisser le verrou initial actif.

## 10.C PROPRIÉTAIRE ET `_SCOPE`

Le paramètre `_SCOPE` contrôle le transfert de propriété entre le programme de dialogue et l’update task. Son effet dépend de la valeur générée et du moment du commit.

| Intention                              | Conception                                                        |
| -------------------------------------- | ----------------------------------------------------------------- |
| Protéger uniquement une section courte | Libération explicite après le traitement                          |
| Protéger jusqu’à la fin de la SAP LUW  | Laisser le commit ou le rollback traiter le verrou selon `_SCOPE` |
| Transférer le verrou à la mise à jour  | Paramétrage `_SCOPE` conforme au contrat de l’objet               |

Ne pas modifier `_SCOPE` par habitude. Vérifier le comportement exact dans la documentation de l’objet et tester avec l’update task réelle.

## 10.D BLOC DE NETTOYAGE

Une procédure robuste libère les verrous dans tous les chemins qui n’aboutissent pas à un commit prévu : erreur de validation, exception gérée, abandon utilisateur ou retour anticipé.

## 10.E PROCESS

### 10.E.1 ÉTAPE 1 — RELEVER LE CONTRAT DE L’ENQUEUE

Conserver l’objet, le mode, la clé et la valeur de `_SCOPE` utilisés lors de l’acquisition. Identifier si la propriété reste au programme de dialogue, est transférée à l’update task ou est partagée selon le paramétrage retenu.

### 10.E.2 ÉTAPE 2 — CHOISIR LE MOMENT DE LIBÉRATION

Pour une section critique courte, prévoir un dequeue explicite dès que l’invariant n’a plus besoin de protection. Pour une protection jusqu’à la fin de la SAP LUW, laisser commit ou rollback agir conformément à `_SCOPE`. Ne pas libérer avant la persistance que le verrou doit protéger.

### 10.E.3 ÉTAPE 3 — APPELER LE MODULE GÉNÉRÉ

Afficher `DEQUEUE_<objet>` dans `SE37` et reprendre les paramètres exacts. Passer une clé et un mode compatibles avec l’enqueue initial. Une valeur différente peut ne pas cibler l’entrée détenue.

### 10.E.4 ÉTAPE 4 — COUVRIR LES CHEMINS D’ERREUR

Structurer le code afin que les exceptions gérées, validations négatives et retours anticipés atteignent le nettoyage prévu. Éviter plusieurs sorties dispersées après l’enqueue. Ne pas effectuer un dequeue appartenant à une update task encore active.

### 10.E.5 ÉTAPE 5 — OBSERVER LA PROPRIÉTÉ DANS `SM12`

Pendant le scénario, rechercher l’objet et l’argument. Vérifier quand le propriétaire ou l’entrée change autour de l’enregistrement de l’update et du commit. Comparer cette observation au comportement attendu de `_SCOPE`.

### 10.E.6 ÉTAPE 6 — TESTER TOUTES LES FINS DE TRAITEMENT

Exécuter un succès, une erreur de validation, une exception gérée, un rollback et une update task en erreur. Après chaque scénario, contrôler `SM12`, `SM13` et les données. Aucun verrou ne doit disparaître trop tôt ni persister sans propriétaire actif.

## 10.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 10.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 10.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'DEQUEUE_EZDEV_ORDER'
  EXPORTING
    mode_zdev_order = 'E'
    mandt           = sy-mandt
    order_id        = lv_order_id.
```

## 10.I TERMES DU LEXIQUE

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 10.J RÉFÉRENCES OFFICIELLES SAP

- [\_SCOPE Parameters — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/6568469cf5a1460a8d85c58b83d21ec2/47daadf638793c85e10000000a42189c.html)
- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)
- [COMMIT WORK — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_752_index_htm/7.52/en-US/abapcommit.htm)

---

[Chapitre suivant — `_WAIT`, `_COLLECT` ET GRANULARITÉ DES VERROUS](<./11 ├── WAIT COLLECT ET GRANULARITE DES VERROUS.md>)
