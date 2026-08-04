# INTERF" Construire les dépendances avant d’exécuter le traitement.

" Construire les dépendances avant d’exécuter le traitement.
ACES GLOBALES AVEC SE24

## RÉSULTAT ATTENDU

- Créer une interface globale dans `SE24`.
- Définir un contrat indépendant d’une implémentation.
- Implémenter l’interface dans une classe globale.

## CAS D’USAGE

Un service de notification peut envoyer un message par e-mail, journal applicatif ou système externe. Les consommateurs doivent dépendre d’un contrat `ZIF_DEV_NOTIFIER`, pas d’une classe concrète.

## PROCESS

### Étape 1 — Définir le contrat minimal

Décider ce que `SEND` reçoit, retourne et peut lever. Exclure les paramètres propres à une technologie d’implémentation particulière.

### Étape 2 — Créer l’interface

Ouvrir `SE24`, saisir `ZIF_DEV_NOTIFIER`, choisir le type interface puis affecter package et tâche de transport.

### Étape 3 — Définir la signature complète

Créer `SEND`. Ajouter les `IMPORTING`, éventuel `RETURNING` et classes `RAISING` avec des types stables. Contrôler et activer l’interface.

### Étape 4 — Ajouter l’interface à la classe

Ouvrir la classe d’implémentation, ajouter l’interface dans l’onglet correspondant puis ouvrir `ZIF_DEV_NOTIFIER~SEND`. Implémenter sans modifier le contrat.

### Étape 5 — Tester par l’interface

Déclarer une référence `TYPE REF TO zif_dev_notifier`, affecter l’instance et appeler `SEND`. La conception est validée lorsque l’appelant ne dépend pas de la classe concrète.

## DÉFINITION DU CONTRAT

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
INTERFACE zif_dev_notifier PUBLIC.
  METHODS send
    IMPORTING
      iv_recipient TYPE string
      iv_message   TYPE string
    RAISING
      zcx_dev_notification.
ENDINTERFACE.
```

## IMPLÉMENTATION

```abap
METHOD zif_dev_notifier~send.
  " Implémentation fictive : remplacer par le canal réel.
  IF iv_recipient IS INITIAL.
    RAISE EXCEPTION TYPE zcx_dev_notification.
  ENDIF.
ENDMETHOD.
```

## UTILISATION

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA lo_notifier TYPE REF TO zif_dev_notifier.
lo_notifier = NEW zcl_dev_mail_notifier( ).
lo_notifier->send(
  iv_recipient = 'user@example.invalid'
  iv_message   = 'Traitement terminé' ).
```

## RÈGLES DE CONCEPTION

- L’interface exprime ce que le consommateur attend.
- Elle ne doit pas exposer les détails techniques d’une implémentation.
- Les types publics utilisés doivent être stables et disponibles.
- Une interface trop large doit être découpée en contrats plus ciblés.

## CONTRÔLE

Remplacer `ZCL_DEV_MAIL_NOTIFIER` par une autre classe implémentant la même interface sans modifier le code consommateur, hors composition de l’objet.

## ERREURS FRÉQUENTES

- Créer une interface contenant des dizaines de méthodes sans cohésion.
- Ajouter un paramètre spécifique à une seule implémentation.
- Typer les consommateurs avec la classe concrète malgré l’existence de l’interface.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [Using Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-interfaces_e45af9bb-46e5-457b-88ef-d5ad6b0d38d7)
- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)

---

[Chapitre suivant — POLYMORPHISME PAR INTERFACE](<./12 ├── POLYMORPHISME PAR INTERFACE.md>)
