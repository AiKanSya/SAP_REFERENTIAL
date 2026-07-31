# 🌸 CLASSES ABSTRAITES, MÉTHODES ABSTRAITES ET FINAL

## 🌺 OBJECTIFS

- Empêcher l’instanciation d’une classe incomplète.
- Imposer une implémentation aux sous-classes.
- Bloquer une extension ou une redéfinition non prévue.

## 🌺 CLASSE ABSTRAITE

Une classe abstraite définit un socle commun mais ne peut pas être instanciée directement. Une méthode abstraite déclare un contrat sans implémentation dans cette classe.

## 🌺 CAS D’USAGE

Plusieurs traitements d’import suivent le même enchaînement : lire, valider, transformer et enregistrer. La classe abstraite définit le flux commun et délègue la lecture du format à chaque sous-classe.

## 🌺 SNIPPET À ADAPTER

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

## 🌺 PROCÉDURE DANS SE24

1. Marquer la classe de base comme abstraite.
2. Déclarer la méthode d’extension en visibilité protégée.
3. Marquer cette méthode comme abstraite.
4. Créer une sous-classe.
5. Redéfinir toutes les méthodes abstraites.
6. Activer la sous-classe.
7. Tester l’instanciation de la sous-classe ; l’instanciation de la base doit être interdite.

## 🌺 FINAL

- Une classe finale ne peut pas être sous-classée.
- Une méthode finale ne peut pas être redéfinie.
- Une méthode publique stable peut être finale pour protéger un algorithme commun.

## 🌺 VÉRIFICATION

- La classe abstraite ne peut pas être créée avec `NEW`.
- La sous-classe reste inactive tant qu’une méthode abstraite n’est pas implémentée.
- Les éléments `FINAL` correspondent à une décision de conception documentée.

## 🌺 ERREURS FRÉQUENTES

- Créer une classe abstraite sans comportement commun.
- Utiliser l’abstraction pour remplacer une interface alors qu’aucun état partagé n’est nécessaire.
- Déclarer `FINAL` partout sans besoin réel d’intégrité du contrat.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)

---

➡️ [Chapitre suivant — EXCEPTIONS ORIENTÉES OBJET](<./15 - 🍧 EXCEPTIONS ORIENTEES OBJET.md>)
