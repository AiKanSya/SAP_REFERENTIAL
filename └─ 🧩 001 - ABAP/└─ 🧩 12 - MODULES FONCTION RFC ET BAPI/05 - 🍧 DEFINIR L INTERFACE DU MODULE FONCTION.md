# 🌸 DÉFINIR L INTERFACE DU MODULE FONCTION

## 🌺 OBJECTIFS

- Comprendre le sens des paramètres de l’interface
- Choisir entre import, export, modification et tables
- Définir les paramètres facultatifs et valeurs par défaut
- Construire un contrat minimal et explicite

## 🌺 PERSPECTIVE DU MODULE

Les directions sont définies du point de vue du module fonction.

| Section `SE37` | Sens dans le module              | Section lors de l’appel |
| -------------- | -------------------------------- | ----------------------- |
| Import         | Le module reçoit                 | `EXPORTING`             |
| Export         | Le module retourne               | `IMPORTING`             |
| Modification   | Le module reçoit et retourne     | `CHANGING`              |
| Tables         | Table bidirectionnelle classique | `TABLES`                |

```mermaid
flowchart LR
    A["Appelant EXPORTING"] --> B["Module IMPORT"]
    B --> C["Traitement"]
    C --> D["Module EXPORT"]
    D --> E["Appelant IMPORTING"]
```

## 🌺 EXEMPLE D INTERFACE

Module fictif `Z_DEV_PRODUCT_GET` :

```text
IMPORT
  IV_MATNR TYPE MATNR

EXPORT
  ES_MARA  TYPE MARA

EXCEPTIONS
  NOT_FOUND
  INVALID_INPUT
```

L’appelant fournit le numéro article et reçoit la structure uniquement lorsque la lecture réussit.

## 🌺 PARAMÈTRES CHANGING

Utiliser `CHANGING` seulement lorsqu’une donnée représente réellement un état d’entrée-sortie. Ne pas l’utiliser pour réduire artificiellement le nombre de paramètres.

## 🌺 PARAMÈTRES TABLES

`TABLES` est une forme classique encore présente dans de nombreuses API. Pour un nouveau module non contraint par un framework, préférer généralement un paramètre tabulaire correctement typé dans `IMPORT`, `EXPORT` ou `CHANGING` lorsque la version le permet.

## 🌺 FACULTATIF ET VALEUR PAR DÉFAUT

Un paramètre facultatif doit avoir un comportement documenté lorsque l’appelant ne le fournit pas.

Exemple :

```text
IV_LANGUAGE TYPE SYLANGU OPTIONAL
```

Le code peut ensuite utiliser `sy-langu` si le paramètre est initial. Éviter les paramètres facultatifs dont l’absence produit un comportement ambigu.

## 🌺 CONTRAT MINIMAL

Une bonne interface :

- expose uniquement les données nécessaires ;
- utilise des types stables ;
- évite les structures excessivement larges ;
- ne dépend pas de données globales cachées ;
- documente les unités, formats et règles ;
- sépare résultat métier et diagnostic.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Specifying Parameters and Exceptions — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_2021/bd833c8355f34e96a6e83096b38bf192/d1801f0f454211d189710000e8322d00.html)
- [Interface Parameters of a Function Module — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/ff59ad5d6c55101492f7f1c64dee0529/d1801ece454211d189710000e8322d00.html)

---

➡️ [Chapitre suivant — TYPAGE, PASSAGE DE PARAMÈTRES ET COMPATIBILITÉ](<./06 - 🍧 TYPAGE PASSAGE DE PARAMETRES ET COMPATIBILITE.md>)
