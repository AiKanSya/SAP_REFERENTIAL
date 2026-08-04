# 10. INITIALISATION DES VALEURS

## 10.A RÉSULTAT ATTENDU

- Distinguer `DEFAULT` et `INITIALIZATION`
- Calculer des valeurs initiales dynamiques
- Alimenter plusieurs lignes de sélection
- Respecter les variantes et la mémoire utilisateur
- Éviter de réinitialiser les saisies à chaque affichage

## 10.B ÉVÉNEMENT INITIALIZATION

`INITIALIZATION` est déclenché avant le premier traitement de l’écran de sélection standard.

```abap
INITIALIZATION.
  p_date = sy-datum.
```

Il convient aux valeurs dépendant du contexte d’exécution.

## 10.C DEFAULT OU INITIALIZATION

| Besoin                              | Technique                              |
| ----------------------------------- | -------------------------------------- |
| Valeur littérale fixe               | `DEFAULT`                              |
| Date système                        | `INITIALIZATION`                       |
| Calcul de période                   | `INITIALIZATION`                       |
| Plusieurs lignes d’un select-option | `INITIALIZATION`                       |
| Valeur pilotée par variante         | Laisser la variante alimenter le champ |

## 10.D INTERVALLE DE DATES INITIAL

```abap
SELECT-OPTIONS s_date FOR sy-datum.

INITIALIZATION.
  APPEND VALUE #(
    sign   = 'I'
    option = 'BT'
    low    = sy-datum - 30
    high   = sy-datum
  ) TO s_date.
```

Le calcul de date doit rester cohérent avec le besoin métier. Une période de 30 jours n’est pas équivalente au mois civil précédent.

## 10.E NE PAS ÉCRASER LES VALEURS

`AT SELECTION-SCREEN OUTPUT` est déclenché avant chaque affichage. Une affectation inconditionnelle dans cet événement peut écraser :

- la saisie utilisateur ;
- une valeur de variante ;
- une valeur passée par `SUBMIT` ;
- une correction après message d’erreur.

```abap
AT SELECTION-SCREEN OUTPUT.
  p_date = sy-datum. " À éviter
```

Utiliser cet événement pour les propriétés d’écran, pas pour réinitialiser systématiquement les données.

## 10.F INITIALISATION CONDITIONNELLE

Lorsque l’objet peut déjà être alimenté, contrôler son état :

```abap
INITIALIZATION.
  IF s_date[] IS INITIAL.
    APPEND VALUE #(
      sign   = 'I'
      option = 'EQ'
      low    = sy-datum
    ) TO s_date.
  ENDIF.
```

## 10.G PROCESS

### 10.G.1 Étape 1 — Identifier la source de chaque valeur initiale

Pour chaque champ de sélection, décider si la valeur vient d’un défaut statique, de `INITIALIZATION`, de la mémoire SAP, d’une variante ou d’une saisie utilisateur. Ne pas alimenter le même champ depuis plusieurs sources sans définir leur priorité.

### 10.G.2 Étape 2 — Implémenter les défauts statiques

Utiliser `DEFAULT` uniquement pour une valeur constante sûre dans tous les contextes visés. Activer puis exécuter sans variante et vérifier la valeur affichée dès le premier écran.

### 10.G.3 Étape 3 — Implémenter une initialisation calculée

Placer dans `INITIALIZATION` uniquement le calcul nécessaire avant le premier affichage. Pour un `SELECT-OPTIONS`, construire explicitement les lignes `SIGN`, `OPTION`, `LOW` et `HIGH`, puis supprimer toute ligne résiduelle non prévue.

### 10.G.4 Étape 4 — Tester la priorité des sources

Exécuter successivement sans variante, avec une variante, puis avec une valeur mémorisée si le champ utilise un parameter ID. Relever quelle source remplace l’autre sur le système cible.

### 10.G.5 Étape 5 — Tester le retour à l’écran

Modifier manuellement la valeur et provoquer une validation en erreur. Vérifier que `INITIALIZATION` ne réécrit pas la saisie lors du simple retour sur l’écran.

La mise en place est validée lorsque la première valeur est prévisible, que la variante produit le résultat attendu et que la saisie utilisateur n’est pas écrasée pendant la validation.

## 10.H VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 10.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 10.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SELECT-OPTIONS s_date FOR sy-datum.

INITIALIZATION.
  APPEND VALUE #(
    sign   = 'I'
    option = 'BT'
    low    = sy-datum - 30
    high   = sy-datum
  ) TO s_date.
```

## 10.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 10.L RÉFÉRENCES OFFICIELLES SAP

- [INITIALIZATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINITIALIZATION.html)
- [Selection Screen Processing — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/a85596deeb19418982bee031d1fd1427/4a43c40d5a503f04e10000000a421937.html)
- [SELECT-OPTIONS, Value Options — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapselect-options_value.htm)

---

[Chapitre suivant — VALIDATION AVEC AT SELECTION-SCREEN](<./11 ├── VALIDATION AVEC AT SELECTION SCREEN.md>)
