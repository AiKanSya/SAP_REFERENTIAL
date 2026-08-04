# 1. SÉCURISER ET TESTER UN SERVICE ODATA

## 1.A RÉSULTAT ATTENDU

Empêcher qu’un utilisateur authentifié accède à une action, une entity set[^terme-entity-set] ou une navigation[^terme-navigation] sans autorisation métier.

## 1.B PRÉREQUIS

- Matrice actions, données, objets d’autorisation et valeurs organisationnelles.
- Comptes de test autorisé, non autorisé et partiellement autorisé.
- Payloads limites et invalides.
- Variante ATC de sécurité du projet.

## 1.C SURFACES À PROTÉGER

| Surface | Risque |
|---|---|
| Entity set | Lecture massive ou transversale |
| Navigation | Contournement du périmètre de la source |
| Mutation | Action métier sans droit |
| Function import/action | Opération privilégiée |
| `$expand`/`$batch` | Amplification de charge |
| Messages/logs | Fuite de données ou secrets |

## 1.D CHECKLIST

- L’authentification est configurée hors du code applicatif.
- Chaque lecture et mutation sensible exécute les contrôles métier requis.
- Les contrôles ne reposent pas uniquement sur l’accès au service ou au catalogue.
- Les champs, filtres, tris, expansions et tailles de payload sont bornés.
- Les mutations exigent un jeton CSRF lorsque le scénario le prévoit.
- Les messages ne divulguent ni stack, ni secret, ni donnée personnelle inutile.
- Les traces et journaux masquent les contenus sensibles.
- Les appels backend appliquent leurs propres autorisations.
- ATC et les contrôles de sécurité disponibles sont exécutés.

## 1.E PROCESS

### 1.E.1 ÉTAPE 1 — CARTOGRAPHIER

Lister toutes les routes, navigations et opérations. Associer chacune à une action et à un périmètre de données.

### 1.E.2 ÉTAPE 2 — PLACER LES CONTRÔLES

Exécuter les contrôles avant la lecture ou mutation sensible, avec les valeurs issues de la ressource demandée. Un droit d’accès au service n’est pas un droit métier universel.

### 1.E.3 ÉTAPE 3 — BORNER

Limiter tailles de page et payload, profondeur d’expansion, nombre d’opérations batch et options dynamiques. Rejeter les noms libres non prévus.

### 1.E.4 ÉTAPE 4 — TESTER

Tracer les autorisations réelles, exécuter les cas négatifs, ATC et une revue manuelle des entrées dynamiques et journaux.

## 1.F CODE PRÊT À ADAPTER

Le contrôle doit précéder la lecture ou la mutation et utiliser les valeurs organisationnelles de la ressource demandée :

```abap
AUTHORITY-CHECK OBJECT 'Z_SALESORG'
  ID 'ACTVT' VALUE '03'
  ID 'VKORG' VALUE lv_sales_organization.

IF sy-subrc <> 0.
  DATA(lo_message_container) = mo_context->get_message_container( ).

  lo_message_container->add_message(
    iv_msg_type   = 'E'
    iv_msg_id     = 'ZODATA'
    iv_msg_number = '001'
    iv_msg_v1     = lv_sales_organization ).

  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
    EXPORTING
      textid            = /iwbep/cx_mgw_busi_exception=>business_error
      message_container = lo_message_container.
ENDIF.
```

Pour une modification, remplacer l’activité `03` par l’activité correspondant au concept d’autorisation validé. `Z_SALESORG`, `VKORG`, la classe de messages et les valeurs sont des exemples.

## 1.G TESTS NÉGATIFS

1. Utilisateur non authentifié.
2. Utilisateur authentifié sans activité métier.
3. Utilisateur autorisé pour une autre unité organisationnelle.
4. Clé d’un objet non autorisée.
5. Payload trop grand ou champ inconnu.
6. Mutation sans jeton CSRF.
7. Filtre ou expansion visant un volume excessif.

## 1.H CONTRÔLE

- Un utilisateur autorisé ne voit que son périmètre.
- Le même utilisateur ne peut pas atteindre une autre organisation par clé directe ou navigation.
- Une mutation sans jeton ou sans activité est refusée.
- Le message retourné ne contient ni stack, classe interne, secret ni donnée d’un autre objet.
- La charge d’une requête complexe reste bornée.

## 1.I ERREURS FRÉQUENTES

- Contrôler uniquement `S_SERVICE` ou l’accès ICF.
- Appliquer l’autorisation sur la collection mais pas sur la navigation.
- Faire confiance aux filtres envoyés par le client.
- Journaliser le payload complet.
- Valider uniquement avec `SAP_ALL`.

## 1.J CRITÈRE DE SORTIE

Le service refuse chaque cas négatif sans fuite d’information et autorise le cas nominal avec un utilisateur de rôle réaliste. Un test avec `SAP_ALL` ne prouve pas la sécurité.

## 1.K COMPATIBILITÉ S/4HANA

Les objets d’autorisation techniques varient avec le runtime et le mode de publication. Les autorisations métier restent propres au domaine. Pour RAP, intégrer aussi DCL et authorization control du behavior.

## 1.L RÉFÉRENCES OFFICIELLES SAP

- [Discussing SAP Gateway and OData Services — SAP Learning](https://learning.sap.com/courses/introducing-sap-abap-platform-fundamentals/discussing-the-sap-gateway-and-odata-services)
- [SAP Gateway and OData — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/PRODUCT_ID/22bbe89ef68b4d0e98d05f0d56a7f6c8/24d9ac6065954bf7a61f2dc9040f7870.html)

[^terme-entity-set]: **ENTITY SET.** Collection adressable d’entités d’un même type. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#entity-set>).
[^terme-navigation]: **NAVIGATION PROPERTY.** Propriété permettant d’accéder à des entités liées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#navigation-property>).
