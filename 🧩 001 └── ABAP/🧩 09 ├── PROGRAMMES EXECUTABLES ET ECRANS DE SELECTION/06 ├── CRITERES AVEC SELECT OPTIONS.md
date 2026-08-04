# 6. CRITÈRES AVEC SELECT-OPTIONS

## 6.A RÉSULTAT ATTENDU

- Déclarer un critère multivaleur
- Comprendre les bornes basse et haute
- Utiliser les inclusions et exclusions
- Passer directement le critère à ABAP[^terme-abap] SQL[^terme-acro-sql]
- Choisir entre `PARAMETERS` et `SELECT-OPTIONS`

## 6.B DÉCLARATION

```abap
SELECT-OPTIONS s_carr FOR scarr-carrid.
```

Cette instruction crée :

- un critère de sélection visible sur l’écran ;
- une table de sélection globale nommée `s_carr` ;
- un accès au dialogue de sélection multiple.

La convention habituelle utilise le préfixe `s_`.

## 6.C CRITÈRE SIMPLE OU MULTIPLE

L’utilisateur peut saisir :

- une valeur unique ;
- un intervalle ;
- plusieurs valeurs ;
- des exclusions ;
- des motifs lorsque le type et l’opérateur le permettent.

```mermaid
flowchart LR
    A["Champ de sélection"] --> B["Valeur unique"]
    A --> C["Intervalle"]
    A --> D["Valeurs multiples"]
    A --> E["Exclusions"]
```

## 6.D UTILISATION DANS ABAP SQL

```abap
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN @s_carr
  INTO TABLE @DATA(lt_carriers).
```

ABAP SQL interprète les lignes de la table de sélection selon `SIGN`, `OPTION`, `LOW` et `HIGH`.

## 6.E LIMITER À UNE VALEUR UNIQUE

```abap
SELECT-OPTIONS s_carr FOR scarr-carrid NO INTERVALS NO-EXTENSION.
```

| Addition       | Effet                                       |
| -------------- | ------------------------------------------- |
| `NO INTERVALS` | Masque la borne haute sur l’écran principal |
| `NO-EXTENSION` | Supprime le dialogue de sélection multiple  |

Même avec `NO INTERVALS`, l’objet ABAP reste une table de sélection.

## 6.F VALEUR PAR DÉFAUT

```abap
SELECT-OPTIONS s_carr FOR scarr-carrid DEFAULT 'LH'.
```

Pour plusieurs lignes initiales, alimenter la table dans `INITIALIZATION`.

## 6.G CHOIX ENTRE PARAMETERS ET SELECT-OPTIONS

| Besoin                            | Instruction                  |
| --------------------------------- | ---------------------------- |
| Une seule valeur métier           | `PARAMETERS`                 |
| Plusieurs valeurs ou intervalles  | `SELECT-OPTIONS`             |
| Critère transmis à `WHERE ... IN` | `SELECT-OPTIONS`             |
| Option binaire                    | `PARAMETERS ... AS CHECKBOX` |

Ne pas utiliser `SELECT-OPTIONS` par habitude lorsque le traitement exige réellement une seule valeur.

## 6.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 6.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 6.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SELECT carrid, carrname
  FROM scarr
  WHERE carrid IN @s_carr
  INTO TABLE @DATA(lt_carriers).
```

## 6.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 6.L MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP[^terme-acro-sap] et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 6.M RÉFÉRENCES OFFICIELLES SAP

- [SELECT-OPTIONS — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_816_index_htm/8.16/en-US/ABAPSELECT-OPTIONS.html)
- [SELECT-OPTIONS, Screen Options — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_750_index_htm/7.50/en-US/ABAPSELECT-OPTIONS_SCREEN.html)
- [Selection Screens — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENSELECTION_SCREEN_OVERVIEW.html)


---

[Chapitre suivant — STRUCTURE ET SÉMANTIQUE DES TABLES DE SÉLECTION](<./07 ├── STRUCTURE ET SEMANTIQUE DES TABLES DE SELECTION.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
