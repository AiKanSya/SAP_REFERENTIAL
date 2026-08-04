# 5. REQUÊTES, QUALITÉ ET SÉCURITÉ

Définitions liées aux options de requête, à la concurrence et au diagnostic.

<a id="query-option"></a>
## 5.A OPTION DE REQUÊTE

**Définition.** Paramètre système OData modifiant la sélection ou la représentation d’une ressource.

**Exemple.** `$filter`, `$select`, `$expand`, `$orderby`, `$top` et `$skip`.

**Repère pratique.** Tester chaque option isolément puis prouver son traitement backend.

**À distinguer de.** Une option envoyée par le client n’est pas automatiquement appliquée par une implémentation SEGW personnalisée.

---

<a id="etag"></a>
## 5.B ETAG

**Définition.** Valeur de version HTTP associée à une représentation et utilisable pour contrôler les mises à jour concurrentes.

**Exemple.** Le client envoie `If-Match` lors d’une modification.

**Repère pratique.** Tester une mise à jour avec une version courante puis obsolète.

**À distinguer de.** Un ETag ne remplace pas un verrou métier ou une transaction cohérente.

---

<a id="gateway-client"></a>
## 5.C GATEWAY CLIENT

**Définition.** Outil `/IWFND/GW_CLIENT` permettant de construire, exécuter et analyser des requêtes OData dans SAP Gateway.

**Exemple.** Rejouer un `GET $metadata` ou un `POST` avec jeton CSRF.

**Repère pratique.** Conserver une requête minimale reproductible sans donnée sensible.

**À distinguer de.** Un test Gateway Client ne reproduit l’application que si utilisateur, en-têtes et payload sont identiques.

---

<a id="gateway-error-log"></a>
## 5.D JOURNAL D’ERREURS GATEWAY

**Définition.** Journal donnant le contexte des erreurs produites pendant le traitement d’une requête Gateway.

**Exemple.** `/IWFND/ERROR_LOG` pour le frontend et `/IWBEP/ERROR_LOG` pour le backend.

**Repère pratique.** Filtrer par heure, utilisateur, service et mandant.

**À distinguer de.** Un échec d’authentification antérieur au runtime peut ne pas apparaître dans ce journal.

---

<a id="batch"></a>
## 5.E BATCH

**Définition.** Requête multipart envoyée à l’endpoint `$batch` et contenant plusieurs opérations OData.

**Exemple.** Deux lectures indépendantes ou plusieurs modifications regroupées dans un changeset.

**Repère pratique.** Tester d’abord chaque opération seule, puis analyser chaque sous-réponse du batch.

**À distinguer de.** Un changeset exprime une unité atomique de modifications ; le batch complet peut aussi contenir des lectures indépendantes.

## 5.F RÉFÉRENCE SAP

- [Gateway Client — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079611.html)
