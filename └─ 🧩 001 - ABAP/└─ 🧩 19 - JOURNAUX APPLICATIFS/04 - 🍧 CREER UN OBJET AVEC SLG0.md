# 🌸 CRÉER UN OBJET AVEC SLG0

## 🌺 OBJECTIFS

- Créer un objet et ses sous-objets
- Comprendre leur transport
- Vérifier que la combinaison est exploitable par le code

## 🌺 TRANSACTION

La transaction `SLG0` maintient les objets du journal applicatif et leurs sous-objets.

```mermaid
flowchart LR
    A["SLG0"] --> B["Créer l objet"]
    B --> C["Créer les sous-objets"]
    C --> D["Affecter le package et le transport"]
    D --> E["Tester dans SLG1 ou par programme"]
```

## 🌺 PROCÉDURE

1. Ouvrir `SLG0`.
2. Créer un objet dans l’espace client, généralement préfixé par `Z` ou `Y`.
3. Saisir un texte compréhensible par l’exploitation.
4. Créer les sous-objets nécessaires.
5. Enregistrer l’objet dans le package et l’ordre de transport appropriés.
6. Vérifier la présence de l’objet dans le système cible après import.

## 🌺 CONTRÔLE PAR PROGRAMME

Les fonctions suivantes permettent de contrôler les définitions :

- `BAL_OBJECT_SELECT` ;
- `BAL_SUBOBJECT_SELECT` ;
- `BAL_OBJECT_SUBOBJECT`.

Le framework vérifie aussi la cohérence lors de `BAL_LOG_CREATE`. Une combinaison inexistante provoque une erreur de création du journal.

## 🌺 ERREURS FRÉQUENTES

- sous-objet créé dans le mauvais objet ;
- définition créée localement alors qu’elle doit être transportée ;
- nom différent entre `SLG0` et le code ;
- objet absent dans le système de recette ou de production ;
- texte métier insuffisant pour l’équipe de support.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Application Log Methodology in SAP — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/ABAP/3353524098.html)
- [Registering Subobjects for the Application Log — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70761bba72014fb48199b9232d0d8409/5f770b3303c142c69e5ab3e97a16d7a8.html)

---

➡️ [Chapitre suivant — ANALYSER LES JOURNAUX AVEC SLG1](<./05 - 🍧 ANALYSER LES JOURNAUX AVEC SLG1.md>)
