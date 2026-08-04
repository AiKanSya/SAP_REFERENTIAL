# 6. CYCLE `OPEN DATASET` ET `CLOSE DATASET`

## 6.A RÉSULTAT ATTENDU

- Maîtriser le cycle d’ouverture et de fermeture
- Choisir un mode d’accès cohérent
- Garantir la fermeture en cas d’erreur

## 6.B CYCLE

```mermaid
flowchart LR
    A["Résoudre le nom"] --> B["OPEN DATASET"]
    B --> C["Lire ou écrire"]
    C --> D["Contrôler les erreurs"]
    D --> E["CLOSE DATASET"]
```

`OPEN DATASET` ouvre un fichier sur le serveur d’application[^terme-fichier-serveur-application]. Le mode choisi conditionne les opérations suivantes.

| Accès           | Usage                                   |
| --------------- | --------------------------------------- |
| `FOR INPUT`     | Lecture                                 |
| `FOR OUTPUT`    | Création ou remplacement                |
| `FOR APPENDING` | Ajout en fin de fichier                 |
| `FOR UPDATE`    | Lecture et écriture avec positionnement |

## 6.C EXEMPLE

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

## 6.D FERMETURE

Fermer explicitement chaque fichier dès que son utilisation est terminée. Une structure locale de traitement ou une méthode[^terme-methode] dédiée limite les chemins de sortie qui oublient `CLOSE DATASET`.

## 6.E PROCESS

### 6.E.1 Étape 1 — Résoudre et valider le nom de fichier

Obtenir un chemin physique absolu à partir d’un nom logique configuré dans `FILE`[^outil-file]. Ne pas construire le chemin par concaténation d’une entrée utilisateur.

### 6.E.2 Étape 2 — Choisir un mode d’ouverture explicite

Déterminer si le traitement lit, crée, remplace ou ajoute des données. Préciser le mode texte ou binaire et, en mode texte, l’encodage[^terme-encodage].

### 6.E.3 Étape 3 — Exécuter `OPEN DATASET`

Ouvrir le fichier dans un bloc qui traite les exceptions d’autorisation et vérifier immédiatement `SY-SUBRC` pour les erreurs d’ouverture signalées par le système d’exploitation.

### 6.E.4 Étape 4 — Effectuer les lectures ou écritures

Traiter chaque résultat de `READ DATASET` ou `TRANSFER`. Borner le volume et interrompre la boucle sur la condition de fin prévue.

### 6.E.5 Étape 5 — Fermer le dataset sur chaque chemin réussi

Appeler `CLOSE DATASET` dès que le traitement est terminé. Structurer les retours et exceptions afin qu’une ouverture réussie ne laisse pas le fichier ouvert.

### 6.E.6 Étape 6 — Tester le cycle complet

Tester l’ouverture réussie, le fichier absent, le refus d’autorisation, l’erreur d’écriture et l’arrêt anticipé. Vérifier ensuite que le fichier peut être rouvert normalement.

## 6.F VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 6.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 6.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 6.I TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)
- [Error Handling for OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_ERROR_HANDLING.html)

---

[Chapitre suivant — FICHIERS TEXTE ET MODES D’ACCÈS](<./07 ├── FICHIERS TEXTE ET MODES D ACCES.md>)

[^terme-fichier-serveur-application]: **SERVEUR D’APPLICATION.** Emplacement du backend où un programme ABAP peut lire ou écrire avec `OPEN DATASET`. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-file]: **FILE.** Transaction de maintenance des noms et chemins de fichiers logiques. Voir [le chapitre associé](<04 ├── NOMS ET CHEMINS LOGIQUES AVEC FILE.md>).
