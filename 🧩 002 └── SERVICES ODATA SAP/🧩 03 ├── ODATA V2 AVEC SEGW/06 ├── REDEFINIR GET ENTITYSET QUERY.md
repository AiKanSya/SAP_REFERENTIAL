# 6. REDÉFINIR GET_ENTITYSET POUR UNE QUERY

## 6.A RÉSULTAT ATTENDU

Redéfinir `<ENTITYSET>_GET_ENTITYSET` dans `DPC_EXT`[^terme-dpc] et remplir `ET_ENTITYSET` avec une collection issue d’une API métier.

Le test est réussi lorsque `GET ProductSet` retourne `200` et une collection dont les propriétés correspondent au metadata.

## 6.B PRÉREQUIS

- Projet SEGW généré et service enregistré.
- Entity set `ProductSet` ou équivalent.
- Classe `DPC_EXT` active.
- API de lecture disponible. `BAPI_EPM_PRODUCT_GET_LIST` appartient au contenu de démonstration utilisé par SAP Learning et peut être absente du système cible.

## 6.C OUVRIR ET REDÉFINIR LA MÉTHODE

1. Ouvrir `SEGW` et le projet.
2. Développer `Service Implementation > ProductSet`.
3. Ouvrir le menu de `GetEntitySet (Query)` puis **Go to ABAP Workbench**.
4. Dans la classe d’extension, placer le curseur sur `PRODUCTSET_GET_ENTITYSET`.
5. Choisir **Redefine**.
6. Ne jamais implémenter la méthode dans la classe DPC de base : une régénération l’écraserait.

## 6.D CODE PRÊT À ADAPTER

```abap
METHOD productset_get_entityset.
  DATA lt_products TYPE TABLE OF bapi_epm_product_header.
  DATA lt_return   TYPE TABLE OF bapiret2.

  CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_LIST'
    TABLES
      headerdata = lt_products
      return     = lt_return.

  IF line_exists( lt_return[ type = 'E' ] )
  OR line_exists( lt_return[ type = 'A' ] ).
    mo_context->get_message_container( )->add_messages_from_bapi(
      it_bapi_messages = lt_return ).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid            = /iwbep/cx_mgw_busi_exception=>business_error
        message_container = mo_context->get_message_container( ).
  ENDIF.

  et_entityset = CORRESPONDING #( lt_products ).
ENDMETHOD.
```

`ET_ENTITYSET` utilise le type table généré depuis l’entity type. `CORRESPONDING` ne remplit que les composants de même nom ; mapper explicitement toute propriété dont le nom ou la conversion diffère.

## 6.E VARIANTE AVEC ABAP SQL

Utiliser uniquement une vue ou table autorisée du domaine client :

```abap
SELECT productid,
       name,
       category,
       price,
       currencycode
  FROM zi_product_api
  ORDER BY productid
  INTO CORRESPONDING FIELDS OF TABLE @et_entityset
  UP TO 100 ROWS.
```

Cette limite fixe est un garde-fou d’exemple. Une implémentation productive doit traiter les options de requête et la pagination conformément au contrat.

## 6.F POINTS À REMPLACER

| Exemple | Remplacement |
|---|---|
| `PRODUCTSET_GET_ENTITYSET` | Méthode générée de l’entity set |
| `BAPI_EPM_PRODUCT_GET_LIST` | API métier publiée du domaine |
| `BAPI_EPM_PRODUCT_HEADER` | Type retourné par cette API |
| `ZI_PRODUCT_API` | Vue autorisée et stable |
| Mapping | Affectations correspondant au metadata |

## 6.G CONTRÔLE

```http
GET /sap/opu/odata/sap/ZPRODUCT_SRV/ProductSet?$top=5
```

1. Obtenir `200`.
2. Contrôler cinq lignes au maximum.
3. Comparer une ligne avec la source métier.
4. Provoquer une erreur contrôlée de l’API en environnement de test et vérifier le message Gateway.

## 6.H ERREURS FRÉQUENTES

| Symptôme | Cause | Correction |
|---|---|---|
| Collection vide | `ET_ENTITYSET` non rempli | Mapper la table de sortie |
| Code perdu | Implémentation dans DPC de base | Redéfinir dans DPC_EXT |
| Propriétés initiales | Noms incompatibles | Mapper explicitement |
| `500` sur BAPI | Messages non convertis | Alimenter le message container |

## 6.I COMPATIBILITÉ S/4HANA

Technique SAP Gateway V2 classique. Les BAPI EPM sont des objets de démonstration et ne constituent pas une API universellement disponible.

## 6.J RÉFÉRENCES OFFICIELLES SAP

- [Implementing Reading Operations — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-reading-operations)

[^terme-dpc]: **DPC.** Data Provider Class fournissant les méthodes de données d’un service Gateway. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/04 ├── SEGW ET RUNTIME V2.md#dpc>).
