# 20. INJECTER UNE DÉPENDANCE PAR CONSTRUCTEUR

## 20.A RÉSULTAT ATTENDU

- Fournir les collaborateurs depuis l’extérieur de la classe[^terme-classe].
- Rendre les dépendances visibles.
- Faciliter les tests et le remplacement d’implémentations.

## 20.B DÉFINITION

Une dépendance est injectée lorsqu’elle est fournie à l’objet au lieu d’être créée de manière cachée. L’injection par constructeur est généralement la plus sûre pour une dépendance obligatoire.

## 20.C CAS D’USAGE

Une classe doit lire la date courante. Un appel direct à `SY-DATUM` rend le test d’une date limite difficile. Une interface `ZIF_DEV_CLOCK` permet d’injecter une horloge réelle ou une horloge de test.

## 20.D INTERFACE ET IMPLÉMENTATION RÉELLE

Les blocs suivants sont des fragments de définition et d’implémentation. Créer les objets globaux `ZIF_DEV_CLOCK`, `ZCL_DEV_SYSTEM_CLOCK` et `ZCL_DEV_VALIDITY_SERVICE` dans `SE24`[^terme-class-builder-se24] avant de les utiliser.

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
INTERFACE zif_dev_clock PUBLIC.
  METHODS today RETURNING VALUE(rv_date) TYPE d.
ENDINTERFACE.

METHOD zif_dev_clock~today.
  rv_date = sy-datum.
ENDMETHOD.
```

## 20.E CLASSE CONSOMMATRICE

Signatures et attribut[^terme-attribut] de `ZCL_DEV_VALIDITY_SERVICE` :

```abap
PUBLIC SECTION.
  METHODS constructor
    IMPORTING io_clock TYPE REF TO zif_dev_clock
    RAISING   zcx_dev_configuration.

  METHODS is_expired
    IMPORTING iv_valid_to TYPE d
    RETURNING VALUE(rv_expired) TYPE abap_bool.

PRIVATE SECTION.
  DATA mo_clock TYPE REF TO zif_dev_clock.
```

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD constructor.
  IF io_clock IS NOT BOUND.
    RAISE EXCEPTION TYPE zcx_dev_configuration.
  ENDIF.
  mo_clock = io_clock.
ENDMETHOD.

METHOD is_expired.
  rv_expired = xsdbool( iv_valid_to < mo_clock->today( ) ).
ENDMETHOD.
```

## 20.F COMPOSITION DANS LE PROGRAMME APPELANT

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA(lo_clock) = NEW zcl_dev_system_clock( ).
DATA(lo_service) = NEW zcl_dev_validity_service( lo_clock ).
```

## 20.G PROCESS

### 20.G.1 Étape 1 — Créer le double

Dans la partie locale du test, créer `LCL_FIXED_CLOCK` et implémenter `ZIF_DEV_CLOCK`. Son constructeur reçoit une date et la conserve dans `MV_DATE`.

### 20.G.2 Étape 2 — Rendre le résultat déterministe

Implémenter la méthode[^terme-methode] de l’interface pour retourner uniquement `MV_DATE`. Tester le double seul afin de vérifier que la date système n’est jamais lue.

### 20.G.3 Étape 3 — Injecter dans le service

Créer le service en passant la référence du double au constructeur. Contrôler que le service stocke le type interface et n’instancie pas lui-même l’horloge réelle.

### 20.G.4 Étape 4 — Tester les deux frontières

Créer une horloge avec date avant expiration puis une autre avec date encore valide. Exécuter la même méthode métier et vérifier les deux résultats.

### 20.G.5 Étape 5 — Prouver l’indépendance temporelle

Relancer avec les mêmes dates un autre jour ou sans utiliser `SY-DATUM`. Le test est validé lorsqu’il dépend uniquement des valeurs injectées.

Classe locale[^terme-classe-locale] de remplacement à placer dans le programme de test ou dans la partie locale de la classe testée :

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS lcl_fixed_clock DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES zif_dev_clock.
    METHODS constructor IMPORTING iv_date TYPE d.
  PRIVATE SECTION.
    DATA mv_date TYPE d.
ENDCLASS.

CLASS lcl_fixed_clock IMPLEMENTATION.
  METHOD constructor.
    mv_date = iv_date.
  ENDMETHOD.

  METHOD zif_dev_clock~today.
    rv_date = mv_date.
  ENDMETHOD.
ENDCLASS.
```

## 20.H CONTRÔLE

- Toutes les dépendances obligatoires apparaissent dans le constructeur.
- La classe n’utilise pas `NEW` pour créer ses services internes variables.
- Le test peut remplacer chaque dépendance externe.

## 20.I ERREURS FRÉQUENTES

- Ajouter des setters publics permettant de retirer une dépendance obligatoire après construction.
- Injecter des objets purement techniques sans bénéfice de substitution.
- Construire toute la chaîne d’objets à l’intérieur de la classe métier.

## 20.J COMPATIBILITÉ S/4HANA

- Statut : recommandé pour rendre les classes testables et limiter les dépendances cachées.
- Utiliser l’injection par constructeur pour les dépendances obligatoires.
- Construire le graphe d’objets dans le programme appelant, une factory ou une couche de composition[^terme-composition] dédiée.

## 20.K RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [ABAP Unit Tests — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f45cbc76c4b1014ad87ebc4a930e7bf/14a794422760c46ae10000000a155106.html)

---

[Chapitre suivant — PATTERNS STRATEGY, ADAPTER ET FAÇADE](<./21 ├── PATTERNS STRATEGY ADAPTER ET FACADE.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-classe-locale]: **CLASSE LOCALE.** Classe définie dans le code source d’un programme, d’un include ou d’un Class Pool et visible uniquement dans ce contexte de compilation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-locale>).
[^terme-composition]: **COMPOSITION.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#composition>).
