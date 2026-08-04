# 1. PRINCIPES DES JOURNAUX APPLICATIFS

## 1.A RÉSULTAT ATTENDU

- Comprendre le rôle du journal applicatif SAP
- Distinguer un journal applicatif d’un message utilisateur, d’un spool et d’un dump
- Identifier les traitements qui doivent produire un journal persistant

## 1.B DÉFINITION

Le **Business Application Log**, couramment appelé **Application Log** ou **BAL**, fournit une infrastructure standard pour collecter des messages métier et techniques, les conserver en base et les analyser ultérieurement.

```mermaid
flowchart LR
    A["Traitement applicatif"] --> B["Collecte des messages"]
    B --> C["Journal en mémoire"]
    C --> D["Persistance en base"]
    D --> E["Analyse avec SLG1"]
```

Un journal regroupe un en-tête et une suite de messages. Il permet de reconstituer le déroulement d’un traitement après sa fin, notamment lorsque l’utilisateur n’était pas présent.

## 1.C CAS D’USAGE

- import ou export de données ;
- traitement en arrière-plan ;
- création ou modification en masse ;
- appel d’interfaces ;
- reprise après erreur ;
- traitement technique nécessitant une piste de diagnostic ;
- contrôle fonctionnel produisant plusieurs avertissements ou erreurs.

## 1.D CE QU’UN JOURNAL NE REMPLACE PAS

| Besoin                                 | Outil principal                 |
| -------------------------------------- | ------------------------------- |
| Informer immédiatement l’utilisateur   | `MESSAGE` ou retour d’interface |
| Diagnostiquer une terminaison anormale | `ST22`                          |
| Tracer les événements système          | `SM21`                          |
| Produire une liste imprimable          | Spool                           |
| Mesurer les performances               | `SAT`, `ST05`, `ST12`           |
| Conserver le déroulement applicatif    | Application Log                 |

Un même traitement peut utiliser plusieurs de ces mécanismes. Le journal applicatif ne doit pas masquer une exception ou remplacer une gestion transactionnelle correcte.

## 1.E PROCESS

### 1.E.1 ÉTAPE 1 — DÉFINIR LE CONSOMMATEUR DU JOURNAL

Identifier qui doit diagnostiquer le traitement, pendant combien de temps et avec quels critères. Définir les questions auxquelles le journal doit répondre : exécution, unité métier, étape, résultat et cause d’échec.

### 1.E.2 ÉTAPE 2 — CHOISIR OBJET, SOUS-OBJET ET IDENTIFIANT

Réutiliser un objet `SLG0` correspondant au domaine et un sous-objet correspondant au processus. Construire un identifiant externe stable et recherchable : lot, fichier, document ou message. Exclure les mots de passe, jetons et données personnelles inutiles.

### 1.E.3 ÉTAPE 3 — CRÉER LE JOURNAL EN MÉMOIRE

Construire un en-tête `BAL_S_LOG`, appeler l’API de création et conserver le handle retourné. Contrôler immédiatement l’erreur de configuration. Aucun ajout ne doit être tenté avec un handle initial ou non valide.

### 1.E.4 ÉTAPE 4 — AJOUTER DES MESSAGES STRUCTURÉS

Utiliser des messages T100 pour les événements stables et traduisibles, du texte libre uniquement pour un diagnostic dynamique, et l’API d’exception pour préserver le contexte d’une exception. Associer gravité, classe de problème, détail et clé métier de manière cohérente.

### 1.E.5 ÉTAPE 5 — SAUVEGARDER SELON LA LUW

Décider si le journal est atomique avec la transaction métier ou s’il doit survivre à son rollback. Sauvegarder uniquement les handles du composant. Ne jamais ajouter un `COMMIT WORK` uniquement pour rendre le journal visible sans analyser la SAP LUW.

### 1.E.6 ÉTAPE 6 — PROUVER LA RECHERCHE ET LA RÉTENTION

Rechercher l’exécution dans `SLG1` avec objet, sous-objet, identifiant et période. Vérifier le contenu, les autorisations et les messages d’erreur. Tester la politique de suppression ou d’archivage afin que le journal reste exploitable sans croissance indéfinie.

## 1.F VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 1.G ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

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

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 1.J RÉFÉRENCES OFFICIELLES SAP

- [Application Log – Guidelines for Developers — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/addb96cd90c945dfb3182865363bbc47/4e21000f35d44180e10000000a15822b.html)
- [Application Logging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/864321b9b3dd487d94c70f6a007b0397/c769bcc9f36611d3a6510000e835363f.html)

---

[Chapitre suivant — ARCHITECTURE ET CYCLE DE VIE DU BAL](<./02 ├── ARCHITECTURE ET CYCLE DE VIE DU BAL.md>)
