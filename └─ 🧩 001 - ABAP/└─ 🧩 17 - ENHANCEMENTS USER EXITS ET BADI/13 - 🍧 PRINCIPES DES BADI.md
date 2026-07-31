# 🌸 PRINCIPES DES BAdI

## 🌺 OBJECTIFS

- Comprendre le contrat orienté objet d’un BAdI
- Distinguer définition et implémentation
- Identifier single-use, multiple-use et filtres

## 🌺 ARCHITECTURE

```mermaid
flowchart LR
    A["Application appelante"] --> B["Définition BAdI"]
    B --> C["Interface BAdI"]
    C --> D["Implémentation client active"]
    D --> E["Classe d implémentation"]
```

La définition appartient au fournisseur de l’application. Elle expose une interface et des propriétés d’appel. Le client crée une implémentation qui référence une classe exécutant les méthodes.

## 🌺 PROPRIÉTÉS

| Propriété        | Effet                                                                |
| ---------------- | -------------------------------------------------------------------- |
| Single-use       | Une implémentation active attendue pour le contexte                  |
| Multiple-use     | Plusieurs implémentations peuvent être appelées                      |
| Filter-dependent | Sélection des implémentations selon une valeur de filtre             |
| Fallback         | Implémentation utilisée lorsqu’aucune autre ne correspond, si prévue |

## 🌺 CLASSIQUE OU ENHANCEMENT FRAMEWORK

Les BAdI classiques sont antérieurs à AS ABAP 7.0. Les nouvelles définitions sont intégrées au Enhancement Framework et utilisent les éléments de langage `GET BADI` et `CALL BADI` côté fournisseur.

Pour le consultant qui implémente un BAdI standard, le point essentiel est d’identifier son type dans `SE18` et d’utiliser le mode d’implémentation correspondant dans `SE19`.

## 🌺 CAS D’USAGE

Dans un contexte où un besoin client doit compléter le comportement standard SAP sans modifier directement le code livré par SAP, le besoin consiste à **utiliser principes des badi pour étendre le standard sans créer de modification directe ni d’effet de bord hors périmètre**. Cette notion est pertinente lorsque le choix technique doit être compris avant d’appliquer une procédure.

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

- À l’issue du chapitre, le lecteur sait **utiliser principes des badi pour étendre le standard sans créer de modification directe ni d’effet de bord hors périmètre**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Business Add-Ins — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/46a2cfc13d25463b8b9a3d2a3c3ba0d9/8ff2e540f8648431e10000000a1550b0.html)
- [Classic BAdIs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/e6d54d3c596f0b26e10000000a11402f.html)
- [Definition of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/7e873842134bad04e10000000a1550b0.html)


---

➡️ [Chapitre suivant — ANALYSER UNE DÉFINITION BAdI AVEC `SE18`](<./14 - 🍧 ANALYSER UNE DEFINITION BADI AVEC SE18.md>)
