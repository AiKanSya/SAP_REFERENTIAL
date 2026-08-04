# 🌸 INSTRUCTION MESSAGE

## 🌺 OBJECTIFS

- Utiliser la syntaxe statique de `MESSAGE`
- Appeler une classe explicitement ou avec `MESSAGE-ID`
- Utiliser une syntaxe dynamique lorsque le besoin l’exige
- Passer des variables au texte
- Comprendre les champs système renseignés

## 🌺 SYNTAXE STATIQUE

```abap
MESSAGE e001(zdev_msg) WITH lv_matnr.
```

Cette instruction appelle :

- le type `E` ;
- le message `001` ;
- la classe `ZDEV_MSG` ;
- la variable `lv_matnr` pour remplacer le premier `&`.

## 🌺 CLASSE DÉCLARÉE DANS REPORT

La classe peut être définie dans l’instruction `REPORT`.

```abap
REPORT zdev_product_check MESSAGE-ID zdev_msg.

PARAMETERS p_matnr TYPE matnr.

START-OF-SELECTION.
  IF p_matnr IS INITIAL.
    MESSAGE e001 WITH p_matnr.
  ENDIF.
```

Cette forme raccourcit les appels, mais rend la dépendance moins visible au niveau de chaque instruction. Une classe explicite reste souvent plus claire dans un code réparti entre plusieurs composants.

## 🌺 MESSAGE AVEC PLUSIEURS VARIABLES

```abap
MESSAGE e002(zdev_msg)
  WITH lv_quantity lv_matnr.
```

Les valeurs sont associées aux `&` dans leur ordre d’apparition. Au maximum quatre variables peuvent être transmises.

## 🌺 SYNTAXE DYNAMIQUE

```abap
MESSAGE ID lv_msgid
        TYPE lv_msgty
      NUMBER lv_msgno
        WITH lv_msgv1 lv_msgv2 lv_msgv3 lv_msgv4.
```

Cette forme est utile lorsque les composantes du message proviennent d’une API ou d’une structure comme `BAPIRET2`.

Elle ne doit pas être utilisée lorsque la classe, le numéro et le type sont connus à la conception. La syntaxe statique est alors plus lisible et mieux contrôlée.

## 🌺 CHAMPS SYSTÈME DE MESSAGE

Après la construction d’un message, les champs système suivants peuvent être renseignés :

| Champ                   | Contenu              |
| ----------------------- | -------------------- |
| `sy-msgid`              | Classe de messages   |
| `sy-msgty`              | Type de message      |
| `sy-msgno`              | Numéro de message    |
| `sy-msgv1` à `sy-msgv4` | Variables du message |

Ces champs sont volatils. Copier leurs valeurs immédiatement lorsqu’elles doivent être conservées.

## 🌺 MESSAGE LITTÉRAL

```abap
MESSAGE 'Traitement terminé' TYPE 'S'.
```

Cette forme existe, mais elle ne fournit pas la gestion centralisée et multilingue d’une classe de messages. Elle doit rester limitée à des usages techniques ponctuels ou à des démonstrations.

## 🌺 BONNES PRATIQUES

- préférer une classe de messages pour les textes destinés aux utilisateurs ;
- utiliser un numéro stable et documenté ;
- fournir les données variables avec `WITH` ;
- ne pas assembler un message traduit par concaténation ;
- ne pas choisir le type uniquement pour obtenir une couleur visuelle.

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
REPORT zdev_product_check MESSAGE-ID zdev_msg.

PARAMETERS p_matnr TYPE matnr.

START-OF-SELECTION.
  IF p_matnr IS INITIAL.
    MESSAGE e001 WITH p_matnr.
  ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [Exception](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/04 - 🍧 LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/08 - 🍧 EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [MESSAGE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMESSAGE_SHORTREF.html)
- [Messages and Message Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec242f66e391014adc9fffe4e204223.html)


---

➡️ [Chapitre suivant — TYPES DE MESSAGES ET COMPORTEMENT](<./04 - 🍧 TYPES DE MESSAGES ET COMPORTEMENT.md>)
