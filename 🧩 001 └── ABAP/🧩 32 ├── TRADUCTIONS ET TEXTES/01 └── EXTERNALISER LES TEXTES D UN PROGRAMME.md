# 1. EXTERNALISER LES TEXTES D’UN PROGRAMME

## 1.A RÉSULTAT ATTENDU

Supprimer les libellés utilisateur codés en dur et permettre leur traduction.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — INVENTORIER LES TEXTES VISIBLES

Rechercher les libellés, titres, messages, textes de sélection et valeurs affichées construits en dur. Exclure les identifiants techniques qui ne sont jamais présentés à l’utilisateur.

### 1.B.2 ÉTAPE 2 — DÉPLACER LES LIBELLÉS DANS LES ÉLÉMENTS DE TEXTE

Créer un symbole de texte pour chaque libellé du programme et remplacer la chaîne par `TEXT-...`. Donner au symbole un sens stable afin que le traducteur dispose du contexte nécessaire.

### 1.B.3 ÉTAPE 3 — UTILISER UNE CLASSE DE MESSAGES

Créer ou compléter la classe[^terme-classe] dans `SE91`[^outil-se91] pour les erreurs, avertissements et confirmations. Passer les valeurs variables avec `WITH` au lieu de concaténer une phrase complète.

### 1.B.4 ÉTAPE 4 — RÉUTILISER LES TEXTES DDIC ET GUI

Pour les champs, vérifier les libellés de l’élément de données[^terme-element-donnees] et les textes de domaine. Traduire aussi les titres, statuts GUI[^terme-acro-gui], menus et textes de dynpro[^terme-dynpro] dans leurs objets respectifs.

### 1.B.5 ÉTAPE 5 — EXÉCUTER LA TRADUCTION

Utiliser `SE63`[^outil-se63] ou le processus de traduction du projet pour chaque langue supportée. Transporter les textes selon les règles du système et contrôler les objets manquants dans la langue cible.

### 1.B.6 ÉTAPE 6 — TESTER CHAQUE LANGUE

Se connecter dans chaque langue supportée, exécuter les écrans et messages, puis vérifier longueur, ordre des mots, variables et caractères spéciaux. Ne pas reconstruire une phrase traduite par concaténation de fragments.

## 1.C CODE PRÊT À ADAPTER

```abap
PARAMETERS p_bukrs TYPE bukrs.

START-OF-SELECTION.
  WRITE: / text-001, p_bukrs. " TEXT-001 est traduit avec les éléments de texte.
```

Pour les messages métier paramétrés :

```abap
MESSAGE e001(zdemo) WITH p_bukrs.
```

## 1.D CONTRÔLE

- Exécuter le programme dans chaque langue supportée.
- Vérifier les éléments de texte, la classe de messages, les textes DDIC[^terme-acro-ddic] et les titres GUI.
- Une traduction manquante ne doit pas être compensée par une concaténation dépendante de l’ordre des mots.

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-element-donnees]: **ÉLÉMENT DE DONNÉES.** Objet DDIC qui attribue une signification métier, des libellés et une documentation à un type élémentaire ou à un domaine. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>).
[^terme-acro-gui]: **GUI.** Graphical User Interface. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-gui>).
[^terme-dynpro]: **DYNPRO.** Écran classique SAP composé d’une définition d’écran et d’une logique PBO/PAI. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se91]: **SE91.** Transaction de création et de maintenance des classes de messages SAP. Voir [le chapitre associé](<../🧩 10 ├── MESSAGES ET GESTION DES ERREURS/02 ├── CLASSES DE MESSAGES ET TRANSACTION SE91.md>).
[^outil-se63]: **SE63.** Transaction centrale de traduction des objets et textes SAP. Voir [le chapitre associé](<01 └── EXTERNALISER LES TEXTES D UN PROGRAMME.md>).
