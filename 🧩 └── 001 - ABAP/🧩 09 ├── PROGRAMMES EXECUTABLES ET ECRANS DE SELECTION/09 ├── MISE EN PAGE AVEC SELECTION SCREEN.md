# 9. MISE EN PAGE AVEC SELECTION-SCREEN

## 9.A RÉSULTAT ATTENDU

- Organiser les champs en blocs
- Ajouter titres, commentaires et séparateurs
- Aligner plusieurs éléments sur une ligne
- Créer un bouton de commande simple
- Maintenir une mise en page compatible SAP GUI[^terme-sap-gui]

## 9.B BLOC AVEC CADRE

```abap
SELECTION-SCREEN BEGIN OF BLOCK b_sel WITH FRAME TITLE text-t01.
  PARAMETERS p_carr TYPE scarr-carrid.
  SELECT-OPTIONS s_conn FOR spfli-connid.
SELECTION-SCREEN END OF BLOCK b_sel.
```

Le texte `text-t01` est maintenu dans les éléments de texte du programme.

## 9.C LIGNE ET COMMENTAIRE

```abap
SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 1(25) text-c01 FOR FIELD p_test.
  PARAMETERS p_test AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
```

`FOR FIELD` associe le commentaire au champ, ce qui améliore le comportement d’aide et de navigation.

## 9.D ESPACEMENT ET SÉPARATION

```abap
SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN ULINE.
```

Utiliser ces instructions avec modération. Les blocs fonctionnels sont généralement plus lisibles qu’un positionnement manuel complexe.

## 9.E POSITIONNEMENT

```abap
SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN POSITION 5.
  PARAMETERS p_short TYPE c LENGTH 10.
SELECTION-SCREEN END OF LINE.
```

Le positionnement absolu peut varier visuellement selon la longueur des textes et la langue. Éviter une mise en page dépendante d’un libellé français fixe.

## 9.F BOUTON SUR L’ÉCRAN

```abap
SELECTION-SCREEN PUSHBUTTON 2(20) text-b01 USER-COMMAND info.

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'INFO'.
      MESSAGE text-i01 TYPE 'I'.
  ENDCASE.
```

Le code fonction est disponible dans `sy-ucomm`. Le traitement doit rester court et ne pas lancer silencieusement une opération métier lourde.

## 9.G LIMITES

Un écran de sélection n’est pas un formulaire applicatif complet. Lorsque l’interface exige :

- plusieurs écrans ;
- navigation complexe ;
- tableaux éditables ;
- contrôles graphiques ;
- logique PBO/PAI détaillée ;

utiliser une technologie d’interface adaptée plutôt que de détourner `SELECTION-SCREEN`.

## 9.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 9.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 9.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SELECTION-SCREEN BEGIN OF BLOCK b_sel WITH FRAME TITLE text-t01.
  PARAMETERS p_carr TYPE scarr-carrid.
  SELECT-OPTIONS s_conn FOR spfli-connid.
SELECTION-SCREEN END OF BLOCK b_sel.
```

## 9.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 9.L MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 9.M RÉFÉRENCES OFFICIELLES SAP

- [SELECTION-SCREEN — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECTION-SCREEN.html)
- [SELECTION-SCREEN, COMMENT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPSELECTION-SCREEN_COMMENT.html)
- [Defining Selection Screens — SAP Help Portal](https://help.sap.com/docs/PRODUCT_ID/6f3e0bea6c4b101484fcf5305b4d624b/4a43c2a55a503f04e10000000a421937.html)


---

[Chapitre suivant — INITIALISATION DES VALEURS](<./10 ├── INITIALISATION DES VALEURS.md>)

[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
