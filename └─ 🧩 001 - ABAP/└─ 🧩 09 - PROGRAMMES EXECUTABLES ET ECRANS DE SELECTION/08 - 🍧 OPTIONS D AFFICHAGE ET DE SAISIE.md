# 🌸 OPTIONS D’AFFICHAGE ET DE SAISIE

## 🌺 OBJECTIFS

- Configurer le comportement des champs de sélection
- Utiliser les additions sans dégrader l’ergonomie
- Gérer majuscules, visibilité et longueur affichée
- Déclencher un rafraîchissement par commande utilisateur
- Distinguer contrainte technique et règle métier

## 🌺 OPTIONS COURANTES DE PARAMETERS

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

## 🌺 OPTIONS DE SELECT-OPTIONS

```abap
SELECT-OPTIONS s_date FOR sy-datum
  NO-EXTENSION
  OBLIGATORY.
```

`NO INTERVALS` modifie principalement la présentation de la borne haute. `NO-EXTENSION` empêche la saisie multiple.

## 🌺 COMMANDE UTILISATEUR

```abap
PARAMETERS:
  p_sum RADIOBUTTON GROUP out DEFAULT 'X' USER-COMMAND mode,
  p_det RADIOBUTTON GROUP out.
```

`USER-COMMAND` associe un code fonction à la modification du champ. Le runtime peut alors traiter l’action et reconstruire l’écran avant la prochaine saisie.

Cette technique est utile pour afficher ou masquer des groupes de champs.

## 🌺 MÉMOIRE UTILISATEUR

Les additions `MEMORY ID` peuvent associer un champ à un paramètre SPA/GPA.

```abap
PARAMETERS p_bukrs TYPE bukrs MEMORY ID buk.
```

Utiliser ce mécanisme seulement lorsque l’identifiant est officiellement défini et que la pré-alimentation est pertinente. Une valeur mémorisée ne doit jamais contourner une validation ou une autorisation.

## 🌺 AIDE À LA RECHERCHE EXPLICITE

```abap
PARAMETERS p_carr TYPE scarr-carrid
  MATCHCODE OBJECT zsh_carrid. " Exemple de search help client
```

Privilégier l’aide à la recherche portée par le type DDIC. Une aide explicitement imposée doit correspondre exactement au besoin du champ.

## 🌺 RÈGLE D’ERGONOMIE

Ne pas multiplier les options techniques pour compenser un écran mal conçu. Un écran de sélection doit rester :

- court ;
- compréhensible ;
- cohérent avec les termes métier ;
- exploitable par variante ;
- utilisable au clavier.

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
  p_name  TYPE c LENGTH 40 LOWER CASE,
  p_limit TYPE i DEFAULT 100 OBLIGATORY,
  p_code  TYPE c LENGTH 20 VISIBLE LENGTH 10.
```

## 🌺 TERMES DU LEXIQUE

- [Programme exécutable](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/02 - 🍧 SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [PARAMETERS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPPARAMETERS.html)
- [SELECT-OPTIONS, Value Options — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapselect-options_value.htm)
- [SELECTION-SCREEN, MODIF ID — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECTION-SCREEN_MODIF_ID.html)


---

➡️ [Chapitre suivant — MISE EN PAGE AVEC SELECTION-SCREEN](<./09 - 🍧 MISE EN PAGE AVEC SELECTION SCREEN.md>)
