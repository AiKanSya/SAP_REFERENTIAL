# 12. EXTENDED PROGRAM CHECK AVEC SLIN

## 12.A RÉSULTAT ATTENDU

Exécuter les contrôles approfondis de la transaction `SLIN`[^outil-slin] sur des sources actives.

## 12.B Exécution

- appeler directement `SLIN` ;
- ou utiliser le menu **Programme > Vérifier > Vérification étendue du programme** dans l’éditeur ABAP[^terme-abap] ;
- sélectionner le programme et les groupes de contrôles ;
- lancer l’analyse ;
- ouvrir chaque message et naviguer vers la source.

## 12.C Catégories rencontrées

Les options exactes dépendent de la release. Elles peuvent couvrir :

- erreurs et avertissements statiques ;
- interfaces de procédures ;
- conversions et accès mémoire ;
- sécurité ;
- package[^terme-package] et dépendances ;
- instructions problématiques.

## 12.D Source active

La vérification étendue s’appuie sur la version active. Activer les objets avant l’analyse, sinon les résultats peuvent ne pas correspondre au code en cours de modification.

## 12.E Traiter un message

1. Comprendre la règle et le scénario détecté.
2. Vérifier si le chemin est réellement possible.
3. Corriger la cause.
4. Relancer le contrôle.
5. Documenter toute suppression autorisée.

## 12.F SLIN n’est pas un test fonctionnel

Il détecte des problèmes reconnaissables statiquement. Il ne valide ni le résultat métier ni la qualité des données produites.

## 12.G Références SAP officielles

- [ABAP Keyword Documentation — Extended Program Check](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXTENDED_PROGRAM_CHECK_GUIDL.html)

## 12.H PROCESS

### 12.H.1 ÉTAPE 1 — ACTIVER UNE VERSION SYNTACTIQUEMENT VALIDE

Contrôler et activer le programme et ses includes. SLIN analyse le code disponible, mais ne remplace pas le contrôle syntaxique. Relever la version et le système utilisés.

### 12.H.2 ÉTAPE 2 — LANCER SLIN SUR LE BON PÉRIMÈTRE

Saisir `/nSLIN` ou utiliser l’entrée de contrôle étendu de l’éditeur. Renseigner le programme, la classe[^terme-classe] ou l’objet supporté puis sélectionner les groupes de contrôles nécessaires. Exécuter sans élargir inutilement à tout le système.

### 12.H.3 ÉTAPE 3 — CLASSER LES MESSAGES

Regrouper les findings par flux de données, interface, exception[^terme-exception], instruction dangereuse ou code inaccessible. Ouvrir la documentation de chaque règle. Commencer par les erreurs susceptibles de produire un défaut runtime.

### 12.H.4 ÉTAPE 4 — NAVIGUER VERS LA SOURCE

Ouvrir la ligne indiquée et analyser le chemin d’exécution complet. Vérifier les types, valeurs initiales et appels. Ne pas neutraliser le finding par un pragma ou pseudo-commentaire avant d’avoir prouvé son absence d’impact.

### 12.H.5 ÉTAPE 5 — CORRIGER ET TESTER LE CAS SIGNALÉ

Modifier le code, ajouter un test reproduisant la condition puis exécuter le périmètre fonctionnel. Pour un finding considéré faux positif, conserver la preuve et appliquer uniquement le mécanisme d’exemption autorisé.

### 12.H.6 ÉTAPE 6 — RELANCER SLIN ET ATC

Vérifier la disparition du message et l’absence de nouveaux findings. Exécuter ensuite la variante ATC[^terme-acro-atc] ou SCI[^outil-sci] du projet, plus large que SLIN, avant livraison.

## 12.I VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 12.J ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 12.K FICHE DE CONTRÔLE À COPIER

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

## 12.L TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).

[^outil-slin]: **SLIN.** Extended Program Check utilisé pour détecter des problèmes statiques au-delà du contrôle syntaxique. Voir [le chapitre associé](<12 ├── EXTENDED PROGRAM CHECK AVEC SLIN.md>).
[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<13 ├── CODE INSPECTOR AVEC SCI.md>).
