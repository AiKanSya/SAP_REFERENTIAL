# 17. CONSTRUIRE ET LIRE DES FICHIERS CSV

## 17.A RÉSULTAT ATTENDU

- Comprendre les règles d’échappement
- Produire un format non ambigu
- Éviter les découpages naïfs

## 17.B CONTRAT CSV

CSV[^terme-csv] n’impose pas un séparateur unique dans tous les usages. Le contrat doit préciser :

- séparateur `,`, `;` ou tabulation ;
- caractère de citation, généralement `"` ;
- échappement des citations par doublement ;
- encodage[^terme-encodage] ;
- présence d’un en-tête ;
- format des dates et nombres ;
- représentation des valeurs vides.

## 17.C ÉCHAPPEMENT

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS lcl_csv DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS escape
      IMPORTING iv_value        TYPE string
      RETURNING VALUE(rv_value) TYPE string.
ENDCLASS.

CLASS lcl_csv IMPLEMENTATION.
  METHOD escape.
    rv_value = iv_value.
    REPLACE ALL OCCURRENCES OF '"' IN rv_value WITH '""'.

    IF rv_value CS ';'
       OR rv_value CS '"'
       OR rv_value CS cl_abap_char_utilities=>newline.
      rv_value = |"{ rv_value }"|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
```

Une valeur `Produit; spécial` devient `"Produit; spécial"`. Une citation interne est doublée.

## 17.D LECTURE

`SPLIT line AT ';'` est insuffisant dès qu’un champ cité contient le séparateur ou une fin de ligne. Pour un CSV complet :

- utiliser un parseur validé ;
- ou implémenter une machine à états tenant compte des citations ;
- ou imposer contractuellement un format plus simple sans champs multiligne.

## 17.E DONNÉES MÉTIER

Écrire les nombres avec un séparateur décimal invariant[^terme-invariant] et les dates dans un format non ambigu, par exemple `YYYY-MM-DD`. Ne pas utiliser directement la présentation locale de l’utilisateur.

## 17.F PROCESS

### 17.F.1 Étape 1 — Fixer le dialecte CSV

Documenter le séparateur, le caractère d’encadrement, la règle d’échappement, l’encodage, la présence d’un en-tête et la convention de fin de ligne.

### 17.F.2 Étape 2 — Sérialiser chaque champ

Convertir la valeur métier dans son format d’échange. Encadrer un champ lorsque son contenu contient le séparateur, un guillemet ou une fin de ligne, puis doubler les guillemets selon le dialecte retenu.

### 17.F.3 Étape 3 — Construire la ligne complète

Assembler les champs déjà échappés avec le séparateur. Ne pas concaténer des valeurs brutes directement dans la ligne finale.

### 17.F.4 Étape 4 — Écrire avec l’encodage convenu

Ouvrir le dataset en mode texte avec l’encodage contractuel, transférer l’en-tête puis les lignes, traiter les erreurs et fermer le fichier.

### 17.F.5 Étape 5 — Analyser avec un parseur adapté

En lecture, ne pas utiliser un simple `SPLIT` si les champs peuvent contenir le séparateur ou des retours à la ligne. Utiliser une API[^terme-api] disponible sur le système ou implémenter un analyseur à états conforme au dialecte.

### 17.F.6 Étape 6 — Valider la structure importée

Contrôler le nombre de colonnes, les noms d’en-tête, les conversions de types et le volume avant d’appeler la logique métier.

### 17.F.7 Étape 7 — Exécuter les cas de test discriminants

Tester un champ vide, un séparateur dans une valeur, un guillemet, une fin de ligne intégrée, des caractères non ASCII et une ligne mal formée.

## 17.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 17.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend[^terme-frontend] et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 17.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Définir le contrat et limiter l’API publique au besoin réel.
CLASS lcl_csv DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS escape
      IMPORTING iv_value        TYPE string
      RETURNING VALUE(rv_value) TYPE string.
ENDCLASS.

CLASS lcl_csv IMPLEMENTATION.
  METHOD escape.
    rv_value = iv_value.
    REPLACE ALL OCCURRENCES OF '"' IN rv_value WITH '""'.

    IF rv_value CS ';'
       OR rv_value CS '"'
       OR rv_value CS cl_abap_char_utilities=>newline.
      rv_value = |"{ rv_value }"|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
```

## 17.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 17.K RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)

---

[Chapitre suivant — FICHIERS À LARGEUR FIXE](<./18 ├── FICHIERS A LARGEUR FIXE.md>)

[^terme-csv]: **CSV.** Format texte tabulaire utilisant un séparateur de champs et des règles d’échappement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>).
[^terme-encodage]: **ENCODAGE.** Règle transformant les caractères en octets et inversement. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>).
[^terme-invariant]: **INVARIANT.** Condition qui doit rester vraie pendant toute la durée de vie valide d’un objet. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#invariant>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-frontend]: **FRONTEND.** Poste ou couche cliente utilisée par l’utilisateur, par exemple SAP GUI for Windows. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#frontend>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
