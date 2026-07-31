# 🌸 OPTIMISER LES TABLES INTERNES

## 🌺 Objectif

Choisir la catégorie de table et la clé adaptées au profil d’accès réel.

## 🌺 Choix principal

| Besoin dominant                          | Catégorie recommandée |
| ---------------------------------------- | --------------------- |
| Ajouts séquentiels et parcours complet   | table standard        |
| Accès par clé et parcours ordonné        | table triée           |
| Accès exact très fréquent par clé unique | table hachée          |

```abap
DATA lt_carriers TYPE HASHED TABLE OF scarr
                 WITH UNIQUE KEY carrid.

SELECT *
  FROM scarr
  INTO TABLE @lt_carriers.

READ TABLE lt_carriers
  WITH TABLE KEY carrid = 'LH'
  INTO DATA(ls_carrier).
```

## 🌺 Exploiter les clés

Une table triée ou hachée n’apporte un bénéfice que si l’accès utilise sa clé. Un accès générique ou un parcours complet reste coûteux. Les clés secondaires peuvent accélérer plusieurs profils d’accès, mais augmentent le coût des insertions et modifications.

## 🌺 Réduire les copies

Pour modifier une ligne existante, `ASSIGNING` évite la copie vers une zone de travail puis la réécriture :

```abap
LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
  <ls_item>-amount = <ls_item>-quantity * <ls_item>-price.
ENDLOOP.
```

## 🌺 Optimisations à mesurer

- `BINARY SEARCH` exige un tri compatible et reste fragile si la clé change.
- Une table hachée consomme davantage de mémoire qu’une table standard.
- Trier à chaque lecture peut coûter plus cher que le gain attendu.
- Les expressions de table peuvent lever une exception si la ligne est absente.

## 🌺 Démarche

Décrire les opérations dominantes, choisir la clé, mesurer sur un volume représentatif, puis vérifier que la structure reste lisible et cohérente avec le modèle métier.

## 🌺 Références SAP officielles

- [ABAP Keyword Documentation — Internal Tables Performance Notes](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenitab_perfo.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)

## 🌺 CAS D’USAGE

Dans un contexte où un programme critique doit conserver ses résultats tout en respectant les exigences de performance, qualité et non-régression, le besoin consiste à **appliquer optimiser les tables internes pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
  <ls_item>-amount = <ls_item>-quantity * <ls_item>-price.
ENDLOOP.
```

## 🌺 TERMES DU LEXIQUE

- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer optimiser les tables internes pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — MAITRISER MEMOIRE COPIES ET VOLUMES](<./06 - 🍧 MAITRISER MEMOIRE COPIES ET VOLUMES.md>)

## 🌺 MODÈLE DE DÉMONSTRATION SFLIGHT

> [!NOTE]
> Les tables `SCARR`, `SPFLI` et `SFLIGHT` appartiennent au modèle de démonstration SAP et peuvent être absentes ou non alimentées dans certains systèmes. Dans ce cas, remplacer les exemples par une table Z de démonstration ou par une source en lecture seule autorisée, sans modifier une table applicative standard.

