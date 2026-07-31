# 🌸 ANALYSER UNE DÉFINITION BAdI AVEC `SE18`

## 🌺 OBJECTIFS

- Lire le contrat d’un BAdI avant de l’implémenter
- Identifier son type, son interface et ses propriétés
- Vérifier le point d’appel réel

## 🌺 INFORMATIONS À CONTRÔLER

Dans `SE18`, relever :

- type classique ou Enhancement Framework ;
- documentation ;
- interface et méthodes ;
- paramètres de chaque méthode ;
- propriété single-use ou multiple-use ;
- filtres et types des filtres ;
- implémentation de repli éventuelle ;
- package et composant logiciel ;
- implémentations actives existantes.

## 🌺 ANALYSE DE L’INTERFACE

Pour chaque paramètre :

| Question                 | Vérification                                      |
| ------------------------ | ------------------------------------------------- |
| Entrée ou sortie ?       | `IMPORTING`, `EXPORTING`, `CHANGING`, `RETURNING` |
| Facultatif ?             | Propriété de l’interface                          |
| Modification persistée ? | Utilisation après l’appel                         |
| Volume ?                 | Structure unique ou table interne                 |
| Référence ?              | Objet potentiellement partagé                     |
| Exception ?              | Contrat de propagation                            |

## 🌺 POINT D’APPEL

La documentation seule ne suffit pas. Rechercher l’utilisation du BAdI ou placer un breakpoint dans une implémentation temporaire contrôlée. Vérifier le moment d’appel, la fréquence et le contexte transactionnel.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Definition of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/7e873842134bad04e10000000a1550b0.html)
- [Classic BAdIs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/e6d54d3c596f0b26e10000000a11402f.html)
- [How to Use Filters — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/44f6cd83912541aae10000000a114a6b.html)

---

➡️ [Chapitre suivant — IMPLEMENTER UNE BADI AVEC SE19](<./15 - 🍧 IMPLEMENTER UNE BADI AVEC SE19.md>)
