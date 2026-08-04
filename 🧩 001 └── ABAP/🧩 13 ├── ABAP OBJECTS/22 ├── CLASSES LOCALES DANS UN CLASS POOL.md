# 22. CLASSES LOCALES DANS UN CLASS POOL

## 22.A RÉSULTAT ATTENDU

- Positionner correctement les classes locales dans un développement centré sur `SE24`[^terme-class-builder-se24].
- Créer un helper privé ou une classe de test[^terme-classe-test] locale.
- Éviter de rendre locale une classe destinée à être réutilisée.

## 22.B POSITIONNEMENT

Les classes globales sont le choix principal pour les services réutilisables. Les classes locales restent pertinentes pour :

- un helper strictement interne au Class Pool[^terme-class-pool] ;
- une implémentation éphémère non exposée ;
- une classe de test ABAP[^terme-abap] Unit ;
- un double de test local.

## 22.C CAS D’USAGE

La classe globale[^terme-classe-globale] `ZCL_DEV_CSV_IMPORTER` a besoin d’un parseur privé spécifique à son implémentation. Aucun autre objet ne doit l’utiliser. `LCL_CSV_PARSER` reste local au Class Pool.

## 22.D PROCESS

### 22.D.1 Étape 1 — Vérifier la portée locale

Confirmer que la classe sert uniquement au class pool et ne doit pas être appelée par un autre objet Repository[^terme-objet-repository]. Sinon créer une classe globale.

### 22.D.2 Étape 2 — Ouvrir les sections locales

Depuis `SE24` ou `SE80`[^outil-se80], accéder aux définitions et implémentations locales prévues. Ne placer pas le code dans une zone générée du Class Builder.

### 22.D.3 Étape 3 — Déclarer avant utilisation

Créer la définition locale avec visibilité[^terme-visibilite] minimale et signature complète. Si la classe globale référence le type avant sa définition complète, ajouter la déclaration différée appropriée.

### 22.D.4 Étape 4 — Implémenter dans la zone correspondante

Ajouter les méthodes dans l’implémentation locale. Contrôler que les dépendances au global class pool sont intentionnelles.

### 22.D.5 Étape 5 — Activer et tester

Activer la classe globale complète puis exécuter le test consommateur. La classe locale[^terme-classe-locale] est validée lorsqu’aucun objet externe ne dépend de son nom.

## 22.E CODE À ADAPTER

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS lcl_csv_parser DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS parse_line
      IMPORTING iv_line TYPE string
      RETURNING VALUE(rt_columns) TYPE string_table.
ENDCLASS.

CLASS lcl_csv_parser IMPLEMENTATION.
  METHOD parse_line.
    SPLIT iv_line AT ';' INTO TABLE rt_columns.
  ENDMETHOD.
ENDCLASS.
```

## 22.F QUAND PROMOUVOIR LA CLASSE EN GLOBAL

Promouvoir la classe si :

- un deuxième objet Repository doit l’utiliser ;
- elle représente un concept métier stable ;
- son interface doit être documentée et transportée indépendamment ;
- elle doit être injectée depuis l’extérieur.

## 22.G CONTRÔLE

La liste des utilisations reste limitée au Class Pool. Aucun consommateur externe ne dépend d’un détail local.

## 22.H ERREURS FRÉQUENTES

- Définir localement toute l’architecture d’un report et empêcher la réutilisation.
- Utiliser une classe locale pour contourner les règles de package[^terme-package].
- Placer une responsabilité métier importante dans un helper invisible et non documenté.

## 22.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport[^terme-ordre-transport] du projet.

## 22.J RÉFÉRENCES OFFICIELLES SAP

- [Creating Local Definitions and Implementations — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/b5693ecb185011d5969b00a0c94260a5.html)
- [Classes — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/10a002cd6c531014b5e1cb16d2455072/c3225b5c54f411d194a60000e8353423.html)

---

[Chapitre suivant — DOCUMENTATION, TEST ET DEBUG AVEC SE24](<./23 ├── DOCUMENTATION TEST ET DEBUG AVEC SE24.md>)

[^terme-class-builder-se24]: **CLASS BUILDER (SE24).** Outil SAP GUI utilisé pour créer, afficher, modifier, tester et documenter les classes et interfaces globales ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-builder-se24>).
[^terme-classe-test]: **CLASSE DE TEST.** Classe locale déclarée `FOR TESTING` contenant des méthodes exécutées par ABAP Unit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-test>).
[^terme-class-pool]: **CLASS POOL.** Programme technique généré qui contient la définition et l’implémentation d’une classe globale ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#class-pool>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-classe-globale]: **CLASSE GLOBALE.** Classe Repository réutilisable dans le système ABAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-globale>).
[^terme-objet-repository]: **OBJET REPOSITORY.** Unité de développement gérée par le Repository et le système de transport. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-classe-locale]: **CLASSE LOCALE.** Classe définie dans le code source d’un programme, d’un include ou d’un Class Pool et visible uniquement dans ce contexte de compilation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#classe-locale>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).

[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
