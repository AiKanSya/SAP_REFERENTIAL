# 13. REDÉFINIR UNE MÉTHODE HÉRITÉE AVEC `SUPER`

## 13.A RÉSULTAT ATTENDU

- Créer une sous-classe globale.
- Redéfinir une méthode héritée.
- Appeler l’implémentation de la superclasse avec `SUPER`.
- Savoir quand préférer la composition.

## 13.B PRINCIPE

ABAP Objects utilise l’héritage simple : une classe ne possède qu’une superclasse directe. Une sous-classe hérite des composants visibles et peut redéfinir certaines méthodes d’instance.

## 13.C CAS D’USAGE

Une classe de base calcule un prix standard. Une sous-classe spécialisée ajoute un supplément réglementaire tout en réutilisant le calcul commun.

## 13.D PROCESS

### 13.D.1 Étape 1 — Valider la relation d’héritage

Confirmer que la sous-classe peut remplacer la superclasse sans violer son contrat. Si le besoin consiste seulement à réutiliser un service, préférer la composition.

### 13.D.2 Étape 2 — Créer et activer la superclasse

Définir ses méthodes publiques/protected, leurs signatures et les points redéfinissables. Activer avant de créer la classe fille.

### 13.D.3 Étape 3 — Créer la sous-classe

Dans `SE24`, renseigner la superclasse dans les propriétés. Examiner les composants hérités puis sélectionner la méthode et choisir **Redéfinir**.

### 13.D.4 Étape 4 — Implémenter avec ou sans SUPER

Conserver préconditions et résultats compatibles. Utiliser `super->methode( )` si le comportement parent doit rester exécuté, et vérifier l’ordre pour éviter un double effet.

### 13.D.5 Étape 5 — Tester la substitution

Affecter l’instance fille à une référence de superclasse et appeler la méthode. Le test est validé lorsque la redéfinition s’exécute sans connaissance de la sous-classe.

## 13.E CODE À ADAPTER

La superclasse doit déclarer cette méthode dans sa section publique ou protégée. La sous-classe la marque ensuite comme redéfinie dans `SE24`.

```abap
METHODS calculate_price
  IMPORTING is_item TYPE zdev_item
  RETURNING VALUE(rv_price) TYPE zdev_amount.
```

La sous-classe doit également déclarer `CALCULATE_REGULATORY_FEE` avec une entrée `ZDEV_ITEM` et un retour `ZDEV_AMOUNT`.

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
METHOD calculate_price.
  rv_price = super->calculate_price( is_item ).
  rv_price = rv_price + calculate_regulatory_fee( is_item ).
ENDMETHOD.
```

Utilisation polymorphe :

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA lo_pricer TYPE REF TO zcl_dev_base_pricer.
lo_pricer = NEW zcl_dev_regulated_pricer( ).
DATA(lv_price) = lo_pricer->calculate_price( ls_item ).
```

## 13.F CONDITIONS D’UTILISATION

L’héritage est adapté si la sous-classe est réellement substituable à la superclasse et partage son contrat. Si le besoin consiste seulement à réutiliser une fonction, préférer une dépendance ou une composition.

## 13.G CONTRÔLE

- Une référence de superclasse peut utiliser l’objet de sous-classe.
- La redéfinition conserve les préconditions du contrat.
- La méthode n’accède pas à des attributs privés de la superclasse.
- Le test couvre le comportement commun et le comportement spécialisé.

## 13.H ERREURS FRÉQUENTES

- Hériter uniquement pour réutiliser quelques lignes de code.
- Modifier le sens du contrat dans la sous-classe.
- Créer une hiérarchie profonde difficile à comprendre.

## 13.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Utiliser l’héritage uniquement pour une relation de substitution stable entre la sous-classe et la superclasse.
- Préférer une interface et la composition lorsque le besoin consiste à remplacer un comportement ou à réutiliser un service.

## 13.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/implementing-inheritance_bfdb59f7-0f99-48b9-b019-a7b766830ecc)
- [Using Inheritance — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-inheritance_e8db2ae2-5d5d-4848-8534-ea9fa00f4f3c)

---

[Chapitre suivant — CLASSES ABSTRAITES, MÉTHODES ABSTRAITES ET FINAL](<./14 ├── CLASSES ABSTRAITES METHODES ABSTRAITES ET FINAL.md>)
