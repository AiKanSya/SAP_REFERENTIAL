# 11. CONTROLES STATIQUES ET CONTROLE SYNTAXIQUE

## 11.A RÉSULTAT ATTENDU

Distinguer les vérifications immédiates de l’éditeur des analyses statiques plus approfondies.

## 11.B Niveaux de contrôle

| Contrôle               | Portée                                          |
| ---------------------- | ----------------------------------------------- |
| Contrôle syntaxique    | grammaire, typage et incohérences immédiates    |
| Activation             | génération de la version active et dépendances  |
| Extended Program Check | erreurs statiquement détectables plus coûteuses |
| Code Inspector / ATC[^terme-acro-atc]   | règles regroupées dans une variante de contrôle |
| ABAP[^terme-abap] Unit              | comportement exécuté                            |

Le contrôle syntaxique doit être exécuté avant l’activation. Une activation réussie ne signifie pas que le programme respecte les règles de sécurité, de performance ou de maintenabilité.

## 11.C Exemples de défauts statiques

- variable jamais utilisée ;
- conversion dangereuse ;
- accès non sécurisé ;
- code inaccessible ;
- exception[^terme-exception] ignorée ;
- instruction obsolète ;
- problème de package[^terme-package] ou d’API[^terme-api] selon la variante.

## 11.D Pseudo-commentaires et pragmas

Ils peuvent supprimer certains messages, mais ne corrigent pas la cause. Leur usage doit être exceptionnel, documenté et compatible avec la gouvernance ATC du projet.

## 11.E Routine développeur

1. Contrôle syntaxique après chaque unité cohérente.
2. Activation de tous les objets dépendants.
3. Contrôle local `ATC` ou `SCI`[^outil-sci].
4. Exécution des tests.
5. Contrôle officiel avant libération du transport.

## 11.F Références SAP officielles

- [ABAP Keyword Documentation — Extended Program Check](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXTENDED_PROGRAM_CHECK_GUIDL.html)
- [SAP Help Portal — Code Inspector](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/49205531d0fc14cfe10000000a42189b.html)
- [SAP Help Portal — ATC Quality Checking](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec1a1126e391014adc9fffe4e204223.html)

## 11.G PROCESS

### 11.G.1 ÉTAPE 1 — CONTRÔLER LA SYNTAXE DE L’OBJET

Depuis l’éditeur, lancer le contrôle syntaxique sur la version active et les includes concernés. Traiter chaque erreur avant activation. Vérifier également les objets dépendants modifiés, car un objet isolé peut rester cohérent alors que l’ensemble ne l’est pas.

### 11.G.2 ÉTAPE 2 — ACTIVER DANS L’ORDRE DES DÉPENDANCES

Activer types DDIC[^terme-acro-ddic], interfaces, classes et programmes selon leur dépendance. Contrôler les messages d’activation. Ne pas utiliser une version inactive différente de celle exécutée pour valider un test.

### 11.G.3 ÉTAPE 3 — LANCER LE CONTRÔLE ÉTENDU

Exécuter SLIN[^outil-slin] sur le programme ou l’objet lorsque l’outil le supporte. Analyser les avertissements sur flux de données, exceptions, conversions et code inaccessible. Distinguer un faux positif prouvé d’un message seulement gênant.

### 11.G.4 ÉTAPE 4 — EXÉCUTER SCI OU ATC

Utiliser la variante approuvée sur l’objet, le package ou la demande. Conserver l’identifiant du run et la version analysée. Les contrôles centraux ATC priment selon la gouvernance du projet.

### 11.G.5 ÉTAPE 5 — CORRIGER ET TESTER

Pour chaque finding, ouvrir la ligne, comprendre la règle et corriger la cause. Exécuter ABAP Unit et les tests d’intégration concernés. Une correction statique ne doit pas changer silencieusement le comportement métier.

### 11.G.6 ÉTAPE 6 — RELANCER SUR LE PÉRIMÈTRE LIVRÉ

Répéter syntaxe, activation et contrôles sur tous les objets de la demande. Vérifier qu’aucun finding bloquant ne subsiste et que toute exemption possède justification, propriétaire et échéance.

## 11.H VÉRIFICATION

- Le résultat fonctionnel est identique avant et après optimisation.
- La mesure est répétée avec le même jeu de données et le même contexte.
- Les contrôles statiques ne retournent plus de finding bloquant.
- Les tests automatiques couvrent les cas nominal, limites et erreurs attendues.

## 11.I ERREURS FRÉQUENTES

- Optimiser sans mesure de référence.
- Accepter un finding critique sans correction ni justification formelle.

## 11.J FICHE DE CONTRÔLE À COPIER

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

## 11.K TERMES DU LEXIQUE

- [ATC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>)
- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

[^terme-acro-atc]: **ATC.** ABAP Test Cockpit, infrastructure de contrôles statiques et de gouvernance qualité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-atc>).
[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-sci]: **SCI.** Code Inspector utilisé pour exécuter des contrôles statiques sur un ensemble d’objets ABAP. Voir [le chapitre associé](<13 ├── CODE INSPECTOR AVEC SCI.md>).
[^outil-slin]: **SLIN.** Extended Program Check utilisé pour détecter des problèmes statiques au-delà du contrôle syntaxique. Voir [le chapitre associé](<12 ├── EXTENDED PROGRAM CHECK AVEC SLIN.md>).
