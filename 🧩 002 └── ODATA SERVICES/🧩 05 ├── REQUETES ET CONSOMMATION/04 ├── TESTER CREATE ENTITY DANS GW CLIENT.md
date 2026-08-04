# 4. TESTER CREATE_ENTITY DANS GW_CLIENT

## 4.A RÉSULTAT ATTENDU

Exécuter un `POST` dans Gateway Client, avec un jeton CSRF[^terme-csrf], obtenir `201 Created`, relever la clé générée puis relire l’entité.

## 4.B PRÉREQUIS

- `CREATE_ENTITY` redéfinie et active.
- Entity set et propriétés marqués creatable.
- Utilisateur autorisé à créer.
- Valeurs uniques et données de test supprimables.
- Compréhension de la responsabilité transactionnelle de l’API.

## 4.C PRÉPARER LE PAYLOAD AVEC USE AS REQUEST

SAP Learning recommande de partir d’une entité lue afin d’obtenir une structure de payload correcte.

1. Exécuter `GET <EntitySet>('<clé>')`.
2. Dans la zone **HTTP Response**, choisir **Use as Request**.
3. Le corps de la réponse est copié dans **HTTP Request**.
4. Supprimer les enveloppes, liens ou propriétés non creatable si le client ne les retire pas.
5. Supprimer ou modifier la clé selon le contrat.
6. Fournir une valeur unique, par exemple l’adresse e-mail.
7. Retirer la clé de l’URI : le `POST` vise l’entity set.

## 4.D OBTENIR LE JETON CSRF

### 4.D.1 REQUÊTE FETCH

- Méthode : `GET`.
- URI : racine du service ou entity set.
- En-tête : `X-CSRF-Token: Fetch`.

```http
GET /sap/opu/odata/sap/ZBP_SRV/
X-CSRF-Token: Fetch
```

### 4.D.2 RÉUTILISER LA SESSION

Relever `X-CSRF-Token` dans les en-têtes de réponse. Conserver les cookies de cette requête. Dans Gateway Client, utiliser la fonction de copie du jeton lorsqu’elle est disponible ou reporter la valeur dans les en-têtes de la requête suivante.

Un jeton obtenu avec une autre session, un autre utilisateur ou des cookies différents peut être refusé.

## 4.E EXÉCUTER LE POST

- Méthode : `POST`.
- URI : entity set sans clé.
- `Content-Type: application/json`.
- `Accept: application/json`.
- `X-CSRF-Token: <TOKEN>`.

```http
POST /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet
Content-Type: application/json
Accept: application/json
X-CSRF-Token: <TOKEN>

{
  "BusinessPartnerRole": "01",
  "EmailAddress": "odata.create@example.invalid",
  "CompanyName": "GW CLIENT TEST",
  "CurrencyCode": "EUR",
  "City": "Paris",
  "Street": "1 Test Street",
  "Country": "FR",
  "AddressType": "02"
}
```

Choisir **Execute**. Le breakpoint dans `<SET>_CREATE_ENTITY` doit être atteint. Contrôler la structure remplie par `READ_ENTRY_DATA`, les messages de l’API et `ER_ENTITY`.

## 4.F CONTRÔLE POSITIF

1. Statut `201 Created`.
2. Corps contenant l’entité et sa clé générée.
3. En-tête `Location` ou identifiant retourné selon le runtime.
4. `GET` sur la clé retournée.
5. Données persistées identiques aux valeurs acceptées par l’API.

## 4.G CONTRÔLES NÉGATIFS

| Test | Résultat attendu |
|---|---|
| Sans jeton CSRF | Requête refusée |
| Champ obligatoire absent | Erreur métier contrôlée |
| Valeur de domaine invalide | Rejet avant persistance |
| Utilisateur sans activité | Refus d’autorisation |
| Clé dans l’URI du POST | URI ou opération refusée |

## 4.H ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| `403` | CSRF/cookie ou autorisation | Refaire Fetch dans la session et tracer les droits |
| `400` | JSON, type ou propriété inconnue | Comparer au metadata |
| `500` | Exception backend | Ouvrir les journaux Gateway |
| `201` mais GET absent | Commit ou API asynchrone | Lire le contrat transactionnel |
| Clé vide dans la réponse | `ER_ENTITY` incomplet | Retourner les champs générés |

## 4.I NETTOYAGE

Conserver la clé produite. Supprimer l’objet avec le test `DELETE_ENTITY` uniquement si l’API et le domaine autorisent cette suppression.

## 4.J COMPATIBILITÉ S/4HANA

Le statut `201` et le corps retourné correspondent au scénario OData V2 documenté par SAP Learning. Valider le contrat du service réel.

## 4.K RÉFÉRENCES OFFICIELLES SAP

- [Implementing Change Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-change-operations)
- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)

[^terme-csrf]: **JETON CSRF.** Jeton lié à une session et utilisé pour protéger les requêtes de modification. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/01 ├── PROTOCOLE HTTP ET ODATA.md#csrf-token>).
