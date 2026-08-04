# 8. OPTIONS D’AFFICHAGE ET DE SAISIE

## 8.A RÉSULTAT ATTENDU

- Configurer le comportement des champs de sélection
- Utiliser les additions sans dégrader l’ergonomie
- Gérer majuscules, visibilité[^terme-visibilite] et longueur affichée
- Déclencher un rafraîchissement par commande utilisateur
- Distinguer contrainte technique et règle métier[^terme-regle-metier]

## 8.B OPTIONS COURANTES DE PARAMETERS

```abap
PARAMETERS:
  p_name  TYPE c LENGTH 40 LOWER CASE,
  p_limit TYPE i DEFAULT 100 OBLIGATORY,
  p_code  TYPE c LENGTH 20 VISIBLE LENGTH 10.
```

| Addition         | Usage                                         |
| ---------------- | --------------------------------------------- |
| `LOWER CASE`     | Autoriser la conservation des minuscules      |
| `DEFAULT`        | Définir une valeur initiale statique          |
| `OBLIGATORY`     | Imposer une saisie non initiale               |
| `VISIBLE LENGTH` | Limiter la largeur affichée                   |
| `NO-DISPLAY`     | Ne pas afficher le champ                      |
| `MODIF ID`       | Affecter le champ à un groupe de modification |

## 8.C OPTIONS DE SELECT-OPTIONS

```abap
SELECT-OPTIONS s_date FOR sy-datum
  NO-EXTENSION
  OBLIGATORY.
```

`NO INTERVALS` modifie principalement la présentation de la borne haute. `NO-EXTENSION` empêche la saisie multiple.

## 8.D COMMANDE UTILISATEUR

```abap
PARAMETERS:
  p_sum RADIOBUTTON GROUP out DEFAULT 'X' USER-COMMAND mode,
  p_det RADIOBUTTON GROUP out.
```

`USER-COMMAND` associe un code fonction à la modification du champ. Le runtime peut alors traiter l’action et reconstruire l’écran avant la prochaine saisie.

Cette technique est utile pour afficher ou masquer des groupes de champs.

## 8.E MÉMOIRE UTILISATEUR

Les additions `MEMORY ID` peuvent associer un champ à un paramètre SPA/GPA.

```abap
PARAMETERS p_bukrs TYPE bukrs MEMORY ID buk.
```

Utiliser ce mécanisme seulement lorsque l’identifiant est officiellement défini et que la pré-alimentation est pertinente. Une valeur mémorisée ne doit jamais contourner une validation ou une autorisation.

## 8.F AIDE À LA RECHERCHE EXPLICITE

```abap
PARAMETERS p_carr TYPE scarr-carrid
  MATCHCODE OBJECT zsh_carrid. " Exemple de search help client
```

Privilégier l’aide à la recherche portée par le type DDIC[^terme-acro-ddic]. Une aide explicitement imposée doit correspondre exactement au besoin du champ.

## 8.G RÈGLE D’ERGONOMIE

Ne pas multiplier les options techniques pour compenser un écran mal conçu. Un écran de sélection doit rester :

- court ;
- compréhensible ;
- cohérent avec les termes métier ;
- exploitable par variante ;
- utilisable au clavier.

## 8.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 8.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 8.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
PARAMETERS:
  p_name  TYPE c LENGTH 40 LOWER CASE,
  p_limit TYPE i DEFAULT 100 OBLIGATORY,
  p_code  TYPE c LENGTH 20 VISIBLE LENGTH 10.
```

## 8.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 8.L MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP[^terme-acro-sap] et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 8.M RÉFÉRENCES OFFICIELLES SAP

- [PARAMETERS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPPARAMETERS.html)
- [SELECT-OPTIONS, Value Options — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapselect-options_value.htm)
- [SELECTION-SCREEN, MODIF ID — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECTION-SCREEN_MODIF_ID.html)


---

[Chapitre suivant — MISE EN PAGE AVEC SELECTION-SCREEN](<./09 ├── MISE EN PAGE AVEC SELECTION SCREEN.md>)

[^terme-visibilite]: **VISIBILITÉ.** Règle déterminant où un composant de classe peut être utilisé : `PUBLIC`, `PROTECTED` ou `PRIVATE`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#visibilite>).
[^terme-regle-metier]: **RÈGLE MÉTIER.** Condition ou calcul imposé par le processus fonctionnel. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#regle-metier>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
