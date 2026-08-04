# 6. ANALYSER UN ENHANCEMENT AVEC `SMOD`

## 6.A RÉSULTAT ATTENDU

- Afficher la définition d’un enhancement classique
- Examiner ses composants et sa documentation
- Retrouver les objets techniques appelés

## 6.B PROCESS

### 6.B.1 ÉTAPE 1 — OUVRIR LA DÉFINITION DANS `SMOD`

Saisir `/nSMOD`, entrer le nom exact de l’enhancement et choisir **Afficher**. Si le nom est inconnu, utiliser la recherche par composant ou package[^terme-package], puis confirmer chaque résultat avec le programme réellement exécuté.

### 6.B.2 ÉTAPE 2 — LIRE LA DOCUMENTATION

Ouvrir la documentation SAP[^terme-acro-sap] et relever le processus couvert, les conditions d’appel et les restrictions. Comparer ces informations au besoin fonctionnel. Ne pas continuer avec un enhancement dont le contrat ne correspond qu’approximativement au scénario.

### 6.B.3 ÉTAPE 3 — INVENTORIER LES COMPOSANTS

Afficher la liste complète des function, screen et menu exits ainsi que les objets DDIC[^terme-acro-ddic] liés. Pour chaque composant, noter son objet technique, son interface et son rôle. Identifier les composants obligatoires les uns pour les autres.

### 6.B.4 ÉTAPE 4 — REMONTER AU CODE APPELANT

Ouvrir le module `EXIT_*`, l’écran ou le code fonction puis retrouver son utilisation dans le standard. Relever le programme, l’include et la séquence de traitement. Examiner ce que le standard fait des valeurs au retour de l’exit.

### 6.B.5 ÉTAPE 5 — CONFIRMER L’EXÉCUTION

Placer un breakpoint[^terme-breakpoint] dans le module ou l’include client et reproduire le scénario. Contrôler la pile d’appels, les paramètres, le nombre de passages et le contexte transactionnel. Conserver ces éléments comme preuve du point retenu.

### 6.B.6 ÉTAPE 6 — IDENTIFIER LE PROJET `CMOD`

Rechercher si l’enhancement est déjà affecté à un projet client. Vérifier le statut actif du projet et des objets implémentés. Si aucun projet n’existe, consigner l’enhancement et ses dépendances avant toute création.

## 6.C INFORMATIONS À RELEVER

| Information          | Utilité                              |
| -------------------- | ------------------------------------ |
| Nom de l’enhancement | Référence fonctionnelle et transport |
| Package              | Recherche d’objets liés              |
| Composants           | Périmètre technique réel             |
| Documentation        | Contrat prévu par SAP                |
| Paramètres           | Données disponibles et modifiables   |
| Programme appelant   | Moment exact de l’appel              |
| Projet actif         | Implémentation réellement exécutée   |

## 6.D RECHERCHE PAR PACKAGE

Lorsque le nom est inconnu, utiliser `SE84`[^outil-se84] ou la recherche étendue de `SMOD`[^outil-smod]. Une recherche par transaction doit être complétée par l’analyse du programme réellement exécuté.

## 6.E CONTRÔLE PAR DEBUG

Placer un breakpoint dans le module `EXIT_*` ou dans l’include client. Vérifier :

- l’ordre des appels ;
- les valeurs importées ;
- les données modifiables ;
- les validations exécutées après l’exit ;
- le contexte de mise à jour.

## 6.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 6.G ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 6.H FICHE DE CONTRÔLE À COPIER

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

## 6.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)
- [Ways to Find a User Exit — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525969.html)
- [Activating User Exits — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/83f4631d77654e14800e31b17fe9bd45/4c3a1afc9995677ae10000000a42189b.html)

---

[Chapitre suivant — CRÉER ET ACTIVER UN PROJET `CMOD`[^outil-cmod]](<./07 ├── CREER ET ACTIVER UN PROJET CMOD.md>)

[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).

[^outil-se84]: **SE84.** Repository Information System utilisé pour rechercher des objets et analyser leurs utilisations. Voir [le chapitre associé](<../🧩 01 ├── FONDAMENTAUX ABAP/02 ├── OBJETS DU REPOSITORY ABAP.md>).
[^outil-smod]: **SMOD.** Transaction de recherche et d’analyse des enhancements SAP classiques. Voir [le chapitre associé](<06 ├── ANALYSER UN ENHANCEMENT AVEC SMOD.md>).
[^outil-cmod]: **CMOD.** Transaction de gestion des projets d’extensions client classiques. Voir [le chapitre associé](<07 ├── CREER ET ACTIVER UN PROJET CMOD.md>).
