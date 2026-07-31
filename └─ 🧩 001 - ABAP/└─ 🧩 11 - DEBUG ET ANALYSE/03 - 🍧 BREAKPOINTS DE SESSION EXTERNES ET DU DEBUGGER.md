# 🌸 BREAKPOINTS DE SESSION, EXTERNES ET DU DÉBOGUEUR

## 🌺 OBJECTIFS

- Choisir le bon type de breakpoint
- Comprendre sa portée et sa durée de validité
- Arrêter un traitement dialogué ou externe
- Éviter les breakpoints placés sur le mauvais utilisateur

## 🌺 PRINCIPE

Un breakpoint demande au processeur ABAP de suspendre l’exécution à un emplacement déterminé.

```mermaid
flowchart LR
    A["Programme en cours"] --> B["Breakpoint actif et applicable"]
    B --> C["Suspension de l’exécution"]
    C --> D["Ouverture du débogueur"]
```

## 🌺 BREAKPOINT DE SESSION

Le breakpoint de session concerne normalement les traitements exécutés par le même utilisateur dans la session SAP GUI correspondante.

Utilisation typique :

- rapport lancé depuis `SE38` ;
- transaction dialoguée ;
- programme appelé dans le même contexte utilisateur.

Il convient aux tests manuels réalisés directement dans SAP GUI.

## 🌺 BREAKPOINT EXTERNE

Le breakpoint externe est destiné aux traitements dont l’appel arrive depuis un autre canal ou une autre session, par exemple :

- requête HTTP ;
- service ICF ;
- appel RFC ;
- application web utilisant le système ABAP ;
- scénario où la session SAP GUI qui pose le breakpoint n’exécute pas directement le traitement.

Le traitement doit généralement s’exécuter avec l’utilisateur pour lequel le breakpoint externe est défini. Certains contextes techniques utilisent un autre utilisateur que celui attendu.

## 🌺 BREAKPOINT DU DÉBOGUEUR

Un breakpoint créé pendant une session de débogage est géré dans cette session. Il permet de préparer plusieurs arrêts après avoir déjà interrompu le programme.

Le Breakpoints Tool permet de lister et gérer :

- breakpoints ;
- watchpoints ;
- checkpoints.

## 🌺 BREAKPOINT DANS LE CODE

L’instruction suivante inscrit un breakpoint dans le source :

```abap
BREAK-POINT.
```

Un breakpoint codé ne doit pas être livré sans justification. Il peut interrompre les utilisateurs autorisés au débogage et polluer le code applicatif.

Pour un besoin temporaire, préférer un breakpoint défini dans l’éditeur ou le débogueur.

## 🌺 CHOIX RAPIDE

| Contexte                                  | Breakpoint conseillé               |
| ----------------------------------------- | ---------------------------------- |
| Rapport exécuté dans SAP GUI              | Session                            |
| Transaction dialoguée du même utilisateur | Session                            |
| Appel HTTP ou OData                       | Externe                            |
| Appel RFC entrant                         | Externe                            |
| Analyse après entrée dans le débogueur    | Débogueur                          |
| Point permanent contrôlé par le code      | Instruction seulement si justifiée |

## 🌺 DIAGNOSTIC D UN BREAKPOINT IGNORÉ

Contrôler :

1. utilisateur réel du traitement ;
2. ligne réellement exécutée ;
3. version active de l’objet ;
4. type de breakpoint ;
5. date d’expiration éventuelle ;
6. contexte système ou mise à jour ;
7. autorisations.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Breakpoints — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491e9433f3ee6492e10000000a42189b.html)
- [Breakpoints Tool — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/492535784d7216b5e10000000a42189d.html)
- [Managing Breakpoints in the ABAP Editor — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/0d1f9c93dc474415810224f98551577b.html)
- [Managing Breakpoints in the ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/e6c585648f054f33ac6384ba6a2e3bf2.html)

---

➡️ [Chapitre suivant — BREAKPOINTS CONDITIONNELS ET DYNAMIQUES](<./04 - 🍧 BREAKPOINTS CONDITIONNELS ET DYNAMIQUES.md>)
