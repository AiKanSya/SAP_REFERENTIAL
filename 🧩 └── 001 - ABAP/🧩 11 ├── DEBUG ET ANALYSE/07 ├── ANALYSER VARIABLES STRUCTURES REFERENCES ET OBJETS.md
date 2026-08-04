# ANALYSER VARIABLES, STRUCTURES, RÉFÉRENCES ET OBJETS

## RÉSULTAT ATTENDU

- Afficher la valeur et les attributs d’un objet de données
- Déplier une structure
- Suivre une référence de données ou d’objet
- Distinguer valeur initiale, référence initiale et objet absent
- Vérifier le type dynamique

## INFORMATIONS À CONTRÔLER

Pour une variable, analyser séparément :

- nom ;
- type statique ;
- type dynamique éventuel ;
- longueur et décimales ;
- valeur ;
- portée ;
- état initial ;
- adresse ou référence lorsque pertinente.

## STRUCTURES

Une structure doit être analysée au niveau du composant qui porte la règle métier.

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE matnr,
         werks TYPE werks_d,
         menge TYPE menge_d,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

Dans le débogueur, développer `ls_product`, puis contrôler chaque composant. Une structure entièrement initiale indique souvent qu’elle n’a pas été alimentée, mais ce n’est pas toujours une erreur.

## PROCESS

### Étape 1 — Ajouter les données au bureau

À un breakpoint stable, ajouter une variable, une structure, une référence et un objet. Relever type déclaré et type dynamique lorsqu’il existe.

### Étape 2 — Examiner les valeurs composites

Développer la structure et comparer ses clés et indicateurs avec les entrées du scénario. Une valeur initiale peut être valide ; elle ne prouve pas à elle seule une lecture absente.

### Étape 3 — Suivre une référence

Contrôler `IS BOUND` avant d’ouvrir la cible. Si la référence est initiale, remonter à sa création ou son affectation au lieu de modifier artificiellement le pointeur.

### Étape 4 — Examiner l’objet

Afficher sa classe dynamique, ses attributs et ses références internes. Utiliser la pile pour identifier le constructeur ou la factory ayant créé l’instance.

### Étape 5 — Comparer après exécution

Exécuter un pas et relever uniquement les composants modifiés. L’analyse est terminée lorsque l’origine de la valeur incorrecte est localisée dans une affectation ou un appel précis.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Modifier les données dans le débogueur puis considérer le résultat comme reproductible.
- Laisser une trace active trop longtemps.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
TYPES: BEGIN OF ty_product,
         matnr TYPE matnr,
         werks TYPE werks_d,
         menge TYPE menge_d,
       END OF ty_product.

DATA ls_product TYPE ty_product.
```

## TERMES DU LEXIQUE

- [Structure](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#structure-abap>)
- [Référence](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#reference>)
- [Breakpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#breakpoint>)
- [Watchpoint](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#watchpoint>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)
- [Trace](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#trace>)

## RÉFÉRENCES

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

## OBJETS

Pour une référence d’objet, afficher :

- la classe dynamique ;
- les attributs d’instance ;
- les références contenues ;
- les interfaces ;
- l’état des attributs avant et après l’appel.

Ne pas conclure qu’une méthode est incorrecte uniquement parce qu’un attribut change. Vérifier le contrat attendu de l’objet.

## FIELD-SYMBOLS

Pour un field-symbol :

```abap
FIELD-SYMBOLS <ls_product> TYPE ty_product.
```

Contrôler :

- s’il est affecté ;
- l’objet de données auquel il est lié ;
- le type concret ;
- les modifications indirectes produites par l’écriture via le field-symbol.

## VALEURS FORMATÉES

Certaines données possèdent une représentation interne différente de l’affichage utilisateur :

- dates ;
- heures ;
- numéros avec zéros initiaux ;
- montants et devises ;
- quantités et unités.

Le débogueur affiche souvent la valeur interne. Comparer avec la conversion appliquée par l’écran ou l’interface.

## PRÉCAUTION SUR LES DONNÉES SENSIBLES

Les outils de débogage peuvent exposer des données métier ou personnelles. Ne pas exporter, capturer ou partager des valeurs sans nécessité et sans respecter les règles du client.

## RÉFÉRENCES OFFICIELLES SAP

- [Standard ABAP Debugger — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/ba879a6e2ea04d9bb94c7ccd7cdac446/49250c884d7216b5e10000000a42189d.html)
- [ABAP Test and Analysis Tools — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/ba879a6e2ea04d9bb94c7ccd7cdac446/491aa66f87041903e10000000a42189c.html)

---

[Chapitre suivant — ANALYSER LES TABLES INTERNES](<./08 ├── ANALYSER LES TABLES INTERNES.md>)
