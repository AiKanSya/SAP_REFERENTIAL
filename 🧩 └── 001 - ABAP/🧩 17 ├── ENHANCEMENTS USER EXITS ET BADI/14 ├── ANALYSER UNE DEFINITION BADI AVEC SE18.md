# 14. ANALYSER UNE DÉFINITION BAdI AVEC `SE18`

## 14.A RÉSULTAT ATTENDU

- Lire le contrat d’un BAdI avant de l’implémenter
- Identifier son type, son interface et ses propriétés
- Vérifier le point d’appel réel

## 14.B INFORMATIONS À CONTRÔLER

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

## 14.C ANALYSE DE L’INTERFACE

Pour chaque paramètre :

| Question                 | Vérification                                      |
| ------------------------ | ------------------------------------------------- |
| Entrée ou sortie ?       | `IMPORTING`, `EXPORTING`, `CHANGING`, `RETURNING` |
| Facultatif ?             | Propriété de l’interface                          |
| Modification persistée ? | Utilisation après l’appel                         |
| Volume ?                 | Structure unique ou table interne                 |
| Référence ?              | Objet potentiellement partagé                     |
| Exception ?              | Contrat de propagation                            |

## 14.D POINT D’APPEL

La documentation seule ne suffit pas. Rechercher l’utilisation du BAdI ou placer un breakpoint dans une implémentation temporaire contrôlée. Vérifier le moment d’appel, la fréquence et le contexte transactionnel.

## 14.E PROCESS

### 14.E.1 ÉTAPE 1 — OUVRIR LA BONNE DÉFINITION

Saisir `/nSE18`, choisir le mode correspondant à la BAdI classique ou à l’Enhancement Framework, puis entrer le nom technique. Ouvrir en affichage et vérifier le package, la documentation et le composant logiciel.

### 14.E.2 ÉTAPE 2 — ANALYSER LES ATTRIBUTS

Relever si l’usage est simple ou multiple, si la définition possède des filtres et si une instanciation dépend du contexte. Pour chaque filtre, noter le type et les valeurs réellement calculées au point d’appel.

### 14.E.3 ÉTAPE 3 — ANALYSER L’INTERFACE

Ouvrir l’interface et documenter chaque méthode : objectif, paramètres, mutabilité, exceptions et valeurs initiales. Identifier les paramètres permettant de limiter le périmètre métier et ceux dont la modification affecte la suite du standard.

### 14.E.4 ÉTAPE 4 — AFFICHER LES IMPLÉMENTATIONS

Lister les implémentations associées et relever leur statut, classe, filtre et package. Ouvrir leur code pour détecter les chevauchements ou dépendances. Ne pas créer une nouvelle implémentation avant d’avoir compris les actives.

### 14.E.5 ÉTAPE 5 — RETROUVER LE POINT D’APPEL

Utiliser la navigation vers les utilisations ou la recherche source afin d’ouvrir l’appel standard. Placer un breakpoint sur la méthode d’interface et reproduire le scénario. Relever la pile, les filtres et l’ordre des validations.

### 14.E.6 ÉTAPE 6 — PRODUIRE UNE FICHE DE DÉCISION

Conserver la définition, la méthode retenue, les données disponibles, les filtres, les implémentations existantes et la preuve runtime. Conclure explicitement si la BAdI couvre le besoin ou pourquoi elle doit être écartée.

## 14.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 14.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 14.H FICHE DE CONTRÔLE À COPIER

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

## 14.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 14.J RÉFÉRENCES OFFICIELLES SAP

- [Definition of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/7e873842134bad04e10000000a1550b0.html)
- [Classic BAdIs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/e6d54d3c596f0b26e10000000a11402f.html)
- [How to Use Filters — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/44f6cd83912541aae10000000a114a6b.html)

---

[Chapitre suivant — IMPLÉMENTER UNE BAdI AVEC `SE19`](<./15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>)
