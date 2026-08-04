# 🌸 PRINCIPES DES JOURNAUX APPLICATIFS

## 🌺 OBJECTIFS

- Comprendre le rôle du journal applicatif SAP
- Distinguer un journal applicatif d’un message utilisateur, d’un spool et d’un dump
- Identifier les traitements qui doivent produire un journal persistant

## 🌺 DÉFINITION

Le **Business Application Log**, couramment appelé **Application Log** ou **BAL**, fournit une infrastructure standard pour collecter des messages métier et techniques, les conserver en base et les analyser ultérieurement.

```mermaid
flowchart LR
    A["Traitement applicatif"] --> B["Collecte des messages"]
    B --> C["Journal en mémoire"]
    C --> D["Persistance en base"]
    D --> E["Analyse avec SLG1"]
```

Un journal regroupe un en-tête et une suite de messages. Il permet de reconstituer le déroulement d’un traitement après sa fin, notamment lorsque l’utilisateur n’était pas présent.

## 🌺 CAS D’USAGE

- import ou export de données ;
- traitement en arrière-plan ;
- création ou modification en masse ;
- appel d’interfaces ;
- reprise après erreur ;
- traitement technique nécessitant une piste de diagnostic ;
- contrôle fonctionnel produisant plusieurs avertissements ou erreurs.

## 🌺 CE QU’UN JOURNAL NE REMPLACE PAS

| Besoin                                 | Outil principal                 |
| -------------------------------------- | ------------------------------- |
| Informer immédiatement l’utilisateur   | `MESSAGE` ou retour d’interface |
| Diagnostiquer une terminaison anormale | `ST22`                          |
| Tracer les événements système          | `SM21`                          |
| Produire une liste imprimable          | Spool                           |
| Mesurer les performances               | `SAT`, `ST05`, `ST12`           |
| Conserver le déroulement applicatif    | Application Log                 |

Un même traitement peut utiliser plusieurs de ces mécanismes. Le journal applicatif ne doit pas masquer une exception ou remplacer une gestion transactionnelle correcte.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nST22`.
2. Choisir la période correspondant à la reproduction.
3. Filtrer par utilisateur, transaction ou runtime error lorsque nécessaire.
4. Ouvrir le dump et relever le nom de l’erreur, l’exception, le programme et la ligne source.
5. Lire les sections **Error analysis**, **How to correct the error** et **Source Code Extract**.
6. Corréler le dump avec les données d’entrée et la version active du code.

## 🌺 VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 🌺 ERREURS FRÉQUENTES

- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

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

- [Application Log](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/10 - 🍧 ACRONYMES SAP.md#acro-bal>)
- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Application Log – Guidelines for Developers — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/addb96cd90c945dfb3182865363bbc47/4e21000f35d44180e10000000a15822b.html)
- [Application Logging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/864321b9b3dd487d94c70f6a007b0397/c769bcc9f36611d3a6510000e835363f.html)


---

➡️ [Chapitre suivant — ARCHITECTURE ET CYCLE DE VIE DU BAL](<./02 - 🍧 ARCHITECTURE ET CYCLE DE VIE DU BAL.md>)
