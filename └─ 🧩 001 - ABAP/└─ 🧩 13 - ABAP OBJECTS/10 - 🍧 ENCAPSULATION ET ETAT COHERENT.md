# 🌸 ENCAPSULATION ET ÉTAT COHÉRENT

## 🌺 OBJECTIFS

- Protéger l’état interne d’un objet
- Exprimer les opérations autorisées par des méthodes métier
- Réduire les effets de bord
- Maintenir les invariants pendant toute la durée de vie de l’objet

## 🌺 PRINCIPE

L’encapsulation consiste à cacher les détails internes et à exposer uniquement un contrat utile aux consommateurs.

```mermaid
flowchart LR
    A["Appelant"] --> B["Méthode publique"]
    B --> C["Validation"]
    C --> D["Modification de l état privé"]
    D --> E["Objet toujours cohérent"]
```

## 🌺 MAUVAIS CONTRAT

```abap
PUBLIC SECTION.
  DATA mv_balance TYPE decfloat34.
```

Tout appelant peut affecter une valeur négative ou contourner une règle métier.

## 🌺 CONTRAT ENCAPSULÉ

```abap
PUBLIC SECTION.
  METHODS deposit
    IMPORTING iv_amount TYPE decfloat34.
  METHODS withdraw
    IMPORTING iv_amount TYPE decfloat34
    RAISING   zcx_dev_insufficient_funds.
  METHODS get_balance
    RETURNING VALUE(rv_balance) TYPE decfloat34.
PRIVATE SECTION.
  DATA mv_balance TYPE decfloat34.
```

Chaque opération peut valider les règles avant de modifier l’état.

## 🌺 COMMANDES ET REQUÊTES

Une méthode de **commande** modifie l’état. Une méthode de **requête** retourne une information.

| Type     | Exemple          |
| -------- | ---------------- |
| Commande | `withdraw( )`    |
| Requête  | `get_balance( )` |

Éviter qu’une méthode nommée comme une simple lecture provoque des écritures ou un commit caché.

## 🌺 EFFETS DE BORD

Un effet de bord est une modification observable en dehors de la valeur retournée :

- modification d’un attribut ;
- écriture en base ;
- mise à jour d’une variable statique ;
- envoi d’un message ;
- appel d’un service distant.

Les effets de bord doivent être prévisibles à partir du nom et du contrat de la méthode.

## 🌺 OBJET ANÉMIQUE

Un objet qui expose uniquement des données et dont toute la logique est située ailleurs ne bénéficie pas réellement de l’encapsulation. Regrouper l’état et les règles qui garantissent sa cohérence lorsque cela correspond au domaine traité.

## 🌺 RÈGLES

- garder les attributs privés ;
- fournir des opérations métier plutôt que des setters génériques ;
- valider avant modification ;
- ne pas laisser l’objet dans un état partiellement mis à jour ;
- ne pas déclencher de transaction cachée ;
- documenter les effets de bord nécessaires.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)
- [Clean ABAP — SAP Style Guides](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)

---

➡️ [Chapitre suivant — HÉRITAGE SIMPLE](<./11 - 🍧 HERITAGE SIMPLE.md>)
