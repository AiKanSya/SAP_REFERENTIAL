# 3. OBJETS, SOUS-OBJETS ET IDENTIFIANTS

## 3.A RÉSULTAT ATTENDU

- Définir une nomenclature stable
- Utiliser correctement l’objet, le sous-objet et le numéro externe
- Éviter la multiplication incontrôlée des objets de journal

## 3.B OBJET

L’objet représente un domaine fonctionnel ou une application durable, par exemple :

- `ZMM_MOBILE` pour une application logistique mobile ;
- `ZFI_IMPORT` pour des imports financiers ;
- `ZINT_CPI` pour des traitements d’intégration.

L’objet ne doit pas correspondre à un numéro de ticket, une version ou un programme temporaire.

## 3.C SOUS-OBJET

Le sous-objet distingue des processus cohérents au sein du domaine :

| Objet        | Sous-objet  | Usage                       |
| ------------ | ----------- | --------------------------- |
| `ZMM_MOBILE` | `CREATE_PR` | Création de demande d’achat |
| `ZMM_MOBILE` | `REASSORT`  | Lecture du réassort         |
| `ZINT_CPI`   | `PRODUCTS`  | Extraction produits         |
| `ZINT_CPI`   | `ORDERS`    | Extraction commandes        |

## 3.D NUMÉRO EXTERNE

Le champ `EXTNUMBER` doit permettre de retrouver un traitement sans connaître son numéro technique. Il peut contenir :

- un numéro de document ;
- un identifiant d’exécution ;
- un nom de fichier ;
- un identifiant de message d’interface ;
- une combinaison courte et stable.

```abap
ls_log-extnumber = |IMPORT_PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
```

## 3.E RÈGLES

- garder la même sémantique pour un objet dans tous les programmes ;
- ne pas mettre de données sensibles dans l’identifiant externe ;
- éviter les identifiants trop longs ou impossibles à rechercher ;
- documenter la convention de nommage dans le dépôt technique ;
- réutiliser un objet existant si le domaine et les autorisations sont identiques.

## 3.F PROCESS

### 3.F.1 ÉTAPE 1 — CARTOGRAPHIER LE DOMAINE FONCTIONNEL

Regrouper les traitements ayant le même propriétaire, les mêmes autorisations et la même politique de rétention. Définir un objet par domaine durable, pas par report, ticket ou version. Vérifier les objets existants dans `SLG0`[^outil-slg0] avant d’en créer un nouveau.

### 3.F.2 ÉTAPE 2 — DÉFINIR LES SOUS-OBJETS

Découper le domaine par processus réellement filtrable : import, export, création ou synchronisation. Limiter le nombre de sous-objets et documenter leur sémantique. Deux traitements partageant un nom mais pas les mêmes exploitants ne doivent pas être regroupés artificiellement.

### 3.F.3 ÉTAPE 3 — DÉFINIR L’IDENTIFIANT EXTERNE

Choisir une clé disponible dès le début du traitement : identifiant de lot, fichier, document ou corrélation. Définir format, longueur, casse et règle d’unicité. N’y placer aucune donnée confidentielle utilisée seulement pour le diagnostic interne.

### 3.F.4 ÉTAPE 4 — CRÉER ET TRANSPORTER LA CONFIGURATION

Maintenir l’objet et les sous-objets dans `SLG0`, avec descriptions explicites. Affecter le package[^terme-package] et la demande de transport. Vérifier la présence de la configuration dans le système cible avant d’exécuter le programme.

### 3.F.5 ÉTAPE 5 — UTILISER DES CONSTANTES DANS LE CODE

Centraliser objet et sous-objet dans une classe[^terme-classe] ou interface Z. Construire l’identifiant externe dans une méthode[^terme-methode] dédiée et contrôlée. Éviter les littéraux divergents répétés dans plusieurs programmes.

### 3.F.6 ÉTAPE 6 — TESTER LA RECHERCHE OPÉRATIONNELLE

Créer plusieurs journaux avec des lots différents, puis les retrouver dans `SLG1`[^outil-slg1] par objet, sous-objet, identifiant et période. Vérifier qu’un exploitant peut isoler une exécution sans connaître le numéro interne BAL[^terme-acro-bal].

## 3.G VÉRIFICATION

- Le journal est retrouvable dans `SLG1` avec objet, sous-objet et période.
- Chaque erreur contient un contexte permettant d’identifier l’enregistrement concerné.
- Le log est sauvegardé même lorsque le traitement se termine avec des erreurs gérées.
- Aucune donnée sensible inutile n’est enregistrée.

## 3.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Enregistrer uniquement un texte générique sans clé métier.
- Journaliser des mots de passe, tokens ou données personnelles inutiles.

## 3.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
ls_log-extnumber = |IMPORT_PRODUCTS_{ sy-datum }_{ sy-uzeit }|.
```

## 3.J TERMES DU LEXIQUE

- [Application Log](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#application-log>)
- [BAL](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>)
- [Job](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#job>)

## 3.K RÉFÉRENCES OFFICIELLES SAP

- [Which Data Can Be Collected? — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/addb96cd90c945dfb3182865363bbc47/4e2106b735d44180e10000000a15822b.html)
- [Analyze Logs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/addb96cd90c945dfb3182865363bbc47/4e21048535d44180e10000000a15822b.html)

---

[Chapitre suivant — CRÉER UN OBJET AVEC SLG0](<./04 ├── CREER UN OBJET AVEC SLG0.md>)

[^terme-package]: **PACKAGE.** Conteneur logique qui regroupe les objets de développement et détermine notamment leur transportabilité. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#package>).
[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-methode]: **MÉTHODE.** Comportement déclaré dans une classe ou une interface et appelé avec une liste de paramètres définie. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#methode>).
[^terme-acro-bal]: **BAL.** Business Application Log, API technique du journal applicatif. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bal>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).

[^outil-slg0]: **SLG0.** Transaction de définition des objets et sous-objets de journal applicatif. Voir [le chapitre associé](<04 ├── CREER UN OBJET AVEC SLG0.md>).
[^outil-slg1]: **SLG1.** Transaction de recherche et d’affichage des journaux applicatifs persistés. Voir [le chapitre associé](<05 ├── ANALYSER LES JOURNAUX AVEC SLG1.md>).
