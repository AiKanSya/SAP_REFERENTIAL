# 12. POLYMORPHISME PAR INTERFACE

## 12.A RÉSULTAT ATTENDU

- Utiliser une référence d’interface.
- Substituer plusieurs implémentations.
- Éliminer des branchements techniques répétés.

## 12.B PRINCIPE

Le polymorphisme permet d’appeler la même méthode sur des objets de classes différentes, tant qu’ils respectent le même contrat.

```mermaid
flowchart TD
    A["Programme consommateur"] --> I["ZIF_DEV_EXPORTER"]
    I --> C["ZCL_DEV_CSV_EXPORTER"]
    I --> J["ZCL_DEV_JSON_EXPORTER"]
```

## 12.C CAS D’USAGE

Une extraction doit produire du CSV ou du JSON selon une configuration. Au lieu de placer un `CASE` dans chaque appelant, deux classes implémentent `ZIF_DEV_EXPORTER`.

## 12.D CODE À ADAPTER

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA lo_exporter TYPE REF TO zif_dev_exporter.

CASE iv_format.
  WHEN 'CSV'.
    lo_exporter = NEW zcl_dev_csv_exporter( ).
  WHEN 'JSON'.
    lo_exporter = NEW zcl_dev_json_exporter( ).
  WHEN OTHERS.
    RAISE EXCEPTION TYPE zcx_dev_unsupported_format.
ENDCASE.

DATA(lv_payload) = lo_exporter->serialize( it_data ).
```

Le `CASE` reste ici au point de composition. Le traitement métier utilise ensuite uniquement l’interface.

## 12.E PROCESS

### 12.E.1 Étape 1 — Créer deux implémentations conformes

Implémenter la même interface dans deux classes avec des comportements distincts mais un résultat respectant le même contrat.

### 12.E.2 Étape 2 — Typer le consommateur sur l’interface

Déclarer sa dépendance `TYPE REF TO` l’interface. Supprimer tout `CASE` sur le nom de classe utilisé uniquement pour choisir l’appel.

### 12.E.3 Étape 3 — Injecter la première classe

Affecter au consommateur une référence vers la première implémentation, puis exécuter la méthode via le type interface. Conserver les entrées, le résultat et les effets observables comme cas de référence pour la substitution suivante.

### 12.E.4 Étape 4 — Substituer la seconde

Changer seulement l’objet injecté et relancer les mêmes entrées. L’appelant ne doit nécessiter aucune modification.

### 12.E.5 Étape 5 — Ajouter un double déterministe

Créer une classe locale de test implémentant l’interface et retournant une valeur contrôlée. Le polymorphisme est validé lorsque le consommateur est testable sans la dépendance réelle.

## 12.F CASTS

Un up-cast vers une interface est généralement implicite et sûr. Un down-cast vers une classe concrète avec `CAST` ou `?=` doit rester exceptionnel : il révèle souvent que le contrat de l’interface est insuffisant ou que l’appelant connaît trop l’implémentation.

## 12.G CONTRÔLE

Le code métier ne doit contenir aucun nom de classe d’implémentation après la phase de composition.

## 12.H ERREURS FRÉQUENTES

- Tester la classe dynamique avec `INSTANCE OF` pour choisir le comportement.
- Ajouter des méthodes spécifiques à l’interface uniquement pour satisfaire une classe.
- Répéter la création des implémentations partout au lieu de centraliser la composition.

## 12.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 12.J RÉFÉRENCES OFFICIELLES SAP

- [Using Interfaces — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/using-interfaces_e45af9bb-46e5-457b-88ef-d5ad6b0d38d7)
- [Inheritance and Interfaces — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENINHERITANCE_INTERFACES.html)

---

[Chapitre suivant — HÉRITAGE, REDÉFINITION ET SUPER](<./13 ├── HERITAGE REDEFINITION ET SUPER.md>)
