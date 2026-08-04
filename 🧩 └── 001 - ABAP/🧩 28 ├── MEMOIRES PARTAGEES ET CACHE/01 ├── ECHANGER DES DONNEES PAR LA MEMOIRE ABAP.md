# 1. ÉCHANGER DES DONNÉES PAR LA MÉMOIRE ABAP

## 1.A RÉSULTAT ATTENDU

Transmettre une valeur entre programmes d’une même session utilisateur avec un identifiant explicite.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — CONFIRMER LE PÉRIMÈTRE DE SESSION

Utiliser la mémoire ABAP uniquement lorsque le producteur et le consommateur s’exécutent dans la même session interne ou dans un enchaînement compatible. Ne pas l’utiliser pour un échange interutilisateur, intersystème ou durable.

### 1.B.2 ÉTAPE 2 — DÉFINIR LE CONTRAT MÉMOIRE

Choisir un identifiant client explicite et documenter les noms des composants exportés, leurs types, le producteur, le consommateur et le moment du nettoyage.

### 1.B.3 ÉTAPE 3 — EXPORTER UNE DONNÉE TYPIQUE

Préparer la valeur dans un type stable, puis exécuter `EXPORT ... TO MEMORY ID`. Ne pas stocker de secret ni un volume important dans ce canal implicite.

### 1.B.4 ÉTAPE 4 — IMPORTER ET TESTER LE RÉSULTAT

Déclarer côté consommateur une cible compatible, appeler `IMPORT ... FROM MEMORY ID` puis tester immédiatement `SY-SUBRC`. Ne pas utiliser la valeur cible lorsqu’aucune donnée n’a été importée.

### 1.B.5 ÉTAPE 5 — SUPPRIMER LA VALEUR CONSOMMÉE

Exécuter `FREE MEMORY ID` lorsque la donnée ne doit pas être relue. Le nettoyage empêche qu’un appel ultérieur de la même session récupère un état périmé.

### 1.B.6 ÉTAPE 6 — TESTER LE CYCLE DE VIE

Vérifier l’import réussi, l’identifiant absent, un second import après nettoyage et l’exécution dans une nouvelle session. Confirmer que le programme ne dépend pas silencieusement d’une valeur résiduelle.

## 1.C CODE PRÊT À ADAPTER

Programme producteur :

```abap
DATA(lv_document) = CONV char20( '4711' ).
EXPORT document = lv_document TO MEMORY ID 'ZDEMO_DOCUMENT'.
```

Programme consommateur :

```abap
DATA lv_document TYPE char20.

IMPORT document = lv_document FROM MEMORY ID 'ZDEMO_DOCUMENT'.
IF sy-subrc = 0.
  FREE MEMORY ID 'ZDEMO_DOCUMENT'. " Supprime la valeur devenue inutile.
ENDIF.
```

## 1.D LIMITES

- Ce mécanisme n’est ni une base de données ni un échange interutilisateur.
- Documenter le producteur, le consommateur, le nom des composants et le nettoyage.
