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

## 🌺 CAS D’USAGE

Dans un contexte où un besoin client doit compléter le comportement standard SAP sans modifier directement le code livré par SAP, le besoin consiste à **analyser une définition BAdI, ses filtres et son mode d’utilisation**. Cette notion est pertinente lorsque la modification ne doit intervenir qu’après identification du bon objet et de son impact.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE18`.
2. Entrer le nom de la BAdI ou utiliser les outils de recherche.
3. Afficher la définition et lire documentation, interface, filtres et options d’utilisation multiple.
4. Analyser les implémentations existantes et leur ordre éventuel.
5. Identifier le point d’appel dans le code standard avant de créer une nouvelle implémentation.

## 🌺 VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 🌺 ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 🌺 FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## 🌺 TERMES DU LEXIQUE

- [BAdI](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-badi>)
- [BTE](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/03 - 🍧 REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **analyser une définition BAdI, ses filtres et son mode d’utilisation**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Definition of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/7e873842134bad04e10000000a1550b0.html)
- [Classic BAdIs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/e6d54d3c596f0b26e10000000a11402f.html)
- [How to Use Filters — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/44f6cd83912541aae10000000a114a6b.html)


---

➡️ [Chapitre suivant — IMPLÉMENTER UNE BAdI AVEC `SE19`](<./15 - 🍧 IMPLEMENTER UNE BADI AVEC SE19.md>)
