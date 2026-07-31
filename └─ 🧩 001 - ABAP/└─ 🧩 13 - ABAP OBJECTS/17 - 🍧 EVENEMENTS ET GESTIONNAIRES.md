# 🌸 ÉVÉNEMENTS ET GESTIONNAIRES

## 🌺 OBJECTIFS

- Déclarer et déclencher un événement
- Implémenter une méthode gestionnaire
- Enregistrer un gestionnaire avec `SET HANDLER`
- Comprendre le couplage entre émetteur et abonnés

## 🌺 DÉCLARATION

```abap
CLASS lcl_download DEFINITION FINAL.
  PUBLIC SECTION.
    EVENTS completed
      EXPORTING VALUE(ev_file_name) TYPE string.
    METHODS execute.
ENDCLASS.
```

## 🌺 DÉCLENCHEMENT

```abap
METHOD execute.
  DATA lv_file_name TYPE string VALUE 'result.csv'.

  " Traitement...

  RAISE EVENT completed
    EXPORTING
      ev_file_name = lv_file_name.
ENDMETHOD.
```

## 🌺 GESTIONNAIRE

```abap
CLASS lcl_monitor DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS on_completed
      FOR EVENT completed OF lcl_download
      IMPORTING ev_file_name sender.
ENDCLASS.
```

```abap
CLASS lcl_monitor IMPLEMENTATION.
  METHOD on_completed.
    WRITE: / 'Fichier créé :', ev_file_name.
  ENDMETHOD.
ENDCLASS.
```

## 🌺 ENREGISTREMENT

```abap
SET HANDLER lo_monitor->on_completed FOR lo_download.
lo_download->execute( ).
```

Le gestionnaire doit être enregistré avant le déclenchement. La référence du gestionnaire doit rester valide tant que les événements doivent être reçus.

## 🌺 FLUX

```mermaid
sequenceDiagram
    participant C as Consommateur
    participant E as Emetteur
    participant G as Gestionnaire
    C->>E: SET HANDLER
    C->>E: execute
    E->>G: RAISE EVENT completed
    G-->>C: Traitement du gestionnaire
```

Les événements ABAP sont traités dans le flux d’exécution du programme. Ils ne constituent pas à eux seuls une file asynchrone ou un mécanisme de persistance.

## 🌺 DÉSENREGISTREMENT

`SET HANDLER ... ACTIVATION abap_false` permet de désactiver un enregistrement lorsque le scénario l’exige.

## 🌺 USAGES

Les événements conviennent notamment pour :

- notifier un changement d’état ;
- connecter un contrôleur à un objet d’interface graphique ;
- permettre plusieurs réactions sans que l’émetteur connaisse leurs implémentations ;
- étendre un traitement par abonnement.

Ne pas utiliser un événement lorsque l’émetteur exige un résultat immédiat et unique d’un collaborateur. Une méthode appelée explicitement est alors plus claire.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects Example — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS_ABEXA.html)
- [SET HANDLER, Static Event — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_751_index_htm/7.51/en-US/abapset_handler_static.htm)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)

---

➡️ [Chapitre suivant — CLASSES AMIES](<./18 - 🍧 CLASSES AMIES.md>)
