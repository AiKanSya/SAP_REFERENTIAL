# 9. RÉFÉRENCES D’OBJET ET CYCLE DE VIE

## 9.A RÉSULTAT ATTENDU

- Déclarer et vérifier une référence d’objet.
- Comprendre `IS BOUND`, `NEW`, affectation et identité.
- Éviter les références non liées et les casts injustifiés.

## 9.B PRINCIPES

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
DATA lo_service TYPE REF TO zcl_dev_service.
lo_service = NEW zcl_dev_service( ).
```

La variable `LO_SERVICE` contient une référence. L’objet existe tant qu’il reste accessible par au moins une référence dans le contexte d’exécution. Deux références peuvent désigner le même objet.

## 9.C TESTER UNE RÉFÉRENCE

```abap
IF lo_service IS BOUND.
  lo_service->execute( ).
ENDIF.
```

`IS BOUND` est le contrôle approprié avant un appel lorsqu’une référence peut légitimement être absente.

## 9.D CAS D’USAGE

Une fabrique peut ne retourner aucun objet si une configuration facultative est absente. Le contrat doit définir clairement si elle retourne une référence initiale ou lève une exception. Le consommateur ne doit pas deviner.

## 9.E PROCESS

### 9.E.1 Étape 1 — Arrêter avant le déréférencement

Placer un breakpoint juste avant l’appel `->`. Relever le type statique de la variable et le chemin ayant dû fournir l’objet.

### 9.E.2 Étape 2 — Vérifier la liaison

Évaluer `IS BOUND`. Si le résultat est faux, ne modifier pas artificiellement la référence : remonter à la branche de création ou d’injection.

### 9.E.3 Étape 3 — Identifier le type dynamique

Ouvrir la référence dans le débogueur et relever la classe concrète. Comparer avec l’implémentation attendue par la factory ou la configuration.

### 9.E.4 Étape 4 — Retrouver le cycle de vie

Remonter jusqu’au constructeur, à `NEW`, à la factory ou à l’injection. Rechercher ensuite remplacement, `CLEAR` ou sortie de portée ayant supprimé le dernier propriétaire.

### 9.E.5 Étape 5 — Corréler un dump

Si un dump existe, ouvrir `ST22`, vérifier ligne et pile puis comparer avec le chemin observé. Le diagnostic est terminé lorsque création, type concret et instruction ayant perdu la référence sont identifiés.

## 9.F CODE D’AFFECTATION ET D’IDENTITÉ À ADAPTER

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA(lo_first)  = NEW zcl_dev_counter( ).
DATA(lo_second) = lo_first.

lo_first->increment( ).

ASSERT lo_second->get_value( ) = 1.
ASSERT lo_first = lo_second.
```

Les deux variables désignent ici la même instance.

## 9.G CONTRÔLE

- Différencier une référence initiale d’un objet existant avec état initial.
- Expliquer pourquoi l’affectation d’une référence ne copie pas l’objet.
- Identifier la classe statique de la référence et la classe dynamique de l’objet.

## 9.H ERREURS FRÉQUENTES

- Tester uniquement `IS INITIAL` sans comprendre le contrat de la méthode.
- Créer une nouvelle instance à chaque appel alors qu’un objet devait conserver un état.
- Conserver des références globales statiques sans raison et prolonger inutilement la durée de vie des objets.

## 9.I COMPATIBILITÉ S/4HANA

- Statut : compatible avec le développement ABAP classique sur SAP S/4HANA.
- Vérifier la syntaxe exacte avec l’aide `F1` du système cible lorsque plusieurs versions d’ABAP Platform sont prises en charge.
- Les objets globaux doivent être créés dans le package et l’ordre de transport du projet.

## 9.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP Objects — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_OBJECTS.html)
- [Object Oriented ABAP — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524907.html)

---

[Chapitre suivant — ENCAPSULATION, INVARIANTS ET API PUBLIQUE](<./10 ├── ENCAPSULATION INVARIANTS ET API PUBLIQUE.md>)
