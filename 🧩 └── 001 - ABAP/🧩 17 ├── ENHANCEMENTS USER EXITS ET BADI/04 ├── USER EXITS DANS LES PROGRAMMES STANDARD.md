# 4. USER EXITS DANS LES PROGRAMMES STANDARD

## 4.A RÉSULTAT ATTENDU

- Reconnaître un user exit historique codé dans un programme SAP[^terme-acro-sap]
- Comprendre son mode d’implémentation
- Éviter la modification directe du programme principal

## 4.B PRINCIPE

Dans certaines applications classiques, SAP fournit des routines ou includes dédiés au code client. Elles peuvent porter un nom tel que `USEREXIT_*` et être appelées depuis le flux standard.

Exemple de forme historique :

```abap
FORM userexit_prepare_data.
  " Déléguer la logique à une classe client
  zcl_dev_extension=>prepare_data(
    CHANGING
      cs_data = gs_data ).
ENDFORM.
```

Le nom, l’emplacement et les paramètres dépendent de l’application. Ne pas créer arbitrairement une routine `USEREXIT_*` : elle doit déjà être appelée par le standard.

## 4.C CARACTÉRISTIQUES

- technologie liée à une application précise ;
- interface souvent constituée de données globales du programme ;
- forte dépendance au contexte d’exécution ;
- faible isolation par rapport au standard ;
- transport du code client comme objet Repository[^terme-objet-repository].

## 4.D PRÉCAUTIONS

- vérifier l’appel par breakpoint[^terme-breakpoint] ;
- ne modifier que l’include client prévu ;
- ne pas dépendre de variables globales non documentées sans contrôle ;
- ne pas interrompre le flux standard par `MESSAGE A`, `LEAVE` ou commit sans nécessité ;
- encapsuler le traitement dans une classe[^terme-classe] client ;
- documenter la transaction et l’événement métier concernés.

## 4.E PROCESS

### 4.E.1 ÉTAPE 1 — RETROUVER LE PROGRAMME RÉEL

Depuis le scénario standard, relever le programme principal et la pile d’appels. Ouvrir l’objet en affichage dans `SE80`[^outil-se80] ou `SE38`[^outil-se38]. Ne pas rechercher uniquement dans le programme de transaction si le traitement est délégué à des includes ou groupes de fonctions.

### 4.E.2 ÉTAPE 2 — RECHERCHER LES CONVENTIONS D’EXIT

Rechercher les `FORM USEREXIT_*`, includes client documentés et appels associés. Examiner aussi les commentaires SAP et la documentation du composant. Un nom ressemblant à un user exit ne prouve pas qu’il est prévu pour le scénario.

### 4.E.3 ÉTAPE 3 — ANALYSER LES DONNÉES DISPONIBLES

Dans le point candidat, relever les paramètres formels, données globales utilisées et structures modifiables. Identifier les validations et mises à jour exécutées après le retour. Écarter un exit dont l’utilisation exigerait de modifier indirectement un état non contractuel.

### 4.E.4 ÉTAPE 4 — CONFIRMER PAR UN BREAKPOINT

Placer un breakpoint dans l’exit sans modifier le standard, puis reproduire le scénario. Vérifier la pile d’appels, les valeurs et le nombre de passages. Tester aussi un scénario proche hors périmètre pour déterminer la condition d’activation nécessaire.

### 4.E.5 ÉTAPE 5 — IMPLÉMENTER DANS LA ZONE CLIENT AUTORISÉE

Ajouter le code uniquement dans l’include ou le mécanisme client prévu. Déléguer la logique à une classe Z et conserver dans l’exit l’adaptation des paramètres. Ne pas créer de modification directe de l’objet SAP.

### 4.E.6 ÉTAPE 6 — TESTER ACTIVATION ET NON-RÉGRESSION

Activer les objets client et exécuter le scénario complet. Vérifier le résultat, les messages, la LUW[^terme-acro-luw] et les performances. Contrôler ensuite un cas où la condition client est fausse afin de prouver que le standard reste inchangé.

## 4.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 4.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 4.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
FORM userexit_prepare_data.
  " Déléguer la logique à une classe client
  zcl_dev_extension=>prepare_data(
    CHANGING
      cs_data = gs_data ).
ENDFORM.
```

## 4.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 4.J RÉFÉRENCES OFFICIELLES SAP

- [Enhancements, User Exits and Customer Exits — SAP Help Portal](https://help.sap.com/docs/btp/ABAP/3353526313.html)
- [Enhancements and Modifications — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353523593.html)

---

[Chapitre suivant — CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES](<./05 ├── CUSTOMER EXITS ET ENHANCEMENTS CLASSIQUES.md>)

[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-objet-repository]: **OBJET REPOSITORY.** Unité de développement gérée par le Repository et le système de transport. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-acro-luw]: **LUW.** Logical Unit of Work. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-luw>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-se80]: **SE80.** Object Navigator utilisé pour parcourir et maintenir les objets du Repository ABAP. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
[^outil-se38]: **SE38.** Éditeur ABAP classique utilisé pour créer, modifier, vérifier et exécuter des programmes. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/04 ├── EDITEURS ABAP SE38 ET SE80.md>).
