# SÉCURISER LES NOMS DYNAMIQUES

## RÉSULTAT ATTENDU

Empêcher qu’une saisie externe choisisse librement une table, un champ, une classe, une méthode ou un programme exécuté dynamiquement.

## CODE PRÊT À ADAPTER

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

## PROCESS

### Étape 1 — Inventorier les éléments dynamiques

Repérer toutes les constructions dont le nom dépend d’une entrée externe : table, champ, clause, classe, méthode, fonction ou programme.

Identifier ensuite l’origine de la valeur : écran, fichier, RFC, HTTP, paramétrage ou base de données.

### Étape 2 — Supprimer le dynamisme inutile

Remplacer l’expression dynamique par une référence statique lorsque le nombre de cibles est connu et limité. Une branche `CASE` explicite est souvent plus facile à contrôler et à relire qu’un nom exécutable construit à l’exécution.

### Étape 3 — Définir une liste d’autorisation fermée

Lorsque le dynamisme est nécessaire, construire une liste contenant uniquement les noms acceptés. Cette liste doit appartenir au programme ou à un paramétrage protégé par un objet d’autorisation adapté.

Une vérification syntaxique seule ne suffit pas : une table techniquement valide peut rester interdite au scénario fonctionnel.

### Étape 4 — Normaliser puis comparer exactement

Convertir la saisie dans le type et la casse attendus, puis vérifier son appartenance exacte à la liste. Rejeter les valeurs initiales, tronquées ou non reconnues avant l’instruction dynamique.

N’utiliser les utilitaires de validation dynamique disponibles dans la version ABAP du système qu’en complément de la liste fonctionnelle, pas comme remplacement.

### Étape 5 — Appliquer les contrôles métier et les limites de volume

Après validation du nom, exécuter les `AUTHORITY-CHECK` nécessaires. Pour une lecture, imposer les filtres métier et une limite de volume adaptée au scénario.

La validation du nom n’accorde aucune autorisation sur le contenu de l’objet.

### Étape 6 — Tester les entrées hostiles et les cas limites

Tester au minimum :

1. chaque nom autorisé ;
2. un nom existant mais non autorisé ;
3. une valeur initiale ;
4. une casse différente ;
5. une valeur trop longue ou tronquée ;
6. une chaîne contenant des caractères de syntaxe dynamique.

Exécuter ensuite les contrôles `ATC` ou `SCI` de sécurité configurés dans le projet.

## CONTRÔLE

- La liste blanche est définie par le programme, pas par une table modifiable sans protection.
- Les autorisations métier restent vérifiées séparément.
- Une lecture des données doit en plus imposer filtres et limite de volume.

## RÉFÉRENCES OFFICIELLES SAP

- [Dynamic Programming — SAP SE, SAP S/4HANA 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/f72ca4e7ac3b471182783bf8540b0a0a.html)
- [Authorization Checks in Your Own Developments — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/5267167f439b11d1896f0000e8322d00.html)
