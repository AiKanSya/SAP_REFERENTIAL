# 8. FUNCTION MODULE EXITS

## 8.A RÉSULTAT ATTENDU

- Comprendre l’appel `CALL CUSTOMER-FUNCTION`
- Implémenter le code dans l’include client prévu
- Respecter l’interface et le contexte transactionnel

## 8.B PRINCIPE

Le standard appelle un module fonction[^terme-module-fonction] d’exit, souvent nommé selon le modèle `EXIT_<programme>_<numéro>`. Ce module expose une interface et contient un include client destiné à l’implémentation.

```mermaid
flowchart LR
    A["Programme SAP"] --> B["CALL CUSTOMER-FUNCTION"]
    B --> C["Module EXIT fourni par SAP"]
    C --> D["Include client ZX..."]
    D --> E["Classe de logique client"]
```

## 8.C IMPLÉMENTATION

Ne pas modifier le module `EXIT_*`. Depuis le composant du projet `CMOD`[^outil-cmod], ouvrir l’include client et déléguer le traitement :

```abap
zcl_dev_customer_exit=>process(
  EXPORTING
    is_header = i_header
  CHANGING
    cs_item   = c_item ).
```

Les noms de paramètres sont définis par SAP[^terme-acro-sap]. Ne pas supposer qu’un paramètre `CHANGING` peut être modifié sans vérifier son usage après le retour.

## 8.D GESTION DES ERREURS

- utiliser les messages autorisés par le contrat de l’exit ;
- éviter un dump pour une erreur fonctionnelle attendue ;
- ne pas déclencher de commit ;
- ne pas lancer une mise à jour indépendante qui survivrait à un rollback du standard ;
- conserver un temps d’exécution faible si l’exit est appelé dans une boucle.

## 8.E PROCESS

### 8.E.1 ÉTAPE 1 — ANALYSER LE MODULE `EXIT_*`

Depuis `SMOD`[^outil-smod], ouvrir le function exit dans `SE37`[^outil-se37]. Lire la documentation et relever précisément les paramètres importés, exportés, modifiés et les tables. Identifier l’include client proposé dans le code source du module.

### 8.E.2 ÉTAPE 2 — RETROUVER LE POINT D’APPEL STANDARD

Utiliser la liste d’utilisation ou la recherche source pour localiser `CALL CUSTOMER-FUNCTION`. Examiner les valeurs préparées avant l’appel et les contrôles exécutés après. Le sens fonctionnel des paramètres dépend de ce contexte.

### 8.E.3 ÉTAPE 3 — CONFIRMER LES VALEURS AU RUNTIME

Placer un breakpoint[^terme-breakpoint] dans le module ou l’include client et reproduire le scénario. Relever la pile, les valeurs d’entrée, les paramètres réellement modifiables et le nombre d’appels. Vérifier si l’exit intervient avant ou après une borne transactionnelle.

### 8.E.4 ÉTAPE 4 — IMPLÉMENTER DANS L’INCLUDE CLIENT

Ouvrir le composant depuis le projet `CMOD` afin de créer ou modifier uniquement l’include prévu. Valider les paramètres, appliquer la condition fonctionnelle minimale puis déléguer le traitement à une classe[^terme-classe] Z. Ne pas lire ou modifier des globales standard non contractuelles.

### 8.E.5 ÉTAPE 5 — ACTIVER CODE ET PROJET

Contrôler et activer l’include et les classes appelées, puis activer le projet `CMOD`. Vérifier que l’enhancement n’est pas affecté à un autre projet concurrent et que tous les objets figurent dans les transports attendus.

### 8.E.6 ÉTAPE 6 — TESTER RETOURS ET ERREURS

Tester les valeurs nominales, initiales et invalides autorisées par l’interface. Vérifier les paramètres au retour de l’exit, les messages et la suite du traitement standard. Exécuter un cas hors périmètre pour prouver l’absence d’effet parasite.

## 8.F VÉRIFICATION

- L’implémentation ou le projet est actif et transporté dans le bon ordre.
- Un breakpoint confirme que le point d’extension est appelé dans le scénario visé.
- Le comportement standard reste inchangé hors du périmètre fonctionnel prévu.
- Aucune modification directe d’un objet SAP standard n’a été créée.

## 8.G ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Choisir le premier exit trouvé sans vérifier le moment exact de l’appel.
- Créer plusieurs implémentations concurrentes sans règles de filtre.

## 8.H SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
zcl_dev_customer_exit=>process(
  EXPORTING
    is_header = i_header
  CHANGING
    cs_item   = c_item ).
```

## 8.I TERMES DU LEXIQUE

- [BAdI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-badi>)
- [BTE](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bte>)
- [Objet Repository](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#objet-repository>)

## 8.J RÉFÉRENCES OFFICIELLES SAP

- [Types of Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975e643b111d1896f0000e8322d00.html)
- [Customer Exits — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/2b28ffa716c24348903f8ffbfeb81df8/c81975cc43b111d1896f0000e8322d00.html)
- [Customer Exits (CMOD) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353525722.html)

---

[Chapitre suivant — SCREEN EXITS](<./09 ├── SCREEN EXITS.md>)

[^terme-module-fonction]: **MODULE FONCTION.** Procédure globale appelée avec `CALL FUNCTION` et définie dans un groupe de fonctions. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-cmod]: **CMOD.** Transaction de gestion des projets d’extensions client classiques. Voir [le chapitre associé](<07 ├── CREER ET ACTIVER UN PROJET CMOD.md>).
[^outil-smod]: **SMOD.** Transaction de recherche et d’analyse des enhancements SAP classiques. Voir [le chapitre associé](<06 ├── ANALYSER UN ENHANCEMENT AVEC SMOD.md>).
[^outil-se37]: **SE37.** Function Builder utilisé pour rechercher, afficher, tester et maintenir les modules fonction. Voir [le chapitre associé](<../🧩 12 ├── MODULES FONCTION RFC ET BAPI/03 ├── RECHERCHER ET ANALYSER AVEC SE37.md>).
