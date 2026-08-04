# 10. ENCAPSULATION, INVARIANTS ET API PUBLIQUE

## 10.A RÉSULTAT ATTENDU

- Concevoir une API publique[^terme-api-publique] réduite.
- Protéger les invariants métier.
- Séparer commandes, requêtes et détails internes.

## 10.B DÉFINITION

L’encapsulation[^terme-encapsulation] consiste à masquer l’état et les détails d’implémentation derrière des opérations contrôlées. Un **invariant[^terme-invariant]** est une règle qui doit rester vraie pendant toute la durée de vie de l’objet.

Exemple : une quantité réservée ne peut pas être négative et ne peut pas dépasser la quantité disponible.

## 10.C CAS D’USAGE

Une classe[^terme-classe] `ZCL_MM_RESERVATION` expose `RESERVE` et `RELEASE`, mais pas l’attribut[^terme-attribut] `MV_RESERVED_QUANTITY`. Les méthodes contrôlent la cohérence et lèvent une exception[^terme-exception] si la règle est violée.

## 10.D CODE À ADAPTER

API publique et état privé correspondants :

```abap
PUBLIC SECTION.
  METHODS reserve
    IMPORTING iv_quantity TYPE zdev_quantity
    RAISING   zcx_dev_invalid_quantity.

  METHODS get_reserved_quantity
    RETURNING VALUE(rv_quantity) TYPE zdev_quantity.

PRIVATE SECTION.
  DATA mv_available TYPE zdev_quantity.
  DATA mv_reserved  TYPE zdev_quantity.
```

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD reserve.
  IF iv_quantity <= 0 OR mv_reserved + iv_quantity > mv_available.
    RAISE EXCEPTION TYPE zcx_dev_invalid_quantity.
  ENDIF.

  mv_reserved = mv_reserved + iv_quantity.
ENDMETHOD.

METHOD get_reserved_quantity.
  rv_quantity = mv_reserved.
ENDMETHOD.
```

## 10.E PROCESS

### 10.E.1 Étape 1 — Formaliser les invariants

Lister les règles vraies après construction et après chaque méthode[^terme-methode] publique. Associer à chacune les données concernées et le résultat attendu en cas de violation.

### 10.E.2 Étape 2 — Masquer l’état

Placer les attributs en `PRIVATE SECTION`. Avant de réduire une visibilité[^terme-visibilite] existante, rechercher les consommateurs et planifier leur migration.

### 10.E.3 Étape 3 — Exposer des opérations métier

Créer des méthodes comme `APPROVE` ou `CHANGE_QUANTITY` plutôt que des setters génériques. Leur signature contient uniquement les données nécessaires à la décision.

### 10.E.4 Étape 4 — Valider avant mutation

Contrôler toutes les préconditions avant de modifier le premier attribut. En cas d’échec, lever une exception et conserver l’état antérieur complet.

### 10.E.5 Étape 5 — Tester les frontières

Tester construction valide, opération autorisée et chaque refus. Relire l’état après exception. L’encapsulation est validée lorsqu’aucune API publique ne permet un état interdit.

## 10.F COMMANDES ET REQUÊTES

Une méthode de commande modifie l’état : `RESERVE`, `SAVE`, `CANCEL`. Une méthode de requête lit l’état : `GET_STATUS`, `IS_ALLOWED`. Éviter qu’une méthode nommée `GET_*` déclenche une mise à jour implicite.

## 10.G CONTRÔLE

- Aucun appelant ne peut affecter directement l’état critique.
- Après chaque méthode publique, les invariants restent vrais.
- Les noms des méthodes indiquent clairement leurs effets.
- Les exceptions décrivent la règle violée.

## 10.H ERREURS FRÉQUENTES

- Générer systématiquement des getters et setters pour tous les attributs.
- Exposer une table interne[^terme-table-interne] par référence puis laisser l’appelant la modifier.
- Mélanger persistance et décision métier sans séparation claire.

## 10.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 10.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — INTERFACES GLOBALES AVEC SE24](<./11 ├── INTERFACES GLOBALES AVEC SE24.md>)

[^terme-api-publique]: **API PUBLIQUE.** Ensemble des composants publics qu’une classe expose à ses consommateurs : méthodes, événements, types, constantes et attributs publics. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#api-publique>).
[^terme-encapsulation]: **ENCAPSULATION.** Principe consistant à protéger l’état interne d’un objet et à imposer son utilisation par une API contrôlée. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#encapsulation>).
[^terme-invariant]: **INVARIANT.** Condition qui doit rester vraie pendant toute la durée de vie valide d’un objet. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#invariant>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
