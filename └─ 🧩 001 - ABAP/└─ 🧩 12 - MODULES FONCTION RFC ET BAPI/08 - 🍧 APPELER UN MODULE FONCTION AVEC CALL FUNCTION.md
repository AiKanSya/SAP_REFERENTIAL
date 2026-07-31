# 🌸 APPELER UN MODULE FONCTION AVEC CALL FUNCTION

## 🌺 OBJECTIFS

- Générer un appel depuis l’éditeur ABAP
- Mapper correctement les paramètres
- Contrôler les paramètres facultatifs
- Traiter le code retour immédiatement

## 🌺 SYNTAXE

```abap
CALL FUNCTION 'Z_DEV_PRODUCT_GET'
  EXPORTING
    iv_matnr        = lv_matnr
  IMPORTING
    es_mara         = ls_mara
  EXCEPTIONS
    not_found       = 1
    invalid_input   = 2
    OTHERS          = 3.
```

Le sens est inversé par rapport à l’interface du module : l’appelant **exporte** vers les paramètres d’import du module et **importe** ses paramètres d’export.

## 🌺 GÉNÉRER LE MODÈLE

Dans l’éditeur ABAP classique, utiliser la fonction **Modèle / Pattern** pour insérer l’appel. Cette méthode réduit les erreurs de nom et permet de partir de l’interface active.

## 🌺 PARAMÈTRES NOMMÉS

Toujours utiliser le nom explicite du paramètre. L’appel reste lisible et résiste mieux à l’ajout de paramètres facultatifs.

## 🌺 PARAMÈTRES FACULTATIFS

Ne fournir un paramètre facultatif que lorsque sa valeur a un sens. Éviter d’envoyer systématiquement une valeur initiale : l’absence du paramètre et une valeur initiale peuvent représenter deux comportements distincts.

## 🌺 CODE RETOUR

Contrôler `sy-subrc` immédiatement après l’appel lorsqu’une liste `EXCEPTIONS` est utilisée :

```abap
CASE sy-subrc.
  WHEN 0.
    " Succès
  WHEN 1.
    MESSAGE 'Produit introuvable' TYPE 'E'.
  WHEN 2.
    MESSAGE 'Entrée invalide' TYPE 'E'.
  WHEN OTHERS.
    MESSAGE 'Erreur technique' TYPE 'E'.
ENDCASE.
```

Ne pas exécuter une instruction intermédiaire avant le contrôle, car elle pourrait modifier `sy-subrc`.

```mermaid
flowchart TD
    A["Préparer les paramètres"] --> B["CALL FUNCTION"]
    B --> C["Contrôler sy-subrc"]
    C -->|"0"| D["Traiter le résultat"]
    C -->|"Différent de 0"| E["Traiter l erreur"]
```

## 🌺 APPEL DYNAMIQUE

`CALL FUNCTION (lv_name)` permet un appel dynamique. Ne l’utiliser que pour un besoin justifié, avec une liste blanche ou une validation stricte du nom. Un nom provenant directement d’une entrée utilisateur constitue un risque technique et de sécurité.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CALL FUNCTION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapcall_function.htm)
- [Calling Function Modules From Your Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801edb454211d189710000e8322d00.html)

---

➡️ [Chapitre suivant — EXCEPTIONS CLASSIQUES ET MESSAGES](<./09 - 🍧 EXCEPTIONS CLASSIQUES ET MESSAGES.md>)
