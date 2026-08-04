# 5. VARIABLES ET CHAMPS SYSTÈME DE MESSAGE

## 5.A RÉSULTAT ATTENDU

- Remplacer les variables d’un message T100
- Exploiter `sy-msgid`, `sy-msgty`, `sy-msgno` et `sy-msgv1` à `sy-msgv4`
- Copier un contexte de message
- Reconstruire un message dynamique
- Éviter les pertes d’information

## 5.B VARIABLES T100

Un texte de classe[^terme-classe] de messages peut contenir jusqu’à quatre marqueurs `&`.

```text
Quantité & invalide pour l’article & dans la division &
```

Appel :

```abap
" Exemple à éviter : comparer avec la correction décrite après le bloc.
MESSAGE e002(zdev_msg)
  WITH lv_quantity lv_matnr lv_werks.
```

Chaque valeur remplace le marqueur correspondant dans l’ordre.

## 5.C CONVERSION DES VALEURS

Les variables sont converties pour être intégrées au texte. Les valeurs longues peuvent être tronquées selon les limites du mécanisme de messages.

Le message doit donc recevoir des identifiants courts et pertinents, pas des structures complètes ni de longs textes techniques.

## 5.D CHAMPS SYSTÈME

```abap
DATA: lv_msgid TYPE symsgid,
      lv_msgty TYPE symsgty,
      lv_msgno TYPE symsgno,
      lv_msgv1 TYPE symsgv.

DATA lv_text TYPE string.

MESSAGE e001(zdev_msg) WITH lv_matnr INTO lv_text.

lv_msgid = sy-msgid.
lv_msgty = sy-msgty.
lv_msgno = sy-msgno.
lv_msgv1 = sy-msgv1.
```

Les valeurs doivent être copiées immédiatement. Une instruction ultérieure peut modifier les champs système.

## 5.E STRUCTURE BAPIRET2

De nombreuses API[^terme-api] SAP[^terme-acro-sap] utilisent une structure comme `BAPIRET2`, qui peut contenir :

- le type ;
- la classe ;
- le numéro ;
- les quatre variables ;
- le texte déjà construit.

Un message peut être reconstruit à partir de ces composantes.

```abap
MESSAGE ID ls_return-id
        TYPE ls_return-type
      NUMBER ls_return-number
        WITH ls_return-message_v1
             ls_return-message_v2
             ls_return-message_v3
             ls_return-message_v4
        INTO DATA(lv_message_text).
```

La gestion détaillée des BAPI[^terme-bapi] sera traitée dans le dossier dédié.

## 5.F CONSERVER LE CONTEXTE

Un texte seul est insuffisant pour certains traitements techniques. Conserver autant que possible :

- l’identifiant du message ;
- le numéro ;
- les variables ;
- le type original ;
- l’objet métier concerné ;
- la cause précédente lorsqu’une exception[^terme-exception] est utilisée.

Cela facilite la traduction, le diagnostic et la restitution dans différents canaux.

## 5.G ERREUR FRÉQUENTE

```abap
MESSAGE e001(zdev_msg) WITH lv_matnr INTO lv_text.
PERFORM another_operation.
ls_error-id = sy-msgid.
```

Le sous-programme peut avoir modifié `sy-msgid`. La copie est trop tardive.

## 5.H VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 5.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Afficher un message technique incompréhensible à l’utilisateur.
- Attraper une exception sans action ni propagation.

## 5.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC[^terme-acro-ddic], les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
MESSAGE ID ls_return-id
        TYPE ls_return-type
      NUMBER ls_return-number
        WITH ls_return-message_v1
             ls_return-message_v2
             ls_return-message_v3
             ls_return-message_v4
        INTO DATA(lv_message_text).
```

## 5.K TERMES DU LEXIQUE

- [Exception](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>)
- [Dump ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/08 ├── EXECUTION EXPLOITATION ET ADMINISTRATION.md#dump-abap>)

## 5.L RÉFÉRENCES OFFICIELLES SAP

- [MESSAGE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMESSAGE_SHORTREF.html)
- [Messages and Message Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec242f66e391014adc9fffe4e204223.html)


---

[Chapitre suivant — MESSAGE INTO ET DISPLAY LIKE](<./06 ├── MESSAGE INTO ET DISPLAY LIKE.md>)

[^terme-classe]: **CLASSE.** Modèle orienté objet définissant état et comportements. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#classe>).
[^terme-api]: **API.** Application Programming Interface, contrat exposant des opérations ou données utilisables par d’autres composants. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#api>).
[^terme-acro-sap]: **SAP.** Nom de l’éditeur et de son écosystème logiciel ; l’acronyme historique provient de l’allemand. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-sap>).
[^terme-bapi]: **BAPI.** Interface métier publiée autour d’un Business Object SAP, généralement implémentée par un module fonction RFC. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#bapi>).
[^terme-exception]: **EXCEPTION.** Objet ou signal représentant une situation anormale qu’un appelant peut traiter. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#exception>).
[^terme-acro-ddic]: **DDIC.** Data Dictionary, abréviation courante de l’ABAP Dictionary. Voir [l’entrée du lexique](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-ddic>).
