# 🌸 BONNES PRATIQUES ET CHECKLIST

## 🌺 OBJECTIFS

- Concevoir un programme exécutable maintenable
- Sécuriser l’écran de sélection
- Préserver la compatibilité avec les variantes
- Préparer l’exécution en dialogue et en arrière-plan
- Vérifier le programme avant livraison

## 🌺 STRUCTURE RECOMMANDÉE

```abap
REPORT zdev_business_report.

SELECTION-SCREEN BEGIN OF BLOCK b_sel WITH FRAME TITLE text-t01.
  PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
  SELECT-OPTIONS s_date FOR sy-datum.
SELECTION-SCREEN END OF BLOCK b_sel.

INITIALIZATION.
  PERFORM initialize_selection.

AT SELECTION-SCREEN.
  PERFORM validate_selection.

START-OF-SELECTION.
  lcl_application=>run(
    iv_bukrs = p_bukrs
    ir_date  = s_date[]
  ).
```

Les événements orchestrent. La logique métier reste dans des unités réutilisables.

## 🌺 ÉCRAN DE SÉLECTION

- limiter le nombre de champs ;
- utiliser les types DDIC ;
- regrouper les critères par fonction ;
- définir des libellés métier ;
- fournir des valeurs par défaut prudentes ;
- éviter une sélection complète involontaire ;
- valider les relations entre champs ;
- conserver la compatibilité avec les variantes.

## 🌺 TRAITEMENT

- effectuer les contrôles d’autorisation ;
- séparer lecture, traitement et restitution ;
- ne pas modifier la base pendant `AT SELECTION-SCREEN` ;
- ne pas placer de `COMMIT WORK` sans frontière transactionnelle explicite ;
- éviter les appels dynamiques non contrôlés ;
- produire des messages exploitables ;
- prévoir un mode test pour les traitements de masse lorsque le besoin le justifie.

## 🌺 ARRIÈRE-PLAN

- ne pas utiliser de dialogue obligatoire ;
- éviter les dépendances au frontend SAP GUI ;
- rendre les entrées enregistrables dans une variante ;
- écrire une sortie spool ou un journal applicatif ;
- traiter les erreurs sans intervention immédiate ;
- vérifier `sy-batch` uniquement lorsqu’un comportement différent est réellement nécessaire.

## 🌺 PERFORMANCE

- limiter les critères trop ouverts ;
- appliquer les filtres dans ABAP SQL ;
- éviter les lectures massives déclenchées pendant la saisie ;
- afficher un avertissement avant un traitement particulièrement large ;
- mesurer les scénarios réels avec les outils adaptés.

## 🌺 CHECKLIST

- [ ] Le programme est-il de type exécutable et affecté au bon package ?
- [ ] Le point d’entrée `START-OF-SELECTION` est-il explicite ?
- [ ] Les paramètres utilisent-ils des types DDIC pertinents ?
- [ ] Les valeurs initiales respectent-elles les variantes ?
- [ ] Les contrôles de sélection sont-ils sans effet métier durable ?
- [ ] Les autorisations sont-elles vérifiées dans le code ?
- [ ] Une sélection vide peut-elle provoquer un volume excessif ?
- [ ] Le programme fonctionne-t-il sans interaction frontend si le background est prévu ?
- [ ] Les erreurs sont-elles compréhensibles et traçables ?
- [ ] Les appels `SUBMIT` utilisent-ils une interface stable et contrôlée ?
- [ ] La sortie est-elle adaptée au besoin réel ?
- [ ] La documentation décrit-elle les impacts productifs ?

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [REPORT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREPORT.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)
- [Event Control — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/0b32146b63054bb293de32877a6ebfe9.html)
- [Understanding the Concept of Background Processing — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-ii-of-sap-s-4hana-and-sap-business-suite/understanding-the-concept-of-background-processing-1)
- [Authorization Checks — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/9fdbaccb35c111d1829f0000e829fbfe.html)
