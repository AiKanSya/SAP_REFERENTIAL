# 🌸 MODIFIER UN JOURNAL PERSISTÉ ET GÉRER LES VERROUS

## 🌺 OBJECTIFS

- Comprendre la séquence de modification d’un journal existant
- Éviter les mises à jour concurrentes
- Connaître les fonctions de verrouillage du BAL

## 🌺 SÉQUENCE

```mermaid
flowchart LR
    A["Rechercher le journal"] --> B["BAL_DB_ENQUEUE"]
    B --> C["BAL_DB_LOAD"]
    C --> D["Modifier en mémoire"]
    D --> E["BAL_DB_SAVE"]
    E --> F["BAL_DB_DEQUEUE"]
```

Les fonctions principales sont :

- `BAL_DB_ENQUEUE` ;
- `BAL_DB_LOAD` ;
- `BAL_LOG_HDR_CHANGE` ;
- `BAL_LOG_MSG_CHANGE` ;
- `BAL_LOG_MSG_DELETE` ;
- `BAL_DB_SAVE` ;
- `BAL_DB_DEQUEUE`.

## 🌺 PRÉCAUTIONS

- verrouiller la plus petite durée possible ;
- toujours déverrouiller, y compris après une erreur ;
- éviter de transformer un journal historique en état métier mutable ;
- préférer un nouveau journal pour une nouvelle exécution ;
- documenter pourquoi un journal existant doit être modifié.

## 🌺 STATUT DU JOURNAL

Le statut d’un journal est informatif. Il ne remplace pas un statut persistant dans la table métier. Un processus critique ne doit pas dépendre uniquement de `BAL_S_LOG-ALSTATE` pour savoir s’il est terminé.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Function Module Overview — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e23b1720771417fe10000000a15822b.html)
- [Database Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21021635d44180e10000000a15822b.html)
- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)

---

➡️ [Chapitre suivant — GERER LES HANDLES ET LA MEMOIRE BAL](<./17 - 🍧 GERER LES HANDLES ET LA MEMOIRE BAL.md>)
