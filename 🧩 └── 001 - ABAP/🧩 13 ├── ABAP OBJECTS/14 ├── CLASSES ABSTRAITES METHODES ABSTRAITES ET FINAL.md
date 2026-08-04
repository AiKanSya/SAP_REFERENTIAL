# 14. CLASSES ABSTRAITES, MÉTHODES ABSTRAITES ET FINAL

## 14.A RÉSULTAT ATTENDU

- Empêcher l’instanciation d’une classe[^terme-classe] incomplète.
- Imposer une implémentation aux sous-classes.
- Bloquer une extension ou une redéfinition[^terme-redefinition] non prévue.

## 14.B CLASSE ABSTRAITE

Une classe abstraite[^terme-classe-abstraite] définit un socle commun mais ne peut pas être instanciée directement. Une méthode abstraite[^terme-methode-abstraite] déclare un contrat sans implémentation dans cette classe.

## 14.C CAS D’USAGE

Plusieurs traitements d’import suivent le même enchaînement : lire, valider, transformer et enregistrer. La classe abstraite définit le flux commun et délègue la lecture du format à chaque sous-classe.

## 14.D CODE À ADAPTER

```abap
CLASS zcl_dev_importer DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PROTECTED.

  PUBLIC SECTION.
    METHODS execute FINAL
      IMPORTING iv_filename TYPE string
      RAISING   zcx_dev_import.

  PROTECTED SECTION.
    METHODS read_data ABSTRACT
      IMPORTING iv_filename TYPE string
      RETURNING VALUE(rt_rows) TYPE string_table
      RAISING   zcx_dev_import.
ENDCLASS.

METHOD execute.
  DATA(lt_rows) = read_data( iv_filename ).
  " Validation et persistance communes.
ENDMETHOD.
```

## 14.E PROCESS

### 14.E.1 Étape 1 — Séparer commun et variable

Identifier le comportement implémentable dans la base et les opérations que chaque sous-classe doit fournir. Une base abstraite ne doit pas représenter une instance métier complète.

### 14.E.2 Étape 2 — Déclarer la base abstraite

Marquer la classe abstraite. Créer la méthode d’extension avec sa signature, la visibilité[^terme-visibilite] appropriée puis l’indicateur abstrait.

### 14.E.3 Étape 3 — Créer une sous-classe concrète

Renseigner la superclasse et implémenter toutes les méthodes abstraites. L’activation doit signaler tout contrat non réalisé.

### 14.E.4 Étape 4 — Utiliser FINAL avec justification

Marquer classe ou méthode finale uniquement lorsque toute extension violerait un invariant[^terme-invariant] ou un contrat stable.

### 14.E.5 Étape 5 — Tester

Vérifier que la base ne peut pas être instanciée, que la fille le peut et que l’appel via une référence de base exécute son implémentation.

## 14.F FINAL

- Une classe finale[^terme-classe-finale] ne peut pas être sous-classée.
- Une méthode finale ne peut pas être redéfinie.
- Une méthode publique stable peut être finale pour protéger un algorithme commun.

## 14.G CONTRÔLE

- La classe abstraite ne peut pas être créée avec `NEW`.
- La sous-classe reste inactive tant qu’une méthode abstraite n’est pas implémentée.
- Les éléments `FINAL` correspondent à une décision de conception documentée.

## 14.H ERREURS FRÉQUENTES

- Créer une classe abstraite sans comportement commun.
- Utiliser l’abstraction pour remplacer une interface alors qu’aucun état partagé n’est nécessaire.
- Déclarer `FINAL` partout sans besoin réel d’intégrité du contrat.

## 14.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP[^terme-abap] classique sur SAP[^terme-acro-sap] S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1`[^terme-aide-f1] du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package[^terme-package] et l’ordre de transport[^terme-ordre-transport] du projet.

## 14.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — EXCEPTIONS ORIENTÉES OBJET](<./15 ├── EXCEPTIONS ORIENTEES OBJET.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-redefinition]: **REDÉFINITION.** Nouvelle implémentation, dans une sous-classe, d’une méthode héritée déclarée redéfinissable. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#redefinition>).
[^terme-classe-abstraite]: **CLASSE ABSTRAITE.** Classe déclarée `ABSTRACT` qui ne peut pas être instanciée directement et qui sert de base à des sous-classes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe-abstraite>).
[^terme-methode-abstraite]: **MÉTHODE ABSTRAITE.** Méthode déclarée `ABSTRACT` sans implémentation dans la classe qui la déclare. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode-abstraite>).
[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-invariant]: **INVARIANT.** Condition qui doit rester vraie pendant toute la durée de vie valide d’un objet. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#invariant>).
[^terme-classe-finale]: **CLASSE FINALE.** Classe déclarée `FINAL` qui ne peut pas être utilisée comme super-classe. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe-finale>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-aide-f1]: **AIDE F1.** Aide contextuelle expliquant un champ, une fonction ou un mot-clé. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#aide-f1>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-ordre-transport]: **ORDRE DE TRANSPORT.** Conteneur qui regroupe des modifications à exporter puis importer dans d’autres systèmes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#ordre-transport>).
