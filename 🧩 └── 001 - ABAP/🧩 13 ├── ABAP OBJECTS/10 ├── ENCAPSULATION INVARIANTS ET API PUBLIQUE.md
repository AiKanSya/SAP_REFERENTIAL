# ENCAPSULATION, INVARIANTS ET API PUBLIQUE

## RÉSULTAT ATTENDU

- Concevoir une API publique réduite.
- Protéger les invariants métier.
- Séparer commandes, requêtes et détails internes.

## DÉFINITION

L’encapsulation consiste à masquer l’état et les détails d’implémentation derrière des opérations contrôlées. Un **invariant** est une règle qui doit rester vraie pendant toute la durée de vie de l’objet.

Exemple : une quantité réservée ne peut pas être négative et ne peut pas dépasser la quantité disponible.

## CAS D’USAGE

Une classe `ZCL_MM_RESERVATION` expose `RESERVE` et `RELEASE`, mais pas l’attribut `MV_RESERVED_QUANTITY`. Les méthodes contrôlent la cohérence et lèvent une exception si la règle est violée.

## CODE À ADAPTER

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

## PROCESS

### Étape 1 — Formaliser les invariants

Lister les règles vraies après construction et après chaque méthode publique. Associer à chacune les données concernées et le résultat attendu en cas de violation.

### Étape 2 — Masquer l’état

Placer les attributs en `PRIVATE SECTION`. Avant de réduire une visibilité existante, rechercher les consommateurs et planifier leur migration.

### Étape 3 — Exposer des opérations métier

Créer des méthodes comme `APPROVE` ou `CHANGE_QUANTITY` plutôt que des setters génériques. Leur signature contient uniquement les données nécessaires à la décision.

### Étape 4 — Valider avant mutation

Contrôler toutes les préconditions avant de modifier le premier attribut. En cas d’échec, lever une exception et conserver l’état antérieur complet.

### Étape 5 — Tester les frontières

Tester construction valide, opération autorisée et chaque refus. Relire l’état après exception. L’encapsulation est validée lorsqu’aucune API publique ne permet un état interdit.

## COMMANDES ET REQUÊTES

Une méthode de commande modifie l’état : `RESERVE`, `SAVE`, `CANCEL`. Une méthode de requête lit l’état : `GET_STATUS`, `IS_ALLOWED`. Éviter qu’une méthode nommée `GET_*` déclenche une mise à jour implicite.

## CONTRÔLE

- Aucun appelant ne peut affecter directement l’état critique.
- Après chaque méthode publique, les invariants restent vrais.
- Les noms des méthodes indiquent clairement leurs effets.
- Les exceptions décrivent la règle violée.

## ERREURS FRÉQUENTES

- Générer systématiquement des getters et setters pour tous les attributs.
- Exposer une table interne par référence puis laisser l’appelant la modifier.
- Mélanger persistance et décision métier sans séparation claire.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — INTERFACES GLOBALES AVEC SE24](<./11 ├── INTERFACES GLOBALES AVEC SE24.md>)
