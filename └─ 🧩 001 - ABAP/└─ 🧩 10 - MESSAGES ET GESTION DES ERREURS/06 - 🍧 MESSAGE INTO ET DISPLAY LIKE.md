# 🌸 MESSAGE INTO ET DISPLAY LIKE

## 🌺 OBJECTIFS

- Construire un texte sans afficher de message
- Utiliser `MESSAGE ... INTO`
- Modifier uniquement l’apparence avec `DISPLAY LIKE`
- Éviter de confondre type réel et apparence
- Préparer des textes pour un log ou une exception

## 🌺 CONSTRUIRE LE TEXTE AVEC INTO

```abap
DATA lv_text TYPE string.

MESSAGE e001(zdev_msg)
  WITH lv_matnr
  INTO lv_text.
```

L’ajout `INTO` renvoie le texte formaté dans une variable au lieu de déclencher le comportement normal d’affichage du type indiqué.

Cette forme est utile pour :

- alimenter un journal ;
- construire un résultat d’API ;
- transmettre un texte à une exception ;
- préparer une liste de messages ;
- tester le rendu d’un message.

## 🌺 LE TYPE RESTE NÉCESSAIRE

Même avec `INTO`, la syntaxe exige un type de message. Il sert notamment à renseigner le contexte de message dans les champs système.

```abap
MESSAGE ID lv_msgid
        TYPE lv_msgty
      NUMBER lv_msgno
        WITH lv_msgv1 lv_msgv2
        INTO lv_text.
```

## 🌺 DISPLAY LIKE

```abap
MESSAGE s006(zdev_msg) DISPLAY LIKE 'E'.
```

Le message conserve le comportement du type `S`, mais il est affiché avec l’apparence du type `E`.

Cette distinction est essentielle :

```mermaid
flowchart LR
    A["TYPE S"] --> B["Poursuite normale"]
    C["DISPLAY LIKE E"] --> D["Apparence d’erreur"]
    B --> E["Message final"]
    D --> E
```

## 🌺 USAGE PRUDENT DE DISPLAY LIKE

`DISPLAY LIKE` peut être utile pour signaler visuellement une anomalie sans modifier le flux. Il ne doit pas servir à contourner une stratégie de gestion des erreurs incohérente.

Un message présenté comme une erreur mais suivi d’une validation métier peut tromper l’utilisateur.

## 🌺 EXEMPLE DE FIN DE TRAITEMENT PARTIEL

```abap
IF lv_error_count = 0.
  MESSAGE s003(zdev_msg) WITH lv_success_count.
ELSE.
  MESSAGE s007(zdev_msg)
    WITH lv_success_count lv_error_count
    DISPLAY LIKE 'W'.
ENDIF.
```

Le type réel reste `S` afin de terminer normalement. L’apparence avertit que le résultat est partiel.

## 🌺 MESSAGE INTO OU EXCEPTION

Utiliser `MESSAGE ... INTO` pour produire un texte. Utiliser une exception pour signaler une erreur entre procédures.

Ne pas remplacer une exception structurée par une simple chaîne si l’appelant doit identifier la nature de l’erreur.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [MESSAGE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPMESSAGE_SHORTREF.html)
- [Messages and Message Classes — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/4ec242f66e391014adc9fffe4e204223.html)

---

➡️ [Chapitre suivant — CODES RETOUR ET SY SUBRC](<./07 - 🍧 CODES RETOUR ET SY SUBRC.md>)
