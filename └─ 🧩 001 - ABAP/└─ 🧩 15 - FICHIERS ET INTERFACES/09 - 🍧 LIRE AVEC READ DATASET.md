# 🌸 LIRE AVEC `READ DATASET`

## 🌺 OBJECTIFS

- Lire un fichier ligne par ligne
- Distinguer fin de fichier et erreur
- Conserver le numéro de ligne pour le diagnostic

## 🌺 LECTURE TEXTE

```abap
DATA lv_file    TYPE string.
DATA lv_line    TYPE string.
DATA lv_line_no TYPE i.

OPEN DATASET lv_file FOR INPUT IN TEXT MODE ENCODING UTF-8.

DO.
  READ DATASET lv_file INTO lv_line.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  lv_line_no += 1.
  " Validation technique de lv_line
ENDDO.

CLOSE DATASET lv_file.
```

Après chaque lecture réussie, `sy-subrc` vaut `0`. Une valeur différente indique normalement qu’aucune donnée complète supplémentaire n’a été fournie. Les exceptions d’E/S ou de conversion doivent être traitées séparément.

## 🌺 NUMÉRO DE LIGNE

Conserver le numéro de ligne est indispensable pour produire un journal exploitable :

```text
Ligne 17 — champ QUANTITE invalide : ABC
```

Un message générique comme « fichier incorrect » ne permet ni correction rapide ni reprise ciblée.

## 🌺 PARSING

La lecture physique et l’interprétation métier doivent être séparées :

1. lire la ligne ;
2. contrôler le format ;
3. convertir les champs ;
4. appliquer les règles métier ;
5. stocker le résultat valide ou l’erreur.

## 🌺 BONNES PRATIQUES

- Refuser les lignes dépassant une longueur prévue.
- Définir le comportement pour les lignes vides.
- Contrôler l’en-tête avant les données.
- Ne pas arrêter tout le fichier au premier rejet si le contrat autorise un succès partiel.
- Limiter les accès base effectués pour chaque ligne.

## 🌺 VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_file    TYPE string.
DATA lv_line    TYPE string.
DATA lv_line_no TYPE i.

OPEN DATASET lv_file FOR INPUT IN TEXT MODE ENCODING UTF-8.

DO.
  READ DATASET lv_file INTO lv_line.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  lv_line_no += 1.
  " Validation technique de lv_line
ENDDO.

CLOSE DATASET lv_file.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [READ DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_DATASET.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)


---

➡️ [Chapitre suivant — ÉCRIRE AVEC `TRANSFER`](<./10 - 🍧 ECRIRE AVEC TRANSFER.md>)
