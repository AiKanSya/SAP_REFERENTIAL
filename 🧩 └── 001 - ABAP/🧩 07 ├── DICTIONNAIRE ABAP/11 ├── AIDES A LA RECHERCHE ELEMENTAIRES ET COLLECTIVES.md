# AIDES À LA RECHERCHE ÉLÉMENTAIRES ET COLLECTIVES

## RÉSULTAT ATTENDU

- Comprendre le fonctionnement d’une aide F4 DDIC
- Créer une aide élémentaire
- Regrouper plusieurs chemins dans une aide collective
- Configurer les paramètres d’import et d’export
- Choisir le niveau d’affectation approprié

## FONCTION

Une aide à la recherche définit un processus de sélection de valeurs pour un champ de saisie.

Elle indique :

- où lire les valeurs ;
- quels champs afficher ;
- quels critères proposer ;
- quelles valeurs recevoir depuis l’écran ;
- quelles valeurs retourner à l’écran.

```mermaid
flowchart LR
    A["Champ d’écran"] --> B["Appel F4"]
    B --> C["Aide à la recherche"]
    C --> D["Sélection des valeurs"]
    D --> E["Liste de résultats"]
    E --> F["Valeur retournée au champ"]
```

## AIDE ÉLÉMENTAIRE

Une aide élémentaire décrit un seul chemin de recherche.

Elle contient notamment :

- une méthode de sélection : table, vue ou autre source compatible ;
- une interface de paramètres ;
- les positions dans la boîte de dialogue de sélection ;
- les positions dans la liste de résultats ;
- un comportement de dialogue ;
- éventuellement un exit d’aide à la recherche.

## PARAMÈTRES

| Indicateur            | Fonction                                                                  |
| --------------------- | ------------------------------------------------------------------------- |
| Import                | Reçoit une valeur déjà présente sur l’écran pour restreindre la sélection |
| Export                | Retourne une valeur vers le champ ou la structure appelante               |
| Position de sélection | Affiche le paramètre comme critère de recherche                           |
| Position de liste     | Affiche le paramètre dans la liste des résultats                          |

Un paramètre peut être à la fois import et export.

## AIDE COLLECTIVE

Une aide collective regroupe plusieurs aides élémentaires représentant des chemins alternatifs.

Exemple : rechercher un partenaire par :

- identifiant ;
- nom et ville ;
- numéro fiscal.

```mermaid
flowchart TD
    A["Aide collective ZSH_PARTNER"] --> B["Recherche par identifiant"]
    A --> C["Recherche par nom"]
    A --> D["Recherche par numéro fiscal"]
```

Les paramètres de l’aide collective doivent être affectés aux paramètres correspondants de chaque aide élémentaire incluse.

## NIVEAUX D’AFFECTATION

Une aide peut être affectée :

- à un élément de données ;
- à un champ de table ou de structure ;
- à une table de contrôle ;
- directement à un champ d’écran selon la technologie.

L’affectation la plus générale est généralement placée sur l’élément de données. Une affectation locale peut la remplacer pour un contexte spécifique.

## EXIT D’AIDE À LA RECHERCHE

Un exit permet d’adapter dynamiquement le processus :

- modifier les critères ;
- compléter les résultats ;
- filtrer les chemins disponibles ;
- implémenter une logique non couverte par la définition standard.

Il doit rester réservé aux besoins impossibles à exprimer par la configuration DDIC, car il augmente la complexité de maintenance.

## POINTS À RETENIR

- Une aide élémentaire définit un chemin de recherche.
- Une aide collective regroupe plusieurs aides élémentaires.
- Les paramètres d’import filtrent ; les paramètres d’export retournent les valeurs.
- Le niveau d’affectation détermine la portée de l’aide.
- Un exit est une extension avancée, pas le mécanisme par défaut.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE11`.
2. Choisir le type d’objet DDIC correspondant au chapitre.
3. Entrer le nom technique ; utiliser **Afficher** pour un objet existant ou **Créer** pour un objet Z autorisé.
4. Renseigner les attributs et composants en suivant les règles du chapitre.
5. Lancer le contrôle de cohérence.
6. Activer l’objet et traiter chaque message avant de poursuivre.
7. Utiliser la liste d’utilisation et, pour les tables, vérifier les paramètres techniques et la structure physique.

## VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## ERREURS FRÉQUENTES

- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

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

- [ABAP Dictionary](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## RÉFÉRENCES OFFICIELLES SAP

- [Search Helps — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ec1c9c8191b74de98feb94001a95dd76/cf21ee2b446011d189700000e8322d00.html?version=202310.latest)
- [Input Help from the ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/f68e489816e043f1add91d69a6842931/4a439ebd5a503f04e10000000a421937.html)


---

[Chapitre suivant — VUES CLASSIQUES DU DICTIONNAIRE](<./12 ├── VUES CLASSIQUES DU DICTIONNAIRE.md>)
