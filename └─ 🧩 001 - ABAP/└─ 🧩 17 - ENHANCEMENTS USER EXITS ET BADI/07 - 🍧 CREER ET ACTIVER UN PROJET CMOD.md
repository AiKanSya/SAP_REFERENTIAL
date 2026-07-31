# 🌸 CRÉER ET ACTIVER UN PROJET `CMOD`

## 🌺 OBJECTIFS

- Créer un projet d’extension client
- Affecter un enhancement `SMOD`
- Implémenter, transporter et activer le projet

## 🌺 PROCÉDURE

1. Ouvrir `CMOD`.
2. Créer un projet client avec une description explicite.
3. Affecter le projet à un package et à un ordre de transport.
4. Ajouter l’enhancement identifié dans `SMOD`.
5. Ouvrir les composants.
6. Implémenter les includes, écrans ou fonctions prévus.
7. Activer les objets techniques.
8. Activer le projet `CMOD`.
9. Tester le scénario métier complet.

## 🌺 NOMMAGE

Utiliser les conventions du client pour le projet, les classes déléguées et les objets DDIC. Le nom du projet doit permettre d’identifier le domaine fonctionnel et le besoin, sans reprendre un nom générique tel que `ZTEST`.

## 🌺 ACTIVATION

```mermaid
flowchart TD
    A["Code client actif"] --> B{"Projet CMOD actif ?"}
    B -->|"Non"| C["Exit non exécuté"]
    B -->|"Oui"| D["Composant disponible au runtime"]
```

Vérifier les deux niveaux : activation des objets ABAP et activation du projet.

## 🌺 TRANSPORT

Le projet `CMOD`, les includes client, les classes déléguées, les écrans et les objets DDIC doivent être transportés dans un ordre cohérent. Contrôler les dépendances entre Workbench et Customizing lorsque l’extension utilise aussi du paramétrage.

## 🌺 CAS D’USAGE

Dans un contexte où un besoin client doit compléter le comportement standard SAP sans modifier directement le code livré par SAP, le besoin consiste à **regrouper et activer les customer exits dans un projet client**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 🌺 ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

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

- [BAdI](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-badi>)
- [BTE](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/03 - 🍧 REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **regrouper et activer les customer exits dans un projet client**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)
- [Activating User Exits — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/83f4631d77654e14800e31b17fe9bd45/4c3a1afc9995677ae10000000a42189b.html)
- [Customer Exit Glossary — SAP Help Portal](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/35/26b1b7afab52b9e10000009b38f974/content.htm)


---

➡️ [Chapitre suivant — FUNCTION MODULE EXITS](<./08 - 🍧 FUNCTION MODULE EXITS.md>)
