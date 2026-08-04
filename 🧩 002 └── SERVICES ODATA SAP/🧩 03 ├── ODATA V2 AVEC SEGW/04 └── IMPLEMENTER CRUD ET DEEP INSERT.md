# 4. IMPLÉMENTER CRUD ET DEEP INSERT

## 4.A RÉSULTAT ATTENDU

Associer chaque opération HTTP à un traitement métier transactionnel explicite.

## 4.B PRÉREQUIS

- Opérations autorisées validées par ressource.
- API métier et responsabilité du commit identifiées.
- Modèle d’erreur et contrôles d’autorisation définis.
- Payloads nominaux et invalides disponibles.

## 4.C MAPPAGE

| HTTP | Intention | Contrôle minimal |
|---|---|---|
| GET | Lire | Autorisation et existence |
| POST | Créer | Validation, API métier, transaction |
| PUT/PATCH | Remplacer/modifier | Clé, concurrence, champs autorisés |
| DELETE | Supprimer | Autorisation, existence, dépendances |

## 4.D TRANSACTION ET CONCURRENCE

Une requête de mutation doit former une unité fonctionnelle cohérente. Le fournisseur de données appelle l’API métier, collecte les messages, retourne une erreur contrôlée en cas d’échec et respecte la stratégie transactionnelle du framework. Pour une modification concurrente, utiliser les ETags et préconditions si le service les expose ; ne pas écraser silencieusement une version plus récente.

## 4.E PROCESS

### 4.E.1 ÉTAPE 1 — LIRE LE PAYLOAD

1. Lire et désérialiser la requête avec l’API Gateway fournie.

### 4.E.2 ÉTAPE 2 — VALIDER

2. Rejeter les champs ou volumes hors contrat.
3. Exécuter les `AUTHORITY-CHECK` métier.

### 4.E.3 ÉTAPE 3 — EXÉCUTER L’API

4. Appeler l’API métier sans accès direct aux tables applicatives.
5. Décider la frontière transactionnelle une seule fois.

### 4.E.4 ÉTAPE 4 — CONSTRUIRE LA RÉPONSE

6. Retourner la ressource créée ou modifiée selon le contrat.

### 4.E.5 ÉTAPE 5 — TRAITER UN ENSEMBLE

7. Pour un deep insert, valider l’en-tête et toutes les positions avant la validation transactionnelle.

## 4.F PAYLOAD À ADAPTER

```http
POST /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet
Content-Type: application/json
X-CSRF-Token: <TOKEN>

{
  "CompanyCode": "1000",
  "DocumentDate": "2026-08-04T00:00:00",
  "Currency": "EUR"
}
```

## 4.G POINTS À REMPLACER

- Service, entity set et propriétés selon `$metadata`.
- Format des dates selon OData V2 et le runtime utilisé.
- Jeton CSRF et cookies obtenus dans la même session.
- API métier et messages selon le domaine.

## 4.H TESTS

- Création nominale.
- Clé inexistante et clé dupliquée.
- Champ obligatoire absent.
- Utilisateur sans autorisation.
- Erreur sur une position d’un deep insert : aucun sous-ensemble ne doit rester validé sans contrat explicite.

## 4.I ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| `403` sur POST | Jeton CSRF/cookie absent ou autorisation | Fetch puis rejouer dans la session ; tracer les droits |
| Création partielle | Transaction mal délimitée | Déplacer l’atomicité dans l’API métier |
| Valeurs ignorées | Propriétés non lues ou non mappées | Comparer payload, metadata et structure d’entrée |
| Mise à jour perdue | ETag/précondition absente | Implémenter le contrôle de concurrence |

## 4.J COMPATIBILITÉ S/4HANA

Statut : SAP Gateway OData V2 classique. Pour un nouveau service transactionnel, évaluer RAP et OData V4 avant de choisir SEGW.

Deep insert et changesets répondent à des contrats différents. Ne pas les substituer sans examiner l’atomicité, les Content-ID et les capacités du consommateur.

## 4.K RÉFÉRENCES OFFICIELLES SAP

- [Managing an SAP Gateway Service — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/managing-an-sap-gateway-service)
- [Explaining the SAP Gateway — SAP Learning](https://learning.sap.com/courses/implementing-sap-service-and-asset-manager/explaining-the-sap-gateway)
- [Getting Started with the Service Builder — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_1909/68bf513362174d54b58cddec28794093/36742c510e87fa50e10000000a441470.html)
