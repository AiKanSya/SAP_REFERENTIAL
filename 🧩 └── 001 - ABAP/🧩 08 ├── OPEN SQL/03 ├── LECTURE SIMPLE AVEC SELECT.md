# 3. LIRE DES DONNÉES AVEC `SELECT`

## 3.A RÉSULTAT ATTENDU

Créer et exécuter un programme qui lit les compagnies aériennes d’une devise donnée, puis affiche uniquement les colonnes utiles.

## 3.B PRÉREQUIS

- Accès à `SE38` ou `SE80` dans un système de développement S/4HANA.
- Autorisation de créer ou modifier un programme `Z`.
- Tables de démonstration `SCARR` disponibles et alimentées.

> [!NOTE]
> Si `SCARR` est absente ou vide, utiliser une table `Z` de démonstration ou une source autorisée en lecture seule. Ne pas remplacer l’exemple par une table applicative standard destinée à être modifiée.

## 3.C PROCESS

### 3.C.1 Étape 1 — Vérifier les données de test

Afficher `SCARR` dans `SE11` ou un outil de consultation autorisé. Relever une devise réellement présente et au moins un transporteur associé. Ne retenir `EUR` que si cette valeur existe dans le système courant.

### 3.C.2 Étape 2 — Créer le programme

Ouvrir `SE38`, saisir `ZDEMO_SELECT_CARRIERS` et choisir **Créer**. Utiliser `$TMP` pour un exercice local ou le package et la tâche imposés par le projet. Si le nom existe, ne pas écraser le programme : choisir un nom libre.

### 3.C.3 Étape 3 — Insérer et vérifier le code

Coller le programme complet du chapitre. Vérifier que la déclaration `REPORT` correspond au nom créé et que les variables hôtes de la requête sont précédées de `@`.

### 3.C.4 Étape 4 — Contrôler puis activer

Exécuter `Ctrl+F2`, corriger chaque erreur, puis `Ctrl+F3`. Si `SCARR` ou un champ est inconnu, confirmer que le système cible contient le modèle de démonstration utilisé par le chapitre.

### 3.C.5 Étape 5 — Exécuter le cas positif

Lancer avec `F8`, saisir la devise relevée à l’étape 1 puis exécuter. Comparer nombre de lignes, identifiants et devises avec la source.

### 3.C.6 Étape 6 — Exécuter le cas sans résultat

Relancer avec une valeur valide techniquement mais absente des données. Le programme doit afficher ou traiter explicitement l’absence de transporteur, sans conserver le résultat de l’exécution précédente.

Le test est terminé lorsque les cas présent et absent produisent deux résultats distincts et contrôlés.

## 3.D CODE PRÊT À ADAPTER

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

## 3.E POINTS À REMPLACER

| Élément                          | Remplacement attendu                      |
| -------------------------------- | ----------------------------------------- |
| `ZDEMO_SELECT_CARRIERS`          | Nom du programme client                   |
| `SCARR`                          | Source DDIC autorisée                     |
| `CARRID`, `CARRNAME`, `CURRCODE` | Colonnes strictement nécessaires          |
| `P_CURR`                         | Critère de sélection adapté au besoin     |
| `ORDER BY CARRID`                | Ordre déterministe requis par l’affichage |

## 3.F VARIANTES UTILES

### 3.F.1 LIRE UNE SEULE LIGNE PAR CLÉ

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
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

### 3.F.2 AJOUTER À UNE TABLE INTERNE EXISTANTE

```abap
" Lire uniquement les colonnes et les lignes nécessaires.
SELECT carrid,
       carrname,
       currcode
  FROM scarr
  WHERE currcode = @p_curr
  APPENDING TABLE @lt_carriers.
```

Contrôler les doublons avant d’employer `APPENDING TABLE` dans plusieurs lectures successives.

## 3.G CONTRÔLE

- `Ctrl+F2` ne retourne aucune erreur de syntaxe.
- Une devise existante produit une liste triée par `CARRID`.
- Une devise absente affiche le message prévu.
- `SY-SUBRC = 0` lorsqu’au moins une ligne est transférée dans la cible.
- `SY-SUBRC = 4` lorsqu’aucune ligne n’est trouvée.
- La liste `SELECT` ne contient que les colonnes utilisées.

## 3.H ERREURS FRÉQUENTES

| Symptôme                        | Cause probable                                    | Correction                                                      |
| ------------------------------- | ------------------------------------------------- | --------------------------------------------------------------- |
| Erreur de syntaxe sur `P_CURR`  | Marqueur de variable hôte absent                  | Utiliser `@p_curr` dans ABAP SQL                                |
| Aucun résultat                  | Valeur absente de la table ou espace significatif | Contrôler les données avec `SE16H` et la valeur saisie          |
| Résultat dans un ordre variable | Aucun ordre SQL demandé                           | Ajouter `ORDER BY` lorsque l’ordre est fonctionnellement requis |
| Trop de données transférées     | Restriction `WHERE` insuffisante                  | Ajouter les critères disponibles avant la lecture               |
| Structure cible incompatible    | Colonnes et cible ne correspondent pas            | Utiliser une cible inline ou adapter explicitement le type      |
| Doublons inattendus             | Usage successif de `APPENDING TABLE`              | Vider la cible ou utiliser `INTO TABLE`                         |

## 3.I COMPATIBILITÉ S/4HANA

- Statut : recommandé pour le développement ABAP classique.
- Employer la syntaxe ABAP SQL avec variables hôte `@`.
- Préférer une lecture ensembliste dans une table interne à une succession de lectures SQL dans une boucle ABAP.
- La disponibilité de la syntaxe exacte dépend de la version d’ABAP Platform ; la documentation `F1` du système reste la référence exécutable.

## 3.J TERMES DU LEXIQUE

- [SQL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Implementing Basic SELECT Statements — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/implementing-basic-select-statements_a6d4effa-f6b0-4ef8-96c8-b79baa2da157)
- [SELECT — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_SHORTREF.html)
- [SELECT List — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSELECT_LIST.html)

---

[Chapitre suivant — CHAMPS, ALIAS ET EXPRESSIONS SQL](<./04 ├── CHAMPS ALIAS ET EXPRESSIONS SQL.md>)
