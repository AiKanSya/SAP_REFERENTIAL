# 5. OPTIMISER LES TABLES INTERNES

## 5.A RÉSULTAT ATTENDU

Choisir la catégorie de table et la clé adaptées au profil d’accès réel.

## 5.B Choix principal

| Besoin dominant                          | Catégorie recommandée |
| ---------------------------------------- | --------------------- |
| Ajouts séquentiels et parcours complet   | table standard        |
| Accès par clé et parcours ordonné        | table triée           |
| Accès exact très fréquent par clé unique | table hachée          |

```abap
" Accéder à la ligne par une clé adaptée au besoin.
DATA lt_carriers TYPE HASHED TABLE OF scarr
                 WITH UNIQUE KEY carrid.

SELECT carrid,
       carrname,
       currcode,
       url
  FROM scarr
  INTO TABLE @lt_carriers.

DATA(ls_carrier) = VALUE scarr(
  lt_carriers[ carrid = 'LH' ] OPTIONAL ).
```

## 5.C Exploiter les clés

Une table triée ou hachée n’apporte un bénéfice que si l’accès utilise sa clé. Un accès générique ou un parcours complet reste coûteux. Les clés secondaires peuvent accélérer plusieurs profils d’accès, mais augmentent le coût des insertions et modifications.

## 5.D Réduire les copies

Pour modifier une ligne existante, `ASSIGNING` évite la copie vers une zone de travail puis la réécriture :

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
  <ls_item>-amount = <ls_item>-quantity * <ls_item>-price.
ENDLOOP.
```

## 5.E Optimisations à mesurer

- `BINARY SEARCH` exige un tri compatible et reste fragile si la clé change.
- Une table hachée consomme davantage de mémoire qu’une table standard.
- Trier à chaque lecture peut coûter plus cher que le gain attendu.
- Les expressions de table peuvent lever une exception si la ligne est absente.

## 5.F Démarche

Décrire les opérations dominantes, choisir la clé, mesurer sur un volume représentatif, puis vérifier que la structure reste lisible et cohérente avec le modèle métier.

## 5.G PROCESS

### 5.G.1 ÉTAPE 1 — INVENTORIER LES ACCÈS

Pour la table concernée, compter insertions, lectures exactes, lectures partielles, parcours complets, tris et modifications. Relever le volume représentatif. Ne pas choisir la catégorie uniquement à partir de la taille maximale.

### 5.G.2 ÉTAPE 2 — CHOISIR CATÉGORIE ET CLÉ

Utiliser une table standard pour les ajouts et parcours séquentiels, triée pour les accès par préfixe de clé et parcours ordonnés, hachée pour les accès exacts fréquents par clé unique. Déclarer la clé correspondant au besoin métier.

### 5.G.3 ÉTAPE 3 — ADAPTER LES LECTURES

Utiliser les expressions de table, `READ TABLE ... WITH TABLE KEY` ou la clé secondaire appropriée. Traiter explicitement l’absence de ligne avec `OPTIONAL`, `line_exists` ou une gestion d’exception selon le contrat. Ne pas ajouter `BINARY SEARCH` sans tri compatible prouvé.

### 5.G.4 ÉTAPE 4 — RÉDUIRE LES COPIES

Utiliser `ASSIGNING` ou `REFERENCE INTO` lors d’une modification en place. Éviter de copier plusieurs fois une table complète entre méthodes si une interface par référence ou un résultat plus petit suffit. Conserver des références seulement pendant la durée utile.

### 5.G.5 ÉTAPE 5 — MESURER SUR LE PROFIL RÉEL

Créer un test ou benchmark contrôlé avec le volume et le ratio de lectures/écritures attendus. Comparer temps et mémoire de l’ancienne et de la nouvelle structure. Inclure le coût de construction, tri et maintenance des clés secondaires.

### 5.G.6 ÉTAPE 6 — VALIDER LA SÉMANTIQUE

Exécuter les tests sur doublons, ordre, clé initiale, modification de clé et ligne absente. Vérifier qu’une clé unique nouvellement déclarée ne rejette pas des données métier valides et que le résultat reste identique.

## 5.H Références SAP officielles

- [ABAP Keyword Documentation — Internal Tables Performance Notes](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenitab_perfo.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

## 5.I VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 5.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 5.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Traiter la collection sans lecture SQL dans la boucle.
LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
  <ls_item>-amount = <ls_item>-quantity * <ls_item>-price.
ENDLOOP.
```

## 5.L TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 5.M MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.
