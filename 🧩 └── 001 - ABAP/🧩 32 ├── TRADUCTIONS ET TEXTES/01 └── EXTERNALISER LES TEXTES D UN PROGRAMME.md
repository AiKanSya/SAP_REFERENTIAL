# EXTERNALISER LES TEXTES D’UN PROGRAMME

## RÉSULTAT ATTENDU

Supprimer les libellés utilisateur codés en dur et permettre leur traduction.

## PROCESS

### ÉTAPE 1 — INVENTORIER LES TEXTES VISIBLES

Rechercher les libellés, titres, messages, textes de sélection et valeurs affichées construits en dur. Exclure les identifiants techniques qui ne sont jamais présentés à l’utilisateur.

### ÉTAPE 2 — DÉPLACER LES LIBELLÉS DANS LES ÉLÉMENTS DE TEXTE

Créer un symbole de texte pour chaque libellé du programme et remplacer la chaîne par `TEXT-...`. Donner au symbole un sens stable afin que le traducteur dispose du contexte nécessaire.

### ÉTAPE 3 — UTILISER UNE CLASSE DE MESSAGES

Créer ou compléter la classe dans `SE91` pour les erreurs, avertissements et confirmations. Passer les valeurs variables avec `WITH` au lieu de concaténer une phrase complète.

### ÉTAPE 4 — RÉUTILISER LES TEXTES DDIC ET GUI

Pour les champs, vérifier les libellés de l’élément de données et les textes de domaine. Traduire aussi les titres, statuts GUI, menus et textes de dynpro dans leurs objets respectifs.

### ÉTAPE 5 — EXÉCUTER LA TRADUCTION

Utiliser `SE63` ou le processus de traduction du projet pour chaque langue supportée. Transporter les textes selon les règles du système et contrôler les objets manquants dans la langue cible.

### ÉTAPE 6 — TESTER CHAQUE LANGUE

Se connecter dans chaque langue supportée, exécuter les écrans et messages, puis vérifier longueur, ordre des mots, variables et caractères spéciaux. Ne pas reconstruire une phrase traduite par concaténation de fragments.

## CODE PRÊT À ADAPTER

```abap
PARAMETERS p_bukrs TYPE bukrs.

START-OF-SELECTION.
  WRITE: / text-001, p_bukrs. " TEXT-001 est traduit avec les éléments de texte.
```

Pour les messages métier paramétrés :

```abap
MESSAGE e001(zdemo) WITH p_bukrs.
```

## CONTRÔLE

- Exécuter le programme dans chaque langue supportée.
- Vérifier les éléments de texte, la classe de messages, les textes DDIC et les titres GUI.
- Une traduction manquante ne doit pas être compensée par une concaténation dépendante de l’ordre des mots.
