# 🌸 INJECTION DE DÉPENDANCES

## 🌺 RÉSULTAT ATTENDU

- Fournir les collaborateurs depuis l’extérieur de la classe.
- Rendre les dépendances visibles.
- Faciliter les tests et le remplacement d’implémentations.

## 🌺 DÉFINITION

Une dépendance est injectée lorsqu’elle est fournie à l’objet au lieu d’être créée de manière cachée. L’injection par constructeur est généralement la plus sûre pour une dépendance obligatoire.

## 🌺 CAS D’USAGE

Une classe doit lire la date courante. Un appel direct à `SY-DATUM` rend le test d’une date limite difficile. Une interface `ZIF_DEV_CLOCK` permet d’injecter une horloge réelle ou une horloge de test.

## 🌺 INTERFACE ET IMPLÉMENTATION RÉELLE

```abap
INTERFACE zif_dev_clock PUBLIC.
  METHODS today RETURNING VALUE(rv_date) TYPE d.
ENDINTERFACE.

METHOD zif_dev_clock~today.
  rv_date = sy-datum.
ENDMETHOD.
```

## 🌺 CLASSE CONSOMMATRICE

```abap
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

## 🌺 COMPOSITION DANS LE PROGRAMME APPELANT

```abap
DATA(lo_clock) = NEW zcl_dev_system_clock( ).
DATA(lo_service) = NEW zcl_dev_validity_service( lo_clock ).
```

## 🌺 PROCÉDURE DE TEST

1. Créer une classe locale de test implémentant `ZIF_DEV_CLOCK`.
2. Faire retourner une date fixe.
3. Injecter cette classe dans le service.
4. Tester une date expirée et une date valide.
5. Vérifier que le test ne dépend pas du jour d’exécution.

## 🌺 CONTRÔLE

- Toutes les dépendances obligatoires apparaissent dans le constructeur.
- La classe n’utilise pas `NEW` pour créer ses services internes variables.
- Le test peut remplacer chaque dépendance externe.

## 🌺 ERREURS FRÉQUENTES

- Ajouter des setters publics permettant de retirer une dépendance obligatoire après construction.
- Injecter des objets purement techniques sans bénéfice de substitution.
- Construire toute la chaîne d’objets à l’intérieur de la classe métier.

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Defining Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/defining-interfaces_ab3c7c07-bb66-424b-ba06-6cfa7cc39439)
- [ABAP Unit Tests — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_701/6f45cbc76c4b1014ad87ebc4a930e7bf/14a794422760c46ae10000000a155106.html)

---

➡️ [Chapitre suivant — PATTERNS STRATEGY, ADAPTER ET FAÇADE](<./21 - 🍧 PATTERNS STRATEGY ADAPTER ET FACADE.md>)
