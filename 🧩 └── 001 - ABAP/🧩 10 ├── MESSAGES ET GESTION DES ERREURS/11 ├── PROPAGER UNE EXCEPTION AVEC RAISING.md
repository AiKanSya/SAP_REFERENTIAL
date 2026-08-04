# 11. PROPAGER UNE EXCEPTION AVEC RAISING

## 11.A RÉSULTAT ATTENDU

- Déclarer les exceptions d’une procédure
- Comprendre la propagation
- Choisir entre interception locale et transmission
- Préserver le contrat d’une méthode[^terme-methode]
- Éviter les interfaces trop générales

## 11.B PRINCIPE

Une procédure peut traiter l’exception[^terme-exception] elle-même ou la transmettre à son appelant.

```mermaid
flowchart LR
    A["Méthode appelée"] --> B["Exception"]
    B --> C["Traitement local"]
    B --> D["Propagation avec RAISING"]
```

## 11.C DÉCLARATION DANS UNE MÉTHODE

```abap
" Isoler le comportement afin de pouvoir l’exécuter avec ABAP Unit.
METHODS read_product
  IMPORTING
    iv_matnr TYPE matnr
  RETURNING
    VALUE(rs_product) TYPE zdev_product
  RAISING
    zcx_dev_product_not_found.
```

L’implémentation peut lever l’exception déclarée.

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
METHOD read_product.
  SELECT SINGLE *
    FROM zdev_product
    WHERE matnr = @iv_matnr
    INTO @rs_product.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE zcx_dev_product_not_found
      EXPORTING
        matnr = iv_matnr.
  ENDIF.
ENDMETHOD.
```

## 11.D TRAITER OU PROPAGER

Traiter localement lorsque la procédure sait :

- corriger la situation ;
- appliquer une valeur de remplacement valide ;
- répéter l’opération de manière sûre ;
- convertir l’erreur vers un contrat plus pertinent.

Propager lorsque la décision appartient au niveau appelant.

## 11.E CATÉGORIE ET DÉCLARATION

Les exceptions issues de `CX_STATIC_CHECK` et `CX_DYNAMIC_CHECK` doivent être déclarées lorsqu’elles sont propagées par une procédure. Les exceptions issues de `CX_NO_CHECK` peuvent traverser une interface sans déclaration explicite.

La catégorie `CX_STATIC_CHECK` impose en plus des contrôles syntaxiques destinés à forcer la prise en compte de l’exception.

## 11.F CONVERTIR UNE EXCEPTION

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
TRY.
    ro_reader->read( ).
  CATCH cx_sy_open_sql_db INTO DATA(lx_sql).
    RAISE EXCEPTION TYPE zcx_dev_persistence_error
      EXPORTING
        previous = lx_sql.
ENDTRY.
```

La couche supérieure ne dépend plus directement d’une exception technique SQL[^terme-acro-sql]. La cause reste accessible via `PREVIOUS`.

## 11.G ÉVITER UNE INTERFACE TROP GÉNÉRALE

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
RAISING cx_root.
```

Une déclaration aussi large ne décrit pas le contrat réel. Elle oblige l’appelant à gérer un ensemble indéterminé de situations.

Déclarer les classes pertinentes ou une superclasse applicative maîtrisée, par exemple `ZCX_DEV_ERROR`.

## 11.H FRONTIÈRE DE PRÉSENTATION

Une méthode métier ne doit pas transformer systématiquement ses exceptions en `MESSAGE`. Le programme appelant peut être :

- un report SAP GUI[^terme-sap-gui] ;
- un job[^terme-job] ;
- une BAPI[^terme-bapi] ;
- un service OData ;
- un test automatisé.

La propagation préserve la réutilisabilité.

## 11.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 11.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 11.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Propager ou traiter l’erreur au niveau qui sait prendre une décision.
METHOD read_product.
  SELECT SINGLE *
    FROM zdev_product
    WHERE matnr = @iv_matnr
    INTO @rs_product.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE zcx_dev_product_not_found
      EXPORTING
        matnr = iv_matnr.
  ENDIF.
ENDMETHOD.
```

## 11.L TERMES DU LEXIQUE

- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 11.M RÉFÉRENCES OFFICIELLES SAP

- [Handling and Propagating Exceptions — ABAP Programming Guideline](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENHANDL_PROP_EXCEPT_GUIDL.html)
- [Exception Categories — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENEXCEPTION_CATEGORIES.html)
- [Exception Handling — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4defead30d6c43ddac8acb50fb5b78f2.html)


---

[Chapitre suivant — TEXTES D’EXCEPTION ET INTERFACES T100](<./12 ├── TEXTES D EXCEPTION ET INTERFACES T100.md>)

[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-acro-sql]: **SQL.** Structured Query Language. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sql>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-job]: **JOB.** Traitement planifié en arrière-plan composé d’une ou plusieurs étapes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>).
[^terme-bapi]: **BAPI.** Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#bapi>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
