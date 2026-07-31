# 🌸 ENHANCEMENT SPOTS ET IMPLÉMENTATIONS

## 🌺 OBJECTIFS

- Distinguer conteneur de définition et conteneur d’implémentation
- Comprendre simple et composite enhancement spots
- Organiser les objets d’extension

## 🌺 MODÈLE

```mermaid
flowchart TD
    A["Enhancement spot"] --> B["Options d extension publiées"]
    B --> C["Enhancement implementation client"]
    C --> D["Éléments d implémentation"]
    D --> E["Source code plug-ins ou BAdI implementations"]
```

L’enhancement spot regroupe des options d’extension du côté définition. L’enhancement implementation regroupe les implémentations client. Les objets restent séparés du code enrichi.

## 🌺 TYPES DE CONTENEURS

- **simple enhancement spot** : regroupe des options d’un même contexte ;
- **composite enhancement spot** : structure plusieurs enhancement spots ;
- **simple enhancement implementation** : contient les éléments d’implémentation ;
- **composite enhancement implementation** : structure plusieurs implémentations.

## 🌺 CRÉATION CÔTÉ CLIENT

Pour implémenter une option existante :

1. ouvrir l’objet standard dans `SE80`, l’éditeur ABAP ou `SE18` ;
2. passer en mode enhancement ;
3. sélectionner l’option ;
4. créer ou choisir une enhancement implementation client ;
5. affecter package et transport ;
6. coder l’élément ;
7. activer l’élément et l’implémentation.

Le client ne doit pas créer un enhancement spot dans un objet SAP uniquement pour contourner l’absence d’un point prévu ; cela modifierait la définition standard.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating Enhancement Spots — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/3b0a39426f79f83ae10000000a1550b0.html)
- [Enhancement Implementations — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/8343e040e136742ae10000000a155106.html)
- [ABAP: Enhancement Concepts — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/f17cdbf76d1f4cb8805ed69891eafdd9.html)

---

➡️ [Chapitre suivant — POINTS D ENHANCEMENT EXPLICITES](<./18 - 🍧 POINTS D ENHANCEMENT EXPLICITES.md>)
