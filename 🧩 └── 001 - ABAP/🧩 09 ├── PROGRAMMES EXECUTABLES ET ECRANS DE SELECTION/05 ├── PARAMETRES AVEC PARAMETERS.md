# 5. PARAMÈTRES AVEC PARAMETERS

## 5.A RÉSULTAT ATTENDU

- Déclarer une valeur unique sur l’écran de sélection
- Utiliser un type ABAP[^terme-abap] ou DDIC[^terme-acro-ddic] adapté
- Définir une valeur par défaut
- Créer une case à cocher ou des boutons radio
- Comprendre la variable globale générée

## 5.B DÉCLARATION SIMPLE

```abap
PARAMETERS p_carr TYPE scarr-carrid.
```

Cette instruction crée :

- un objet de données[^terme-objet-donnees] global `p_carr` ;
- un champ de saisie sur l’écran de sélection ;
- les contrôles techniques associés au type.

La longueur du nom est limitée par les règles du langage pour les paramètres de sélection. Utiliser une convention courte et explicite, généralement préfixée par `p_`.

## 5.C TYPAGE DDIC

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

## 5.D VALEUR PAR DÉFAUT

```abap
PARAMETERS p_limit TYPE i DEFAULT 100.
```

`DEFAULT` convient à une valeur statique ou directement disponible lors de la déclaration. Pour une valeur calculée ou dépendante du contexte, utiliser `INITIALIZATION`.

## 5.E CHAMP OBLIGATOIRE

```abap
PARAMETERS p_bukrs TYPE bukrs OBLIGATORY.
```

`OBLIGATORY` impose une valeur avant l’exécution. Cette option ne remplace pas la validation métier.

## 5.F CASE À COCHER

```abap
PARAMETERS p_test AS CHECKBOX DEFAULT abap_true.
```

La valeur cochée est généralement `X`, compatible avec `abap_true`.

```abap
IF p_test = abap_true.
  " Mode test
ENDIF.
```

## 5.G BOUTONS RADIO

```abap
PARAMETERS:
  p_sum RADIOBUTTON GROUP out DEFAULT 'X',
  p_det RADIOBUTTON GROUP out.
```

Tous les boutons d’un même groupe sont exclusifs. Prévoir une valeur par défaut pour éviter un état ambigu.

## 5.H PARAMÈTRE TECHNIQUE MASQUÉ

```abap
PARAMETERS p_mode TYPE c LENGTH 1 NO-DISPLAY.
```

Un champ masqué peut être alimenté par variante ou par `SUBMIT`. Ne pas y stocker un secret : la valeur reste une donnée du programme.

## 5.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 5.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 5.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
PARAMETERS:
  p_bukrs TYPE bukrs,
  p_date  TYPE sy-datum.
```

## 5.L TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 5.M MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP[^terme-acro-sap] et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 5.N RÉFÉRENCES OFFICIELLES SAP

- [PARAMETERS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPPARAMETERS.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)


---

[Chapitre suivant — CRITÈRES AVEC SELECT-OPTIONS](<./06 ├── CRITERES AVEC SELECT OPTIONS.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-objet-donnees]: **OBJET DE DONNÉES.** Zone de mémoire typée contenant une valeur pendant l’exécution. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
