# ANALYSER UN ENHANCEMENT AVEC `SMOD`

## RÉSULTAT ATTENDU

- Afficher la définition d’un enhancement classique
- Examiner ses composants et sa documentation
- Retrouver les objets techniques appelés

## PROCESS

### ÉTAPE 1 — OUVRIR LA DÉFINITION DANS `SMOD`

Saisir `/nSMOD`, entrer le nom exact de l’enhancement et choisir **Afficher**. Si le nom est inconnu, utiliser la recherche par composant ou package, puis confirmer chaque résultat avec le programme réellement exécuté.

### ÉTAPE 2 — LIRE LA DOCUMENTATION

Ouvrir la documentation SAP et relever le processus couvert, les conditions d’appel et les restrictions. Comparer ces informations au besoin fonctionnel. Ne pas continuer avec un enhancement dont le contrat ne correspond qu’approximativement au scénario.

### ÉTAPE 3 — INVENTORIER LES COMPOSANTS

Afficher la liste complète des function, screen et menu exits ainsi que les objets DDIC liés. Pour chaque composant, noter son objet technique, son interface et son rôle. Identifier les composants obligatoires les uns pour les autres.

### ÉTAPE 4 — REMONTER AU CODE APPELANT

Ouvrir le module `EXIT_*`, l’écran ou le code fonction puis retrouver son utilisation dans le standard. Relever le programme, l’include et la séquence de traitement. Examiner ce que le standard fait des valeurs au retour de l’exit.

### ÉTAPE 5 — CONFIRMER L’EXÉCUTION

Placer un breakpoint dans le module ou l’include client et reproduire le scénario. Contrôler la pile d’appels, les paramètres, le nombre de passages et le contexte transactionnel. Conserver ces éléments comme preuve du point retenu.

### ÉTAPE 6 — IDENTIFIER LE PROJET `CMOD`

Rechercher si l’enhancement est déjà affecté à un projet client. Vérifier le statut actif du projet et des objets implémentés. Si aucun projet n’existe, consigner l’enhancement et ses dépendances avant toute création.

## INFORMATIONS À RELEVER

| Information          | Utilité                              |
| -------------------- | ------------------------------------ |
| Nom de l’enhancement | Référence fonctionnelle et transport |
| Package              | Recherche d’objets liés              |
| Composants           | Périmètre technique réel             |
| Documentation        | Contrat prévu par SAP                |
| Paramètres           | Données disponibles et modifiables   |
| Programme appelant   | Moment exact de l’appel              |
| Projet actif         | Implémentation réellement exécutée   |

## RECHERCHE PAR PACKAGE

Lorsque le nom est inconnu, utiliser `SE84` ou la recherche étendue de `SMOD`. Une recherche par transaction doit être complétée par l’analyse du programme réellement exécuté.

## CONTRÔLE PAR DEBUG

Placer un breakpoint dans le module `EXIT_*` ou dans l’include client. Vérifier :

- l’ordre des appels ;
- les valeurs importées ;
- les données modifiables ;
- les validations exécutées après l’exit ;
- le contexte de mise à jour.

## VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## ERREURS FRÉQUENTES

- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

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

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## RÉFÉRENCES OFFICIELLES SAP

- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)
- [Ways to Find a User Exit — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525969.html)
- [Activating User Exits — SAP Help Portal](https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/83f4631d77654e14800e31b17fe9bd45/4c3a1afc9995677ae10000000a42189b.html)

---

[Chapitre suivant — CRÉER ET ACTIVER UN PROJET `CMOD`](<./07 ├── CREER ET ACTIVER UN PROJET CMOD.md>)
