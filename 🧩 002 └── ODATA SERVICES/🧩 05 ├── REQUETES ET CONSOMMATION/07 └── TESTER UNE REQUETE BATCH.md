# 7. TESTER UNE REQUÊTE `$BATCH`

## 7.A RÉSULTAT ATTENDU

Envoyer plusieurs opérations OData V2 dans une requête batch[^terme-batch] et analyser chaque sous-réponse.

## 7.B PRÉREQUIS

- Service V2 actif et testé hors batch.
- Méthodes individuelles fonctionnelles.
- Limites de nombre d’opérations et de taille connues.
- Jeton CSRF pour tout batch contenant un changeset de modification.
- Données de test pouvant être créées puis supprimées.

## 7.C PRINCIPES

SAP Learning décrit `$batch` comme un endpoint permettant de transmettre plusieurs opérations dans une requête multipart. Les lectures peuvent être des parties indépendantes. Les modifications placées dans un changeset expriment une unité atomique : toutes réussissent ou l’ensemble doit échouer selon le traitement du runtime.

La réponse HTTP externe peut être `202 Accepted` alors qu’une sous-réponse contient une erreur. Il faut analyser chaque partie.

## 7.D TESTER DEUX LECTURES

### 7.D.1 CONFIGURATION GW_CLIENT

- Méthode : `POST`.
- URI : `/sap/opu/odata/sap/ZPRODUCT_SRV/$batch`.
- En-tête : `Content-Type: multipart/mixed; boundary=batch_read`.
- Corps : multipart ci-dessous.

```http
--batch_read
Content-Type: application/http
Content-Transfer-Encoding: binary

GET ProductSet?$top=2 HTTP/1.1
Accept: application/json

--batch_read
Content-Type: application/http
Content-Transfer-Encoding: binary

GET ProductSet('HT-1000') HTTP/1.1
Accept: application/json

--batch_read--
```

Les lignes vides font partie du format MIME. La boundary de l’en-tête doit correspondre exactement aux délimiteurs du corps, sans les deux tirets initiaux dans sa valeur.

## 7.E TESTER UN CHANGESET

Obtenir d’abord un jeton CSRF dans la même session. Utiliser ensuite une boundary de batch et une boundary de changeset distinctes.

```http
--batch_change
Content-Type: multipart/mixed; boundary=changeset_create

--changeset_create
Content-Type: application/http
Content-Transfer-Encoding: binary
Content-ID: 1

POST BusinessPartnerSet HTTP/1.1
Content-Type: application/json

{
  "BusinessPartnerRole": "01",
  "EmailAddress": "batch.create@example.invalid",
  "CompanyName": "BATCH TEST",
  "CurrencyCode": "EUR",
  "City": "Paris",
  "Country": "FR"
}

--changeset_create--
--batch_change--
```

En-têtes de la requête externe :

```http
POST /sap/opu/odata/sap/ZBP_SRV/$batch
Content-Type: multipart/mixed; boundary=batch_change
X-CSRF-Token: <TOKEN>
```

## 7.F PROCESS

1. Tester chaque sous-requête individuellement.
2. Ouvrir Gateway Client depuis le service.
3. Récupérer un jeton si le batch modifie des données.
4. Sélectionner `POST` et saisir l’endpoint `$batch`.
5. Ajouter le `Content-Type` multipart avec la boundary.
6. Coller le payload en conservant les lignes vides et fins de boundary.
7. Exécuter.
8. Lire le statut externe, puis chaque statut interne.
9. Pour un changeset, prouver l’atomicité par relecture des données.

## 7.G CONTRÔLE POSITIF

- Le statut externe indique la prise en charge du batch.
- Chaque lecture contient son propre statut `200`.
- Le `Content-ID` permet d’identifier la sous-opération concernée.
- Le changeset valide toutes ses modifications ou aucune selon le contrat.
- Les clés créées sont relevées puis nettoyées.

## 7.H CONTRÔLES NÉGATIFS

1. Boundary de corps différente de l’en-tête.
2. Sous-requête avec URI inconnue.
3. Deux créations dans un changeset, dont une invalide.
4. Batch de modification sans jeton CSRF.
5. Nombre d’opérations supérieur à la limite du service.

## 7.I ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Rejet MIME | Boundary ou lignes vides incorrectes | Comparer en-tête et corps caractère par caractère |
| Statut externe réussi, fonction en erreur | Sous-réponse non analysée | Lire chaque partie HTTP |
| Modification partielle | Opérations hors changeset ou transaction incorrecte | Regrouper et tester l’atomicité |
| `403` | Jeton/cookie absent | Fetch dans la même session |
| Temps excessif | Batch trop volumineux | Borner taille et nombre d’opérations |

## 7.J COMPATIBILITÉ S/4HANA

Le format ci-dessus vise OData V2. Les optimisations Gateway telles que Batch At Once dépendent de la release et du service. Ne les activer qu’après mesure et validation fonctionnelle.

## 7.K RÉFÉRENCES OFFICIELLES SAP

- [Performing OData Queries — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/performing-odata-queries)
- [Explaining the SAP Gateway — SAP Learning](https://learning.sap.com/courses/implementing-sap-service-and-asset-manager/explaining-the-sap-gateway)

[^terme-batch]: **BATCH.** Requête multipart contenant plusieurs opérations OData, dont les modifications peuvent être regroupées dans un changeset. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#batch>).
