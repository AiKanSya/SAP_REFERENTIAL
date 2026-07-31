# 🌸 TEXTES D’EXCEPTION ET INTERFACES T100

## 🌺 OBJECTIFS

- Associer une exception à une classe de messages
- Comprendre `IF_T100_MESSAGE`
- Comprendre `IF_T100_DYN_MSG`
- Récupérer un texte traduit
- Réutiliser un message intercepté

## 🌺 POURQUOI UTILISER T100

Une exception doit fournir un texte compréhensible, stable et traduisible. Les messages T100 répondent à ce besoin.

```mermaid
flowchart LR
    A["Classe d’exception"] --> B["Interface T100"]
    B --> C["Classe et numéro de message"]
    C --> D["Texte traduit"]
```

## 🌺 IF_T100_MESSAGE

L’interface `IF_T100_MESSAGE` permet d’associer des identifiants de texte définis dans la classe d’exception à des messages T100.

Lors de la création de la classe d’exception dans le Workbench, les outils SAP peuvent générer les éléments nécessaires selon les options choisies.

L’appelant peut ensuite récupérer le texte :

```abap
CATCH zcx_dev_product_not_found INTO DATA(lx_not_found).
  DATA(lv_text) = lx_not_found->get_text( ).
```

## 🌺 IF_T100_DYN_MSG

L’interface `IF_T100_DYN_MSG` étend le mécanisme pour permettre l’association dynamique d’un message T100 à l’exception.

Exemple conceptuel :

```abap
RAISE EXCEPTION TYPE zcx_dev_error
  MESSAGE ID 'ZDEV_MSG'
          TYPE 'E'
        NUMBER '001'
          WITH iv_matnr.
```

La disponibilité exacte de certaines formes syntaxiques dépend de la version ABAP. Vérifier la documentation du système cible.

## 🌺 RÉUTILISER UN MESSAGE EXISTANT

Une couche peut intercepter un message ou une erreur provenant d’une API, puis la représenter sous forme d’exception sans perdre :

- la classe ;
- le numéro ;
- les variables ;
- le texte traduit ;
- la cause précédente.

Cette conservation est préférable à la création d’un texte générique comme `Erreur technique`.

## 🌺 TEXTID

Une classe d’exception peut définir plusieurs constantes `TEXTID`, chaque constante représentant une situation précise.

```abap
RAISE EXCEPTION TYPE zcx_dev_product
  EXPORTING
    textid = zcx_dev_product=>not_found
    matnr  = iv_matnr.
```

Le `TEXTID` rend l’erreur identifiable sans analyser son texte.

## 🌺 GET_TEXT ET GET_LONGTEXT

Les exceptions héritent de fonctionnalités permettant d’obtenir leur texte. Le texte court sert à la restitution immédiate. Un texte long peut fournir des informations complémentaires si la classe et son référentiel le prévoient.

Le programme ne doit pas dépendre du contenu littéral du texte pour prendre une décision.

Mauvais :

```abap
IF lx_error->get_text( ) CS 'introuvable'.
```

Correct : intercepter une classe ou analyser un identifiant stable.

## 🌺 CAS D’USAGE

Dans un contexte où un import doit signaler clairement les erreurs, permettre leur traitement et éviter les arrêts non maîtrisés, le besoin consiste à **gérer une situation d’erreur avec textes d’exception et interfaces t100 et produire une information exploitable par l’appelant ou l’utilisateur**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CATCH zcx_dev_product_not_found INTO DATA(lx_not_found).
  DATA(lv_text) = lx_not_found->get_text( ).
```

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **gérer une situation d’erreur avec textes d’exception et interfaces t100 et produire une information exploitable par l’appelant ou l’utilisateur**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Exception Classes for Messages — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENMESSAGE_EXCEPTIONS.html)
- [Message Interface Reuse Example — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENMESSAGE_INTERFACE_REUSE_ABEXA.html)
- [Creating an Exception Class — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/92823e6017aa11d5969b00a0c94260a5.html)


---

➡️ [Chapitre suivant — EXCEPTIONS SYSTÈME CX_SY](<./13 - 🍧 EXCEPTIONS SYSTEME CX SY.md>)
