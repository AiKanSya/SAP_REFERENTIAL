# 1. TESTER AVEC /IWFND/GW_CLIENT

## 1.A RÉSULTAT ATTENDU

Reproduire une requête OData avec Gateway Client[^terme-gateway-client] sans dépendre de l’application consommatrice.

## 1.B PRÉREQUIS

- URI relative, méthode, en-têtes et payload de la requête à reproduire.
- Utilisateur possédant uniquement les droits requis pour le test.
- Données non productives pour les mutations.
- Heure et identifiant de corrélation relevés.

## 1.C INTERFACE

Gateway Client permet de choisir `GET`, `POST`, `PUT`, `PATCH`, `MERGE`, `DELETE` ou `HEAD`, de saisir une URI, des en-têtes et un corps, puis d’examiner statut, en-têtes et réponse. Il peut être lancé depuis le contexte d’une erreur Gateway afin de reproduire la situation.

## 1.D PROCESS

### 1.D.1 ÉTAPE 1 — RECONSTRUIRE LA REQUÊTE

1. Ouvrir `/IWFND/GW_CLIENT`.
2. Sélectionner la méthode HTTP.
3. Saisir l’URI relative exacte.
4. Ajouter uniquement les en-têtes nécessaires.

### 1.D.2 ÉTAPE 2 — OBTENIR LE JETON SI NÉCESSAIRE

5. Pour une mutation, récupérer un jeton CSRF[^terme-csrf] avec `X-CSRF-Token: Fetch`, conserver les cookies puis rejouer la requête avec le jeton.

### 1.D.3 ÉTAPE 3 — EXÉCUTER ET RELEVER

6. Exécuter et relever statut, en-têtes, corps et durée.
7. Sauvegarder la requête de reproduction sans secret.

## 1.E REQUÊTES PRÊTES À ADAPTER

```http
GET /sap/opu/odata/sap/ZSALES_SRV/$metadata
GET /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet?$top=10
```

Récupération d’un jeton :

```http
GET /sap/opu/odata/sap/ZSALES_SRV/
X-CSRF-Token: Fetch
```

Tester ensuite une clé valide, une clé inconnue, un filtre valide, un filtre invalide et une mutation sans autorisation.

## 1.F POINTS À REMPLACER

- Nom et version du service.
- Entity set, clé et options depuis `$metadata`.
- Payload conforme au contrat.
- Jeton et cookies de la session courante.

## 1.G INTERPRÉTATION

| Statut | Lecture initiale |
|---|---|
| 200 | Réponse traitée |
| 400 | Requête ou contrat invalide |
| 401/403 | Authentification ou autorisation |
| 404 | Ressource, service ou route absente |
| 412 | Précondition ou concurrence |
| 500 | Erreur technique backend ou Gateway |

## 1.H CONTRÔLE

1. `$metadata` retourne `200`.
2. Une clé connue retourne la ressource attendue.
3. Une clé absente produit le statut prévu.
4. Une mutation sans jeton est refusée.
5. La même mutation avec jeton, cookie et autorisation produit le résultat attendu.

## 1.I ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| `403` sur mutation | Jeton/cookie ou autorisation | Refaire le fetch dans la même session et tracer les droits |
| Réponse différente de l’UI | En-têtes ou utilisateur différents | Comparer la requête complète |
| Breakpoint absent | Utilisateur ou backend incorrect | Point externe et alias |
| Replay dangereux | Requête mutante productive | Reproduire sur données de test |

## 1.J COMPATIBILITÉ S/4HANA

Gateway Client reste l’outil SAP GUI central pour isoler le service V2. Les formats de payload, en-têtes et URI doivent correspondre à la version OData du service.

## 1.K RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Gateway Client — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079611.html)

[^terme-gateway-client]: **GATEWAY CLIENT.** Outil SAP permettant de construire, exécuter et analyser des requêtes OData. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#gateway-client>).
[^terme-csrf]: **JETON CSRF.** Jeton de session protégeant les requêtes de modification contre certaines requêtes forgées. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/01 ├── PROTOCOLE HTTP ET ODATA.md#csrf-token>).
