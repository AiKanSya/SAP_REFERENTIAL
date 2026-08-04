# 7. IMPLÉMENTATION, DONNÉES GLOBALES ET INCLUDES

## 7.A RÉSULTAT ATTENDU

- Situer le code du module dans le Function Pool
- Utiliser correctement variables locales et données globales
- Structurer les includes du groupe
- Limiter les effets de bord

## 7.B CODE GÉNÉRÉ

Le Function Builder génère le bloc :

```abap
FUNCTION z_dev_calculate_total.
*"----------------------------------------------------------------------
*" Interface locale
*"----------------------------------------------------------------------

  " Implémentation

ENDFUNCTION.
```

Écrire le traitement entre `FUNCTION` et `ENDFUNCTION`. Ne pas modifier manuellement les éléments générés de l’interface dans le commentaire technique.

## 7.C DONNÉES LOCALES

Déclarer localement les données nécessaires au traitement :

```abap
DATA lv_total TYPE decfloat34.

lv_total = iv_quantity * iv_unit_price.
ev_total = lv_total.
```

Une donnée locale :

- réduit le couplage ;
- facilite le debug ;
- évite les états persistants ;
- clarifie la responsabilité du module.

## 7.D INCLUDE TOP

L’include `...TOP` contient les déclarations globales du groupe. Il peut héberger :

- types communs ;
- constantes réellement partagées ;
- références nécessaires à plusieurs modules ;
- contrôles déclaratifs du Function Pool.

Éviter d’y placer toutes les variables par habitude.

## 7.E INCLUDES COMPLÉMENTAIRES

Selon les conventions du projet, des includes peuvent séparer :

- sous-programmes internes ;
- implémentations PBO/PAI d’écrans du groupe ;
- types et constantes ;
- traitements techniques communs.

```mermaid
flowchart TD
    A["Function Pool"] --> B["TOP : déclarations globales"]
    A --> C["UXX : modules fonction"]
    A --> D["FXX : sous-programmes éventuels"]
    A --> E["OXX et IXX : dynpros éventuels"]
```

## 7.F DÉPENDANCES

Un module fonction doit pouvoir être compris à partir de :

- son interface ;
- son code ;
- les appels explicites qu’il effectue ;
- une quantité minimale de contexte global.

Une variable globale modifiée par un autre module du groupe constitue une dépendance cachée. La supprimer ou la documenter précisément.

## 7.G PROCESS

### 7.G.1 Étape 1 — Localiser le source généré

Depuis `SE37`, naviguer vers le groupe dans `SE80`. Identifier l’include du module et l’include TOP ; ne modifier pas les parties générées hors des zones prévues.

### 7.G.2 Étape 2 — Implémenter depuis la signature

Valider d’abord les imports, exécuter le traitement puis alimenter toutes les sorties. Ne lire une donnée globale que si elle représente explicitement l’état partagé du groupe.

### 7.G.3 Étape 3 — Réduire les globales

Pour chaque globale utilisée, rechercher tous les modules consommateurs. Remplacer par variable locale ou paramètre lorsque sa conservation entre appels n’est pas indispensable.

### 7.G.4 Étape 4 — Traiter erreurs et transaction

Déclencher l’exception ou le retour prévu au point où la cause est connue. Ne lancer ni commit ni rollback sauf si le contrat du module en fait explicitement le propriétaire.

### 7.G.5 Étape 5 — Tester l’indépendance

Exécuter le module seul, puis après un autre module du groupe. Les résultats doivent rester identiques pour les mêmes entrées, sauf état partagé documenté. Activer le groupe complet et vérifier ses includes.

## 7.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 7.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 7.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
FUNCTION z_dev_calculate_total.
*"----------------------------------------------------------------------
*" Interface locale
*"----------------------------------------------------------------------

  " Implémentation

ENDFUNCTION.
```

## 7.K TERMES DU LEXIQUE

- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>)

## 7.L RÉFÉRENCES OFFICIELLES SAP

- [Understanding Function Module Code — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801f1c454211d189710000e8322d00.html)
- [Creating New Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801ee8454211d189710000e8322d00.html)

---

[Chapitre suivant — APPELER UN MODULE FONCTION AVEC CALL FUNCTION](<./08 ├── APPELER UN MODULE FONCTION AVEC CALL FUNCTION.md>)
