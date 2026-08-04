# MÉTHODES D’INSTANCE ET PARAMÈTRES

## RÉSULTAT ATTENDU

- Définir une méthode d’instance dans `SE24`.
- Choisir les catégories de paramètres.
- Concevoir une signature compréhensible et stable.

## CATÉGORIES DE PARAMÈTRES

| Catégorie   | Usage recommandé                               |
| ----------- | ---------------------------------------------- |
| `IMPORTING` | Donnée fournie à la méthode                    |
| `RETURNING` | Résultat principal unique                      |
| `EXPORTING` | Résultats supplémentaires                      |
| `CHANGING`  | Donnée réellement modifiée par la méthode      |
| `RAISING`   | Exceptions de classe que l’appelant doit gérer |

Une méthode fonctionnelle courte privilégie souvent `IMPORTING` et un seul `RETURNING`. `CHANGING` doit rester explicite : l’appelant doit comprendre que sa donnée peut être modifiée.

## PROCESS

### Étape 1 — Définir le contrat

Décider que `CALCULATE_TOTAL` reçoit une table d’articles et retourne un montant. Identifier le type de ligne, le type de table et le type de montant avant d’ouvrir la signature.

### Étape 2 — Créer la méthode

Dans **Méthodes**, créer `CALCULATE_TOTAL`, niveau instance, visibilité publique. Ouvrir immédiatement les paramètres.

### Étape 3 — Créer la signature complète

Ajouter `IT_ITEMS` dans `IMPORTING` avec le type de table exact. Ajouter `RV_TOTAL` dans `RETURNING`, passage par valeur, avec le type montant prévu. Dans `RAISING`, ajouter la classe d’exception utilisée pour une ligne invalide.

### Étape 4 — Implémenter avec l’état d’instance nécessaire

Valider les lignes, utiliser uniquement les attributs privés appartenant au calcul puis affecter `RV_TOTAL` sur tous les chemins normaux. Lever l’exception avant de retourner un total partiel.

### Étape 5 — Activer et tester

Tester table valide, table vide et ligne invalide. Vérifier le montant et la classe d’exception. La méthode est validée lorsque sa signature suffit à comprendre entrées, sortie et erreur.

## CAS D’USAGE

Calculer le total d’une liste de lignes de commande sans modifier la table fournie.

## CODE À ADAPTER

Signature publique à créer dans `SE24` :

```abap
METHODS calculate_total
  IMPORTING
    it_items TYPE zdev_item_tab
  RETURNING
    VALUE(rv_total) TYPE zdev_amount.
```

`ZDEV_ITEM_TAB` doit être un type de table dont la ligne expose le composant `AMOUNT` de type compatible avec `ZDEV_AMOUNT`.

Implémentation de la méthode :

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD calculate_total.
  rv_total = REDUCE zdev_amount(
    INIT total = CONV zdev_amount( 0 )
    FOR item IN it_items
    NEXT total = total + item-amount ).
ENDMETHOD.
```

Appel depuis un consommateur disposant d’une référence `LO_SERVICE` et d’une table `LT_ITEMS` correctement typées :

```abap
DATA(lv_total) = lo_service->calculate_total( lt_items ).
```

## PASSAGE PAR VALEUR ET PAR RÉFÉRENCE

La configuration exacte dépend de la catégorie de paramètre et de la release. Un paramètre de retour est transmis par valeur. Pour les gros volumes, éviter les copies inutiles, mais ne pas sacrifier la clarté de l’interface sans mesure réelle.

## CONTRÔLE

- La méthode ne modifie pas `IT_ITEMS`.
- Le résultat est déterministe pour une même entrée.
- Les cas vides et les montants invalides sont couverts.
- La signature ne contient pas de paramètres inutilisés.

## ERREURS FRÉQUENTES

- Utiliser plusieurs `EXPORTING` alors qu’une structure de résultat serait plus claire.
- Modifier indirectement un objet fourni sans que l’interface le signale.
- Retourner `sy-subrc` au lieu d’une exception ou d’un résultat métier explicite.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — MÉTHODES STATIQUES ET COMPOSANTS DE CLASSE](<./07 ├── METHODES STATIQUES ET COMPOSANTS DE CLASSE.md>)
