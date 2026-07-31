# 🌸 CHOISIR ENTRE IF ET CASE

## 🌺 OBJECTIFS

- Identifier la structure la plus lisible pour un besoin donné
- Distinguer comparaison de valeur et condition générale
- Réduire les branches redondantes
- Organiser les règles par priorité
- Préparer des traitements faciles à tester

## 🌺 RÈGLE DE CHOIX

Utiliser `CASE` lorsque :

- une seule expression pilote le branchement ;
- chaque branche repose principalement sur une égalité ;
- les valeurs possibles sont distinctes et lisibles.

Utiliser `IF` lorsque :

- plusieurs objets de données participent à la décision ;
- les conditions utilisent des plages, des inégalités ou des prédicats ;
- l’ordre de priorité des règles est important.

| Besoin                                  | Structure recommandée |
| --------------------------------------- | --------------------- |
| Comparer un statut à plusieurs codes    | `CASE`                |
| Vérifier un montant et une devise       | `IF`                  |
| Tester une plage de dates               | `IF`                  |
| Traiter plusieurs commandes utilisateur | `CASE`                |
| Combiner autorisation, état et quantité | `IF`                  |

## 🌺 EXEMPLE ADAPTÉ À CASE

Version `IF` valide mais répétitive :

```abap
IF lv_status = 'N'.
  WRITE: / 'Nouveau'.
ELSEIF lv_status = 'P'.
  WRITE: / 'En cours'.
ELSEIF lv_status = 'C'.
  WRITE: / 'Clôturé'.
ELSE.
  WRITE: / 'Statut inconnu'.
ENDIF.
```

Version `CASE` plus directe :

```abap
CASE lv_status.
  WHEN 'N'.
    WRITE: / 'Nouveau'.
  WHEN 'P'.
    WRITE: / 'En cours'.
  WHEN 'C'.
    WRITE: / 'Clôturé'.
  WHEN OTHERS.
    WRITE: / 'Statut inconnu'.
ENDCASE.
```

## 🌺 EXEMPLE ADAPTÉ À IF

```abap
IF lv_amount <= 0.
  WRITE: / 'Montant invalide'.
ELSEIF lv_currency IS INITIAL.
  WRITE: / 'Devise obligatoire'.
ELSEIF lv_blocked = abap_true.
  WRITE: / 'Document bloqué'.
ELSE.
  WRITE: / 'Document valide'.
ENDIF.
```

Un `CASE` ne rendrait pas cette décision plus claire, car plusieurs critères indépendants sont vérifiés.

## 🌺 PRIORISER LES RÈGLES

Dans une chaîne `IF ... ELSEIF`, la première condition vraie gagne.

```mermaid
flowchart TD
    A["Règle la plus bloquante"] --> B["Règle spécifique suivante"]
    B --> C["Règle générale"]
    C --> D["Traitement par défaut"]
```

Exemple :

```abap
IF lv_deleted = abap_true.
  WRITE: / 'Document supprimé'.
ELSEIF lv_blocked = abap_true.
  WRITE: / 'Document bloqué'.
ELSEIF lv_complete = abap_true.
  WRITE: / 'Document complet'.
ELSE.
  WRITE: / 'Document incomplet'.
ENDIF.
```

## 🌺 ÉVITER LES DUPLICATIONS

Si plusieurs branches exécutent le même traitement, regrouper la condition ou extraire le traitement commun.

Avant :

```abap
IF lv_country = 'FR'.
  lv_region = 'EU'.
ELSEIF lv_country = 'BE'.
  lv_region = 'EU'.
ENDIF.
```

Après :

```abap
IF lv_country = 'FR' OR lv_country = 'BE'.
  lv_region = 'EU'.
ENDIF.
```

Ou avec `CASE` :

```abap
CASE lv_country.
  WHEN 'FR' OR 'BE'.
    lv_region = 'EU'.
  WHEN OTHERS.
    CLEAR lv_region.
ENDCASE.
```

## 🌺 TESTABILITÉ

Chaque branche représente un chemin de traitement à tester.

| Structure                | Cas minimaux à tester                       |
| ------------------------ | ------------------------------------------- |
| `IF` sans `ELSE`         | Condition vraie, condition fausse           |
| `IF ... ELSEIF ... ELSE` | Chaque condition et la branche par défaut   |
| `CASE`                   | Chaque `WHEN` et, si présent, `WHEN OTHERS` |

La couverture de toutes les branches réduit les anomalies liées aux cas limites.

## 🌺 CAS D’USAGE

Dans un contexte où un traitement doit appliquer plusieurs règles métier et arrêter ou poursuivre le flux selon les données rencontrées, le besoin consiste à **sélectionner une branche à partir d’une même valeur discriminante**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
- Créer une boucle sans condition de sortie fiable.
- Utiliser `CHECK`, `CONTINUE`, `EXIT` ou `RETURN` sans rendre le flux lisible.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
IF lv_status = 'N'.
  WRITE: / 'Nouveau'.
ELSEIF lv_status = 'P'.
  WRITE: / 'En cours'.
ELSEIF lv_status = 'C'.
  WRITE: / 'Clôturé'.
ELSE.
  WRITE: / 'Statut inconnu'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [Instruction ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **sélectionner une branche à partir d’une même valeur discriminante**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Using Control Structures in ABAP — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/using-control-structures-in-abap_a4d7803e-eac2-458e-acf9-8628289f3701)
- [Control Flow — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/94e1b1978adf45c1a72bd9d8075436d3.html)
- [Branch Code Coverage — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/7f27a2638ee64d1d97dd53c69c562e7b.html)


---

➡️ [Chapitre suivant — EXPRESSIONS CONDITIONNELLES COND ET SWITCH](<./05 - 🍧 EXPRESSIONS CONDITIONNELLES COND ET SWITCH.md>)
