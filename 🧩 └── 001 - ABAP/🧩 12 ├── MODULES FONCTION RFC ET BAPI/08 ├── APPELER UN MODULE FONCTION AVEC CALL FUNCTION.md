# 8. APPELER UN MODULE FONCTION AVEC CALL FUNCTION

## 8.A RÉSULTAT ATTENDU

- Générer un appel depuis l’éditeur ABAP
- Mapper correctement les paramètres
- Contrôler les paramètres facultatifs
- Traiter le code retour immédiatement

## 8.B SYNTAXE

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

## 8.C GÉNÉRER LE MODÈLE

Dans l’éditeur ABAP classique, utiliser la fonction **Modèle / Pattern** pour insérer l’appel. Cette méthode réduit les erreurs de nom et permet de partir de l’interface active.

## 8.D PARAMÈTRES NOMMÉS

Toujours utiliser le nom explicite du paramètre. L’appel reste lisible et résiste mieux à l’ajout de paramètres facultatifs.

## 8.E PARAMÈTRES FACULTATIFS

Ne fournir un paramètre facultatif que lorsque sa valeur a un sens. Éviter d’envoyer systématiquement une valeur initiale : l’absence du paramètre et une valeur initiale peuvent représenter deux comportements distincts.

## 8.F CODE RETOUR

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

## 8.G APPEL DYNAMIQUE

`CALL FUNCTION (lv_name)` permet un appel dynamique. Ne l’utiliser que pour un besoin justifié, avec une liste blanche ou une validation stricte du nom. Un nom provenant directement d’une entrée utilisateur constitue un risque technique et de sécurité.

## 8.H PROCESS

### 8.H.1 Étape 1 — Copier la signature exacte

Afficher le module dans `SE37`, puis insérer son modèle d’appel depuis l’éditeur ABAP. Ne recopier pas une signature de mémoire : paramètres et exceptions dépendent de la version active.

### 8.H.2 Étape 2 — Préparer des variables typées

Déclarer chaque entrée et sortie avec le type DDIC de l’interface. Alimenter les paramètres obligatoires et documenter toute valeur facultative omise.

### 8.H.3 Étape 3 — Implémenter CALL FUNCTION

Conserver les sections `EXPORTING`, `IMPORTING`, `CHANGING`, `TABLES` réellement nécessaires. Dans `EXCEPTIONS`, affecter un code distinct aux erreurs que l’appelant doit différencier et terminer par `OTHERS` si le contrat l’exige.

### 8.H.4 Étape 4 — Traiter immédiatement le résultat

Tester `SY-SUBRC` juste après l’appel. Ne lire les sorties comme valides que pour les codes documentés. Transformer l’erreur en exception, message ou retour contrôlé au niveau responsable.

### 8.H.5 Étape 5 — Tester les chemins

Exécuter un cas nominal puis chaque exception reproductible. L’appel est validé lorsque aucune erreur n’est ignorée et que les sorties correspondent au test direct `SE37` pour les mêmes entrées.

## 8.I VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## 8.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Appeler un module fonction sans lire sa documentation et ses exceptions.
- Supposer qu’une BAPI effectue automatiquement le commit.

## 8.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

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

## 8.L TERMES DU LEXIQUE

- [Module fonction](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#module-fonction>)
- [Function group](<../🧩 00 ├── LEXIQUE SAP ET ABAP/06 ├── PROGRAMMES CLASSES ET OBJETS TECHNIQUES.md#function-group>)
- [RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-rfc>)
- [BAPI](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-bapi>)
- [Destination RFC](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#destination-rfc>)

## 8.M RÉFÉRENCES OFFICIELLES SAP

- [CALL FUNCTION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/abapcall_function.htm)
- [Calling Function Modules From Your Programs — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/bd833c8355f34e96a6e83096b38bf192/d1801edb454211d189710000e8322d00.html)

---

[Chapitre suivant — EXCEPTIONS CLASSIQUES ET MESSAGES](<./09 ├── EXCEPTIONS CLASSIQUES ET MESSAGES.md>)
