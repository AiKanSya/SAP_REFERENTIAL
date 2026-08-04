# 4. OPTIMISER LES ACCES ABAP SQL

## 4.A RÉSULTAT ATTENDU

Réduire le nombre d’accès, le volume transféré et le travail inutile demandé à la base de données.

## 4.B Règles prioritaires

- Lire uniquement les colonnes nécessaires.
- Filtrer le plus tôt possible avec `WHERE`.
- Éviter les `SELECT` unitaires répétés dans une boucle.
- Utiliser les jointures et agrégations lorsque la base peut effectuer le travail.
- Définir un ordre explicite uniquement lorsqu’il est fonctionnellement requis.
- Vérifier les résultats avec `ST05` ou `SQLM`.

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
SELECT carrid,
       connid,
       fldate,
       seatsocc
  FROM sflight
  WHERE carrid = @p_carrid
    AND fldate BETWEEN @p_date_low AND @p_date_high
  INTO TABLE @DATA(lt_flights).
```

## 4.C Anti-pattern : accès dans une boucle

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
LOOP AT lt_keys INTO DATA(ls_key).
  SELECT SINGLE carrname
    FROM scarr
    WHERE carrid = @ls_key-carrid
    INTO @DATA(lv_name).
ENDLOOP.
```

Une alternative consiste à lire l’ensemble nécessaire en une fois, puis à utiliser une table interne avec une clé adaptée.

## 4.D Volume et sémantique

`SELECT SINGLE` exprime la lecture d’une ligne selon la condition fournie. `UP TO 1 ROWS` avec `ORDER BY` exprime la sélection de la première ligne selon un ordre défini. Ils ne sont pas interchangeables par simple préférence de style.

## 4.E Optimisations dépendantes du contexte

Les index, buffers et plans d’accès dépendent des tables, de la base et de la distribution des données. Ne pas proposer un nouvel index sans trace, volumétrie et validation avec l’équipe responsable de la base.

## 4.F Validation

Après modification, comparer : nombre d’exécutions, temps cumulé, lignes examinées, lignes transférées et résultat fonctionnel.

## 4.G Références SAP officielles

- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [SAP Help Portal — SQL Trace Analysis](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/d1801f89454211d189710000e8322d00.html)
- [SAP Help Portal — SQL Monitor](https://help.sap.com/docs/ABAP_PLATFORM_NEW/a24970c68fcf4770a64bf9a78e3719e2/1ec2329419b64f3992a9c342437d3a0f.html)

## 4.H PROCESS

### 4.H.1 ÉTAPE 1 — CAPTURER LE SQL RÉEL

Dans `ST05`, tracer un utilisateur et un scénario courts. Désactiver immédiatement puis regrouper les instructions identiques. Relever le SQL dominant, sa source ABAP, son nombre d’exécutions, ses lignes et son temps cumulé.

### 4.H.2 ÉTAPE 2 — VÉRIFIER LA SÉLECTION

Examiner champs sélectionnés, prédicats, jointures et cardinalité. Remplacer `SELECT *` lorsque seules quelques colonnes sont nécessaires et pousser les filtres stables vers la base. Préserver la sémantique des valeurs initiales et des clients.

### 4.H.3 ÉTAPE 3 — SUPPRIMER LES ALLERS-RETOURS RÉPÉTITIFS

Rechercher les `SELECT` dans des boucles et les lectures unitaires répétées. Regrouper par jointure, expression SQL ou lecture en masse lorsque les volumes et la logique le permettent. Ne pas charger toute une table pour éviter quelques requêtes ciblées.

### 4.H.4 ÉTAPE 4 — ALIGNER ACCÈS ET CLÉS

Vérifier dans le DDIC et le plan d’accès les champs exploitables par la clé ou les index existants. Ajuster les prédicats avant d’envisager un nouvel index, décision qui doit être analysée avec l’administration base et les impacts d’écriture.

### 4.H.5 ÉTAPE 5 — TESTER LES VOLUMES ET CAS LIMITES

Exécuter données absentes, une ligne, nombreuses lignes, plages initiales et valeurs dupliquées. Vérifier ordre, agrégats et doublons après une nouvelle jointure ou un `FOR ALL ENTRIES`. Protéger explicitement une table de sélection vide lorsque cette construction est utilisée.

### 4.H.6 ÉTAPE 6 — REJOUER `ST05`

Tracer exactement le même scénario et comparer exécutions, lignes, temps cumulé et résultat fonctionnel. Valider le gain sur un volume représentatif et exécuter ATC/tests avant livraison.

## 4.I VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 4.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 4.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Mesurer la requête avec un volume représentatif avant de l’optimiser.
SELECT carrid,
       connid,
       fldate,
       seatsocc
  FROM sflight
  WHERE carrid = @p_carrid
    AND fldate BETWEEN @p_date_low AND @p_date_high
  INTO TABLE @DATA(lt_flights).
```

## 4.L TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 4.M MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.
