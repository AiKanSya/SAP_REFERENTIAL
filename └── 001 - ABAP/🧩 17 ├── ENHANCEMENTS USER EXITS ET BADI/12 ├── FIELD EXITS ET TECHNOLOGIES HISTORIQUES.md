# FIELD EXITS ET TECHNOLOGIES HISTORIQUES

## OBJECTIFS

- Reconnaître un field exit dans une application existante
- Comprendre ses limites
- Éviter son utilisation comme choix par défaut

## FIELD EXIT

Un field exit est une ancienne technologie liée à un champ de saisie d’écran, généralement par l’intermédiaire de son élément de données. Il permet d’exécuter une logique de contrôle ou de transformation lors de la saisie.

## LIMITES

- technologie historique ;
- effet potentiellement global sur tous les écrans utilisant l’élément de données ;
- contexte applicatif limité ;
- dépendance à l’activation système ;
- diagnostic difficile lorsqu’un même champ est utilisé dans plusieurs transactions ;
- alternatives plus explicites souvent disponibles : BAdI, validation applicative, screen exit ou enhancement framework.

## MAINTENANCE

Lorsqu’un field exit existe :

1. identifier le module fonction associé ;
2. rechercher tous les écrans concernés ;
3. vérifier les conditions limitant son exécution ;
4. analyser les effets lors des traitements batch ou interfaces ;
5. documenter sa stratégie de remplacement éventuelle.

## AUTRES TECHNOLOGIES HISTORIQUES

Les modifications directes, routines client spécifiques à une application et exits non documentés doivent être analysés comme du patrimoine à maintenir, pas comme des modèles de nouveau développement.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE80`.
2. Sélectionner le type d’objet ou le package dans la liste de gauche.
3. Entrer le nom technique puis valider.
4. Commencer en mode **Afficher** pour analyser l’objet et ses sous-objets.
5. Passer en modification uniquement dans un système et un objet autorisés.
6. Contrôler la syntaxe, activer les objets modifiés puis vérifier leur statut actif.

## VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## FICHE DE CONTRÔLE À COPIER

```text
Système / SID       :
Mandant             :
Utilisateur         :
Transaction / outil :
Objet technique     :
Jeu de données      :
Résultat attendu    :
Résultat observé    :
Horodatage          :
Ordre de transport  :
```

## TERMES DU LEXIQUE

- [BAdI](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Field Exits — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525738.html)
- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)


---

[Chapitre suivant — PRINCIPES DES BAdI](<./13 ├── PRINCIPES DES BADI.md>)
