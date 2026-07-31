# 🌸 FIELD EXITS ET TECHNOLOGIES HISTORIQUES

## 🌺 OBJECTIFS

- Reconnaître un field exit dans une application existante
- Comprendre ses limites
- Éviter son utilisation comme choix par défaut

## 🌺 FIELD EXIT

Un field exit est une ancienne technologie liée à un champ de saisie d’écran, généralement par l’intermédiaire de son élément de données. Il permet d’exécuter une logique de contrôle ou de transformation lors de la saisie.

## 🌺 LIMITES

- technologie historique ;
- effet potentiellement global sur tous les écrans utilisant l’élément de données ;
- contexte applicatif limité ;
- dépendance à l’activation système ;
- diagnostic difficile lorsqu’un même champ est utilisé dans plusieurs transactions ;
- alternatives plus explicites souvent disponibles : BAdI, validation applicative, screen exit ou enhancement framework.

## 🌺 MAINTENANCE

Lorsqu’un field exit existe :

1. identifier le module fonction associé ;
2. rechercher tous les écrans concernés ;
3. vérifier les conditions limitant son exécution ;
4. analyser les effets lors des traitements batch ou interfaces ;
5. documenter sa stratégie de remplacement éventuelle.

## 🌺 AUTRES TECHNOLOGIES HISTORIQUES

Les modifications directes, routines client spécifiques à une application et exits non documentés doivent être analysés comme du patrimoine à maintenir, pas comme des modèles de nouveau développement.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Field Exits — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525738.html)
- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)

---

➡️ [Chapitre suivant — PRINCIPES DES BADI](<./13 - 🍧 PRINCIPES DES BADI.md>)
