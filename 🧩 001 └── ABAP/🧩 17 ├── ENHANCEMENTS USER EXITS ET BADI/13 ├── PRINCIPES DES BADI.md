# 13. PRINCIPES DES BAdI

## 13.A RÉSULTAT ATTENDU

- Comprendre le contrat orienté objet d’un BAdI[^terme-acro-badi]
- Distinguer définition et implémentation
- Identifier single-use, multiple-use et filtres

## 13.B ARCHITECTURE

```mermaid
flowchart LR
    A["Application appelante"] --> B["Définition BAdI"]
    B --> C["Interface BAdI"]
    C --> D["Implémentation client active"]
    D --> E["Classe d implémentation"]
```

La définition appartient au fournisseur de l’application. Elle expose une interface et des propriétés d’appel. Le client crée une implémentation qui référence une classe[^terme-classe] exécutant les méthodes.

## 13.C PROPRIÉTÉS

| Propriété        | Effet                                                                |
| ---------------- | -------------------------------------------------------------------- |
| Single-use       | Une implémentation active attendue pour le contexte                  |
| Multiple-use     | Plusieurs implémentations peuvent être appelées                      |
| Filter-dependent | Sélection des implémentations selon une valeur de filtre             |
| Fallback         | Implémentation utilisée lorsqu’aucune autre ne correspond, si prévue |

## 13.D CLASSIQUE OU ENHANCEMENT FRAMEWORK

Les BAdI classiques sont antérieurs à AS ABAP[^terme-abap] 7.0. Les nouvelles définitions sont intégrées au Enhancement Framework et utilisent les éléments de langage `GET BADI` et `CALL BADI` côté fournisseur.

Pour le consultant qui implémente un BAdI standard, le point essentiel est d’identifier son type dans `SE18`[^outil-se18] et d’utiliser le mode d’implémentation correspondant dans `SE19`[^outil-se19].

## 13.E PROCESS

### 13.E.1 ÉTAPE 1 — IDENTIFIER LA DÉFINITION

À partir du processus et du code appelant, relever le nom exact de la BAdI et, pour l’Enhancement Framework, son enhancement spot. Confirmer que la définition appartient au composant et à la version réellement exécutés.

### 13.E.2 ÉTAPE 2 — LIRE LE CONTRAT DANS `SE18`

Afficher la documentation, l’interface et chaque méthode[^terme-methode]. Relever les paramètres importés, exportés, changing et returning, ainsi que les exceptions. Identifier les filtres, l’usage multiple et le caractère dépendant du contexte.

### 13.E.3 ÉTAPE 3 — ANALYSER L’APPEL STANDARD

Retrouver l’instanciation ou l’appel de la BAdI dans le code standard. Examiner les valeurs de filtre calculées, l’ordre relatif aux validations et la manière dont les résultats sont consommés. Confirmer avec un breakpoint[^terme-breakpoint] si nécessaire.

### 13.E.4 ÉTAPE 4 — INVENTORIER LES IMPLÉMENTATIONS

Afficher toutes les implémentations actives et inactives. Relever leurs classes, filtres, packages et périmètres. Pour une BAdI à usage multiple, ne pas supposer un ordre d’exécution si le contrat ne le garantit pas.

### 13.E.5 ÉTAPE 5 — CONCEVOIR UNE IMPLÉMENTATION ISOLÉE

Définir des filtres non chevauchants et des conditions métier précises. Garder la méthode BAdI légère et déléguer à une classe Z testable. Ne pas modifier des données que l’interface ne déclare pas modifiables.

### 13.E.6 ÉTAPE 6 — PROUVER SÉLECTION ET NON-RÉGRESSION

Tester une valeur de filtre qui sélectionne l’implémentation, une valeur qui l’exclut et les interactions avec les implémentations existantes. Vérifier le résultat standard après le retour et la présence de tous les objets dans le transport.

## 13.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP[^terme-acro-sap] standard n’a été créée.

## 13.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 13.H FICHE DE CONTRÔLE À COPIER

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

## 13.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 13.J RÉFÉRENCES OFFICIELLES SAP

- [Business Add-Ins — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/46a2cfc13d25463b8b9a3d2a3c3ba0d9/8ff2e540f8648431e10000000a1550b0.html)
- [Classic BAdIs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/e6d54d3c596f0b26e10000000a11402f.html)
- [Definition of BAdIs in the Enhancement Builder — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/12a713d06c531014903e876ccc9a0b0d27/7e873842134bad04e10000000a1550b0.html)

---

[Chapitre suivant — ANALYSER UNE DÉFINITION BAdI AVEC `SE18`](<./14 ├── ANALYSER UNE DEFINITION BADI AVEC SE18.md>)

[^terme-acro-badi]: **BADI.** Business Add-In, mécanisme d’extension orienté objet du standard SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).

[^outil-se18]: **SE18.** BAdI Builder utilisé pour rechercher et analyser les définitions de BAdI. Voir [le chapitre associé](<14 ├── ANALYSER UNE DEFINITION BADI AVEC SE18.md>).
[^outil-se19]: **SE19.** BAdI Builder utilisé pour créer et maintenir les implémentations de BAdI. Voir [le chapitre associé](<15 ├── IMPLEMENTER UNE BADI AVEC SE19.md>).
