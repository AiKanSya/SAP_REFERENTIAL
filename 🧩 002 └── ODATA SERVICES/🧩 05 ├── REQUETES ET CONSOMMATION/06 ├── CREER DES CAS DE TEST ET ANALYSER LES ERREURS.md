# 6. CRÉER DES CAS DE TEST ET ANALYSER LES ERREURS

## 6.A RÉSULTAT ATTENDU

Conserver des requêtes Gateway Client rejouables et relier chaque échec au journal Gateway[^terme-error-log] approprié.

## 6.B PRÉREQUIS

- Groupe de test dédié au service.
- Données de test reproductibles.
- Règles interdisant l’enregistrement de secrets, cookies et données personnelles.
- Accès aux journaux Gateway.

## 6.C ENREGISTRER UN CAS DE TEST

SAP Learning indique que Gateway Client peut enregistrer les données de requête sous forme XML et organiser les tests en groupes.

1. Construire et exécuter une requête minimale.
2. Ouvrir la fonction de gestion des test cases.
3. Créer un groupe nommé selon le service et la version.
4. Enregistrer méthode, URI, en-têtes non secrets et payload anonymisé.
5. Documenter le statut et les assertions attendus dans la description.
6. Rejouer le cas après une modification ou un transport.

Ne pas persister un jeton CSRF, un cookie de session, un mot de passe ou une clé d’API. Ces valeurs doivent être obtenues au moment du test.

## 6.D JEU MINIMAL DE NON-RÉGRESSION

| Cas | Méthode | Assertion |
|---|---|---|
| Metadata | `GET` | `200`, entités et types attendus |
| Query bornée | `GET` | `200`, volume maximal |
| Read existante | `GET` | Clé et valeurs attendues |
| Read absente | `GET` | Erreur métier conforme |
| Create valide | `POST` | `201`, clé retournée |
| Create invalide | `POST` | Aucune persistance |
| Update | `PUT/PATCH` | `204`, valeur relue |
| Delete | `DELETE` | `204`, clé ensuite absente |
| Autorisation | Toutes | Refus avec utilisateur limité |

## 6.E ANALYSER UNE ERREUR DEPUIS GW_CLIENT

1. Ne rejouer qu’une fois la requête.
2. Relever heure, utilisateur, service, URI, statut et transaction ID.
3. Choisir **Error Log** depuis Gateway Client.
4. Ouvrir l’entrée correspondante dans `/IWFND/ERROR_LOG`.
5. Pour une erreur backend, suivre vers `/IWBEP/ERROR_LOG`.
6. Pour un dump, ouvrir `ST22` au même horodatage.
7. Pour un refus, exécuter `STAUTHTRACE` avec le même utilisateur et le même appel.

## 6.F TABLE DE DÉCISION

| Statut | Premier contrôle | Preuve suivante |
|---|---|---|
| `400` | URI, JSON, types et propriétés | Metadata et message container |
| `401` | Authentification | Configuration HTTP/identity provider |
| `403` | CSRF ou autorisation | En-têtes, cookies, `STAUTHTRACE` |
| `404` | Service, version, entity set, clé | Maintenance et metadata |
| `412` | ETag/précondition | ETag lu et envoyé |
| `500` | Error logs | Exception backend ou dump |

## 6.G EXEMPLE DE FICHE DE TEST

```text
ID              : ZBP_CREATE_VALID
Utilisateur     : ZODATA_TEST_CREATE
Méthode         : POST
URI             : /sap/opu/odata/sap/ZBP_SRV/BusinessPartnerSet
Précondition    : e-mail unique, jeton CSRF courant
Statut attendu  : 201
Assertion       : clé non vide, GET par clé = 200
Nettoyage       : DELETE de la clé créée
```

## 6.H ERREURS FRÉQUENTES

- Enregistrer des cookies ou jetons dans un test partagé.
- Dépendre d’une clé productive mutable.
- Comparer uniquement le statut sans vérifier le corps et les effets persistés.
- Rejouer une mutation en production depuis le journal.
- Déclarer le test réussi sans nettoyer ses données.

## 6.I COMPATIBILITÉ S/4HANA

La disponibilité et l’interface de gestion des test cases dépendent de la version de Gateway Client. Les principes de reproductibilité et de protection des secrets restent applicables.

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Gateway Client — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abapconn/3354079611.html)

[^terme-error-log]: **JOURNAL D’ERREURS GATEWAY.** Journal donnant le contexte des erreurs produites pendant une requête OData. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/05 ├── REQUETES QUALITE ET SECURITE.md#gateway-error-log>).
