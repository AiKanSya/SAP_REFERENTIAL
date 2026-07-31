# 🌸 DÉFINITION, IMPLÉMENTATION ET VISIBILITÉ

## 🌺 OBJECTIFS

- Séparer le contrat d’une classe de son implémentation
- Maîtriser les sections `PUBLIC`, `PROTECTED` et `PRIVATE`
- Réduire la surface publique d’une classe
- Comprendre l’accès depuis une sous-classe

## 🌺 DEUX PARTIES

Une classe locale est décrite en deux blocs :

```abap
CLASS lcl_product DEFINITION.
  PUBLIC SECTION.
    METHODS get_name
      RETURNING VALUE(rv_name) TYPE string.
  PRIVATE SECTION.
    DATA mv_name TYPE string.
ENDCLASS.

CLASS lcl_product IMPLEMENTATION.
  METHOD get_name.
    rv_name = mv_name.
  ENDMETHOD.
ENDCLASS.
```

La **définition** décrit les composants et leur visibilité. L’**implémentation** contient le code des méthodes.

## 🌺 SECTIONS DE VISIBILITÉ

| Section             | Accessible depuis                        |
| ------------------- | ---------------------------------------- |
| `PUBLIC SECTION`    | Tous les consommateurs autorisés         |
| `PROTECTED SECTION` | La classe et ses sous-classes            |
| `PRIVATE SECTION`   | La classe elle-même et ses amis déclarés |

```mermaid
flowchart TD
    A["Consommateur externe"] --> B["Composants publics"]
    C["Sous-classe"] --> B
    C --> D["Composants protégés"]
    E["Classe elle-même"] --> B
    E --> D
    E --> F["Composants privés"]
```

## 🌺 SURFACE PUBLIQUE

La section publique constitue le contrat de la classe. Toute modification incompatible peut affecter les programmes consommateurs.

Placer en public uniquement :

- les méthodes nécessaires aux appelants ;
- les types utiles au contrat ;
- les constantes faisant partie de l’API ;
- les événements destinés aux consommateurs.

Les détails d’implémentation doivent rester privés.

## 🌺 SECTION PROTÉGÉE

La visibilité protégée crée un contrat spécifique pour les sous-classes. Elle doit être utilisée avec retenue : toute donnée protégée augmente le couplage entre la superclasse et ses descendants.

Préférer une méthode protégée ciblée à l’exposition directe d’un ensemble important d’attributs.

## 🌺 EXEMPLE D ENCAPSULATION

```abap
CLASS lcl_bank_account DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS deposit
      IMPORTING iv_amount TYPE decfloat34.
    METHODS get_balance
      RETURNING VALUE(rv_balance) TYPE decfloat34.
  PRIVATE SECTION.
    DATA mv_balance TYPE decfloat34.
ENDCLASS.
```

L’appelant ne peut pas affecter directement `mv_balance`. La méthode `deposit` peut donc contrôler la validité du montant avant de modifier l’état.

## 🌺 RÈGLE

Commencer par une visibilité privée. Élargir ensuite uniquement lorsqu’un besoin réel du contrat le justifie.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CLASS, DEFINITION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLASS_DEFINITION.html)
- [ABAP Objects as a Programming Model — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJ_PROGR_MODEL_GUIDL.html)
- [ABAP Objects — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/7bfe8cdcfbb040dcb6702dada8c3e2f0/8e8b9c6bc4b94848b13f792966f02085.html)

---

➡️ [Chapitre suivant — ATTRIBUTS, CONSTANTES ET TYPES DE CLASSE](<./05 - 🍧 ATTRIBUTS CONSTANTES ET TYPES DE CLASSE.md>)
