# DOCUMENTATION, TEST ET DEBUG AVEC SE24

## RÉSULTAT ATTENDU

- Documenter une classe globale et ses composants.
- Exécuter un test simple depuis le Class Builder.
- Déboguer une méthode appelée depuis un programme.
- Positionner ABAP Unit par rapport au test manuel.

## DOCUMENTATION

La description courte doit expliquer la responsabilité de la classe. ABAP Doc peut documenter classes, interfaces, méthodes, types, données et constantes selon la syntaxe disponible dans la release.

```abap
"! Service de calcul des échéances contractuelles.
"! Ne réalise aucune mise à jour en base.
CLASS zcl_dev_due_date_service DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    "! Calcule l'échéance à partir d'une date de départ.
    "! @parameter iv_start_date | Date de départ
    "! @parameter rv_due_date   | Date d'échéance calculée
    METHODS calculate
      IMPORTING iv_start_date TYPE d
      RETURNING VALUE(rv_due_date) TYPE d.
ENDCLASS.
```

## TEST MANUEL DANS SE24

1. Ouvrir la classe.
2. Choisir la fonction de test de classe si elle est disponible.
3. Sélectionner une méthode publique testable.
4. Renseigner les paramètres.
5. Exécuter.
6. Examiner les valeurs de retour et exceptions.
7. Répéter avec les cas limites.

Le test manuel ne remplace pas un test automatisé : il dépend de la saisie et ne protège pas automatiquement contre les régressions.

## REPORT D’APPEL À COPIER

```abap
REPORT zdev_test_due_date_service.

PARAMETERS p_date TYPE d DEFAULT sy-datum.

START-OF-SELECTION.
  DATA(lo_service) = NEW zcl_dev_due_date_service( ).
  DATA(lv_due_date) = lo_service->calculate( p_date ).
  WRITE: / lv_due_date.
```

## DEBUG

1. Placer un breakpoint externe ou de session dans la méthode.
2. Exécuter le report, job ou transaction appelante.
3. Vérifier les paramètres d’entrée.
4. Examiner `ME`, les attributs d’instance et la pile d’appels.
5. Suivre les appels aux collaborateurs.
6. Contrôler l’exception ou la valeur de retour.

## ABAP UNIT

Les classes de test locales peuvent être placées dans le Class Pool. Elles doivent tester le comportement public et les cas limites, pas reproduire l’implémentation ligne par ligne.

## CONTRÔLE

- La classe possède une responsabilité compréhensible sans ouvrir son code.
- Chaque méthode publique non triviale possède des cas de test définis.
- Le test manuel et le test automatisé utilisent des données sans impact.
- Le debugger confirme le flux attendu sans modifier les données en production.

## ERREURS FRÉQUENTES

- Documenter uniquement ce que le code dit déjà.
- Tester uniquement le cas nominal.
- Modifier les valeurs dans le debugger et considérer le résultat comme une validation fiable.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Code Documentation — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Testing a Class — SAP Help Portal](https://help.sap.com/saphelp_em900/helpdata/en/91/67d406f53a11d194dc00a0c94260a5/content.htm)
- [ABAP Unit Tests — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f45cbc76c4b1014ad87ebc4a930e7bf/14a794422760c46ae10000000a155106.html)

---

[Chapitre suivant — PACKAGES, TRANSPORTS, VERSIONING ET BONNES PRATIQUES](<./24 └── PACKAGES TRANSPORTS VERSIONING ET BONNES PRATIQUES.md>)
