# 13. OBJETS DE VERROUILLAGE

## 13.A RÉSULTAT ATTENDU

- Comprendre le verrouillage logique SAP
- Créer un objet de verrouillage dans SE11
- Identifier les modules fonction générés
- Choisir les champs de l’argument de verrouillage
- Diagnostiquer les verrous avec prudence

## 13.B POURQUOI UN VERROU LOGIQUE

Une transaction métier peut durer plus longtemps qu’une opération de base de données unique.

Le verrouillage logique SAP empêche plusieurs utilisateurs ou traitements de modifier simultanément la même ressource métier pendant cette durée.

```mermaid
sequenceDiagram
    participant U1 as Utilisateur 1
    participant E as Service de verrouillage SAP
    participant U2 as Utilisateur 2
    U1->>E: Demande de verrou sur la clé K
    E-->>U1: Verrou accordé
    U2->>E: Demande de verrou sur la clé K
    E-->>U2: Verrou refusé ou attente
    U1->>E: Libération du verrou K
```

## 13.C DÉFINITION DANS SE11

Un objet de verrouillage indique :

- une table primaire ;
- éventuellement des tables secondaires reliées ;
- les champs qui composent l’argument de verrouillage ;
- le mode de verrouillage proposé.

Lors de l’activation, le système génère généralement deux modules fonction :

- `ENQUEUE_<objet>` ;
- `DEQUEUE_<objet>`.

## 13.D MODES CLASSIQUES

| Mode                   | Principe                                                     |
| ---------------------- | ------------------------------------------------------------ |
| Partagé                | Plusieurs lectures protégées peuvent coexister               |
| Exclusif               | Une seule modification logique est autorisée                 |
| Exclusif non cumulatif | Variante exclusive avec règles de cumul plus strictes        |
| Optimiste              | Verrou initial pouvant être converti lors de la modification |

Le mode exact doit correspondre au scénario métier et à l’architecture de l’application.

## 13.E EXEMPLE D’APPEL

Pour un objet `EZ_ORDER` générant `ENQUEUE_EZ_ORDER` :

```abap
CALL FUNCTION 'ENQUEUE_EZ_ORDER'
  EXPORTING
    mandt      = sy-mandt
    order_id   = lv_order_id
  EXCEPTIONS
    foreign_lock = 1
    system_failure = 2
    OTHERS       = 3.

IF sy-subrc <> 0.
  MESSAGE 'Objet déjà verrouillé' TYPE 'E'.
ENDIF.
```

La signature réelle dépend des champs de l’objet généré. Elle doit être vérifiée dans `SE37`.

Le verrou doit ensuite être libéré au moment cohérent du traitement, explicitement ou selon la portée configurée.

## 13.F ANALYSE AVEC SM12

La transaction `SM12` permet d’analyser les entrées de verrouillage.

Supprimer manuellement un verrou peut permettre à deux traitements incompatibles de s’exécuter simultanément. Cette action exige de vérifier :

- l’utilisateur propriétaire ;
- l’heure de création ;
- la transaction concernée ;
- l’état du traitement ;
- l’absence réelle de session active.

## 13.G POINTS À RETENIR

- Un objet de verrouillage protège une ressource métier au niveau SAP.
- L’activation génère les modules `ENQUEUE_...` et `DEQUEUE_...`.
- L’argument doit être assez précis pour éviter de verrouiller trop de données.
- La durée du verrou doit couvrir le traitement critique sans être excessive.
- Un verrou ne doit pas être supprimé dans SM12 sans diagnostic.

## 13.H PROCESS

### 13.H.1 Étape 1 — Définir l’unité logique verrouillée

Identifier la table racine et les champs qui représentent l’objet métier modifié simultanément. Le verrou doit couvrir l’unité de concurrence réelle : une clé trop large bloque inutilement, une clé trop étroite autorise des mises à jour concurrentes incohérentes.

### 13.H.2 Étape 2 — Créer l’objet de verrouillage

1. Ouvrir `SE11`, choisir **Objet de verrouillage** et saisir un nom commençant par `EZ` ou `EY` selon la convention client.
2. Ajouter la table primaire.
3. Ajouter les tables secondaires uniquement lorsqu’elles appartiennent à la même unité verrouillée.
4. Vérifier les relations proposées et les paramètres de clé générés.

### 13.H.3 Étape 3 — Choisir le mode de verrouillage

Sélectionner le mode adapté au scénario de lecture/modification. Documenter la raison et la durée prévue du verrou. Ne pas conserver un verrou pendant une interaction utilisateur plus longue que nécessaire.

### 13.H.4 Étape 4 — Activer et contrôler les modules générés

Activer l’objet puis ouvrir dans `SE37` les modules `ENQUEUE_...` et `DEQUEUE_...`. Relever leur signature exacte, notamment les champs clés, le mandant, le mode et les paramètres de portée.

### 13.H.5 Étape 5 — Tester la concurrence

Dans une première session, appeler le module ENQUEUE avec une clé de test et conserver le verrou. Dans une seconde session, tenter la même clé : l’appel doit signaler le conflit prévu. Libérer ensuite avec DEQUEUE et vérifier dans `SM12` qu’aucun verrou de test ne subsiste.

La mise en place est validée lorsque deux clés différentes peuvent travailler indépendamment et que la même clé ne peut pas être modifiée simultanément.

## 13.I VÉRIFICATION

- Le contrôle de cohérence ne retourne aucune erreur bloquante.
- L’objet est actif et son entrée de répertoire pointe vers le package attendu.
- La liste d’utilisation et les dépendances correspondent au périmètre prévu.
- Pour une table Z, la structure active et la structure de base sont cohérentes.

## 13.J ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Modifier un objet standard au lieu d’utiliser une extension.
- Activer une table sans vérifier clé, paramètres techniques et impact base.

## 13.K SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
CALL FUNCTION 'ENQUEUE_EZ_ORDER'
  EXPORTING
    mandt      = sy-mandt
    order_id   = lv_order_id
  EXCEPTIONS
    foreign_lock = 1
    system_failure = 2
    OTHERS       = 3.

IF sy-subrc <> 0.
  MESSAGE 'Objet déjà verrouillé' TYPE 'E'.
ENDIF.
```

## 13.L TERMES DU LEXIQUE

- [ABAP Dictionary](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#abap-dictionary>)
- [Domaine](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#domaine>)
- [Élément de données](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#element-donnees>)
- [Table transparente](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#table-transparente>)
- [MANDT](<../🧩 00 ├── LEXIQUE SAP ET ABAP/05 ├── DONNEES DICTIONNAIRE ET BASE DE DONNEES.md#mandt>)

## 13.M RÉFÉRENCES OFFICIELLES SAP

- [Lock Objects — ABAP Dictionary — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_731_BW_ABAP/ec1c9c8191b74de98feb94001a95dd76/cf21eea5446011d189700000e8322d00.html)
- [SAP Lock Concept — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/47df3d6f30fd4c9d8a91d99f6e2be3e5/4ec5c7196e391014adc9fffe4e204223.html)

---

[Chapitre suivant — GÉNÉRATEUR DE MAINTENANCE ET SM30](<./14 ├── GENERATEUR DE MAINTENANCE ET SM30.md>)
