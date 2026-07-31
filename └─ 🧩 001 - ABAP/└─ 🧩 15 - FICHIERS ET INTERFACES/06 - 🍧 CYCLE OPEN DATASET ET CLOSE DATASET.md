# 🌸 CYCLE `OPEN DATASET` ET `CLOSE DATASET`

## 🌺 OBJECTIFS

- Maîtriser le cycle d’ouverture et de fermeture
- Choisir un mode d’accès cohérent
- Garantir la fermeture en cas d’erreur

## 🌺 CYCLE

```mermaid
flowchart LR
    A["Résoudre le nom"] --> B["OPEN DATASET"]
    B --> C["Lire ou écrire"]
    C --> D["Contrôler les erreurs"]
    D --> E["CLOSE DATASET"]
```

`OPEN DATASET` ouvre un fichier sur le serveur d’application. Le mode choisi conditionne les opérations suivantes.

| Accès           | Usage                                   |
| --------------- | --------------------------------------- |
| `FOR INPUT`     | Lecture                                 |
| `FOR OUTPUT`    | Création ou remplacement                |
| `FOR APPENDING` | Ajout en fin de fichier                 |
| `FOR UPDATE`    | Lecture et écriture avec positionnement |

## 🌺 EXEMPLE

```abap
DATA lv_file TYPE string VALUE '/interface/in/products.csv'.
DATA lv_line TYPE string.

TRY.
    OPEN DATASET lv_file
      FOR INPUT
      IN TEXT MODE
      ENCODING UTF-8.

    DO.
      READ DATASET lv_file INTO lv_line.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      " Traitement de la ligne
    ENDDO.

    CLOSE DATASET lv_file.
  CATCH cx_sy_file_open
        cx_sy_file_authority
        cx_sy_file_io INTO DATA(lx_file).
    CLOSE DATASET lv_file.
    MESSAGE lx_file->get_text( ) TYPE 'E'.
ENDTRY.
```

La liste exacte des exceptions dépend de l’instruction et du mode. Elle doit être contrôlée dans la documentation de la version cible.

## 🌺 FERMETURE

Fermer explicitement chaque fichier dès que son utilisation est terminée. Une structure locale de traitement ou une méthode dédiée limite les chemins de sortie qui oublient `CLOSE DATASET`.

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **ouvrir un fichier serveur dans le mode et l’encodage attendus**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

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
DATA lv_file TYPE string VALUE '/interface/in/products.csv'.
DATA lv_line TYPE string.

TRY.
    OPEN DATASET lv_file
      FOR INPUT
      IN TEXT MODE
      ENCODING UTF-8.

    DO.
      READ DATASET lv_file INTO lv_line.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      " Traitement de la ligne
    ENDDO.

    CLOSE DATASET lv_file.
  CATCH cx_sy_file_open
        cx_sy_file_authority
        cx_sy_file_io INTO DATA(lx_file).
    CLOSE DATASET lv_file.
    MESSAGE lx_file->get_text( ) TYPE 'E'.
ENDTRY.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **ouvrir un fichier serveur dans le mode et l’encodage attendus**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)
- [Error Handling for OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_ERROR_HANDLING.html)


---

➡️ [Chapitre suivant — FICHIERS TEXTE ET MODES D’ACCÈS](<./07 - 🍧 FICHIERS TEXTE ET MODES D ACCES.md>)
