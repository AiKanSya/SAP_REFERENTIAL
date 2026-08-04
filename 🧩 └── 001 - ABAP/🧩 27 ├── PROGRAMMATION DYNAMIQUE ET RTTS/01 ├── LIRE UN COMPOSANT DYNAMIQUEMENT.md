# LIRE UN COMPOSANT DYNAMIQUEMENT

## RÉSULTAT ATTENDU

Lire un composant dont le nom est déterminé à l’exécution sans provoquer d’accès invalide.

## PROCESS

### ÉTAPE 1 — JUSTIFIER LE NOM DYNAMIQUE

Utiliser `ASSIGN COMPONENT` uniquement lorsque plusieurs composants connus doivent être traités par la même logique. Préférer un accès statique ou un `CASE` si le nombre de champs est faible et stable.

### ÉTAPE 2 — DÉFINIR LA LISTE DES COMPOSANTS AUTORISÉS

Énumérer les noms acceptés dans le code ou dans un paramétrage protégé. Si la valeur provient d’un écran, d’un fichier ou d’un appel distant, ne jamais accepter tout composant techniquement existant.

### ÉTAPE 3 — NORMALISER LE NOM

Convertir la valeur dans la casse et le type attendus, refuser une valeur initiale puis vérifier son appartenance exacte à la liste autorisée.

### ÉTAPE 4 — EXÉCUTER L’AFFECTATION

Appeler `ASSIGN COMPONENT ... OF STRUCTURE ...` vers un field-symbol. Le nom doit être validé avant l’instruction dynamique.

### ÉTAPE 5 — TESTER SY-SUBRC AVANT L’ACCÈS

Lire ou convertir le field-symbol uniquement lorsque `SY-SUBRC = 0` et que le field-symbol est affecté. Retourner un message contrôlé dans tous les autres cas.

### ÉTAPE 6 — TESTER LES CAS LIMITES

Vérifier un composant autorisé, un composant existant mais interdit, un nom inconnu, une valeur initiale et une casse différente. Exécuter les contrôles ATC ou SCI de sécurité disponibles sur le système.

## CODE PRÊT À ADAPTER

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

## CONTRÔLE

- Tester immédiatement `SY-SUBRC` avant d’accéder au field-symbol.
- Le nom dynamique doit provenir d’une liste blanche lorsque sa source est externe.
