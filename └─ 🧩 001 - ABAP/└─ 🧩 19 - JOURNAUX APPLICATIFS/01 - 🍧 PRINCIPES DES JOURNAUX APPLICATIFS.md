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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Application Log – Guidelines for Developers — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/addb96cd90c945dfb3182865363bbc47/4e21000f35d44180e10000000a15822b.html)
- [Application Logging — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/864321b9b3dd487d94c70f6a007b0397/c769bcc9f36611d3a6510000e835363f.html)

---

➡️ [Chapitre suivant — ARCHITECTURE ET CYCLE DE VIE DU BAL](<./02 - 🍧 ARCHITECTURE ET CYCLE DE VIE DU BAL.md>)
