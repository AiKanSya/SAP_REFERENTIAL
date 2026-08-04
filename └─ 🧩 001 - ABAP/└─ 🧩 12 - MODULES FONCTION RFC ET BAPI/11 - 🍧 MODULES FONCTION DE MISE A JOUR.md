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

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE37`.
2. Entrer le nom du module fonction puis choisir **Afficher**, **Modifier** ou **Créer** selon l’autorisation.
3. Analyser les onglets Import, Export, Changing, Tables et Exceptions.
4. Lire la documentation et le code source avant tout appel.
5. Utiliser **Test/Exécuter** avec des données non destructives.
6. Pour un module Z, contrôler, activer puis tester les cas nominal et d’erreur.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'Z_DEV_UPDATE_DOCUMENT'
  IN UPDATE TASK
  EXPORTING
    is_document = ls_document.
```

## 🌺 TERMES DU LEXIQUE

- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#destination-rfc>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating Update Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/cfae740a0a21455dbe6e510c2d86e36a/417af4daa79e11d1950f0000e82de14a.html)
- [Synchronous and Asynchronous Updating — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/6b96ee764b054c5f929dea77ffcf7a6b.html)
- [V1 and V2 Update Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/23e9aa61638e404d81575e939b5cd847.html)


---

➡️ [Chapitre suivant — PRINCIPES DU RFC](<./12 - 🍧 PRINCIPES DU RFC.md>)
