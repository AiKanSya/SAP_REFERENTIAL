# 2. LIRE LE METADATA ET LE MODÈLE

## 2.A RÉSULTAT ATTENDU

Déterminer les URI[^terme-uri] valides, les clés et les propriétés à partir de `$metadata`[^terme-metadata].

Le contrôle est réussi lorsque le lecteur peut construire manuellement l’URI d’une collection, d’une entité et d’une navigation sans deviner le nom ni le type d’une clé.

## 2.B PRÉREQUIS

- URL racine du service et utilisateur autorisé.
- Accès à `/IWFND/GW_CLIENT` ou à un client HTTP.
- Connaissance du format URI attendu pour les valeurs texte, numériques, GUID, date et heure de la version concernée.

## 2.C ÉLÉMENTS À RELEVER

| Élément | Question |
|---|---|
| `EntityContainer` | Quel conteneur publie les ressources ? |
| `EntitySet` | Quel segment URI adresse la collection ? |
| `EntityType` | Quelles propriétés décrivent une entité ? |
| `Key` | Quelles propriétés composent l’identifiant ? |
| Type EDM | Quel littéral et quel format envoyer ? |
| Navigation | Quelle relation est accessible ? |
| Operation | Quelle action ou fonction est exposée ? |

Les extensions SAP du metadata peuvent ajouter libellés, sémantique, capacités et informations utilisées par les clients metadata-driven.

## 2.D PROCESS

### 2.D.1 ÉTAPE 1 — OBTENIR LE DOCUMENT

1. Exécuter `GET <racine>/$metadata`.
2. Contrôler le statut HTTP `200` et le type de contenu XML.

### 2.D.2 ÉTAPE 2 — PARTIR DU CONTENEUR

3. Rechercher l’entity container puis les entity sets exposés.
4. Associer chaque entity set à son entity type.

### 2.D.3 ÉTAPE 3 — RECONSTRUIRE LES CLÉS

5. Relever les propriétés de clé, leur type EDM, leur nullabilité et leurs contraintes.

### 2.D.4 ÉTAPE 4 — RELEVER LES RELATIONS

6. Relever les navigation properties et les opérations.

### 2.D.5 ÉTAPE 5 — COMPARER AU BESOIN

7. Comparer le contrat au besoin du consommateur avant de changer le backend.

Exemple d’URI V2 :

```http
GET /sap/opu/odata/sap/ZSALES_SRV/$metadata
GET /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet('500000001')
```

## 2.E URI PRÊTES À ADAPTER

```http
GET /sap/opu/odata/sap/ZSALES_SRV/
GET /sap/opu/odata/sap/ZSALES_SRV/$metadata
GET /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet?$top=5
GET /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet('500000001')
GET /sap/opu/odata/sap/ZSALES_SRV/SalesOrderSet('500000001')/ToItems
```

## 2.F POINTS À REMPLACER

| Valeur | Remplacement |
|---|---|
| `ZSALES_SRV` | Nom technique enregistré |
| `SalesOrderSet` | Entity set du metadata |
| `'500000001'` | Littéral conforme au type de clé |
| `ToItems` | Navigation property publiée |

## 2.G CONTRÔLE POSITIF

1. Exécuter `$metadata` et obtenir `200`.
2. Appeler une collection avec `$top=5`.
3. Relever une clé réelle dans la réponse.
4. Construire l’URI de l’entité avec le type exact.
5. Appeler une navigation publiée et comparer sa cardinalité au metadata.

## 2.H CONTRÔLE NÉGATIF

- Une entity set absente du metadata ne doit pas être appelée.
- Une clé texte doit conserver les quotes et l’encodage URI.
- Une propriété non exposée ne doit pas être supposée disponible parce qu’elle existe en DDIC.

## 2.I MAINTENANCE

Après une modification du modèle, comparer le metadata avant/après. Une suppression ou un changement de type est une rupture de contrat pour les consommateurs existants.

Conserver une copie normalisée du metadata de la version productive. Comparer entity sets, propriétés, types, nullabilité, clés et opérations. Un simple changement d’ordre XML ne constitue pas une rupture.

## 2.J ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| `404` sur une collection | Nom d’entity set incorrect | Reprendre le nom du conteneur |
| Erreur de syntaxe de clé | Littéral incompatible | Utiliser le type EDM du metadata |
| Navigation absente | Association non exposée ou mauvais sens | Lire la navigation property source |
| Champ absent | Propriété non publiée | Corriger le contrat ou le consommateur |

## 2.K COMPATIBILITÉ S/4HANA

Le principe `$metadata` s’applique aux services V2 et V4. Les constructions CSDL et les littéraux URI varient selon la version ; ne pas transposer une syntaxe V2 vers V4 sans vérification.

## 2.L RÉFÉRENCES OFFICIELLES SAP

- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [SAP Gateway Service Builder — SAP Help Portal, 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/cddd22512c312314e10000000a44176d.html)

[^terme-uri]: **URI.** Identifiant textuel d’une ressource ou d’une opération du service. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/01 ├── PROTOCOLE HTTP ET ODATA.md#uri>).
[^terme-metadata]: **METADATA.** Document CSDL décrivant types, collections, relations et opérations. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#metadata>).
