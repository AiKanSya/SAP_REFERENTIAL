# VISIBILITÉ, TYPES, CONSTANTES ET ATTRIBUTS

## RÉSULTAT ATTENDU

- Choisir entre visibilité publique, protégée et privée.
- Déclarer les types, constantes et attributs au bon niveau.
- Éviter l’exposition directe d’un état modifiable.

## VISIBILITÉS

| Visibilité  | Accessible depuis                                     |
| ----------- | ----------------------------------------------------- |
| `PUBLIC`    | Tous les consommateurs autorisés à utiliser la classe |
| `PROTECTED` | La classe et ses sous-classes                         |
| `PRIVATE`   | La classe elle-même et, selon le cas, ses amis        |

L’API publique doit rester minimale. Un attribut interne est normalement privé. Une valeur destinée aux consommateurs peut être exposée par une méthode de lecture ou une constante publique.

## PROCESS

### Étape 1 — Classer chaque composant

Avant `SE24`, décider si le composant appartient au contrat public, aux sous-classes ou uniquement à l’implémentation. Utiliser public, protected ou private selon ce consommateur réel.

### Étape 2 — Créer un type

Dans **Types**, ajouter le nom et le type référencé, puis choisir la visibilité. Un type public devient une dépendance pour les appelants ; ne l’exposer que s’il fait partie de la signature externe.

### Étape 3 — Créer la constante

Dans **Attributs**, créer une constante de niveau classe, lui affecter un type explicite et une valeur compatible. Choisir une visibilité publique uniquement si les consommateurs doivent partager cette valeur contractuelle.

### Étape 4 — Créer l’état d’instance

Ajouter les attributs privés nécessaires. Initialiser dans la déclaration ou le constructeur, puis créer des méthodes publiques orientées métier plutôt que des setters permettant n’importe quel état.

### Étape 5 — Tester les frontières

Depuis un report externe, vérifier que les composants publics sont accessibles et que les privés provoquent une erreur syntaxique. Tester ensuite que les méthodes publiques maintiennent les invariants. La visibilité est validée lorsque aucun appelant ne dépend de l’implémentation interne.

## CAS D’USAGE

Une classe représentant une limite de crédit doit empêcher un montant négatif. Si `MV_LIMIT` est public, tout appelant peut contourner la règle. L’attribut doit être privé et modifié uniquement par `SET_LIMIT`.

## CODE À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS zcl_dev_credit_limit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES ty_amount TYPE p LENGTH 16 DECIMALS 2.

    CONSTANTS c_currency TYPE waers VALUE 'EUR'.

    METHODS constructor
      IMPORTING iv_limit TYPE ty_amount.

    METHODS get_limit
      RETURNING VALUE(rv_limit) TYPE ty_amount.

    METHODS set_limit
      IMPORTING iv_limit TYPE ty_amount
      RAISING   zcx_dev_invalid_amount.

  PRIVATE SECTION.
    DATA mv_limit TYPE ty_amount.
ENDCLASS.
```

## RÈGLES PRATIQUES

- Un type public fait partie du contrat et devient plus difficile à modifier.
- Une constante publique est adaptée à une valeur stable du contrat.
- Un attribut public modifiable crée un couplage fort et affaiblit les contrôles.
- Un attribut statique conserve une valeur partagée pour la session interne : l’utiliser uniquement si ce partage est intentionnel.

## CONTRÔLE

Tenter d’accéder à l’attribut privé depuis un report doit produire une erreur de syntaxe. La valeur doit être accessible uniquement via la méthode prévue.

## ERREURS FRÉQUENTES

- Utiliser `PUBLIC` par facilité.
- Déclarer des types publics qui ne servent qu’à l’implémentation.
- Employer un attribut statique pour stocker un état utilisateur sans maîtriser sa durée de vie.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — MÉTHODES D’INSTANCE ET PARAMÈTRES](<./06 ├── METHODES D INSTANCE ET PARAMETRES.md>)
