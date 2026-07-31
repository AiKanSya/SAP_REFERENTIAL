# 🌸 BORNES DE TRANSACTION ET COMMITS IMPLICITES

## 🌺 OBJECTIFS

- Identifier les événements pouvant terminer une database LUW
- Éviter les validations accidentelles au milieu d’un traitement
- Protéger la phase de sauvegarde

## 🌺 COMMITS EXPLICITES ET IMPLICITES

`COMMIT WORK` termine explicitement la SAP LUW. Le runtime ABAP peut également déclencher des commits de base de données lors de certains changements de contexte, par exemple lorsqu’un traitement quitte une étape de dialogue ou transfère le contrôle vers un autre processus.

```mermaid
flowchart LR
    A["Écritures non validées"] --> B["Instruction ou changement de contexte"]
    B --> C{"Commit implicite ?"}
    C -->|"Oui"| D["Écritures rendues persistantes"]
    C -->|"Non"| E["SAP LUW poursuivie"]
```

## 🌺 SITUATIONS À ANALYSER

- appel RFC synchrone ou asynchrone ;
- `WAIT` ;
- changement d’étape de dialogue ;
- certains appels de programmes ou de transactions ;
- instruction explicitement documentée comme provoquant un commit.

La liste exacte dépend du contexte et de la version. Vérifier la documentation de l’instruction utilisée au lieu de supposer qu’un appel est transactionnellement neutre.

## 🌺 RÈGLE DE CONCEPTION

Pendant une phase de sauvegarde :

- ne pas appeler un composant dont le contrat transactionnel est inconnu ;
- ne pas exécuter de `COMMIT WORK` dans une API réutilisable ;
- ne pas déléguer la validation à une méthode profonde ;
- laisser le propriétaire de la transaction décider du commit ou du rollback.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [LUWs in ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/8132142fd1a144a59303663a03a7c2d4/54f5462a9604498382319304869a4280.html)
- [Transactional Consistency Check — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/753088fc00704d0a80e7fbd6803c8adb/89be29c77d1b4b5e80678e4d2da51345.html)
- [Committing Database Changes — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/fe24b0146c551014891ad42d6b2789e5/fceb3b64358411d1829f0000e829fbfe.html)

---

➡️ [Chapitre suivant — COMMIT WORK ET COMMIT WORK AND WAIT](<./04 - 🍧 COMMIT WORK ET COMMIT WORK AND WAIT.md>)
