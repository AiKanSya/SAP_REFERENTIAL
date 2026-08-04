# 14. ANALYSER UNE DÉFINITION BAdI AVEC `SE18`

## 14.A RÉSULTAT ATTENDU

- Lire le contrat d’un BAdI[^terme-acro-badi] avant de l’implémenter
- Identifier son type, son interface et ses propriétés
- Vérifier le point d’appel réel

## 14.B INFORMATIONS À CONTRÔLER

Dans `SE18`[^outil-se18], relever :

- type classique ou Enhancement Framework ;
- documentation ;
- interface et méthodes ;
- paramètres de chaque méthode[^terme-methode] ;
- propriété single-use ou multiple-use ;
- filtres et types des filtres ;
- implémentation de repli éventuelle ;
- package[^terme-package] et composant logiciel ;
- implémentations actives existantes.

## 14.C ANALYSE DE L’INTERFACE

Pour chaque paramètre :

| Question                 | Vérification                                      |
| ------------------------ | ------------------------------------------------- |
| Entrée ou sortie ?       | `IMPORTING`, `EXPORTING`, `CHANGING`, `RETURNING` |
| Facultatif ?             | Propriété de l’interface                          |
| Modification persistée ? | Utilisation après l’appel                         |
| Volume ?                 | Structure unique ou table interne[^terme-table-interne]                 |
| Référence ?              | Objet potentiellement partagé                     |
| Exception[^terme-exception] ?              | Contrat de propagation                            |

## 14.D POINT D’APPEL

La documentation seule ne suffit pas. Rechercher l’utilisation du BAdI ou placer un breakpoint[^terme-breakpoint] dans une implémentation temporaire contrôlée. Vérifier le moment d’appel, la fréquence et le contexte transactionnel.

## 14.E PROCESS

### 14.E.1 ÉTAPE 1 — OUVRIR LA BONNE DÉFINITION

Saisir `/nSE18`, choisir le mode correspondant à la BAdI classique ou à l’Enhancement Framework, puis entrer le nom technique. Ouvrir en affichage et vérifier le package, la documentation et le composant logiciel.

### 14.E.2 ÉTAPE 2 — ANALYSER LES ATTRIBUTS

Relever si l’usage est simple ou multiple, si la définition possède des filtres et si une instanciation dépend du contexte. Pour chaque filtre, noter le type et les valeurs réellement calculées au point d’appel.

### 14.E.3 ÉTAPE 3 — ANALYSER L’INTERFACE

Ouvrir l’interface et documenter chaque méthode : objectif, paramètres, mutabilité, exceptions et valeurs initiales. Identifier les paramètres permettant de limiter le périmètre métier et ceux dont la modification affecte la suite du standard.

### 14.E.4 ÉTAPE 4 — AFFICHER LES IMPLÉMENTATIONS

Lister les implémentations associées et relever leur statut, classe[^terme-classe], filtre et package. Ouvrir leur code pour détecter les chevauchements ou dépendances. Ne pas créer une nouvelle implémentation avant d’avoir compris les actives.

### 14.E.5 ÉTAPE 5 — RETROUVER LE POINT D’APPEL

Utiliser la navigation vers les utilisations ou la recherche source afin d’ouvrir l’appel standard. Placer un breakpoint sur la méthode d’interface et reproduire le scénario. Relever la pile, les filtres et l’ordre des validations.

### 14.E.6 ÉTAPE 6 — PRODUIRE UNE FICHE DE DÉCISION

Conserver la définition, la méthode retenue, les données disponibles, les filtres, les implémentations existantes et la preuve runtime. Conclure explicitement si la BAdI couvre le besoin ou pourquoi elle doit être écartée.

## 14.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP[^terme-acro-sap] standard n’a été créée.

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

[Chapitre suivant — IMPLÉMENTER UNE BAdI AVEC `SE19`[^outil-se19]](<./15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>)

[^terme-acro-badi]: **BADI.** Business Add-In, mécanisme d’extension orienté objet du standard SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-table-interne]: **TABLE INTERNE.** Collection dynamique de lignes stockée en mémoire dans le programme ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).

[^outil-se18]: **SE18.** BAdI Builder utilisé pour rechercher et analyser les définitions de BAdI. Voir [le chapitre associé](<14 ├── ANALYSER UNE DEFINITION BADI AVEC SE18.md>).
[^outil-se19]: **SE19.** BAdI Builder utilisé pour créer et maintenir les implémentations de BAdI. Voir [le chapitre associé](<15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>).
