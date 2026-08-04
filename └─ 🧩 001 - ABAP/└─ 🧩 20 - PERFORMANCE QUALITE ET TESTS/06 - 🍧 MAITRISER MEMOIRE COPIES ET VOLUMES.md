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
