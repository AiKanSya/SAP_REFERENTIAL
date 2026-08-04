# 1. OBTENIR LE PROCHAIN NUMÉRO

## 1.A RÉSULTAT ATTENDU

Obtenir un numéro unique depuis l’objet de plage `ZDEMO_NR`.

## 1.B PRÉREQUIS

- Objet et intervalle créés dans `SNRO`[^outil-snro].
- Intervalle `01` disponible pour l’exercice courant.

## 1.C PROCESS

### 1.C.1 ÉTAPE 1 — CONFIGURER L’OBJET DANS SNRO

Créer ou examiner l’objet `ZDEMO_NR` dans `SNRO`. Relever la longueur, le domaine de sous-objet éventuel, la gestion par exercice et le mode de buffering ; ces paramètres déterminent la signature utile et le format du numéro.

### 1.C.2 ÉTAPE 2 — MAINTENIR L’INTERVALLE

Créer l’intervalle `01` dans le mandant[^terme-mandant] approprié avec des bornes non chevauchantes. Si l’objet dépend d’un sous-objet ou d’un exercice, maintenir exactement la combinaison utilisée par le programme.

### 1.C.3 ÉTAPE 3 — TYPER LA VALEUR RETOURNÉE

Déclarer la variable avec une longueur compatible avec l’objet de plage. Ne pas convertir prématurément le numéro dans un type numérique si les zéros initiaux appartiennent à la clé métier.

### 1.C.4 ÉTAPE 4 — APPELER NUMBER_GET_NEXT

Appeler `NUMBER_GET_NEXT` au moment où le traitement est prêt à créer l’objet métier. Transmettre l’objet, l’intervalle et les paramètres conditionnels réellement configurés.

### 1.C.5 ÉTAPE 5 — TRAITER CHAQUE ÉCHEC

Tester immédiatement `SY-SUBRC`. Distinguer au minimum l’objet absent, l’intervalle absent et le dépassement d’intervalle dans le journal technique ; interrompre la création métier si aucun numéro n’est retourné.

### 1.C.6 ÉTAPE 6 — ENREGISTRER LE NUMÉRO AVEC L’OBJET MÉTIER

Utiliser la valeur retournée comme clé dans la même unité de travail que la création. Ne pas remettre manuellement un numéro consommé à disposition après un rollback.

### 1.C.7 ÉTAPE 7 — TESTER LA CONCURRENCE ET LES BORNES

Exécuter plusieurs appels parallèles en environnement[^terme-environnement] de test, contrôler l’unicité, puis tester une configuration proche de la borne supérieure. Vérifier aussi le comportement après rollback métier.

## 1.D CODE PRÊT À ADAPTER

```abap
DATA lv_number TYPE n LENGTH 10.

CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr = '01'
    object      = 'ZDEMO_NR'
  IMPORTING
    number      = lv_number
  EXCEPTIONS
    interval_not_found      = 1
    number_range_not_intern = 2
    object_not_found        = 3
    quantity_is_0           = 4
    quantity_is_not_1       = 5
    interval_overflow       = 6
    buffer_overflow         = 7
    OTHERS                  = 8.

IF sy-subrc <> 0.
  MESSAGE e001(zdemo) WITH sy-subrc.
ENDIF.
```

## 1.E CONTRÔLE

- Deux appels validés ne doivent pas attribuer le même numéro.
- Un numéro demandé peut être consommé même si la transaction métier est annulée ; ne pas exiger une numérotation sans trou sans règle métier[^terme-regle-metier] explicite.

[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-environnement]: **ENVIRONNEMENT.** Rôle fonctionnel attribué à un système dans le cycle de vie : développement, test, recette, préproduction ou production. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#environnement>).
[^terme-regle-metier]: **RÈGLE MÉTIER.** Condition ou calcul imposé par le processus fonctionnel. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#regle-metier>).

[^outil-snro]: **SNRO.** Transaction de maintenance des objets de plage de numéros. Voir [le chapitre associé](<01 ├── OBTENIR LE PROCHAIN NUMERO.md>).
