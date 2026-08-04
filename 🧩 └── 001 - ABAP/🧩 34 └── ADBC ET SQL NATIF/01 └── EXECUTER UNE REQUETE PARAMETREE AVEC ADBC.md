# EXÉCUTER UNE REQUÊTE PARAMÉTRÉE AVEC ADBC

## RÉSULTAT ATTENDU

Lire une donnée avec une instruction SQL native sans concaténer les valeurs dans le texte SQL, en gérant explicitement le mandant et les erreurs de base de données.

L’exemple compte les sociétés de `T001` correspondant au mandant courant et à une société donnée.

## QUAND UTILISER ADBC

Utiliser ADBC uniquement lorsqu’ABAP SQL ne couvre pas le besoin technique, par exemple pour une fonction spécifique à SAP HANA validée par l’architecture.

Ne pas utiliser ADBC pour une sélection ordinaire. L’équivalent ABAP SQL est plus portable, applique automatiquement les règles ABAP du mandant et s’intègre mieux aux contrôles statiques.

## PRÉREQUIS

- Système SAP S/4HANA avec accès à la classe `CL_SQL_STATEMENT`.
- Autorisation de lecture de l’objet métier concerné ; ADBC ne remplace aucun `AUTHORITY-CHECK`.
- Table et colonnes connues sur la base cible.
- Justification documentée de l’emploi de SQL natif.

## RISQUE À CONNAÎTRE

ADBC exécute du SQL natif. Le traitement automatique du mandant d’ABAP SQL ne s’applique pas. Pour une table dépendante du mandant, la colonne `MANDT` doit donc être filtrée explicitement.

Les noms de tables et de colonnes ne peuvent pas être remplacés par les marqueurs `?`. S’ils doivent être dynamiques, ils doivent provenir d’une liste blanche contrôlée.

## CODE PRÊT À ADAPTER

```abap
REPORT zdemo_adbc_parameter.

PARAMETERS p_bukrs TYPE bukrs OBLIGATORY DEFAULT '1000'.

START-OF-SELECTION.
  DATA lv_mandt TYPE mandt VALUE sy-mandt.
  DATA lv_bukrs TYPE bukrs VALUE p_bukrs.
  DATA lv_count TYPE int8.

  DATA lo_result TYPE REF TO cl_sql_result_set.

  TRY.
      DATA(lo_statement) = NEW cl_sql_statement( ).

      "Les appels SET_PARAM suivent exactement l’ordre des marqueurs ?.
      lo_statement->set_param( REF #( lv_mandt ) ).
      lo_statement->set_param( REF #( lv_bukrs ) ).

      lo_result = lo_statement->execute_query(
        `SELECT COUNT(*)`
        && ` FROM T001`
        && ` WHERE MANDT = ?`
        && ` AND BUKRS = ?` ).

      "Le paramètre de sortie reçoit la première colonne de la ligne lue.
      lo_result->set_param( REF #( lv_count ) ).

      IF lo_result->next( ) <> 1.
        lo_result->close( ).
        CLEAR lo_result.
        MESSAGE 'La requête COUNT ne retourne aucune ligne' TYPE 'E'.
      ENDIF.

      lo_result->close( ).
      CLEAR lo_result.

      WRITE: / |Société { lv_bukrs } trouvée : { lv_count }|.

    CATCH cx_sql_exception INTO DATA(lx_sql).
      "Dans un programme productif, écrire le détail technique dans un journal
      "et présenter à l’utilisateur un message fonctionnel contrôlé.
      IF lo_result IS BOUND.
        TRY.
            lo_result->close( ).
          CATCH cx_sql_exception.
            "Le premier défaut SQL reste le diagnostic principal.
        ENDTRY.
      ENDIF.

      MESSAGE lx_sql TYPE 'E'.
  ENDTRY.
```

## VERSION ABAP SQL À PRIVILÉGIER

Pour ce besoin précis, le code suivant suffit et doit être préféré :

```abap
SELECT COUNT(*)
  FROM t001
  WHERE bukrs = @p_bukrs
  INTO @DATA(lv_count).
```

ABAP SQL ajoute le traitement du mandant selon les règles de la source concernée. Ne recopier la variante ADBC que si le besoin natif est réel.

## POINTS À REMPLACER

| Élément | Remplacement attendu |
|---|---|
| `ZDEMO_ADBC_PARAMETER` | Nom du programme client |
| `T001` | Table ou vue réellement nécessaire |
| `MANDT`, `BUKRS` | Colonnes de la table cible |
| `LV_MANDT`, `LV_BUKRS` | Variables dont les types correspondent aux colonnes |
| Instruction SQL | Syntaxe native supportée par la base S/4HANA cible |

## ORDRE DES PARAMÈTRES

Pour l’instruction suivante :

```sql
WHERE MANDT = ? AND BUKRS = ?
```

le premier `SET_PARAM` lie `LV_MANDT` et le deuxième lie `LV_BUKRS`. Une inversion peut produire un résultat faux ou une erreur de conversion.

## CONTRÔLE POSITIF

1. Exécuter le programme avec une société existante dans le mandant courant.
2. Vérifier que `LV_COUNT = 1` pour une clé unique existante.
3. Exécuter la variante ABAP SQL avec la même valeur.
4. Comparer les résultats.
5. Mesurer avec `ST05` uniquement si ADBC répond à un motif de performance démontré.

## CONTRÔLE NÉGATIF

1. Tester une société inexistante : `LV_COUNT` doit valoir `0`.
2. Remplacer temporairement un nom de colonne dans un système de développement : `CX_SQL_EXCEPTION` doit être interceptée.
3. Vérifier qu’une valeur contenant des caractères SQL reste une valeur de paramètre et ne modifie pas l’instruction.

## ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Données d’un autre mandant | Filtre `MANDT` absent | Ajouter un marqueur et lier `SY-MANDT` avec une variable typée |
| Résultat vide malgré une donnée existante | Ordre des `SET_PARAM` incorrect | Aligner chaque liaison sur l’ordre des `?` |
| Erreur de conversion | Type ABAP incompatible avec la colonne SQL | Utiliser un type DDIC correspondant |
| Injection SQL possible | Valeur concaténée dans le texte SQL | Utiliser un marqueur `?` et `SET_PARAM` |
| Injection par nom d’objet | Nom de table ou colonne fourni librement | Appliquer une liste blanche fermée |
| Curseur ou ressource conservée | `CLOSE` non exécuté | Fermer le result set après lecture et dans le traitement d’erreur |
| Comportement différent selon la base | SQL natif spécifique au fournisseur | Documenter la dépendance et tester sur SAP HANA cible |
| Autorisation métier contournée | ADBC considéré comme un contrôle d’accès | Exécuter les mêmes contrôles métier avant la lecture |

## COMPATIBILITÉ S/4HANA

- Statut : compatible mais spécialisé.
- ADBC reste dépendant du dialecte de la base de données.
- Sur SAP S/4HANA, valider la syntaxe avec SAP HANA et les règles du projet.
- ABAP Cloud et Clean Core sont hors périmètre de ce chapitre et peuvent interdire ou restreindre cette API.

## RÉFÉRENCES OFFICIELLES SAP

- [ADBC — SAP Help Portal](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenadbc.htm)
- [CL_SQL_STATEMENT — SAP Help Portal](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abencl_sql_statement.htm)
- [SQL Injections Using ADBC — SAP Help Portal](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abensql_inj_adbc_scrty.htm)
