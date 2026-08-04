# CRÉER ET ACTIVER UN PROJET `CMOD`

## RÉSULTAT ATTENDU

- Créer un projet d’extension client
- Affecter un enhancement `SMOD`
- Implémenter, transporter et activer le projet

## PROCESS

### ÉTAPE 1 — VÉRIFIER L’ABSENCE DE PROJET CONCURRENT

À partir de l’enhancement validé dans `SMOD`, rechercher son affectation existante. Si un projet actif le contient déjà, analyser ce projet et compléter sa gouvernance plutôt que de créer une seconde affectation incompatible.

### ÉTAPE 2 — CRÉER LE PROJET DANS `CMOD`

Saisir `/nCMOD`, entrer un nom Z conforme aux conventions puis choisir **Créer**. Renseigner une description fonctionnelle explicite, le package et la demande de transport. Éviter les noms temporaires qui ne permettent pas d’identifier le domaine.

### ÉTAPE 3 — AFFECTER L’ENHANCEMENT

Ouvrir l’affectation des extensions et ajouter le nom `SMOD` confirmé. Traiter tout message indiquant une utilisation existante. Enregistrer puis ouvrir la vue des composants pour vérifier que la liste attendue est complète.

### ÉTAPE 4 — IMPLÉMENTER LES COMPOSANTS CLIENT

Pour chaque function exit, ouvrir l’include client prévu et déléguer la logique à une classe Z. Pour un screen ou menu exit, créer les objets associés selon leur contrat. Ajouter auparavant les append structures nécessaires aux données affichées ou transmises.

### ÉTAPE 5 — ACTIVER DANS L’ORDRE

Contrôler et activer les objets DDIC, includes, classes, écrans et fonctions de menu. Activer ensuite le projet CMOD. Vérifier séparément le statut actif du code et celui du projet ; l’un ne remplace pas l’autre.

### ÉTAPE 6 — TESTER ET CONTRÔLER LE TRANSPORT

Placer un breakpoint dans le composant, exécuter le processus standard et vérifier le résultat cible ainsi qu’un cas hors périmètre. Contrôler que le projet et tous ses objets dépendants figurent dans des demandes transportées dans l’ordre requis.

## NOMMAGE

Utiliser les conventions du client pour le projet, les classes déléguées et les objets DDIC. Le nom du projet doit permettre d’identifier le domaine fonctionnel et le besoin, sans reprendre un nom générique tel que `ZTEST`.

## ACTIVATION

```mermaid
flowchart TD
    A["Code client actif"] --> B{"Projet CMOD actif ?"}
    B -->|"Non"| C["Exit non exécuté"]
    B -->|"Oui"| D["Composant disponible au runtime"]
```

Vérifier les deux niveaux : activation des objets ABAP et activation du projet.

## TRANSPORT

Le projet `CMOD`, les includes client, les classes déléguées, les écrans et les objets DDIC doivent être transportés dans un ordre cohérent. Contrôler les dépendances entre Workbench et Customizing lorsque l’extension utilise aussi du paramétrage.

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

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)
- [Activating User Exits — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/83f4631d77654e14800e31b17fe9bd45/4c3a1afc9995677ae10000000a42189b.html)
- [Customer Exit Glossary — SAP Help Portal](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/35/26b1b7afab52b9e10000009b38f974/content.htm)

---

[Chapitre suivant — FUNCTION MODULE EXITS](<./08 ├── FUNCTION MODULE EXITS.md>)
