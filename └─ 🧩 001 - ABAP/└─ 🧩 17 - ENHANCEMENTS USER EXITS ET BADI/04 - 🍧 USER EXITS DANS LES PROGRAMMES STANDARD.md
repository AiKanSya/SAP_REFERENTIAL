# 🌸 USER EXITS DANS LES PROGRAMMES STANDARD

## 🌺 OBJECTIFS

- Reconnaître un user exit historique codé dans un programme SAP
- Comprendre son mode d’implémentation
- Éviter la modification directe du programme principal

## 🌺 PRINCIPE

Dans certaines applications classiques, SAP fournit des routines ou includes dédiés au code client. Elles peuvent porter un nom tel que `USEREXIT_*` et être appelées depuis le flux standard.

Exemple de forme historique :

```abap
FORM userexit_prepare_data.
  " Déléguer la logique à une classe client
  zcl_dev_extension=>prepare_data(
    CHANGING
      cs_data = gs_data ).
ENDFORM.
```

Le nom, l’emplacement et les paramètres dépendent de l’application. Ne pas créer arbitrairement une routine `USEREXIT_*` : elle doit déjà être appelée par le standard.

## 🌺 CARACTÉRISTIQUES

- technologie liée à une application précise ;
- interface souvent constituée de données globales du programme ;
- forte dépendance au contexte d’exécution ;
- faible isolation par rapport au standard ;
- transport du code client comme objet Repository.

## 🌺 PRÉCAUTIONS

- vérifier l’appel par breakpoint ;
- ne modifier que l’include client prévu ;
- ne pas dépendre de variables globales non documentées sans contrôle ;
- ne pas interrompre le flux standard par `MESSAGE A`, `LEAVE` ou commit sans nécessité ;
- encapsuler le traitement dans une classe client ;
- documenter la transaction et l’événement métier concernés.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Enhancements, User Exits and Customer Exits — SAP Help Portal](https://help.sap.com/docs/btp/ABAP/3353526313.html)
- [Enhancements and Modifications — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353523593.html)

---

➡️ [Chapitre suivant — CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES](<./05 - 🍧 CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES.md>)
