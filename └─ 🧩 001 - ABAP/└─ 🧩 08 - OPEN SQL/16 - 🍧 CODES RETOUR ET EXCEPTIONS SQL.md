# 🌸 CODES RETOUR ET EXCEPTIONS SQL

## 🌺 OBJECTIFS

- Interpréter `sy-subrc`
- Exploiter `sy-dbcnt`
- Gérer `CX_SY_OPEN_SQL_DB`
- Distinguer absence de résultat et erreur technique
- Produire un traitement fiable après une instruction SQL

## 🌺 SY-SUBRC

Le sens de `sy-subrc` dépend de l’instruction et de sa variante.

Pour une lecture simple :

- `0` : au moins une ligne a été fournie ;
- `4` : aucune ligne n’a été fournie dans les cas usuels.

```abap
SELECT SINGLE carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(lv_name).

IF sy-subrc <> 0.
  MESSAGE 'Transporteur introuvable' TYPE 'I'.
ENDIF.
```

Ne pas conserver la valeur de `sy-subrc` pendant plusieurs instructions. La tester immédiatement après l’instruction concernée.

## 🌺 SY-DBCNT

`sy-dbcnt` contient le nombre de lignes traitées par de nombreuses instructions SQL.

```abap
UPDATE zdev_product
  SET active = @abap_false
  WHERE category = @p_category.

DATA(lv_updated_rows) = sy-dbcnt.
```

Copier la valeur immédiatement si elle doit être réutilisée plus tard.

## 🌺 EXCEPTION CX_SY_OPEN_SQL_DB

Certaines erreurs de base de données sont représentées par l’exception interceptable `CX_SY_OPEN_SQL_DB`.

```abap
TRY.
    INSERT zdev_product FROM TABLE @lt_products.

  CATCH cx_sy_open_sql_db INTO DATA(lx_sql).
    MESSAGE lx_sql->get_text( ) TYPE 'E'.
ENDTRY.
```

Causes possibles :

- clé dupliquée ;
- valeur incompatible ;
- violation d’une contrainte ;
- erreur du système de base de données ;
- problème de connexion.

## 🌺 ABSENCE MÉTIER OU ERREUR TECHNIQUE

| Situation                           | Traitement                                           |
| ----------------------------------- | ---------------------------------------------------- |
| Aucune ligne ne correspond          | Cas métier à traiter par `sy-subrc` ou résultat vide |
| Clé dupliquée attendue et acceptée  | Code retour ou variante dédiée                       |
| Violation inattendue ou erreur base | Exception et journal technique                       |
| Nombre de lignes incohérent         | Contrôle avec `sy-dbcnt` et arrêt sécurisé           |

## 🌺 CAS D’USAGE

Dans un contexte où un report doit lire ou mettre à jour des données en limitant le volume transféré et en conservant une transaction cohérente, le besoin consiste à **écrire et vérifier une instruction ABAP SQL utilisant codes retour et exceptions sql sur un jeu de données maîtrisé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
- Lire toutes les colonnes ou toutes les lignes par défaut.
- Effectuer des commits dans une méthode réutilisable sans contrat explicite.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
SELECT SINGLE carrname
  FROM scarr
  WHERE carrid = @p_carrid
  INTO @DATA(lv_name).

IF sy-subrc <> 0.
  MESSAGE 'Transporteur introuvable' TYPE 'I'.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [SQL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-sql>)
- [MANDT](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)
- [Table transparente](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/05 - 🍧 DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [LUW base de données](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire et vérifier une instruction ABAP SQL utilisant codes retour et exceptions sql sur un jeu de données maîtrisé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Predefined Data Objects — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/43e4215eb12c497daaa58382a0411b17/41fd5d4c66654ab99620a5ee2857d9ee.html)
- [CX_SY_OPEN_SQL_DB — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPINSERT_SOURCE.html)
- [ABAP SQL — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_SQL_OVIEW.html)


---

➡️ [Chapitre suivant — LUW, COMMIT WORK ET ROLLBACK WORK](<./17 - 🍧 LUW COMMIT WORK ET ROLLBACK WORK.md>)
