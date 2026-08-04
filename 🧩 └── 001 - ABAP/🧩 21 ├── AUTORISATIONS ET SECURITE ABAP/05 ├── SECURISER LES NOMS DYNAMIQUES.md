# 5. SÉCURISER LES NOMS DYNAMIQUES

## 5.A RÉSULTAT ATTENDU

Empêcher qu’une saisie externe choisisse librement une table, un champ, une classe[^terme-classe], une méthode[^terme-methode] ou un programme exécuté dynamiquement.

## 5.B CODE PRÊT À ADAPTER

```abap
TYPES ty_allowed_table TYPE c LENGTH 30.
DATA lt_allowed_tables TYPE HASHED TABLE OF ty_allowed_table WITH UNIQUE KEY table_line.
lt_allowed_tables = VALUE #( ( 'ZDEMO_HEADER' ) ( 'ZDEMO_ITEM' ) ).

DATA(lv_table_name) = CONV ty_allowed_table( to_upper( val = p_table ) ).
IF NOT line_exists( lt_allowed_tables[ table_line = lv_table_name ] ).
  MESSAGE e001(zdemo) WITH lv_table_name.
ENDIF.

" Le nom dynamique est désormais limité à une liste maîtrisée par le programme.
SELECT COUNT(*) FROM (lv_table_name)
  INTO @DATA(lv_count).
```

## 5.C PROCESS

### 5.C.1 Étape 1 — Inventorier les éléments dynamiques

Repérer toutes les constructions dont le nom dépend d’une entrée externe : table, champ, clause, classe, méthode, fonction ou programme.

Identifier ensuite l’origine de la valeur : écran, fichier, RFC[^terme-rfc], HTTP, paramétrage ou base de données.

### 5.C.2 Étape 2 — Supprimer le dynamisme inutile

Remplacer l’expression dynamique par une référence statique lorsque le nombre de cibles est connu et limité. Une branche `CASE` explicite est souvent plus facile à contrôler et à relire qu’un nom exécutable construit à l’exécution.

### 5.C.3 Étape 3 — Définir une liste d’autorisation fermée

Lorsque le dynamisme est nécessaire, construire une liste contenant uniquement les noms acceptés. Cette liste doit appartenir au programme ou à un paramétrage protégé par un objet d’autorisation[^terme-objet-autorisation] adapté.

Une vérification syntaxique seule ne suffit pas : une table techniquement valide peut rester interdite au scénario fonctionnel.

### 5.C.4 Étape 4 — Normaliser puis comparer exactement

Convertir la saisie dans le type et la casse attendus, puis vérifier son appartenance exacte à la liste. Rejeter les valeurs initiales, tronquées ou non reconnues avant l’instruction dynamique.

N’utiliser les utilitaires de validation dynamique disponibles dans la version ABAP[^terme-abap] du système qu’en complément de la liste fonctionnelle, pas comme remplacement.

### 5.C.5 Étape 5 — Appliquer les contrôles métier et les limites de volume

Après validation du nom, exécuter les `AUTHORITY-CHECK` nécessaires. Pour une lecture, imposer les filtres métier et une limite de volume adaptée au scénario.

La validation du nom n’accorde aucune autorisation sur le contenu de l’objet.

### 5.C.6 Étape 6 — Tester les entrées hostiles et les cas limites

Tester au minimum :

1. chaque nom autorisé ;
2. un nom existant mais non autorisé ;
3. une valeur initiale ;
4. une casse différente ;
5. une valeur trop longue ou tronquée ;
6. une chaîne contenant des caractères de syntaxe dynamique.

Exécuter ensuite les contrôles `ATC`[^terme-acro-atc] ou `SCI`[^outil-sci] de sécurité configurés dans le projet.

## 5.D CONTRÔLE

- La liste blanche est définie par le programme, pas par une table modifiable sans protection.
- Les autorisations métier restent vérifiées séparément.
- Une lecture des données doit en plus imposer filtres et limite de volume.

## 5.E RÉFÉRENCES OFFICIELLES SAP

- [Dynamic Programming — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/f72ca4e7ac3b471182783bf8540b0a0a.html)
- [Authorization Checks in Your Own Developments — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-rfc]: **RFC.** Remote Function Call, mécanisme permettant d’appeler un module fonction compatible dans un autre contexte ou système. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#rfc>).
[^terme-objet-autorisation]: **OBJET D’AUTORISATION.** Structure de contrôle contenant des champs vérifiés lors d’une action. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#objet-autorisation>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).

[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<../🧩 20 ├── PERFORMANCE QUALITE ET TESTS/13 ├── CODE INSPECTOR AVEC SCI.md>).
