# CLASSES ABSTRAITES, MÉTHODES ABSTRAITES ET FINAL

## RÉSULTAT ATTENDU

- Empêcher l’instanciation d’une classe incomplète.
- Imposer une implémentation aux sous-classes.
- Bloquer une extension ou une redéfinition non prévue.

## CLASSE ABSTRAITE

Une classe abstraite définit un socle commun mais ne peut pas être instanciée directement. Une méthode abstraite déclare un contrat sans implémentation dans cette classe.

## CAS D’USAGE

Plusieurs traitements d’import suivent le même enchaînement : lire, valider, transformer et enregistrer. La classe abstraite définit le flux commun et délègue la lecture du format à chaque sous-classe.

## CODE À ADAPTER

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

## PROCESS

### Étape 1 — Séparer commun et variable

Identifier le comportement implémentable dans la base et les opérations que chaque sous-classe doit fournir. Une base abstraite ne doit pas représenter une instance métier complète.

### Étape 2 — Déclarer la base abstraite

Marquer la classe abstraite. Créer la méthode d’extension avec sa signature, la visibilité appropriée puis l’indicateur abstrait.

### Étape 3 — Créer une sous-classe concrète

Renseigner la superclasse et implémenter toutes les méthodes abstraites. L’activation doit signaler tout contrat non réalisé.

### Étape 4 — Utiliser FINAL avec justification

Marquer classe ou méthode finale uniquement lorsque toute extension violerait un invariant ou un contrat stable.

### Étape 5 — Tester

Vérifier que la base ne peut pas être instanciée, que la fille le peut et que l’appel via une référence de base exécute son implémentation.

## FINAL

- Une classe finale ne peut pas être sous-classée.
- Une méthode finale ne peut pas être redéfinie.
- Une méthode publique stable peut être finale pour protéger un algorithme commun.

## CONTRÔLE

- La classe abstraite ne peut pas être créée avec `NEW`.
- La sous-classe reste inactive tant qu’une méthode abstraite n’est pas implémentée.
- Les éléments `FINAL` correspondent à une décision de conception documentée.

## ERREURS FRÉQUENTES

- Créer une classe abstraite sans comportement commun.
- Utiliser l’abstraction pour remplacer une interface alors qu’aucun état partagé n’est nécessaire.
- Déclarer `FINAL` partout sans besoin réel d’intégrité du contrat.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

[Chapitre suivant — EXCEPTIONS ORIENTÉES OBJET](<./15 ├── EXCEPTIONS ORIENTEES OBJET.md>)
