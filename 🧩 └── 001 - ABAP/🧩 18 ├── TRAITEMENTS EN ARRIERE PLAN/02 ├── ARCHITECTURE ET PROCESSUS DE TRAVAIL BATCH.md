# ARCHITECTURE ET PROCESSUS DE TRAVAIL BATCH

## RÉSULTAT ATTENDU

- Comprendre où un job est exécuté
- Identifier le rôle du planificateur et des processus de travail
- Expliquer pourquoi un job peut attendre après son heure théorique

## ARCHITECTURE SIMPLIFIÉE

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

## SERVEUR CIBLE

Un job peut être affecté à un serveur d’application précis. Cette contrainte doit rester exceptionnelle : elle réduit les possibilités de répartition de charge et peut empêcher le démarrage si le serveur est indisponible.

Un serveur cible est justifié seulement lorsqu’une dépendance technique l’impose, par exemple :

- accès à une ressource locale au serveur ;
- commande externe installée sur un hôte précis ;
- configuration Basis spécifique ;
- contrainte explicitement documentée par SAP.

## OUTILS D’ANALYSE

- `SM37` : statut et serveur d’exécution du job ;
- `SM50` : processus de travail de l’instance courante ;
- `SM51` : liste des serveurs d’application ;
- `RZ04` : modes d’exploitation et répartition des processus ;
- `SM21` : journal système.

## PROCESS

### ÉTAPE 1 — IDENTIFIER L’EXÉCUTION ET LE SERVEUR

Dans `SM37`, ouvrir le job et relever l’heure, l’étape, le statut et le serveur d’exécution. Distinguer l’attente de planification, l’attente d’un processus batch et l’exécution réelle. Ne pas attribuer un retard au programme avant son démarrage effectif.

### ÉTAPE 2 — CONTRÔLER LE PROGRAMME DE L’ÉTAPE

Relever le programme, la variante, l’utilisateur et la classe. Vérifier si l’étape appelle un programme ABAP, une commande externe ou un programme externe. Chaque type utilise un contexte et des autorisations différents.

### ÉTAPE 3 — EXAMINER LA DISPONIBILITÉ BATCH

Avec les outils d’administration autorisés, contrôler les processus de travail batch disponibles sur le serveur et les groupes de serveurs définis. Corréler leur occupation avec l’heure prévue du job. Une absence de capacité doit être traitée avec Basis, pas contournée dans le code.

### ÉTAPE 4 — DISTINGUER TEMPS D’ATTENTE ET TEMPS D’EXÉCUTION

Comparer l’heure prévue, l’heure de début et l’heure de fin dans `SM37`. Calculer séparément le retard de démarrage et la durée du programme. Utiliser ensuite le journal, le spool ou une trace ciblée uniquement pour la partie réellement lente.

### ÉTAPE 5 — VÉRIFIER LES CONTRAINTES DE CIBLAGE

Contrôler la classe de job, le serveur cible, le groupe de serveurs et les restrictions d’exploitation. Vérifier qu’un ciblage trop étroit ne force pas le job à attendre une ressource indisponible. Toute modification de capacité ou de classe relève de la gouvernance Basis.

### ÉTAPE 6 — REPRODUIRE ET MESURER

Planifier une exécution contrôlée avec les mêmes caractéristiques et un volume représentatif. Conserver les horodatages, le serveur et les ressources. Comparer avant/après correction sans mélanger un gain de capacité système et une optimisation du programme ABAP.

## VÉRIFICATION

- Le job apparaît dans `SM37` avec le statut attendu.
- Le journal ne contient pas de message d’erreur non traité.
- Le spool, le fichier ou le journal applicatif contient le résultat attendu.
- Une relance contrôlée ne crée pas de doublon métier.

## ERREURS FRÉQUENTES

- Planifier un job avec l’utilisateur personnel d’un développeur.
- Relancer un job non idempotent après un échec partiel.

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

- [Processus de travail](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-travail>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)
- [Spool](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>)
- [Processus background](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#processus-background>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)

## RÉFÉRENCES OFFICIELLES SAP

- [Background Work Processes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2b3c3e8eb51780e10000000a42189c.html)
- [Job Start Management — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b07e7195f03f438b8e7ed273099d74f3/4b2bc0094c594ba2e10000000a42189c.html)

---

[Chapitre suivant — JOBS ET ÉTAPES DE JOB](<./03 ├── JOBS ET ETAPES DE JOB.md>)
