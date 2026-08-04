# 7. ANALYSER VARIABLES, STRUCTURES, RÉFÉRENCES ET OBJETS

## 7.A RÉSULTAT ATTENDU

- Afficher la valeur et les attributs d’un objet de données[^terme-objet-donnees]
- Déplier une structure
- Suivre une référence de données[^terme-reference] ou d’objet
- Distinguer valeur initiale, référence initiale et objet absent
- Vérifier le type dynamique

## 7.B INFORMATIONS À CONTRÔLER

Pour une variable, analyser séparément :

- nom ;
- type statique ;
- type dynamique éventuel ;
- longueur et décimales ;
- valeur ;
- portée ;
- état initial ;
- adresse ou référence lorsque pertinente.

## 7.C STRUCTURES

Une structure doit être analysée au niveau du composant qui porte la règle métier[^terme-regle-metier].

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE matnr,
         werks TYPE werks_d,
         menge TYPE menge_d,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

Dans le débogueur, développer `ls_product`, puis contrôler chaque composant. Une structure entièrement initiale indique souvent qu’elle n’a pas été alimentée, mais ce n’est pas toujours une erreur.

## 7.D PROCESS

### 7.D.1 Étape 1 — Ajouter les données au bureau

À un breakpoint[^terme-breakpoint] stable, ajouter une variable, une structure, une référence et un objet. Relever type déclaré et type dynamique lorsqu’il existe.

### 7.D.2 Étape 2 — Examiner les valeurs composites

Développer la structure et comparer ses clés et indicateurs avec les entrées du scénario. Une valeur initiale peut être valide ; elle ne prouve pas à elle seule une lecture absente.

### 7.D.3 Étape 3 — Suivre une référence

Contrôler `IS BOUND` avant d’ouvrir la cible. Si la référence est initiale, remonter à sa création ou son affectation au lieu de modifier artificiellement le pointeur.

### 7.D.4 Étape 4 — Examiner l’objet

Afficher sa classe[^terme-classe] dynamique, ses attributs et ses références internes. Utiliser la pile pour identifier le constructeur ou la factory ayant créé l’instance.

### 7.D.5 Étape 5 — Comparer après exécution

Exécuter un pas et relever uniquement les composants modifiés. L’analyse est terminée lorsque l’origine de la valeur incorrecte est localisée dans une affectation ou un appel précis.

## 7.E VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant[^terme-mandant], transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace[^terme-trace] ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 7.F ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## 7.G SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE matnr,
         werks TYPE werks_d,
         menge TYPE menge_d,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

## 7.H TERMES DU LEXIQUE

- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## 7.I RÉFÉRENCES

```abap
DATA lr_product TYPE REF TO ty_product.
CREATE DATA lr_product.
lr_product->matnr = '000000000000006200'.
```

Points à vérifier :

- la référence est-elle initiale ?
- l’objet référencé existe-t-il encore ?
- le type dynamique correspond-il au type attendu ?
- plusieurs références pointent-elles sur le même objet ?

## 7.J OBJETS

Pour une référence d’objet, afficher :

- la classe dynamique ;
- les attributs d’instance ;
- les références contenues ;
- les interfaces ;
- l’état des attributs avant et après l’appel.

Ne pas conclure qu’une méthode[^terme-methode] est incorrecte uniquement parce qu’un attribut[^terme-attribut] change. Vérifier le contrat attendu de l’objet.

## 7.K FIELD-SYMBOLS

Pour un field-symbol[^terme-field-symbol] :

```abap
FIELD-SYMBOLS <ls_product> TYPE ty_product.
```

Contrôler :

- s’il est affecté ;
- l’objet de données auquel il est lié ;
- le type concret ;
- les modifications indirectes produites par l’écriture via le field-symbol.

## 7.L VALEURS FORMATÉES

Certaines données possèdent une représentation interne différente de l’affichage utilisateur :

- dates ;
- heures ;
- numéros avec zéros initiaux ;
- montants et devises ;
- quantités et unités.

Le débogueur affiche souvent la valeur interne. Comparer avec la conversion appliquée par l’écran ou l’interface.

## 7.M PRÉCAUTION SUR LES DONNÉES SENSIBLES

Les outils de débogage peuvent exposer des données métier ou personnelles. Ne pas exporter, capturer ou partager des valeurs sans nécessité et sans respecter les règles du client.

## 7.N RÉFÉRENCES OFFICIELLES SAP

- [Standard ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/ba879a6e2ea04d9bb94c7ccd7cdac446/49250c884d7216b5e10000000a42189d.html)
- [ABAP Test and Analysis Tools — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491aa66f87041903e10000000a42189c.html)

---

[Chapitre suivant — ANALYSER LES TABLES INTERNES](<./08 ├── ANALYSER LES TABLES INTERNES.md>)

[^terme-objet-donnees]: **OBJET DE DONNÉES.** Zone de mémoire typée contenant une valeur pendant l’exécution. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#objet-donnees>).
[^terme-reference]: **RÉFÉRENCE.** Valeur qui pointe vers un objet de données ou une instance de classe. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>).
[^terme-regle-metier]: **RÈGLE MÉTIER.** Condition ou calcul imposé par le processus fonctionnel. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/09 ├── NOTIONS FONCTIONNELLES ET ORGANISATIONNELLES.md#regle-metier>).
[^terme-breakpoint]: **BREAKPOINT.** Point d’arrêt suspendant l’exécution dans le débogueur. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-mandant]: **MANDANT.** Subdivision logique d’un système SAP. Il est identifié par un numéro à trois chiffres et isole une partie des données, du paramétrage et des utilisateurs. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/01 ├── SYSTEMES ENVIRONNEMENTS ET MANDANTS.md#mandant>).
[^terme-trace]: **TRACE.** Enregistrement détaillé d’événements techniques pour analyser exécution, SQL ou appels. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-attribut]: **ATTRIBUT.** Composant de données déclaré dans une classe et appartenant soit à chaque instance, soit à la classe elle-même. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#attribut>).
[^terme-field-symbol]: **FIELD-SYMBOL.** Alias dynamique vers une zone de mémoire existante. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#field-symbol>).
