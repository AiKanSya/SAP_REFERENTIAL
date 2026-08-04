# 24. PACKAGES, TRANSPORTS, VERSIONING ET BONNES PRATIQUES

## 24.A RÉSULTAT ATTENDU

- Intégrer les classes globales dans un package[^terme-package] cohérent.
- Transporter toutes les dépendances nécessaires.
- Comparer les versions et limiter les ruptures d’API[^terme-api].
- Appliquer une checklist avant livraison.

## 24.B PACKAGE

Une classe globale[^terme-classe-globale] doit appartenir au package du domaine qu’elle sert. Les interfaces, exceptions et classes concrètes associées doivent suivre une organisation cohérente. Les dépendances entre packages doivent être intentionnelles.

## 24.C TRANSPORT

Lors d’une modification :

1. vérifier le package de la classe ;
2. affecter la modification à l’ordre de transport[^terme-ordre-transport] correct ;
3. inclure les interfaces, exceptions et objets DDIC[^terme-acro-ddic] créés ;
4. contrôler la liste d’objets de l’ordre ;
5. activer tous les objets dépendants ;
6. exécuter les tests avant libération ;
7. vérifier l’import sur le système cible.

## 24.D COMPATIBILITÉ DE L’API

Modifications à risque :

- suppression ou renommage d’une méthode[^terme-methode] publique ;
- ajout d’un paramètre obligatoire ;
- modification incompatible d’un type public ;
- nouvelle exception[^terme-exception] déclarée imposant une gestion aux appelants ;
- changement d’instanciation publique vers privée ;
- passage d’une classe extensible à `FINAL`.

Préférer une évolution compatible lorsque cela est possible : nouveau paramètre optionnel, nouvelle méthode, nouvelle interface versionnée ou adaptateur.

## 24.E PROCESS

### 24.E.1 Étape 1 — Stabiliser la version active

Contrôler la syntaxe, activer la classe complète et vérifier qu’aucun composant local ou interface ne reste inactif.

### 24.E.2 Étape 2 — Exécuter les tests

Lancer ABAP[^terme-abap] Unit, puis cas manuels nécessaires. Toute erreur doit être corrigée ou explicitement hors périmètre avant de poursuivre.

### 24.E.3 Étape 3 — Exécuter les contrôles statiques

Lancer ATC[^terme-acro-atc] ou SCI[^outil-sci] avec la variante projet. Traiter les findings bloquants et documenter toute exemption avec responsable et échéance.

### 24.E.4 Étape 4 — Analyser l’impact

Consulter les utilisations des méthodes, types et attributs modifiés. Vérifier compatibilité des signatures, autorisations et données sensibles.

### 24.E.5 Étape 5 — Contrôler le transport

Dans `SE10`[^outil-se10], vérifier classe, interfaces, exceptions, messages et types DDIC. Confirmer l’ordre d’import des dépendances.

### 24.E.6 Étape 6 — Documenter et rejouer

Décrire changement, preuve et scénario de non-régression. La livraison est prête lorsque la version transportée correspond exactement à la version testée.

## 24.F CHECKLIST À COPIER

```text
Classe / interface        :
Package                    :
Ordre de transport        :
API publique modifiée     : Oui / Non
Liste des utilisations    : Contrôlée / Non contrôlée
ABAP Unit                 : OK / KO / Non applicable
ATC ou SCI                : OK / KO
Test nominal              : OK / KO
Tests d'erreur            : OK / KO
Dépendances transportées  : Oui / Non
Documentation mise à jour : Oui / Non
```

## 24.G BONNES PRATIQUES SYNTHÉTIQUES

- Concevoir d’abord le contrat, puis l’implémentation.
- Préférer les classes globales pour les services réutilisables.
- Dépendre d’interfaces lorsque plusieurs implémentations ou tests sont attendus.
- Garder les attributs privés.
- Utiliser l’héritage[^terme-heritage] seulement pour une vraie relation de spécialisation.
- Préférer la composition[^terme-composition] et l’injection de dépendances[^terme-injection-dependances].
- Utiliser Factory ou Singleton[^terme-singleton] uniquement pour un problème réel de création ou d’unicité.
- Ne jamais masquer un `COMMIT WORK`[^terme-commit-work] dans une méthode métier sans contrat explicite.
- Documenter les effets, exceptions et contraintes de version.

## 24.H CRITÈRE DE FIN DE DOSSIER

Le lecteur doit être capable de créer dans `SE24`[^terme-class-builder-se24] une classe globale transportable, définir son API, injecter ses dépendances, implémenter une interface, gérer ses exceptions, choisir un pattern adapté et fournir un test reproductible.

## 24.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 24.J RÉFÉRENCES OFFICIELLES SAP

- [Class Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_BW4HANA/a602ff71a47c441bb3000504ec938fea/cac035baa6c611d1b4790000e8a52bed.html)
- [ABAP Code Documentation — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/documenting-abap-code_ad565c7e-6ac5-4a49-95e2-e4c33268dac6)
- [Improving Code Quality using ABAP Test Cockpit — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/improving-code-quality-using-abap-test-cockpit_dd1d868f-a539-49ee-8e49-e57563131058)

[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).
[^terme-heritage]: **HÉRITAGE.** Relation permettant à une sous-classe de reprendre les composants accessibles d’une super-classe et de spécialiser son comportement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#heritage>).
[^terme-composition]: **COMPOSITION.** Relation dans laquelle une classe réalise son comportement en contenant ou en utilisant d’autres objets spécialisés. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#composition>).
[^terme-injection-dependances]: **INJECTION DE DÉPENDANCES.** Fourniture des collaborateurs d’un objet depuis l’extérieur au lieu de les créer directement dans son implémentation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#injection-dependances>).
[^terme-singleton]: **SINGLETON.** Pattern limitant la création à une seule instance accessible dans une session interne ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#singleton>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).

[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/13 ├── CODE INSPECTOR AVEC SCI.md>).
[^outil-se10]: **SE10.** Transaction de l’Organisateur de transports utilisée pour consulter et gérer les ordres et tâches de transport. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/03 ├── PACKAGES ET ORDRES DE TRANSPORT.md>).
