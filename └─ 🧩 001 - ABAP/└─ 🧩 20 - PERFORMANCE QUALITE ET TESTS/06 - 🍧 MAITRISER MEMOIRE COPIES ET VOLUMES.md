# 🌸 MAITRISER MEMOIRE COPIES ET VOLUMES

## 🌺 Objectif

Limiter la consommation mémoire sans introduire de libérations prématurées ou de code obscur.

## 🌺 Principales sources de consommation

- tables internes volumineuses ;
- copies de structures ou de tables ;
- références maintenant des objets accessibles ;
- caches globaux non bornés ;
- résultats SQL surdimensionnés ;
- transformations créant plusieurs versions complètes des mêmes données.

## 🌺 Copier ou référencer

```abap
LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
  " Accès direct à la ligne
ENDLOOP.
```

`ASSIGNING` ou `REFERENCE INTO` peut réduire les copies. La référence ne doit toutefois pas survivre inutilement au contexte qui possède les données.

## 🌺 CLEAR et FREE

- `CLEAR` remet une variable à sa valeur initiale.
- `FREE` libère aussi les ressources dynamiques associées lorsque cela est pertinent.
- La fin de portée libère normalement les données locales ; ajouter `FREE` partout n’est pas une stratégie d’optimisation.

```abap
FREE lt_large_result.
```

Cette instruction est utile lorsqu’une grande table n’est plus nécessaire alors que le traitement continue longtemps.

## 🌺 Mesurer avec le Memory Inspector

Comparer deux snapshots : avant le chargement, après le traitement et éventuellement après libération. Examiner les catégories mémoire et les chemins de référence qui empêchent la collecte.

```mermaid
flowchart LR
    A["Snapshot initial"] --> B["Traitement volumineux"]
    B --> C["Snapshot après traitement"]
    C --> D["Comparaison des objets"]
```

## 🌺 Priorité

Réduire d’abord le volume lu et conservé. Une micro-optimisation de quelques structures ne compense pas une extraction inutile de millions de lignes.

## 🌺 Références SAP officielles

- [SAP Help Portal — Memory Inspector Concepts](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/8884fb5269d34838a1f119b41dcdbc57.html)
- [SAP Help Portal — ABAP Performance and Tuning](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353523595.html)
- [ABAP Keyword Documentation — Internal Tables Performance Notes](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abenitab_perfo.html)

## 🌺 CAS D’USAGE

Dans un contexte où un programme critique doit conserver ses résultats tout en respectant les exigences de performance, qualité et non-régression, le besoin consiste à **appliquer maitriser memoire copies et volumes pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
  " Accès direct à la ligne
ENDLOOP.
```

## 🌺 TERMES DU LEXIQUE

- [ATC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-abap>)
- [Trace](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **appliquer maitriser memoire copies et volumes pour mesurer, contrôler et sécuriser la qualité d’une livraison ABAP**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.


---

➡️ [Chapitre suivant — MESURER LE TEMPS D EXECUTION AVEC SAT](<./07 - 🍧 MESURER LE TEMPS D EXECUTION AVEC SAT.md>)
