# 🌸 GROUPES DE FONCTIONS ET PROGRAMMES GÉNÉRÉS

## 🌺 OBJECTIFS

- Comprendre le rôle d’un groupe de fonctions
- Identifier les programmes et includes générés
- Maîtriser la portée des données globales
- Éviter les dépendances cachées entre modules

## 🌺 GROUPE DE FONCTIONS

Un groupe de fonctions est le conteneur technique de modules fonction liés. À l’exécution, il correspond à un programme de type **Function Pool**.

```mermaid
flowchart TD
    A["Groupe de fonctions ZFG_DEV_UTILS"] --> B["Programme SAPLZFG_DEV_UTILS"]
    B --> C["Include global LZFG_DEV_UTILSTOP"]
    B --> D["Includes des modules fonction"]
    B --> E["Includes complémentaires"]
```

## 🌺 OBJETS GÉNÉRÉS

Pour un groupe fictif `ZFG_DEV_UTILS`, le système génère notamment :

| Objet                            | Rôle                                 |
| -------------------------------- | ------------------------------------ |
| `SAPLZFG_DEV_UTILS`              | Programme principal du Function Pool |
| `LZFG_DEV_UTILSTOP`              | Données et types globaux             |
| `LZFG_DEV_UTILSUXX`              | Include d’inclusion des modules      |
| `LZFG_DEV_UTILSU01`, `U02`, etc. | Code des modules fonction            |

Les noms exacts des includes techniques sont gérés par le Workbench. Ne pas les renommer manuellement.

## 🌺 CHARGEMENT EN MÉMOIRE

Lorsqu’un module fonction est appelé, le groupe de fonctions est chargé dans la session interne du programme appelant. Les données globales du groupe peuvent alors rester disponibles pour les appels suivants dans cette même session.

Conséquences :

- une variable globale peut conserver un état ;
- deux modules du même groupe peuvent partager des données ;
- une dépendance invisible peut apparaître ;
- le comportement peut différer entre deux sessions.

## 🌺 DONNÉES GLOBALES

Utiliser les données globales uniquement lorsqu’elles sont réellement communes au groupe. Éviter de les employer comme cache implicite ou comme moyen de transmettre des valeurs entre deux modules.

Préférer :

- des paramètres explicites ;
- des variables locales ;
- une classe dédiée pour un état complexe ;
- un cache documenté et invalidé correctement lorsqu’il est nécessaire.

## 🌺 COHÉSION

Un groupe de fonctions doit regrouper des fonctions cohérentes. Éviter les groupes génériques de type `ZUTILS` contenant des traitements sans relation métier ou technique.

Exemples de regroupements cohérents :

- gestion d’une interface métier précise ;
- fonctions techniques relatives à un même format ;
- modules générés par un framework ;
- fonctions d’une même API classique.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Understanding Function Module Code — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801f1c454211d189710000e8322d00.html)
- [Creating New Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801ee8454211d189710000e8322d00.html)
- [Overview of Function Modules — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/ff59ad5d6c55101492f7f1c64dee0529/d1801ea7454211d189710000e8322d00.html)

---

➡️ [Chapitre suivant — RECHERCHER ET ANALYSER AVEC SE37](<./03 - 🍧 RECHERCHER ET ANALYSER AVEC SE37.md>)
