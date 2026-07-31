# 🌸 MODULES FONCTION DE MISE À JOUR

## 🌺 OBJECTIFS

- Comprendre le rôle d’un module de mise à jour
- Distinguer enregistrement et exécution
- Situer les catégories V1 et V2
- Identifier les contraintes d’interface et de debug

## 🌺 PRINCIPE

Un module fonction de mise à jour est enregistré avec :

```abap
CALL FUNCTION 'Z_DEV_UPDATE_DOCUMENT'
  IN UPDATE TASK
  EXPORTING
    is_document = ls_document.
```

L’appel n’exécute pas immédiatement le module. Il enregistre les données nécessaires dans la requête de mise à jour. L’exécution intervient lors de la clôture appropriée de la SAP LUW.

```mermaid
flowchart LR
    A["Programme de dialogue"] --> B["IN UPDATE TASK"]
    B --> C["Requête de mise à jour"]
    C --> D["COMMIT WORK"]
    D --> E["Processus de mise à jour"]
```

## 🌺 TYPE DE TRAITEMENT

Le module doit être défini comme module de mise à jour dans le Function Builder. Les catégories principales sont :

| Catégorie | Usage général                               |
| --------- | ------------------------------------------- |
| V1        | Mise à jour critique et prioritaire         |
| V2        | Mise à jour secondaire, souvent statistique |

Le choix dépend du processus applicatif et ne doit pas être improvisé.

## 🌺 CONTRAINTES

Les modules de mise à jour disposent d’une interface restreinte. Les données nécessaires doivent pouvoir être enregistrées puis rejouées par la tâche de mise à jour.

Principes :

- ne pas dépendre de l’état mémoire du programme appelant ;
- transmettre toutes les données nécessaires ;
- éviter les interactions utilisateur ;
- ne pas effectuer de logique de dialogue ;
- concevoir une reprise ou un diagnostic en cas d’échec.

## 🌺 COMMIT

Le `COMMIT WORK` déclenche le traitement des modules enregistrés. Il ne doit pas être placé arbitrairement dans une fonction réutilisable, car il termine la SAP LUW de l’appelant.

Le futur dossier sur les LUW détaillera les règles transactionnelles.

## 🌺 ANALYSE

Outils classiques :

- `SM13` pour les requêtes de mise à jour ;
- debug de mise à jour activé dans le débogueur ;
- `ST22` en cas de dump ;
- journaux applicatifs ou techniques du processus.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)
- [V1 and V2 Update Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/23e9aa61638e404d81575e939b5cd847.html)

---

➡️ [Chapitre suivant — PRINCIPES DU RFC](<./12 - 🍧 PRINCIPES DU RFC.md>)
