# 🌸 PARAMÈTRES AVEC PARAMETERS

## 🌺 OBJECTIFS

- Déclarer une valeur unique sur l’écran de sélection
- Utiliser un type ABAP ou DDIC adapté
- Définir une valeur par défaut
- Créer une case à cocher ou des boutons radio
- Comprendre la variable globale générée

## 🌺 DÉCLARATION SIMPLE

```abap
PARAMETERS p_carr TYPE scarr-carrid.
```

Cette instruction crée :

- un objet de données global `p_carr` ;
- un champ de saisie sur l’écran de sélection ;
- les contrôles techniques associés au type.

La longueur du nom est limitée par les règles du langage pour les paramètres de sélection. Utiliser une convention courte et explicite, généralement préfixée par `p_`.

## 🌺 TYPAGE DDIC

```abap
PARAMETERS:
  p_bukrs TYPE bukrs,
  p_date  TYPE sy-datum.
```

Un type DDIC apporte selon sa définition :

- format de sortie ;
- aide à la saisie ;
- conversion ;
- documentation ;
- contrôle de valeurs fixes.

Ne pas utiliser un type générique `c` lorsque le champ possède une sémantique DDIC connue.

## 🌺 VALEUR PAR DÉFAUT

```abap
PARAMETERS p_limit TYPE i DEFAULT 100.
```

`DEFAULT` convient à une valeur statique ou directement disponible lors de la déclaration. Pour une valeur calculée ou dépendante du contexte, utiliser `INITIALIZATION`.

## 🌺 CHAMP OBLIGATOIRE

```abap
PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
```

`OBLIGATORY` impose une valeur avant l’exécution. Cette option ne remplace pas la validation métier.

## 🌺 CASE À COCHER

```abap
PARAMETERS p_test AS CHECKBOX DEFAULT abap_true.
```

La valeur cochée est généralement `X`, compatible avec `abap_true`.

```abap
IF p_test = abap_true.
  " Mode test
ENDIF.
```

## 🌺 BOUTONS RADIO

```abap
PARAMETERS:
  p_sum RADIOBUTTON GROUP out DEFAULT 'X',
  p_det RADIOBUTTON GROUP out.
```

Tous les boutons d’un même groupe sont exclusifs. Prévoir une valeur par défaut pour éviter un état ambigu.

## 🌺 PARAMÈTRE TECHNIQUE MASQUÉ

```abap
PARAMETERS p_mode TYPE c LENGTH 1 NO-DISPLAY.
```

Un champ masqué peut être alimenté par variante ou par `SUBMIT`. Ne pas y stocker un secret : la valeur reste une donnée du programme.

## 🌺 CAS D’USAGE

Dans un contexte où un utilisateur doit exécuter un report paramétrable, valider ses critères et réutiliser des variantes, le besoin consiste à **déclarer un critère simple et le rendre obligatoire ou prérempli selon le besoin**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
PARAMETERS:
  p_bukrs TYPE bukrs,
  p_date  TYPE sy-datum.
```

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **déclarer un critère simple et le rendre obligatoire ou prérempli selon le besoin**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [PARAMETERS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPPARAMETERS.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)


---

➡️ [Chapitre suivant — CRITÈRES AVEC SELECT-OPTIONS](<./06 - 🍧 CRITERES AVEC SELECT OPTIONS.md>)
