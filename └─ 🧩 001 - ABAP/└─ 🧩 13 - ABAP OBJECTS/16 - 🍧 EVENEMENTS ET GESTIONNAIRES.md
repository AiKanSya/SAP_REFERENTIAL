# 🌸 ÉVÉNEMENTS ET GESTIONNAIRES

## 🌺 RÉSULTAT ATTENDU

- Déclarer un événement dans une classe globale.
- Lever l’événement.
- Enregistrer un gestionnaire avec `SET HANDLER`.
- Maîtriser la durée de vie des émetteurs et récepteurs.

## 🌺 CAS D’USAGE

Un traitement long publie sa progression. Plusieurs consommateurs peuvent réagir : affichage, journal applicatif ou mesure de performance, sans modifier la classe productrice.

## 🌺 PROCÉDURE DANS SE24

1. Ouvrir la classe émettrice.
2. Créer l’événement `PROGRESS_CHANGED`.
3. Définir les paramètres de l’événement.
4. Lever l’événement dans la méthode concernée.
5. Créer une classe réceptrice.
6. Déclarer une méthode `FOR EVENT ... OF ...`.
7. Enregistrer le gestionnaire avec `SET HANDLER`.
8. Exécuter et vérifier le déclenchement.

## 🌺 CODE ÉMETTEUR À ADAPTER

```abap
EVENTS progress_changed
  EXPORTING VALUE(ev_percent) TYPE i.

METHOD execute.
  DO 10 TIMES.
    " Traitement d'une étape.
    RAISE EVENT progress_changed
      EXPORTING
        ev_percent = sy-index * 10.
  ENDDO.
ENDMETHOD.
```

## 🌺 CODE GESTIONNAIRE À ADAPTER

```abap
METHOD on_progress_changed.
  WRITE: / |Progression : { ev_percent } %|.
ENDMETHOD.

SET HANDLER lo_receiver->on_progress_changed FOR lo_service.
lo_service->execute( ).
```

## 🌺 PRÉCAUTIONS

- Le récepteur doit exister au moment où l’événement est levé.
- Le gestionnaire ne doit pas provoquer de dépendance circulaire incontrôlée.
- Une exception dans un gestionnaire suit les règles spécifiques des événements et doit être conçue avec prudence.
- Les événements ne remplacent pas un résultat de méthode requis immédiatement.

## 🌺 CONTRÔLE

- Le gestionnaire est appelé exactement le nombre attendu de fois.
- Aucun appel n’a lieu avant `SET HANDLER`.
- Le désenregistrement est traité si la durée de vie est longue.

## 🌺 ERREURS FRÉQUENTES

- Utiliser un événement pour un simple appel direct connu.
- Enregistrer plusieurs fois le même gestionnaire sans le savoir.
- Modifier lourdement l’état métier dans un gestionnaire de notification.

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Events Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEVENTS_OVERVIEW.html)
- [Inheritance and Events — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINHERITANCE_EVENTS.html)

---

➡️ [Chapitre suivant — FACTORY METHOD ET SIMPLE FACTORY](<./17 - 🍧 FACTORY METHOD ET SIMPLE FACTORY.md>)
