# 11. MODULES FONCTION DE MISE À JOUR

## 11.A RÉSULTAT ATTENDU

- Comprendre le rôle d’un module de mise à jour
- Distinguer enregistrement et exécution
- Situer les catégories V1 et V2
- Identifier les contraintes d’interface et de debug

## 11.B PRINCIPE

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

## 11.C TYPE DE TRAITEMENT

Le module doit être défini comme module de mise à jour dans le Function Builder. Les catégories principales sont :

| Catégorie | Usage général                               |
| --------- | ------------------------------------------- |
| V1        | Mise à jour critique et prioritaire         |
| V2        | Mise à jour secondaire, souvent statistique |

Le choix dépend du processus applicatif et ne doit pas être improvisé.

## 11.D CONTRAINTES

Les modules de mise à jour disposent d’une interface restreinte. Les données nécessaires doivent pouvoir être enregistrées puis rejouées par la tâche de mise à jour.

Principes :

- ne pas dépendre de l’état mémoire du programme appelant ;
- transmettre toutes les données nécessaires ;
- éviter les interactions utilisateur ;
- ne pas effectuer de logique de dialogue ;
- concevoir une reprise ou un diagnostic en cas d’échec.

## 11.E COMMIT

Le `COMMIT WORK` déclenche le traitement des modules enregistrés. Il ne doit pas être placé arbitrairement dans une fonction réutilisable, car il termine la SAP LUW de l’appelant.

Le futur dossier sur les LUW détaillera les règles transactionnelles.

## 11.F ANALYSE

Outils classiques :

- `SM13` pour les requêtes de mise à jour ;
- debug de mise à jour activé dans le débogueur ;
- `ST22` en cas de dump ;
- journaux applicatifs ou techniques du processus.

## 11.G PROCESS

### 11.G.1 Étape 1 — Séparer préparation et écriture

Valider et préparer toutes les données dans le programme appelant. Le module update doit recevoir un état cohérent et exécuter uniquement l’écriture prévue.

### 11.G.2 Étape 2 — Déclarer le type de mise à jour

Dans les attributs `SE37`, choisir le type update requis par la conception. Vérifier les restrictions de l’interface et l’absence d’opération interdite dans ce contexte.

### 11.G.3 Étape 3 — Enregistrer la tâche

Appeler le module avec `IN UPDATE TASK`. À ce stade, vérifier qu’aucune écriture n’est encore considérée comme validée par l’appelant.

### 11.G.4 Étape 4 — Décider la LUW

Lancer `COMMIT WORK` uniquement dans la couche propriétaire du processus. Tester aussi `ROLLBACK WORK` avant commit : la tâche enregistrée ne doit pas être exécutée.

### 11.G.5 Étape 5 — Diagnostiquer

Après un échec, contrôler `SM13`, l’utilisateur, l’heure et le module. Corriger la cause avant toute répétition. La mise en place est validée lorsque commit écrit une fois et rollback n’écrit rien.

## 11.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 11.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 11.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'Z_DEV_UPDATE_DOCUMENT'
  IN UPDATE TASK
  EXPORTING
    is_document = ls_document.
```

## 11.K TERMES DU LEXIQUE

- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>)

## 11.L RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)
- [V1 and V2 Update Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/23e9aa61638e404d81575e939b5cd847.html)

---

[Chapitre suivant — PRINCIPES DU RFC](<./12 ├── PRINCIPES DU RFC.md>)
