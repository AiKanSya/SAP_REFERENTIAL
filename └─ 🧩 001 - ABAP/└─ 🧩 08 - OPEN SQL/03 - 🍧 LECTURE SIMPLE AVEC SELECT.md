# 🌸 LIRE DES DONNÉES AVEC `SELECT`

## 🌺 RÉSULTAT ATTENDU

Créer et exécuter un programme qui lit les compagnies aériennes d’une devise donnée, puis affiche uniquement les colonnes utiles.

## 🌺 PRÉREQUIS

- Accès à `SE38` ou `SE80` dans un système de développement S/4HANA.
- Autorisation de créer ou modifier un programme `Z`.
- Tables de démonstration `SCARR` disponibles et alimentées.

> [!NOTE]
> Si `SCARR` est absente ou vide, utiliser une table `Z` de démonstration ou une source autorisée en lecture seule. Ne pas remplacer l’exemple par une table applicative standard destinée à être modifiée.

## 🌺 PROCÉDURE RAPIDE

1. Ouvrir `SE38`.
2. Créer le programme `ZDEMO_SELECT_CARRIERS` dans `$TMP` pour un test local, ou dans le package fourni par le projet.
3. Coller le programme complet ci-dessous.
4. Lancer le contrôle syntaxique avec `Ctrl+F2`.
5. Activer avec `Ctrl+F3`.
6. Exécuter avec `F8`.
7. Saisir une devise présente dans `SCARR`, par exemple `EUR`, puis exécuter.

## 🌺 CODE PRÊT À ADAPTER

```abap
REPORT zdemo_select_carriers.

PARAMETERS p_curr TYPE scarr-currcode DEFAULT 'EUR'.

START-OF-SELECTION.
  SELECT carrid,
         carrname,
         currcode
    FROM scarr
    WHERE currcode = @p_curr
    ORDER BY carrid
    INTO TABLE @DATA(lt_carriers).

  IF sy-subrc <> 0.
    WRITE / |Aucune compagnie trouvée pour la devise { p_curr }.|.
    RETURN.
  ENDIF.

  LOOP AT lt_carriers ASSIGNING FIELD-SYMBOL(<ls_carrier>).
    WRITE: / <ls_carrier>-carrid,
             <ls_carrier>-carrname,
             <ls_carrier>-currcode.
  ENDLOOP.
```

La variable ABAP `p_curr` est préfixée par `@` parce qu’elle est utilisée comme variable hôte dans l’instruction ABAP SQL.

`INTO TABLE` remplace le contenu de la table interne cible. `APPENDING TABLE` ajoute les lignes au contenu existant et ne doit être utilisé que si cette accumulation est voulue.

## 🌺 POINTS À REMPLACER

| Élément | Remplacement attendu |
|---|---|
| `ZDEMO_SELECT_CARRIERS` | Nom du programme client |
| `SCARR` | Source DDIC autorisée |
| `CARRID`, `CARRNAME`, `CURRCODE` | Colonnes strictement nécessaires |
| `P_CURR` | Critère de sélection adapté au besoin |
| `ORDER BY CARRID` | Ordre déterministe requis par l’affichage |

## 🌺 VARIANTES UTILES

### 🌻 LIRE UNE SEULE LIGNE PAR CLÉ

```abap
PARAMETERS p_carrid TYPE scarr-carrid.

SELECT SINGLE carrid,
              carrname,
              currcode
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(ls_carrier).

IF sy-subrc <> 0.
  MESSAGE 'Compagnie introuvable' TYPE 'S' DISPLAY LIKE 'E'.
  RETURN.
ENDIF.
```

Utiliser cette forme lorsque la condition identifie une ligne unique. Le choix entre `SELECT SINGLE` et `UP TO 1 ROWS` est détaillé dans le chapitre suivant consacré à ce sujet.

### 🌻 AJOUTER À UNE TABLE INTERNE EXISTANTE

```abap
SELECT carrid,
       carrname,
       currcode
  FROM scarr
  WHERE currcode = @p_curr
  APPENDING TABLE @lt_carriers.
```

Contrôler les doublons avant d’employer `APPENDING TABLE` dans plusieurs lectures successives.

## 🌺 CONTRÔLE

- `Ctrl+F2` ne retourne aucune erreur de syntaxe.
- Une devise existante produit une liste triée par `CARRID`.
- Une devise absente affiche le message prévu.
- `SY-SUBRC = 0` lorsqu’au moins une ligne est transférée dans la cible.
- `SY-SUBRC = 4` lorsqu’aucune ligne n’est trouvée.
- La liste `SELECT` ne contient que les colonnes utilisées.

## 🌺 ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Erreur de syntaxe sur `P_CURR` | Marqueur de variable hôte absent | Utiliser `@p_curr` dans ABAP SQL |
| Aucun résultat | Valeur absente de la table ou espace significatif | Contrôler les données avec `SE16H` et la valeur saisie |
| Résultat dans un ordre variable | Aucun ordre SQL demandé | Ajouter `ORDER BY` lorsque l’ordre est fonctionnellement requis |
| Trop de données transférées | Restriction `WHERE` insuffisante | Ajouter les critères disponibles avant la lecture |
| Structure cible incompatible | Colonnes et cible ne correspondent pas | Utiliser une cible inline ou adapter explicitement le type |
| Doublons inattendus | Usage successif de `APPENDING TABLE` | Vider la cible ou utiliser `INTO TABLE` |

## 🌺 COMPATIBILITÉ S/4HANA

- Statut : recommandé pour le développement ABAP classique.
- Employer la syntaxe ABAP SQL avec variables hôte `@`.
- Préférer une lecture ensembliste dans une table interne à une succession de lectures SQL dans une boucle ABAP.
- La disponibilité de la syntaxe exacte dépend de la version d’ABAP Platform ; la documentation `F1` du système reste la référence exécutable.

## 🌺 TERMES DU LEXIQUE

- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)
- [SELECT List — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_LIST.html)

---

➡️ [Chapitre suivant — CHAMPS, ALIAS ET EXPRESSIONS SQL](<./04 - 🍧 CHAMPS ALIAS ET EXPRESSIONS SQL.md>)
