# 🌸 REDÉFINIR UNE MÉTHODE HÉRITÉE AVEC `SUPER`

## 🌺 RÉSULTAT ATTENDU

- Créer une sous-classe globale.
- Redéfinir une méthode héritée.
- Appeler l’implémentation de la superclasse avec `SUPER`.
- Savoir quand préférer la composition.

## 🌺 PRINCIPE

ABAP Objects utilise l’héritage simple : une classe ne possède qu’une superclasse directe. Une sous-classe hérite des composants visibles et peut redéfinir certaines méthodes d’instance.

## 🌺 CAS D’USAGE

Une classe de base calcule un prix standard. Une sous-classe spécialisée ajoute un supplément réglementaire tout en réutilisant le calcul commun.

## 🌺 PROCÉDURE DANS SE24

1. Créer la superclasse globale et l’activer.
2. Créer la sous-classe.
3. Renseigner la superclasse dans les propriétés d’héritage.
4. Sélectionner une méthode redéfinissable.
5. Choisir **Redéfinir**.
6. Implémenter la méthode dans la sous-classe.
7. Appeler `SUPER->méthode( )` si le comportement commun doit être conservé.
8. Tester via une référence de superclasse.

## 🌺 CODE À ADAPTER

```abap
METHOD calculate_price.
  rv_price = super->calculate_price( is_item ).
  rv_price = rv_price + calculate_regulatory_fee( is_item ).
ENDMETHOD.
```

Utilisation polymorphe :

```abap
DATA lo_pricer TYPE REF TO zcl_dev_base_pricer.
lo_pricer = NEW zcl_dev_regulated_pricer( ).
DATA(lv_price) = lo_pricer->calculate_price( ls_item ).
```

## 🌺 CONDITIONS D’UTILISATION

L’héritage est adapté si la sous-classe est réellement substituable à la superclasse et partage son contrat. Si le besoin consiste seulement à réutiliser une fonction, préférer une dépendance ou une composition.

## 🌺 CONTRÔLE

- Une référence de superclasse peut utiliser l’objet de sous-classe.
- La redéfinition conserve les préconditions du contrat.
- La méthode n’accède pas à des attributs privés de la superclasse.
- Le test couvre le comportement commun et le comportement spécialisé.

## 🌺 ERREURS FRÉQUENTES

- Hériter uniquement pour réutiliser quelques lignes de code.
- Modifier le sens du contrat dans la sous-classe.
- Créer une hiérarchie profonde difficile à comprendre.

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Utiliser l’héritage uniquement pour une relation de substitution stable entre la sous-classe et la superclasse.
- Préférer une interface et la composition lorsque le besoin consiste à remplacer un comportement ou à réutiliser un service.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Using Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-inheritance_e8db2ae2-5d5d-4848-8534-ea9fa00f4f3c)

---

➡️ [Chapitre suivant — CLASSES ABSTRAITES, MÉTHODES ABSTRAITES ET FINAL](<./14 - 🍧 CLASSES ABSTRAITES METHODES ABSTRAITES ET FINAL.md>)
