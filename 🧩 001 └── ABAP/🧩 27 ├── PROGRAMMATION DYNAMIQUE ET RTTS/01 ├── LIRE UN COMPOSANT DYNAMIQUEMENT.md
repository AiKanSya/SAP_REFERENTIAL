# 1. LIRE UN COMPOSANT DYNAMIQUEMENT

## 1.A RÉSULTAT ATTENDU

Lire un composant dont le nom est déterminé à l’exécution sans provoquer d’accès invalide.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — JUSTIFIER LE NOM DYNAMIQUE

Utiliser `ASSIGN COMPONENT` uniquement lorsque plusieurs composants connus doivent être traités par la même logique. Préférer un accès statique ou un `CASE` si le nombre de champs est faible et stable.

### 1.B.2 ÉTAPE 2 — DÉFINIR LA LISTE DES COMPOSANTS AUTORISÉS

Énumérer les noms acceptés dans le code ou dans un paramétrage protégé. Si la valeur provient d’un écran, d’un fichier ou d’un appel distant, ne jamais accepter tout composant techniquement existant.

### 1.B.3 ÉTAPE 3 — NORMALISER LE NOM

Convertir la valeur dans la casse et le type attendus, refuser une valeur initiale puis vérifier son appartenance exacte à la liste autorisée.

### 1.B.4 ÉTAPE 4 — EXÉCUTER L’AFFECTATION

Appeler `ASSIGN COMPONENT ... OF STRUCTURE ...` vers un field-symbol[^terme-field-symbol]. Le nom doit être validé avant l’instruction dynamique.

### 1.B.5 ÉTAPE 5 — TESTER SY-SUBRC AVANT L’ACCÈS

Lire ou convertir le field-symbol uniquement lorsque `SY-SUBRC = 0` et que le field-symbol est affecté. Retourner un message contrôlé dans tous les autres cas.

### 1.B.6 ÉTAPE 6 — TESTER LES CAS LIMITES

Vérifier un composant autorisé, un composant existant mais interdit, un nom inconnu, une valeur initiale et une casse différente. Exécuter les contrôles ATC[^terme-acro-atc] ou SCI[^outil-sci] de sécurité disponibles sur le système.

## 1.C CODE PRÊT À ADAPTER

```abap
DATA ls_data TYPE zdemo_structure.
DATA(lv_component_name) = CONV string( 'BUKRS' ).

ASSIGN COMPONENT lv_component_name OF STRUCTURE ls_data TO FIELD-SYMBOL(<lv_value>).
IF sy-subrc = 0.
  DATA(lv_text) = |{ <lv_value> }|.
ELSE.
  MESSAGE e001(zdemo) WITH lv_component_name.
ENDIF.
```

## 1.D CONTRÔLE

- Tester immédiatement `SY-SUBRC` avant d’accéder au field-symbol.
- Le nom dynamique doit provenir d’une liste blanche lorsque sa source est externe.

[^terme-field-symbol]: **FIELD-SYMBOL.** Alias dynamique vers une zone de mémoire existante. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>).
[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).

[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/13 ├── CODE INSPECTOR AVEC SCI.md>).
