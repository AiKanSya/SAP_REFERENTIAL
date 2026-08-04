# 1. PRINCIPES D’EXTENSION DU STANDARD SAP

## 1.A RÉSULTAT ATTENDU

- Distinguer extension, paramétrage et modification
- Comprendre pourquoi une extension doit rester séparée du code SAP
- Identifier les critères de choix d’une technique

## 1.B BESOIN D’EXTENSION

Une extension ajoute ou adapte un comportement sans modifier directement l’objet Repository livré par SAP. Le code client est conservé dans un objet distinct, relié à un point prévu par SAP ou par l’Enhancement Framework.

```mermaid
flowchart LR
    A["Traitement standard SAP"] --> B["Point d extension"]
    B --> C["Implémentation client"]
    C --> D["Comportement enrichi"]
```

## 1.C EXTENSION OU MODIFICATION

| Approche                  | Effet sur le standard                                 | Risque de maintenance |
| ------------------------- | ----------------------------------------------------- | --------------------- |
| Customizing               | Aucun code modifié                                    | Faible                |
| Extension publiée par SAP | Code client séparé                                    | Maîtrisé              |
| Enhancement implicite     | Code client séparé mais fortement lié à l’emplacement | Plus élevé            |
| Modification directe      | Objet SAP modifié                                     | Élevé                 |

Une modification directe nécessite une clé de modification, crée un écart avec la version SAP et doit être ajustée lors des mises à niveau. Elle ne doit être retenue qu’après absence démontrée de solution standard ou d’extension.

## 1.D PRINCIPES DE CONCEPTION

- privilégier le paramétrage avant le code ;
- rechercher une API ou un point d’extension publié ;
- limiter l’implémentation à l’orchestration ;
- placer la logique métier dans une classe client testable ;
- ne pas exécuter de `COMMIT WORK` dans un exit sans contrat explicite ;
- documenter le point d’appel, le contexte et les effets de bord ;
- tester l’activation et la désactivation de l’extension.

## 1.E PROCESS

### 1.E.1 ÉTAPE 1 — DÉCRIRE LE BESOIN SANS SOLUTION TECHNIQUE

Documenter le processus standard, le point où le comportement attendu diverge et les données nécessaires. Définir le périmètre fonctionnel, les transactions concernées et les cas où le standard doit rester inchangé.

### 1.E.2 ÉTAPE 2 — REPRODUIRE LE FLUX STANDARD

Exécuter le scénario avec un jeu de données identifié. Relever le programme, la classe ou le framework réellement appelé au moyen des informations système et du débogueur. Ne pas choisir une extension uniquement à partir du nom de la transaction.

### 1.E.3 ÉTAPE 3 — INVENTORIER LES MÉCANISMES FOURNIS

Rechercher d’abord les BAdI et enhancement spots documentés, puis les customer exits, user exits, BTE ou points explicites propres au domaine. Examiner la documentation, les paramètres disponibles, le moment d’appel et les implémentations déjà actives.

### 1.E.4 ÉTAPE 4 — CHOISIR LE POINT LE PLUS STABLE

Retenir l’extension publique qui reçoit les données nécessaires au moment adéquat et dont le contrat couvre le besoin. Écarter les points appelés trop tôt, trop tard ou seulement dans une variante du processus. Documenter pourquoi les autres candidats ne conviennent pas.

### 1.E.5 ÉTAPE 5 — ISOLER LE CODE CLIENT

Maintenir l’implémentation d’extension légère et déléguer la logique à une classe Z testable. Ne modifier aucun objet SAP standard. Encadrer le comportement par des conditions métier explicites, sans dépendance implicite à un utilisateur ou un système.

### 1.E.6 ÉTAPE 6 — TESTER ET PRÉPARER LA MAINTENANCE

Tester le cas cible, les scénarios hors périmètre, les erreurs et les exécutions concurrentes si elles existent. Relever les objets, activations, filtres et transports. Après une mise à niveau, retester le point d’appel et le contrat de données avant de conclure que l’extension reste valide.

## 1.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 1.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 1.H FICHE DE CONTRÔLE À COPIER

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

## 1.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 1.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP: Enhancement Concepts — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/f17cdbf76d1f4cb8805ed69891eafdd9.html)
- [Enhancement Framework — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/e322becd165844e5868e590bc8efafaf/949cdc40132a8531e10000000a1550b0.html)
- [Enhancement Technologies — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/46a2cfc13d25463b8b9a3d2a3c3ba0d9/7063da4023a28631e10000000a1550b0.html)

---

[Chapitre suivant — CHOISIR UNE TECHNOLOGIE D’EXTENSION](<./02 ├── CHOISIR UNE TECHNOLOGIE D EXTENSION.md>)
