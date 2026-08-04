# 5. TESTER UPDATE_ENTITY ET DELETE_ENTITY DANS GW_CLIENT

## 5.A RÉSULTAT ATTENDU

Modifier puis supprimer une entité de test dans Gateway Client, avec contrôle de l’ETag[^terme-etag] et preuve par relecture.

## 5.B PRÉREQUIS

- Entité créée pour ce test et clé conservée.
- `UPDATE_ENTITY` et `DELETE_ENTITY` actives.
- Entity set marqué updatable et deletable.
- Jeton CSRF et cookies valides.
- Autorisations de modification et suppression.

## 5.C PRÉPARER LA MISE À JOUR

1. Exécuter `GET <EntitySet>('<clé>')`.
2. Choisir **Use as Request**.
3. Modifier uniquement les propriétés autorisées.
4. Conserver la clé dans l’URI.
5. Récupérer un jeton CSRF si la session n’en possède pas.
6. Relever l’ETag de la réponse si le service applique la concurrence optimiste.

## 5.D EXÉCUTER UPDATE_ENTITY

```http
PUT /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')
Content-Type: application/json
Accept: application/json
X-CSRF-Token: <TOKEN>
If-Match: <ETAG_SI_REQUIS>

{
  "BusinessPartnerID": "0100000000",
  "BusinessPartnerRole": "01",
  "EmailAddress": "odata.updated@example.invalid",
  "CompanyName": "GW CLIENT TEST",
  "CurrencyCode": "EUR",
  "City": "Lyon",
  "Country": "FR"
}
```

Dans `UPDATE_ENTITY`, contrôler :

- structure de clé retournée par `GET_CONVERTED_KEYS` ;
- structure de payload retournée par `READ_ENTRY_DATA` ;
- indicateurs de champs modifiés ;
- messages de l’API ;
- absence de commit contradictoire avec le contrat.

Le résultat nominal de l’exemple SAP Learning est `204 No Content`.

## 5.E PROUVER LA MISE À JOUR

```http
GET /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')?$select=BusinessPartnerID,EmailAddress,City
```

La réponse doit contenir les nouvelles valeurs. Un `204` sans relecture ne prouve pas que la mise à jour a persisté.

## 5.F EXÉCUTER DELETE_ENTITY

Récupérer un jeton encore valide, puis exécuter :

```http
DELETE /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')
X-CSRF-Token: <TOKEN>
If-Match: <ETAG_SI_REQUIS>
```

Le corps de requête reste vide. Dans `DELETE_ENTITY`, contrôler la clé et les messages retournés par l’API. Le résultat nominal de l’exemple SAP Learning est `204 No Content`.

## 5.G PROUVER LA SUPPRESSION

```http
GET /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet('0100000000')
```

Le service doit produire l’erreur documentée pour une clé inconnue. Une structure vide avec `200` masquerait l’absence.

## 5.H TESTS NÉGATIFS

| Opération | Test | Résultat |
|---|---|---|
| Update | Clé URI différente du payload | Rejet ou normalisation explicitement documentée |
| Update | ETag obsolète | Erreur de précondition si activé |
| Update | Champ non updatable | Rejet ou absence de modification conforme |
| Delete | Clé inconnue | Erreur métier conforme |
| Delete | Dépendance bloquante | Message métier et aucune suppression partielle |
| Les deux | Sans autorisation | Refus avant mutation |

## 5.I ERREURS FRÉQUENTES

- Utiliser `POST` au lieu de `PUT` ou `PATCH`.
- Effacer la clé de l’URI pour une modification.
- Envoyer un corps avec `DELETE` sans besoin contractuel.
- Réutiliser un jeton expiré après changement de session.
- Tester la suppression sur un objet non créé pour le test.

## 5.J COMPATIBILITÉ S/4HANA

Les statuts et corps décrits correspondent au cours SAP Learning OData V2. OData V4 peut retourner une représentation mise à jour selon ses préférences et son contrat.

## 5.K RÉFÉRENCES OFFICIELLES SAP

- [Implementing Change Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-change-operations)

[^terme-etag]: **ETAG.** Valeur de version HTTP utilisable pour contrôler une modification concurrente. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#etag>).
