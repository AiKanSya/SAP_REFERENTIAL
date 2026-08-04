# 🌸 CRÉER UN GROUPE ET UN MODULE FONCTION

## 🌺 OBJECTIFS

- Créer un groupe de fonctions dans le namespace client
- Créer un module fonction dans `SE37`
- Affecter les objets au package et à l’ordre de transport
- Respecter les étapes d’activation

## 🌺 PRÉREQUIS

Définir avant la création :

- responsabilité du module ;
- nom dans le namespace client ;
- package ;
- groupe de fonctions ;
- interface prévue ;
- stratégie d’erreur ;
- type de traitement.

## 🌺 CRÉATION DU GROUPE

Le groupe peut être créé depuis `SE80` ou lors de la création du module selon le système.

Exemple :

```text
Groupe de fonctions : ZFG_DEV_PRODUCT
Description          : Services classiques sur les produits
Package              : ZDEV_ABAP
```

## 🌺 CRÉATION DU MODULE

Dans `SE37` :

1. saisir `Z_DEV_PRODUCT_GET` ;
2. choisir **Créer** ;
3. renseigner le groupe `ZFG_DEV_PRODUCT` ;
4. saisir une description précise ;
5. définir l’interface ;
6. implémenter le traitement ;
7. documenter ;
8. vérifier la syntaxe ;
9. activer le module et le groupe.

```mermaid
flowchart TD
    A["Définir le contrat"] --> B["Créer ou choisir le groupe"]
    B --> C["Créer le module fonction"]
    C --> D["Définir l interface"]
    D --> E["Implémenter et documenter"]
    E --> F["Tester et activer"]
```

## 🌺 NOMMAGE

Le nom doit exprimer une action et un périmètre. Exemples :

- `Z_DEV_PRODUCT_GET`
- `Z_DEV_PRODUCT_VALIDATE`
- `Z_DEV_ORDER_CREATE`

Éviter :

- `Z_TEST1` ;
- `Z_FUNCTION` ;
- noms dépendant d’un écran ou d’un utilisateur ;
- abréviations incompréhensibles.

## 🌺 TRANSPORT

Le groupe de fonctions et les modules sont des objets Repository. Vérifier que :

- le package n’est pas `$TMP` pour un développement transportable ;
- tous les sous-objets sont enregistrés dans l’ordre correct ;
- les types DDIC requis sont transportés avant ou avec le module ;
- l’activation est complète dans le système source.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE80`.
2. Sélectionner le type d’objet ou le package dans la liste de gauche.
3. Entrer le nom technique puis valider.
4. Commencer en mode **Afficher** pour analyser l’objet et ses sous-objets.
5. Passer en modification uniquement dans un système et un objet autorisés.
6. Contrôler la syntaxe, activer les objets modifiés puis vérifier leur statut actif.

## 🌺 VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 🌺 ERREURS FRÉQUENTES

- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 🌺 FICHE DE CONTRÔLE À COPIER

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

## 🌺 TERMES DU LEXIQUE

- [Module fonction](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#destination-rfc>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Creating New Function Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801ee8454211d189710000e8322d00.html)
- [Working with ABAP Function Groups and Modules — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/5b3370ee088a4e2b9579da3f6e994456.html)


---

➡️ [Chapitre suivant — DÉFINIR L INTERFACE DU MODULE FONCTION](<./05 - 🍧 DEFINIR L INTERFACE DU MODULE FONCTION.md>)
