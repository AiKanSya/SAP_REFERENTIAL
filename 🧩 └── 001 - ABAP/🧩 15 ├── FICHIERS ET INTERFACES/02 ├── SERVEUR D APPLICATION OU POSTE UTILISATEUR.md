# SERVEUR D’APPLICATION OU POSTE UTILISATEUR

## RÉSULTAT ATTENDU

- Distinguer les deux emplacements de fichiers
- Choisir une solution compatible avec le mode d’exécution
- Éviter les dépendances au poste utilisateur

## DEUX SYSTÈMES DE FICHIERS

Un programme ABAP peut principalement manipuler :

| Emplacement           | Exécution du code         | API principale                                          |
| --------------------- | ------------------------- | ------------------------------------------------------- |
| Serveur d’application | Instance AS ABAP          | Instructions `OPEN DATASET`, `READ DATASET`, `TRANSFER` |
| Poste utilisateur     | Machine exécutant SAP GUI | `CL_GUI_FRONTEND_SERVICES`                              |

```mermaid
flowchart TD
    A["Le traitement doit fonctionner sans utilisateur ?"] -->|"Oui"| B["Serveur d application"]
    A -->|"Non"| C["SAP GUI disponible"]
    C -->|"Oui"| D["Poste utilisateur possible"]
    C -->|"Non"| B
```

## SERVEUR D’APPLICATION

À privilégier pour :

- les traitements planifiés ;
- les interfaces automatiques ;
- les volumes importants ;
- les répertoires partagés avec un middleware ;
- les traitements nécessitant une reprise contrôlée.

Dans un système réparti, chaque instance peut disposer de son propre système de fichiers. Un chemin physique local n’est donc pas nécessairement visible depuis toutes les instances.

## POSTE UTILISATEUR

À réserver aux interactions explicites :

- import manuel ponctuel ;
- export demandé par l’utilisateur ;
- sélection d’un fichier au moyen d’une boîte de dialogue.

Ces opérations dépendent de SAP GUI et ne doivent pas être utilisées dans un job de fond.

## DÉCISION

| Besoin                                   | Choix recommandé      |
| ---------------------------------------- | --------------------- |
| Interface nocturne                       | Serveur d’application |
| Fichier déposé par CPI ou SFTP           | Serveur d’application |
| Export manuel d’une liste                | Poste utilisateur     |
| Traitement relançable sans session       | Serveur d’application |
| Sélection interactive d’un fichier local | Poste utilisateur     |

## PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

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

- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)


---

[Chapitre suivant — RÉPERTOIRES SERVEUR ET TRANSACTION AL11](<./03 ├── REPERTOIRES SERVEUR ET TRANSACTION AL11.md>)
