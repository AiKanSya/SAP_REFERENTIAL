# 🌸 ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH

## 🌺 OBJECTIFS

- Comprendre où un job est exécuté
- Identifier le rôle du planificateur et des processus de travail
- Expliquer pourquoi un job peut attendre après son heure théorique

## 🌺 ARCHITECTURE SIMPLIFIÉE

```mermaid
flowchart TD
    A["Job libéré"] --> B["Planificateur de jobs"]
    B --> C{"Condition atteinte ?"}
    C -->|"Non"| B
    C -->|"Oui"| D["Statut prêt"]
    D --> E{"Processus batch disponible ?"}
    E -->|"Non"| D
    E -->|"Oui"| F["Exécution de l étape"]
```

Les processus de travail de fond sont configurés sur les serveurs d’application. Un job prêt peut rester en attente si aucune ressource compatible n’est disponible ou si des jobs de priorité supérieure doivent être servis.

## 🌺 SERVEUR CIBLE

Un job peut être affecté à un serveur d’application précis. Cette contrainte doit rester exceptionnelle : elle réduit les possibilités de répartition de charge et peut empêcher le démarrage si le serveur est indisponible.

Un serveur cible est justifié seulement lorsqu’une dépendance technique l’impose, par exemple :

- accès à une ressource locale au serveur ;
- commande externe installée sur un hôte précis ;
- configuration Basis spécifique ;
- contrainte explicitement documentée par SAP.

## 🌺 OUTILS D’ANALYSE

- `SM37` : statut et serveur d’exécution du job ;
- `SM50` : processus de travail de l’instance courante ;
- `SM51` : liste des serveurs d’application ;
- `RZ04` : modes d’exploitation et répartition des processus ;
- `SM21` : journal système.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nATC` ou utiliser l’entrée ATC disponible dans le système.
2. Choisir une variante de contrôle autorisée.
3. Lancer le contrôle sur l’objet, le package ou l’ordre de transport.
4. Classer les findings par priorité et corriger d’abord les erreurs bloquantes.
5. Demander une exemption uniquement avec justification, propriétaire et échéance.
6. Relancer le contrôle avant libération.

## 🌺 VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## 🌺 ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

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

- [Processus de travail](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-travail>)
- [Job](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/06 - 🍧 PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)
- [Job Start Management — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc0094c594ba2e10000000a42189c.html)


---

➡️ [Chapitre suivant — JOBS ET ÉTAPES DE JOB](<./03 - 🍧 JOBS ET ETAPES DE JOB.md>)
