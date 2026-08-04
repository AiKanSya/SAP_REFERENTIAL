# 🌸 APPELER `ENQUEUE` ET TRAITER LES COLLISIONS

## 🌺 OBJECTIFS

- Poser un verrou avant la modification
- Traiter correctement `foreign_lock` et `system_failure`
- Conserver une clé de verrouillage explicite

## 🌺 EXEMPLE

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

## 🌺 TRAITEMENT DES ERREURS

| Exception        | Signification                                                   |
| ---------------- | --------------------------------------------------------------- |
| `foreign_lock`   | Une entrée incompatible appartient déjà à un autre propriétaire |
| `system_failure` | Le service de verrouillage n’a pas pu traiter la demande        |

Ne pas poursuivre silencieusement après une collision. Relire les données après l’obtention du verrou si elles ont été lues avant la tentative, car elles peuvent avoir changé entre-temps.

## 🌺 ORDRE RECOMMANDÉ

1. déterminer la clé métier ;
2. poser le verrou ;
3. relire l’état persistant déterminant ;
4. contrôler ;
5. modifier ;
6. valider ou annuler.

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

## 🌺 TERMES DU LEXIQUE

- [SAP LUW](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Modules for Lock Requests — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21eebf446011d189700000e8322d00.html)
- [Example Program: SAP Locking — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4c8a79e11d1950f0000e82de14a.html)


---

➡️ [Chapitre suivant — `DEQUEUE`, PROPRIÉTAIRE ET DURÉE DU VERROU](<./10 - 🍧 DEQUEUE PROPRIETAIRE ET DUREE DU VERROU.md>)
