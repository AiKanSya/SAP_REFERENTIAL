# RÉFÉRE" Construire les dépendances avant d’exécuter le traitement.
" Construire les dépendances avant d’exécuter le traitement.
NCES D’OBJET ET CYCLE DE VIE

## RÉSULTAT ATTENDU

- Déclarer et vérifier une référence d’objet.
- Comprendre `IS BOUND`, `NEW`, affectation et identité.
- Éviter les références non liées et les casts injustifiés.

## PRINCIPES

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
DATA lo_service TYPE REF TO zcl_dev_service.
lo_service = NEW zcl_dev_service( ).
```

La variable `LO_SERVICE` contient une référence. L’objet existe tant qu’il reste accessible par au moins une référence dans le contexte d’exécution. Deux références peuvent désigner le même objet.

## TESTER UNE RÉFÉRENCE

```abap
IF lo_service IS BOUND.
  lo_service->execute( ).
ENDIF.
```

`IS BOUND` est le contrôle approprié avant un appel lorsqu’une référence peut légitimement être absente.

## CAS D’USAGE

Une fabrique peut ne retourner aucun objet si une configuration facultative est absente. Le contrat doit définir clairement si elle retourne une référence initiale ou lève une exception. Le consommateur ne doit pas deviner.

## PROCÉDURE DE DIAGNOSTIC

1. Placer un breakpoint avant l’appel `->`.
2. Vérifier si la référence est liée.
3. Afficher la classe dynamique de l’objet dans le debugger.
4. Vérifier si la référence a été écrasée ou vidée.
5. Contrôler le chemin de création : constructeur, factory ou injection.
6. Rechercher les exceptions de type référence initiale dans `ST22` si un dump s’est produit.

## CODE D’AFFECTATION ET D’IDENTITÉ À ADAPTER

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA(lo_first)  = NEW zcl_dev_counter( ).
DATA(lo_second) = lo_first.

lo_first->increment( ).

ASSERT lo_second->get_value( ) = 1.
ASSERT lo_first = lo_second.
```

Les deux variables désignent ici la même instance.

## CONTRÔLE

- Différencier une référence initiale d’un objet existant avec état initial.
- Expliquer pourquoi l’affectation d’une référence ne copie pas l’objet.
- Identifier la classe statique de la référence et la classe dynamique de l’objet.

## ERREURS FRÉQUENTES

- Tester uniquement `IS INITIAL` sans comprendre le contrat de la méthode.
- Créer une nouvelle instance à chaque appel alors qu’un objet devait conserver un état.
- Conserver des références globales statiques sans raison et prolonger inutilement la durée de vie des objets.

## COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
- [Object Oriented ABAP — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524907.html)

---

[Chapitre suivant — ENCAPSULATION, INVARIANTS ET API PUBLIQUE](<./10 ├── ENCAPSULATION INVARIANTS ET API PUBLIQUE.md>)
