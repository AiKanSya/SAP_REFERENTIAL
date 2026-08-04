# 7. PROTÉGER UN MODULE RFC

## 7.A RÉSULTAT ATTENDU

Appliquer les contrôles techniques et métier dans le module appelé, indépendamment de la confiance accordée à la destination RFC[^terme-destination-rfc].

## 7.B PROCESS

### 7.B.1 Étape 1 — Confirmer la nécessité de l’accès distant

Activer l’option RFC du module uniquement si un consommateur distant identifié doit l’appeler. Documenter le système appelant, la destination, l’utilisateur technique et l’action métier exposée.

Une destination `SM59`[^outil-sm59] fonctionnelle ne constitue pas une autorisation métier.

### 7.B.2 Étape 2 — Définir un contrat d’interface strict

Utiliser uniquement des types compatibles RFC dans l’interface. Pour chaque paramètre, définir :

- son type DDIC[^terme-acro-ddic] ;
- son caractère obligatoire ou facultatif ;
- son domaine de valeurs ;
- sa longueur et son volume maximal ;
- les erreurs retournées.

Éviter les paramètres génériques ou les structures permettant de choisir librement une table, une classe[^terme-classe], une fonction ou un programme.

### 7.B.3 Étape 3 — Valider toutes les entrées au début du module

Rejeter avant toute lecture ou modification :

- les valeurs obligatoires initiales ;
- les valeurs hors domaine ;
- les tables internes trop volumineuses ;
- les combinaisons fonctionnelles incohérentes ;
- les noms dynamiques absents d’une liste d’autorisation.

Le système cible doit considérer les paramètres RFC comme des entrées externes non fiables.

### 7.B.4 Étape 4 — Exécuter les contrôles métier dans le système cible

Placer les `AUTHORITY-CHECK` avant chaque lecture sensible ou modification. Contrôler les activités et valeurs organisationnelles du scénario avec l’utilisateur réellement utilisé par la destination.

Le contrôle `S_RFC` autorise l’appel RFC au niveau technique. Il ne remplace pas les objets d’autorisation métier du module.

### 7.B.5 Étape 5 — Maîtriser les écritures et la transaction logique

Définir explicitement qui déclenche `COMMIT WORK`[^terme-commit-work] ou `ROLLBACK WORK`[^terme-rollback-work]. Éviter un commit implicite caché dans une API[^terme-api] appelée si le contrat RFC prévoit que l’appelant contrôle la transaction.

Pour une opération susceptible d’être rejouée après une erreur réseau, prévoir une clé fonctionnelle ou technique permettant d’éviter un doublon.

### 7.B.6 Étape 6 — Retourner des erreurs exploitables sans fuite d’information

Définir des exceptions ou une structure de retour stable. Fournir au consommateur un code et un message fonctionnels, sans exposer de pile d’appel, de chemin serveur, de secret ou de contenu personnel.

Journaliser côté cible un identifiant de corrélation et les éléments techniques nécessaires, dans un journal dont l’accès est protégé.

### 7.B.7 Étape 7 — Vérifier la destination et les rôles

Avec les équipes Basis et sécurité, contrôler dans `SM59` :

- le système cible ;
- le mode d’authentification ;
- l’utilisateur réellement utilisé ;
- les autorisations `S_RFC` nécessaires ;
- l’absence de droits génériques inutiles.

### 7.B.8 Étape 8 — Exécuter les tests positifs et négatifs

Tester au minimum :

1. appel technique autorisé et action métier autorisée ;
2. refus `S_RFC` ;
3. appel RFC autorisé mais autorisation métier refusée ;
4. paramètre invalide ;
5. volume excessif ;
6. répétition du même appel d’écriture.

Utiliser une trace[^terme-trace] d’autorisation ciblée dans le système cible pour confirmer l’utilisateur, les objets et les valeurs contrôlés.

## 7.C CONTRÔLE

Tester avec l’utilisateur réellement configuré sur la destination, pas seulement avec un compte développeur disposant de droits étendus.

## 7.D RÉFÉRENCES OFFICIELLES SAP

- [RFC Authorizations — SAP SE, SAP NetWeaver AS ABAP](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c495ada972d045b2be2869f5573af8e7/488de31b81cd0e27e10000000a421937.html)
- [Authorization Checks — SAP SE, SAP S/4HANA](https://help.sap.com/docs/ABAP_PLATFORM_NEW/88c6b8647c8d40b39eb554e2d7b6bda1/4ca0ac7a68243b9ee10000000a42189b.html)

[^terme-destination-rfc]: **DESTINATION RFC.** Configuration `SM59` décrivant comment joindre une cible RFC. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-commit-work]: **COMMIT WORK.** Instruction clôturant la SAP LUW courante, déclenchant notamment les mises à jour enregistrées et validant la base. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#commit-work>).
[^terme-rollback-work]: **ROLLBACK WORK.** Instruction annulant les modifications non validées de la LUW courante et les tâches de mise à jour enregistrées. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#rollback-work>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).

[^outil-sm59]: **SM59.** Transaction de création, test et maintenance des destinations RFC. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/14 ├── DESTINATIONS RFC AVEC SM59.md>).
