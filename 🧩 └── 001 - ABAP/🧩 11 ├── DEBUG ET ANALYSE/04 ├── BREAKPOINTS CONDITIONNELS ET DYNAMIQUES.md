# BREAKPOINTS CONDITIONNELS ET DYNAMIQUES

## RÉSULTAT ATTENDU

- Arrêter l’exécution uniquement dans le cas utile
- Utiliser une condition pour éviter des milliers d’arrêts
- Poser un breakpoint sur une instruction ou un événement
- Réduire le coût d’analyse d’un traitement volumineux

## BREAKPOINT CONDITIONNEL

Un breakpoint conditionnel n’interrompt l’exécution que lorsque son expression est vraie.

Exemples de conditions :

```abap
lv_matnr = '000000000000006200'
sy-subrc <> 0
lines( lt_items ) > 1000
```

La condition doit être :

- simple ;
- sans effet de bord ;
- basée sur des données disponibles à cet emplacement ;
- assez sélective pour éviter des arrêts inutiles.

## CAS D USAGE

```mermaid
flowchart TD
    A["Boucle de 100 000 lignes"] --> B["Condition sur la clé recherchée"]
    B --> C["Breakpoint uniquement sur la ligne utile"]
    C --> D["Analyse du contexte précis"]
```

Un breakpoint non conditionnel placé dans une boucle massive rend l’analyse lente et peut immobiliser inutilement le traitement.

## BREAKPOINT SUR UNE INSTRUCTION ABAP

Le débogueur permet de demander un arrêt lorsqu’une instruction particulière est rencontrée, par exemple :

- `MESSAGE` ;
- `AUTHORITY-CHECK` ;
- `CALL FUNCTION` ;
- `COMMIT WORK` ;
- `SELECT` selon les possibilités de la version.

Cette technique est utile lorsque le programme source exact n’est pas connu.

## BREAKPOINT SUR UN MESSAGE

Lorsque l’application émet un message précis, un breakpoint sur l’instruction ou les attributs du message permet de remonter vers l’endroit qui le déclenche.

Données utiles :

- classe de messages ;
- numéro ;
- type ;
- variables `sy-msgv1` à `sy-msgv4`.

## BREAKPOINT SUR UNE MÉTHODE OU UN MODULE FONCTION

Selon les outils disponibles, un breakpoint dynamique peut cibler :

- une méthode ;
- un module fonction ;
- un sous-programme ;
- une instruction ABAP ;
- un écran ou un événement Dynpro.

Il évite de rechercher manuellement chaque appel dans un environnement complexe.

## PRÉCAUTIONS

- ne pas définir une condition coûteuse ;
- éviter les appels de méthode susceptibles de modifier l’état ;
- vérifier les conversions implicites ;
- supprimer les breakpoints devenus inutiles ;
- ne pas utiliser une condition dépendant d’une variable hors portée.

## PROCÉDURE PAS À PAS

1. Lire la définition et identifier les prérequis du chapitre.
2. Choisir un objet Z ou un scénario de démonstration sans impact métier.
3. Reproduire l’exemple dans un système de développement et relever les données d’entrée.
4. Contrôler la syntaxe ou la configuration avant activation/exécution.
5. Comparer le résultat observé avec la section **Vérification**.
6. Documenter toute différence liée à la release, aux autorisations ou au paramétrage du système.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
lv_matnr = '000000000000006200'
sy-subrc <> 0
lines( lt_items ) > 1000
```

## TERMES DU LEXIQUE

- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## RÉFÉRENCES OFFICIELLES SAP

- [Managing Dynamic Breakpoints — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49256af629ac16b7e10000000a42189d.html)
- [Breakpoints Tool — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/492535784d7216b5e10000000a42189d.html)
- [Breakpoints — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491e9433f3ee6492e10000000a42189b.html)


---

[Chapitre suivant — WATCHPOINTS](<./05 ├── WATCHPOINTS.md>)
