# 16. SORTIE D’UN PROGRAMME EXÉCUTABLE

## 16.A RÉSULTAT ATTENDU

- Produire une sortie simple avec `WRITE`
- Comprendre la liste ABAP[^terme-abap] classique
- Distinguer sortie de démonstration et restitution professionnelle
- Anticiper le comportement en arrière-plan
- Choisir le bon mécanisme de sortie

## 16.B SORTIE SIMPLE

```abap
START-OF-SELECTION.
  WRITE: / 'Compagnie :', p_carr.
```

`WRITE` crée une liste ABAP classique. Le caractère `/` commence une nouvelle ligne.

```abap
WRITE: / sy-uline,
       / 'Nombre de lignes :', lines( lt_result ).
```

## 16.C EN-TÊTE DE PAGE

```abap
TOP-OF-PAGE.
  WRITE: / 'Rapport des vols'.
  ULINE.
```

Cet événement est déclenché lors de la création d’une nouvelle page de liste, selon le traitement de sortie.

## 16.D LISTES INTERACTIVES CLASSIQUES

Des événements comme `AT LINE-SELECTION` permettent de créer des listes de détail. Cette technique est historique et ne doit pas être choisie par défaut pour une nouvelle restitution tabulaire.

Préférer :

- ALV[^terme-alv] pour une liste structurée dans SAP GUI[^terme-sap-gui] ;
- journal applicatif pour un traitement technique ;
- spool[^terme-spool] pour un traitement de fond ;
- fichier ou interface lorsque le contrat l’exige.

## 16.E EXÉCUTION EN ARRIÈRE-PLAN

Une sortie de liste produite en arrière-plan peut être enregistrée dans le spool.

```mermaid
flowchart LR
    A["Programme en background"] --> B["Liste ABAP"]
    B --> C["Requête spool"]
    C --> D["Consultation ou impression"]
```

Une boîte de dialogue SAP GUI ne peut pas remplacer une sortie de fond exploitable.

## 16.F SÉPARER TRAITEMENT ET AFFICHAGE

```abap
START-OF-SELECTION.
  DATA(lt_result) = lcl_service=>read_data( p_carr ).
  lcl_output=>display( lt_result ).
```

Cette séparation facilite :

- les tests ;
- le remplacement de `WRITE` par un ALV ;
- l’exécution sans interface ;
- la réutilisation du traitement.

## 16.G LIMITES DE WRITE

`WRITE` reste pertinent pour :

- démonstrations ;
- petits rapports techniques ;
- diagnostics temporaires ;
- sorties spool simples.

Il est insuffisant pour les besoins avancés de tri, filtre, export, variantes d’affichage et colonnes dynamiques.

## 16.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 16.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mettre une logique lourde dans les événements de validation de l’écran.
- Créer une variante contenant des valeurs obsolètes ou sensibles.

## 16.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
START-OF-SELECTION.
  DATA(lt_result) = lcl_service=>read_data( p_carr ).
  lcl_output=>display( lt_result ).
```

## 16.K TERMES DU LEXIQUE

- [Programme exécutable](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#programme-executable>)
- [Variante](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#variante>)
- [Transaction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#transaction>)
- [Dynpro](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#dynpro>)

## 16.L RÉFÉRENCES OFFICIELLES SAP

- [Lists — Overview — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_751_index_htm/7.51/en-US/ABENLIST_OVERVIEW.html)
- [WRITE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPWRITE.html)
- [Understanding the Concept of Background Processing — SAP Learning](https://learning.sap.com/courses/technical-implementation-and-operation-ii-of-sap-s-4hana-and-sap-business-suite/understanding-the-concept-of-background-processing-1)


---

[Chapitre suivant — BONNES PRATIQUES ET CHECKLIST](<./17 └── BONNES PRATIQUES ET CHECKLIST.md>)

[^terme-abap]: **ABAP.** Langage de programmation de la plateforme ABAP, conçu pour développer des applications métier et techniques SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#abap>).
[^terme-alv]: **ALV.** ABAP List Viewer, ensemble de technologies d’affichage tabulaire avec tri, filtre, total et variantes. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#alv>).
[^terme-sap-gui]: **SAP GUI.** Client graphique permettant d’utiliser les transactions et écrans d’un système SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/02 ├── SAP GUI NAVIGATION ET TRANSACTIONS.md#sap-gui>).
[^terme-spool]: **SPOOL.** Infrastructure stockant et acheminant les sorties imprimables produites par les traitements SAP. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#spool>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
