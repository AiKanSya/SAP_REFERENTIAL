# 🌸 WATCHPOINTS

## 🌺 OBJECTIFS

- Arrêter l’exécution lors de la modification d’une donnée
- Distinguer watchpoint et breakpoint
- Ajouter une condition de déclenchement
- Retrouver l’instruction qui altère une valeur

## 🌺 PRINCIPE

Un watchpoint surveille un objet de données pendant la session de débogage. Le débogueur s’arrête lorsque la valeur surveillée change ou lorsque la condition associée devient vraie.

```mermaid
flowchart LR
    A["Valeur initiale"] --> B["Instruction exécutée"]
    B --> C["Valeur modifiée"]
    C --> D["Watchpoint déclenché"]
```

## 🌺 DIFFÉRENCE AVEC UN BREAKPOINT

| Breakpoint                                 | Watchpoint                                            |
| ------------------------------------------ | ----------------------------------------------------- |
| Associé à un emplacement ou événement      | Associé à une donnée                                  |
| Arrête avant ou sur une instruction ciblée | Arrête après la modification détectée                 |
| Requiert de connaître le point probable    | Utile lorsque l’auteur de la modification est inconnu |

## 🌺 EXEMPLE

Une quantité devient négative, mais plusieurs procédures peuvent la modifier.

1. démarrer le débogueur avant la divergence ;
2. afficher `lv_quantity` ;
3. créer un watchpoint sur cette variable ;
4. poursuivre avec **Continuer** ;
5. analyser l’instruction ayant produit la nouvelle valeur.

Condition possible :

```abap
lv_quantity < 0
```

## 🌺 VALEUR AVANT ET APRÈS

L’outil de watchpoints peut afficher :

- la valeur actuelle ;
- la valeur avant la dernière modification ;
- la condition ;
- l’état actif du watchpoint.

Comparer les deux valeurs permet de vérifier que l’arrêt correspond bien à la divergence recherchée.

## 🌺 LIMITES

Un watchpoint peut perdre sa validité lorsque :

- la variable locale sort de sa portée ;
- une référence ne pointe plus sur le même objet ;
- la session interne change ;
- l’objet surveillé est recréé ;
- le traitement passe dans un autre contexte technique.

Les détails varient selon la version du débogueur et le type de donnée.

## 🌺 BONNES PRATIQUES

- surveiller une donnée précise plutôt qu’une structure complète ;
- ajouter une condition restrictive ;
- supprimer les watchpoints inutiles ;
- documenter la valeur attendue ;
- vérifier la pile d’appels au déclenchement.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Watchpoints — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/4926d933c93016b8e10000000a42189d.html)
- [Breakpoints Tool — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/492535784d7216b5e10000000a42189d.html)

---

➡️ [Chapitre suivant — PILOTER L EXECUTION DU PROGRAMME](<./06 - 🍧 PILOTER L EXECUTION DU PROGRAMME.md>)
