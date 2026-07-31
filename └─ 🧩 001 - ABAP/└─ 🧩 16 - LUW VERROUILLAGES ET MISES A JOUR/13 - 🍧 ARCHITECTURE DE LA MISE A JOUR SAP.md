# 🌸 ARCHITECTURE DE LA MISE À JOUR SAP

## 🌺 OBJECTIFS

- Comprendre la séparation entre dialogue et update task
- Identifier le rôle des processus de travail de mise à jour
- Visualiser le cycle d’une demande

## 🌺 PRINCIPE

Le programme de dialogue enregistre des appels de modules fonction de mise à jour. Lors du `COMMIT WORK`, le système transmet la demande à un processus de travail d’update, qui exécute les écritures dans une database LUW dédiée.

```mermaid
sequenceDiagram
    participant D as Programme de dialogue
    participant U as Gestion des updates
    participant W as Update work process
    participant DB as Base de données
    D->>U: CALL FUNCTION IN UPDATE TASK
    D->>U: COMMIT WORK
    U->>W: Demande V1
    W->>DB: Écritures groupées
    DB-->>W: Commit ou rollback
    W-->>U: Statut
```

## 🌺 INTÉRÊTS

- raccourcir le temps occupé par le processus de dialogue ;
- regrouper les écritures liées ;
- centraliser le statut de l’update ;
- permettre le diagnostic et, selon le type de demande, une reprise administrative.

## 🌺 LIMITES

L’update task n’est pas une file d’intégration générique. Elle fait partie de la SAP LUW et doit exécuter des changements persistants déterministes, sans interaction utilisateur ni commit interne.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [The Update Process — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/979cf1522d164bf7a781796efd8850ee/c8ed15db039b4f45a8507015f531976b.html)
- [Work Processes in Application Server ABAP — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/e067931e0b0a4b2089f4db327879cd55/22d85d37ab534b86a5098ded38c06c0f.html)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)

---

➡️ [Chapitre suivant — CREER UN MODULE FONCTION DE MISE A JOUR](<./14 - 🍧 CREER UN MODULE FONCTION DE MISE A JOUR.md>)
