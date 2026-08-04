# 9. APPELER `ENQUEUE` ET TRAITER LES COLLISIONS

## 9.A RÉSULTAT ATTENDU

- Poser un verrou avant la modification
- Traiter correctement `foreign_lock` et `system_failure`
- Conserver une clé de verrouillage explicite

## 9.B EXEMPLE

```abap
CALL FUNCTION 'ENQUEUE_EZDEV_ORDER'
  EXPORTING
    mode_zdev_order = 'E'
    mandt           = sy-mandt
    order_id        = lv_order_id
    _wait           = abap_false
  EXCEPTIONS
    foreign_lock    = 1
    system_failure  = 2
    OTHERS          = 3.

CASE sy-subrc.
  WHEN 0.
    " Le traitement peut poursuivre
  WHEN 1.
    MESSAGE e010(zdev_msg) WITH lv_order_id.
  WHEN OTHERS.
    MESSAGE e011(zdev_msg) WITH lv_order_id.
ENDCASE.
```

Les noms exacts des paramètres dépendent de l’objet de verrouillage généré.

## 9.C TRAITEMENT DES ERREURS

| Exception        | Signification                                                   |
| ---------------- | --------------------------------------------------------------- |
| `foreign_lock`   | Une entrée incompatible appartient déjà à un autre propriétaire |
| `system_failure` | Le service de verrouillage n’a pas pu traiter la demande        |

Ne pas poursuivre silencieusement après une collision. Relire les données après l’obtention du verrou si elles ont été lues avant la tentative, car elles peuvent avoir changé entre-temps.

## 9.D ORDRE RECOMMANDÉ

1. déterminer la clé métier ;
2. poser le verrou ;
3. relire l’état persistant déterminant ;
4. contrôler ;
5. modifier ;
6. valider ou annuler.

## 9.E PROCESS

### 9.E.1 ÉTAPE 1 — CONSTRUIRE LA CLÉ COMPLÈTE

Déterminer la clé métier à protéger et convertir ses composants dans les types attendus par le module généré. Renseigner explicitement le mandant si la signature le prévoit. Éviter les valeurs initiales non intentionnelles, qui peuvent élargir l’argument de verrouillage.

### 9.E.2 ÉTAPE 2 — CONTRÔLER LA SIGNATURE GÉNÉRÉE

Afficher `ENQUEUE_<objet>` dans `SE37`. Relever les paramètres de table, de mode, `_SCOPE`, `_WAIT` et les exceptions exactes. Adapter le code à cette signature ; les noms de paramètres d’un autre objet ne sont pas transposables.

### 9.E.3 ÉTAPE 3 — DEMANDER LE VERROU

Appeler le module avec le mode prévu par la conception. Utiliser `_WAIT = abap_false` pour un retour immédiat, sauf besoin d’attente explicitement validé. Tester `sy-subrc` immédiatement après l’appel.

### 9.E.4 ÉTAPE 4 — TRAITER CHAQUE RÉSULTAT

Sur succès, poursuivre vers la relecture. Sur `foreign_lock`, informer que la ressource est déjà traitée et arrêter l’opération courante. Sur `system_failure` ou toute autre erreur, journaliser la cause technique et ne réaliser aucune modification non protégée.

### 9.E.5 ÉTAPE 5 — RELIRE SOUS VERROU

Relire depuis la base l’état utilisé pour la décision métier. Comparer avec les données éventuellement affichées avant l’enqueue et refaire les validations dépendantes. Cette relecture ferme la fenêtre entre la consultation initiale et l’obtention du verrou.

### 9.E.6 ÉTAPE 6 — TESTER LA COLLISION

Maintenir le verrou dans une première session. Dans une seconde, appeler le même scénario avec la même clé, puis avec une clé différente. Vérifier le message contrôlé, l’absence d’écriture concurrente et les entrées attendues dans `SM12`.

## 9.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 9.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 9.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'ENQUEUE_EZDEV_ORDER'
  EXPORTING
    mode_zdev_order = 'E'
    mandt           = sy-mandt
    order_id        = lv_order_id
    _wait           = abap_false
  EXCEPTIONS
    foreign_lock    = 1
    system_failure  = 2
    OTHERS          = 3.

CASE sy-subrc.
  WHEN 0.
    " Le traitement peut poursuivre
  WHEN 1.
    MESSAGE e010(zdev_msg) WITH lv_order_id.
  WHEN OTHERS.
    MESSAGE e011(zdev_msg) WITH lv_order_id.
ENDCASE.
```

## 9.I TERMES DU LEXIQUE

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 9.J RÉFÉRENCES OFFICIELLES SAP

- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)
- [Example Program: SAP Locking — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4c8a79e11d1950f0000e82de14a.html)

---

[Chapitre suivant — `DEQUEUE`, PROPRIÉTAIRE ET DURÉE DU VERROU](<./10 ├── DEQUEUE PROPRIETAIRE ET DUREE DU VERROU.md>)
