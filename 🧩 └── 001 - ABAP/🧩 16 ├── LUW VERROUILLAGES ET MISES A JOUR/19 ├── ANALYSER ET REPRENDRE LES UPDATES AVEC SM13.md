# 19. ANALYSER ET REPRENDRE LES UPDATES AVEC `SM13`

## 19.A RÉSULTAT ATTENDU

- Rechercher une demande de mise à jour en erreur
- Identifier le module et la cause
- Décider si une reprise est sûre

## 19.B RECHERCHE

Dans `SM13`[^outil-sm13], filtrer notamment par :

- utilisateur ;
- date et heure ;
- mandant[^terme-mandant] ;
- statut ;
- transaction ou identifiant de demande.

Analyser ensuite :

- le module fonction[^terme-module-fonction] en erreur ;
- le message ou le dump associé ;
- les paramètres enregistrés ;
- les modules V1 et V2 de la demande ;
- l’état actuel des données métier.

## 19.C REPRISE

```mermaid
flowchart TD
    A["Update en erreur"] --> B["Corriger la cause technique"]
    B --> C["Vérifier l état métier actuel"]
    C --> D{"Reprise idempotente et sûre ?"}
    D -->|"Oui"| E["Relancer selon la procédure autorisée"]
    D -->|"Non"| F["Correction métier contrôlée"]
```

Ne pas relancer mécaniquement une demande ancienne. Les données ou le customizing[^terme-customizing] peuvent avoir changé, et un traitement manuel peut avoir déjà compensé l’erreur.

## 19.D OUTILS ASSOCIÉS

- `ST22`[^outil-st22] pour un dump du module de mise à jour ;
- `SM12`[^outil-sm12] pour les verrous ;
- `SM21`[^outil-sm21] pour le journal système ;
- `SLG1`[^outil-slg1] si l’application écrit un journal applicatif ;
- `SM14`[^outil-sm14] pour l’état administratif du système de mise à jour.

## 19.E PROCESS

### 19.E.1 ÉTAPE 1 — DÉLIMITER L’INCIDENT

Relever l’utilisateur, le mandant, la transaction, l’heure, le document métier et le message reçu. Vérifier dans `ST22` si un dump correspond au même intervalle. Ces éléments évitent de diagnostiquer une update homonyme appartenant à un autre traitement.

### 19.E.2 ÉTAPE 2 — RECHERCHER L’UPDATE DANS `SM13`

Saisir `/nSM13`, renseigner l’utilisateur et la période la plus courte possible, puis sélectionner le statut pertinent. Ouvrir l’entrée correspondant à l’heure et à l’identifiant métier attendus. Relever son identifiant, son statut et sa séquence de modules.

### 19.E.3 ÉTAPE 3 — LOCALISER LE PREMIER MODULE EN ÉCHEC

Consulter les détails et les données enregistrées pour identifier le module qui a échoué, son message et ses paramètres. Distinguer la première erreur des modules seulement non exécutés ensuite. Corréler le code actif et les valeurs enregistrées au moment de la SAP LUW[^terme-sap-luw] initiale.

### 19.E.4 ÉTAPE 4 — CONTRÔLER L’ÉTAT MÉTIER PERSISTANT

Vérifier les tables V1 et V2, les documents créés et les verrous restants. Déterminer précisément ce qui a été validé avant l’échec. Ne pas conclure qu’aucune donnée n’existe uniquement parce que l’update porte le statut d’erreur.

### 19.E.5 ÉTAPE 5 — CORRIGER LA CAUSE RACINE

Corriger la donnée de référence, l’autorisation, le paramétrage ou le programme identifié. Tester la correction avec les mêmes caractéristiques en développement ou en qualité. Conserver les preuves de l’update initiale avant toute suppression ou répétition.

### 19.E.6 ÉTAPE 6 — ÉVALUER LA RÉPÉTITION

Vérifier que les modules sont idempotents ou que leur état partiel est compatible avec une répétition. Si une unité déjà créée peut être dupliquée, appliquer d’abord la procédure métier de remise en cohérence. Une répétition dans `SM13` est une action de production, pas un test technique.

### 19.E.7 ÉTAPE 7 — RÉPÉTER ET VALIDER

Après autorisation opérationnelle, répéter l’update ciblée. Contrôler son nouveau statut, les tables concernées, les compteurs métier et l’absence de doublons. Documenter l’identifiant initial, la cause, la correction et le résultat final.

## 19.F VÉRIFICATION

- Les données sont toutes validées ou toutes annulées selon le cas testé.
- Les verrous sont libérés à la fin du traitement normal et après erreur.
- Aucune update en erreur inattendue ne reste dans `SM13`.
- Les collisions concurrentes produisent un message contrôlé, pas une incohérence.

## 19.G ERREURS FRÉQUENTES

- Supprimer manuellement un verrou sans comprendre son propriétaire.
- Relancer une update en erreur sans vérifier l’état métier.

## 19.H FICHE DE CONTRÔLE À COPIER

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

## 19.I TERMES DU LEXIQUE

- [SAP LUW](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>)
- [LUW base de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#luw-base>)
- [COMMIT WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>)
- [ROLLBACK WORK](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>)
- [Enqueue server](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#enqueue-server>)
- [Update task](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#update-task>)

## 19.J RÉFÉRENCES OFFICIELLES SAP

- [Update Management — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/979cf1522d164bf7a781796efd8850ee/078cb02dc14d497f9779f7a309c1a7bc.html)
- [Update Statuses — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/979cf1522d164bf7a781796efd8850ee/3c7ad8b964b74aac9e1d3e709b33e794.html)
- [SM13 - Update Request — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/basis/3354611548.html)

---

[Chapitre suivant — CONCEPTION, DIAGNOSTIC ET BONNES PRATIQUES](<./20 └── CONCEPTION DIAGNOSTIC ET BONNES PRATIQUES.md>)

[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-customizing]: **CUSTOMIZING.** Paramétrage permettant d’adapter le comportement standard SAP à l’organisation. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#customizing>).
[^terme-sap-luw]: **SAP LUW.** Unité logique métier SAP pouvant regrouper plusieurs étapes de dialogue et différer les mises à jour jusqu’au commit. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#sap-luw>).

[^outil-sm13]: **SM13.** Transaction de surveillance et de reprise des enregistrements de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
[^outil-st22]: **ST22.** Transaction d’analyse des terminaisons anormales et dumps ABAP. Voir [le chapitre associé](<../🧩 11 ├── DEBUG ET ANALYSE/13 ├── ANALYSER LES DUMPS AVEC ST22.md>).
[^outil-sm12]: **SM12.** Transaction de surveillance et d’administration des entrées de verrouillage SAP. Voir [le chapitre associé](<12 ├── ANALYSER LES VERROUS AVEC SM12.md>).
[^outil-sm21]: **SM21.** Transaction de consultation du journal système SAP. Voir [le chapitre associé](<../🧩 18 ├── TRAITEMENTS EN ARRIERE PLAN/22 ├── ANALYSER LES ECHECS ET LES RETARDS.md>).
[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<../🧩 19 ├── JOURNAUX APPLICATIFS/05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
[^outil-sm14]: **SM14.** Transaction d’administration du système de mise à jour SAP. Voir [le chapitre associé](<19 ├── ANALYSER ET REPRENDRE LES UPDATES AVEC SM13.md>).
