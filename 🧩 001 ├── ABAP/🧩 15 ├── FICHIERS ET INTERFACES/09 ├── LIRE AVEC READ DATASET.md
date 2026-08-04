# 9. LIRE AVEC `READ DATASET`

## 9.A RÉSULTAT ATTENDU

- Lire un fichier ligne par ligne
- Distinguer fin de fichier et erreur
- Conserver le numéro de ligne pour le diagnostic

## 9.B LECTURE TEXTE

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

## 9.C NUMÉRO DE LIGNE

Conserver le numéro de ligne est indispensable pour produire un journal exploitable :

```text
Ligne 17 — champ QUANTITE invalide : ABC
```

Un message générique comme « fichier incorrect » ne permet ni correction rapide ni reprise ciblée.

## 9.D PARSING

La lecture physique et l’interprétation métier doivent être séparées :

1. lire la ligne ;
2. contrôler le format ;
3. convertir les champs ;
4. appliquer les règles métier ;
5. stocker le résultat valide ou l’erreur.

## 9.E BONNES PRATIQUES

- Refuser les lignes dépassant une longueur prévue.
- Définir le comportement pour les lignes vides.
- Contrôler l’en-tête avant les données.
- Ne pas arrêter tout le fichier au premier rejet si le contrat autorise un succès partiel.
- Limiter les accès base effectués pour chaque ligne.

## 9.F PROCESS

### 9.F.1 Étape 1 — Ouvrir le fichier dans le mode correspondant au contrat

Résoudre le nom logique, puis utiliser `OPEN DATASET ... FOR INPUT` avec le mode texte ou binaire prévu. Ne pas commencer la boucle si l’ouverture a échoué.

### 9.F.2 Étape 2 — Initialiser la zone de lecture

Employer un `STRING` pour une ligne texte ou une zone binaire adaptée pour un bloc. Définir une taille maximale afin d’éviter une allocation non bornée.

### 9.F.3 Étape 3 — Lire et tester immédiatement `SY-SUBRC`

Appeler `READ DATASET`, puis distinguer une lecture réussie de la fin de fichier. Ne pas traiter le contenu de la zone lorsque la lecture n’a rien retourné.

### 9.F.4 Étape 4 — Valider avant d’accumuler

Contrôler la longueur, le format et le nombre de colonnes ou d’octets. Rejeter ou journaliser la ligne selon la stratégie d’erreur définie, sans recopier des données sensibles inutiles.

### 9.F.5 Étape 5 — Borner la boucle

Compter les lignes ou les octets lus et arrêter le traitement lorsque la limite applicative est atteinte. La fin de fichier ne doit pas être la seule protection contre un volume excessif.

### 9.F.6 Étape 6 — Fermer et restituer un bilan

Fermer le dataset, puis retourner les nombres de lignes acceptées, rejetées et non traitées. Tester un fichier vide, une dernière ligne sans séparateur et une ligne invalide.

## 9.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage[^terme-encodage] correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 9.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV[^terme-csv] par simple séparation alors que les champs peuvent être échappés.

## 9.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 9.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 9.K RÉFÉRENCES OFFICIELLES SAP

- [READ DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_DATASET.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)

---

[Chapitre suivant — ÉCRIRE AVEC `TRANSFER`](<./10 ├── ECRIRE AVEC TRANSFER.md>)

[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
