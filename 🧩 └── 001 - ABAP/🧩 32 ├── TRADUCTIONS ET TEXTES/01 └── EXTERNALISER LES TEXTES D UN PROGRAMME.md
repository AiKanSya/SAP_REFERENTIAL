# EXTERNALISER LES TEXTES D’UN PROGRAMME

## RÉSULTAT ATTENDU

Supprimer les libellés utilisateur codés en dur et permettre leur traduction.

## CODE PRÊT À ADAPTER

```abap
PARAMETERS p_bukrs TYPE bukrs.

START-OF-SELECTION.
  WRITE: / text-001, p_bukrs. "TEXT-001 est traduit avec les éléments de texte.
```

Pour les messages métier paramétrés :

```abap
MESSAGE e001(zdemo) WITH p_bukrs.
```

## CONTRÔLE

- Exécuter le programme dans chaque langue supportée.
- Vérifier les éléments de texte, la classe de messages, les textes DDIC et les titres GUI.
- Une traduction manquante ne doit pas être compensée par une concaténation dépendante de l’ordre des mots.
