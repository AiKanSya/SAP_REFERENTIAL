# DEBUG SYSTÈME ET TRAITEMENTS SPÉCIAUX

## RÉSULTAT ATTENDU

- Comprendre le débogage système
- Activer le débogage des modules de mise à jour
- Identifier les changements de session interne
- Déboguer un appel externe avec le bon utilisateur
- Connaître les limites des traitements asynchrones

## DÉBOGAGE SYSTÈME

Le mode **System Debugging** permet d’entrer dans des programmes marqués comme programmes système, en plus des programmes applicatifs.

L’activer lorsque :

- le traitement pertinent est masqué dans le standard ;
- la pile indique un programme système ;
- une fonction technique doit être analysée.

Le désactiver après usage pour éviter de parcourir inutilement l’infrastructure SAP.

## DEBUG DE MISE À JOUR

Les modules appelés avec `IN UPDATE TASK` ne sont pas exécutés directement dans le même traitement dialogué. Pour les analyser :

1. entrer dans le débogueur avant le `COMMIT WORK` ;
2. activer **Update Debugging** dans les paramètres ;
3. poursuivre l’exécution ;
4. le débogueur s’arrête dans la tâche de mise à jour lorsque celle-ci démarre.

```mermaid
flowchart LR
    A["CALL FUNCTION IN UPDATE TASK"] --> B["Enregistrement de la demande"]
    B --> C["COMMIT WORK"]
    C --> D["Session de mise à jour"]
    D --> E["Arrêt dans le module si Update Debugging actif"]
```

## MISES À JOUR ANNULÉES

Pour une mise à jour déjà en erreur, les outils de suivi des mises à jour permettent d’afficher l’enregistrement et, avec les autorisations nécessaires, de l’analyser dans le débogueur.

Ne pas retraiter ou modifier une mise à jour annulée sans comprendre son impact métier.

## APPELS HTTP ET RFC

Pour un appel entrant :

- utiliser un breakpoint externe ;
- vérifier l’utilisateur technique réel ;
- reproduire exactement la requête ;
- contrôler les données transmises ;
- tenir compte du fait que le traitement ne possède pas nécessairement une interface SAP GUI.

## TRAITEMENTS ASYNCHRONES

Certains appels asynchrones ou transactionnels ne restent pas dans la session de débogage courante. Il peut être nécessaire de :

- utiliser un breakpoint externe ;
- analyser la file ou le journal technique ;
- reproduire l’unité appelée directement ;
- activer une option spécifique du débogueur.

## PROCESS

### Étape 1 — Identifier le changement de contexte

Déterminer si le code s’exécute dans une mise à jour, un appel RFC, une tâche asynchrone, un autre utilisateur ou du code système. Relever l’instruction qui provoque ce changement.

### Étape 2 — Activer uniquement le mode requis

Configurer le débogage système, update ou RFC selon le scénario et les autorisations. Éviter d’activer tous les modes : les arrêts dans le framework masquent le chemin utile.

### Étape 3 — Placer un breakpoint dans le contexte cible

Utiliser un breakpoint externe lorsque l’utilisateur ou la session change. Pour une update task, cibler le module de mise à jour ; pour RFC, cibler le module appelé dans le système destinataire.

### Étape 4 — Reproduire une seule unité

Exécuter le scénario et vérifier dans le débogueur l’utilisateur, le programme et le système. Si l’arrêt ne survient pas, déterminer si l’unité a été créée avant de modifier le breakpoint.

### Étape 5 — Désactiver les options spéciales

Après analyse, retirer breakpoints externes et modes système/update. Le diagnostic est terminé lorsque le changement de contexte et le code réellement exécuté sont prouvés.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## TERMES DU LEXIQUE

- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## RÉFÉRENCES OFFICIELLES SAP

- [System Debugging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4925636629ac16b7e10000000a42189d.html)
- [Debugger Settings — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/7b8f8115c62847f493e69bef6e78ba81.html)
- [Analyzing Canceled Updates — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/97de29925b894871aba86eb7e2963bcb.html)
- [Starting and Directly Debugging ABAP Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/a95208086a6e448aa35f08357d958af5.html)

---

[Chapitre suivant — DEBUG DES JOBS ET TRAITEMENTS EN ARRIÈRE-PLAN](<./12 ├── DEBUG DES JOBS ET TRAITEMENTS EN ARRIERE PLAN.md>)
