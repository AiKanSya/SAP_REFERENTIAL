# DATES, HEURES ET HORODATAGES

## OBJECTIFS

- Manipuler les types classiques `d` et `t`
- Utiliser les champs système de date et d’heure
- Effectuer des calculs simples sur les dates
- Comprendre la limite des calculs directs sur les heures
- Convertir une date et une heure en horodatage avec un fuseau horaire

## TYPES CLASSIQUES

| Type | Format interne | Exemple    |
| ---- | -------------- | ---------- |
| `d`  | `YYYYMMDD`     | `20260731` |
| `t`  | `HHMMSS`       | `115000`   |

```abap
DATA lv_date TYPE d VALUE '20260731'.
DATA lv_time TYPE t VALUE '115000'.
```

Ces formats sont internes. L’affichage utilisateur dépend notamment des paramètres utilisateur et des options de formatage.

## CHAMPS SYSTÈME

Champs usuels :

| Champ      | Contenu                                     |
| ---------- | ------------------------------------------- |
| `sy-datum` | Date locale courante du système applicatif  |
| `sy-uzeit` | Heure locale courante du système applicatif |
| `sy-datlo` | Date locale de l’utilisateur                |
| `sy-timlo` | Heure locale de l’utilisateur               |
| `sy-zonlo` | Fuseau horaire local de l’utilisateur       |

La valeur appropriée dépend du besoin technique et fonctionnel. Ne pas supposer que l’heure du serveur, l’heure utilisateur et l’heure UTC sont identiques.

## METTRE À JOUR L’HEURE SYSTÈME

Les champs `sy-datum` et `sy-uzeit` correspondent au moment où l’environnement d’exécution les a renseignés. Pour actualiser ces valeurs pendant un traitement long :

```abap
GET TIME.
```

## CALCULS SUR LES DATES

Ajouter ou retirer des jours :

```abap
DATA lv_tomorrow  TYPE d.
DATA lv_yesterday TYPE d.

lv_tomorrow  = sy-datum + 1.
lv_yesterday = sy-datum - 1.
```

Calculer un nombre de jours :

```abap
DATA lv_start_date TYPE d VALUE '20260701'.
DATA lv_end_date   TYPE d VALUE '20260731'.
DATA lv_days       TYPE i.

lv_days = lv_end_date - lv_start_date.
```

## EXTRACTION DES COMPOSANTES

```abap
DATA lv_year  TYPE c LENGTH 4.
DATA lv_month TYPE c LENGTH 2.
DATA lv_day   TYPE c LENGTH 2.

lv_year  = sy-datum(4).
lv_month = sy-datum+4(2).
lv_day   = sy-datum+6(2).
```

Cette extraction lit la représentation interne. Elle ne remplace pas une API de calendrier pour calculer le dernier jour d’un mois, les jours ouvrés ou les périodes fiscales.

## CALCULS SUR LES HEURES

ABAP peut interpréter une heure comme un nombre de secondes depuis minuit dans certains calculs.

```abap
DATA lv_start_time TYPE t VALUE '083000'.
DATA lv_end_time   TYPE t VALUE '101500'.
DATA lv_seconds    TYPE i.

lv_seconds = lv_end_time - lv_start_time.
```

Résultat : `6300` secondes.

> [!WARNING]
> Une simple soustraction d’heures ne gère pas correctement tous les cas traversant minuit, les changements de fuseau horaire ou les changements d’heure saisonniers. Utiliser des horodatages lorsque le contexte temporel complet est nécessaire.

## HORODATAGE

Un horodatage représente un instant absolu. Dans l’ABAP classique, les types DDIC `TIMESTAMP` et `TIMESTAMPL` sont couramment utilisés selon la précision attendue.

```abap
DATA lv_timestamp TYPE timestamp.

GET TIME STAMP FIELD lv_timestamp.
```

L’horodatage obtenu est fondé sur UTC.

## CONVERSION AVEC FUSEAU HORAIRE

Date et heure locales vers horodatage :

```abap
DATA lv_timestamp TYPE timestamp.

CONVERT DATE sy-datlo
        TIME sy-timlo
        INTO TIME STAMP lv_timestamp
        TIME ZONE sy-zonlo.
```

Horodatage vers date et heure locales :

```abap
DATA lv_date TYPE d.
DATA lv_time TYPE t.

CONVERT TIME STAMP lv_timestamp
        TIME ZONE sy-zonlo
        INTO DATE lv_date
             TIME lv_time.
```

```mermaid
flowchart LR
    A["Date locale"] --> C["CONVERT"]
    B["Heure locale et fuseau"] --> C
    C --> D["Horodatage UTC"]
    D --> E["CONVERT avec fuseau cible"]
    E --> F["Date et heure locales"]
```

## AFFICHAGE

```abap
DATA(lv_date_text) = |{ sy-datlo DATE = USER }|.
DATA(lv_time_text) = |{ sy-timlo TIME = USER }|.
```

Le format d’affichage ne doit pas être utilisé comme format interne d’échange, sauf contrat d’interface explicite.

## CAS NÉCESSITANT UNE API MÉTIER

Ne pas implémenter manuellement sans vérifier les API SAP disponibles :

- dernier jour du mois ;
- calendrier usine ;
- jours ouvrés ;
- semaine calendaire ;
- exercice et période comptable ;
- changements de fuseau horaire ;
- durée entre deux instants internationaux.

## VÉRIFICATION

- Le contrôle syntaxique réussit.
- La version active correspond au code sauvegardé.
- L’exécution produit le résultat décrit dans le chapitre.
- Les cas vide, limite et erreur sont testés séparément lorsque la syntaxe le permet.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- S’appuyer sur une conversion implicite pouvant tronquer ou arrondir.
- Ignorer l’encodage et les formats externes.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA(lv_date_text) = |{ sy-datlo DATE = USER }|.
DATA(lv_time_text) = |{ sy-timlo TIME = USER }|.
```

## TERMES DU LEXIQUE

- [Instruction ABAP](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#instruction-abap>)
- [Expression](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#expression>)
- [Type de données](<../00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#type-donnees>)

## RÉFÉRENCES OFFICIELLES SAP

- [Calculating with Dates, Times, and Timestamps — SAP Learning](https://learning.sap.com/courses/deepening-your-abap-programming-knowledge/calculating-with-dates-times-and-timestamps_a393cf01-946e-487b-a690-0aab8fc49a39)
- [Date and Time Processing — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENDATE_TIME_SOURCE_FIELDS.html)
- [System Fields for Date and Time — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENTIME_SYSTEM_FIELDS.html)
- [CONVERT DATE, TIME STAMP — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCONVERT_DATE_TIME-STAMP.html)
