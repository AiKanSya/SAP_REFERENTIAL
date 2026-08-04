# 16. ÉVÉNEMENTS ET GESTIONNAIRES

## 16.A RÉSULTAT ATTENDU

- Déclarer un événement dans une classe globale[^terme-classe-globale].
- Lever l’événement.
- Enregistrer un gestionnaire avec `SET HANDLER`.
- Maîtriser la durée de vie des émetteurs et récepteurs.

## 16.B CAS D’USAGE

Un traitement long publie sa progression. Plusieurs consommateurs peuvent réagir : affichage, journal applicatif ou mesure de performance, sans modifier la classe productrice.

## 16.C PROCESS

### 16.C.1 Étape 1 — Définir le fait publié

Décrire `PROGRESS_CHANGED` comme un fait déjà survenu et définir les données minimales nécessaires aux récepteurs.

### 16.C.2 Étape 2 — Déclarer l’événement

Dans la classe émettrice, créer l’événement et ses paramètres typés. Activer la définition avant d’implémenter l’émission.

### 16.C.3 Étape 3 — Lever au point exact

Utiliser `RAISE EVENT` après la mise à jour réussie de la progression. Ne lever pas l’événement avant une validation susceptible d’échouer.

### 16.C.4 Étape 4 — Créer le gestionnaire

Dans la classe réceptrice, déclarer une méthode[^terme-methode] `FOR EVENT progress_changed OF ...` avec les paramètres générés, puis implémenter un traitement sans modifier l’émetteur de façon récursive.

### 16.C.5 Étape 5 — Enregistrer et tester

Exécuter `SET HANDLER`, déclencher l’événement, puis tester sans gestionnaire et après désenregistrement. La mise en place est validée lorsque chaque émission appelle exactement les récepteurs attendus une seule fois.

## 16.D CODE ÉMETTEUR À ADAPTER

```abap
EVENTS progress_changed
  EXPORTING VALUE(ev_percent) TYPE i.

METHODS execute.

METHOD execute.
  DO 10 TIMES.
    " Traitement d'une étape.
    RAISE EVENT progress_changed
      EXPORTING
        ev_percent = sy-index * 10.
  ENDDO.
ENDMETHOD.
```

## 16.E CODE GESTIONNAIRE À ADAPTER

Signature à déclarer dans la classe réceptrice :

```abap
METHODS on_progress_changed
  FOR EVENT progress_changed OF zcl_dev_service
  IMPORTING ev_percent.
```

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD on_progress_changed.
  WRITE: / |Progression : { ev_percent } %|.
ENDMETHOD.

SET HANDLER lo_receiver->on_progress_changed FOR lo_service.
lo_service->execute( ).
```

## 16.F PRÉCAUTIONS

- Le récepteur doit exister au moment où l’événement est levé.
- Le gestionnaire ne doit pas provoquer de dépendance circulaire incontrôlée.
- Une exception[^terme-exception] dans un gestionnaire suit les règles spécifiques des événements et doit être conçue avec prudence.
- Les événements ne remplacent pas un résultat de méthode requis immédiatement.

## 16.G CONTRÔLE

- Le gestionnaire est appelé exactement le nombre attendu de fois.
- Aucun appel n’a lieu avant `SET HANDLER`.
- Le désenregistrement est traité si la durée de vie est longue.

## 16.H ERREURS FRÉQUENTES

- Utiliser un événement pour un simple appel direct connu.
- Enregistrer plusieurs fois le même gestionnaire sans le savoir.
- Modifier lourdement l’état métier dans un gestionnaire de notification.

## 16.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 16.J RÉFÉRENCES OFFICIELLES SAP

- [Events Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEVENTS_OVERVIEW.html)
- [Inheritance and Events — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINHERITANCE_EVENTS.html)

---

[Chapitre suivant — FACTORY METHOD ET SIMPLE FACTORY](<./17 ├── FACTORY METHOD ET SIMPLE FACTORY.md>)

[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
