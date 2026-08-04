# 3. MODÉLISER LES ANNOTATIONS ODATA V2

## 3.A RÉSULTAT ATTENDU

Produire un `$metadata` contenant des annotations[^terme-annotation] cohérentes avec les données, les capacités réelles du service et les besoins du consommateur.

À la fin du chapitre, le service expose au minimum des libellés traduisibles, les relations montant-devise ou quantité-unité nécessaires et des indicateurs d’opération conformes à l’implémentation.

## 3.B PRÉREQUIS

- Projet SEGW et modèle de données créés.
- Entity types, propriétés et entity sets stabilisés.
- Cas d’usage du client identifiés.
- Vocabulaires requis disponibles sur la release cible.
- Accès à `SEGW`, `/IWFND/GW_CLIENT` et, pour les annotations ex-place, `/IWBEP/REG_VOCAN`.

## 3.C RÔLE DES ANNOTATIONS

Une annotation ajoute une information destinée au consommateur : libellé, sémantique métier, capacité, relation montant-devise, relation valeur-texte ou règle de présentation. Elle ne remplace ni une donnée, ni une validation métier, ni une autorisation backend.

SAP Learning indique que les extensions SAP du metadata permettent aux clients d’adapter dynamiquement leur interface. Une propriété annoncée comme modifiable peut, par exemple, être rendue éditable par un client compatible. Le comportement réel du service doit rester conforme à cette annonce.

## 3.D DISTINGUER FACETTES ET ANNOTATIONS

| Élément | Exemple | Fonction |
|---|---|---|
| Facette CSDL | `Nullable="false"`, `MaxLength="10"`, `Precision="15"`, `Scale="2"` | Contraint la valeur EDM |
| Extension SAP V2 | `sap:label`, `sap:unit`, `sap:text`, `sap:creatable` | Ajoute une sémantique ou une capacité SAP |
| Annotation de vocabulaire | `com.sap.vocabularies.UI.v1.LineItem` | Décrit un usage au moyen d’un terme normalisé |

`MaxLength` et `Precision` ne sont pas des annotations. Les attributs `sap:*` sont des extensions SAP V2 intégrées au CSDL. Les termes `UI`, `Common`, `Capabilities` et `Measures` appartiennent à des vocabulaires.

## 3.E CHOISIR LE MÉCANISME

| Mécanisme | Emplacement | Usage |
|---|---|---|
| Indicateurs SEGW | Modèle du projet | Capacités, libellés et sémantiques SAP V2 simples |
| Annotation de vocabulaire in-place | `$metadata` principal | Annotation livrée avec le modèle |
| Annotation de vocabulaire ex-place | Document séparé produit par une Annotation Provider Class | Description complémentaire découplée du modèle principal |

Dans SEGW, ouvrir `Extras > Vocabulary Repository` pour consulter les vocabulaires disponibles. SAP Help distingue les annotations **in-place**, incluses dans le metadata, et **ex-place**, produites séparément puis associées au service avec `/IWBEP/REG_VOCAN`. Les termes disponibles dépendent de la release et des vocabulaires installés.

## 3.F ANNOTATIONS SAP V2 COURANTES

| Annotation produite | Niveau habituel | Signification | Exemple |
|---|---|---|---|
| `sap:label` | Propriété ou artefact | Libellé traduisible | `sap:label="Credit Limit"` |
| `sap:creatable` | Propriété, type ou set | Création annoncée | `sap:creatable="false"` |
| `sap:updatable` | Propriété, type ou set | Modification annoncée | `sap:updatable="false"` |
| `sap:deletable` | Type ou set | Suppression annoncée | `sap:deletable="false"` |
| `sap:filterable` | Propriété | Utilisation dans `$filter` annoncée | `sap:filterable="false"` |
| `sap:sortable` | Propriété | Utilisation dans `$orderby` annoncée | `sap:sortable="false"` |
| `sap:unit` | Propriété numérique | Propriété contenant devise ou unité | `sap:unit="CurrencyCode"` |
| `sap:text` | Propriété code | Propriété contenant le texte associé | `sap:text="CompanyName"` |
| `sap:semantics` | Propriété | Nature métier de la valeur | `sap:semantics="currency-code"` |
| `sap:display-format` | Propriété | Indication de présentation | `sap:display-format="Date"` |
| `sap:filter-restriction` | Propriété | Forme de filtre attendue | `single-value`, `multi-value`, `interval` |

Un client peut exploiter ou ignorer une annotation. Le contrat doit être testé avec le consommateur cible.

## 3.G CONFIGURER LES ANNOTATIONS DANS SEGW

1. Ouvrir le projet dans `SEGW`.
2. Développer `Data Model > Entity Types > <EntityType> > Properties`.
3. Sélectionner une propriété.
4. Renseigner le libellé et les indicateurs disponibles : `Creatable`, `Updatable`, `Sortable`, `Filterable`.
5. Pour un montant ou une quantité, renseigner la propriété portant la devise ou l’unité.
6. Développer `Entity Sets` et aligner les capacités du set sur les méthodes DPC_EXT réellement implémentées.
7. Ouvrir `Extras > Vocabulary Repository` avant d’utiliser un terme de vocabulaire.
8. Exécuter le consistency check.
9. Régénérer les runtime objects.
10. Lire le `$metadata` généré.

Les champs visibles et leurs libellés peuvent varier selon le type de projet SEGW et la version de `SAP_GWFND`.

## 3.H MODÉLISER UN MONTANT ET SA DEVISE

Le montant et la devise sont deux propriétés distinctes. La propriété numérique référence la propriété portant le code devise.

| Propriété | Type | Configuration attendue |
|---|---|---|
| `CreditLimit` | `Edm.Decimal` | `Precision`, `Scale`, `sap:unit="CurrencyCode"` |
| `CurrencyCode` | `Edm.String` | longueur adaptée et sémantique de code devise |

Metadata attendu, simplifié :

```xml
<Property Name="CreditLimit"
          Type="Edm.Decimal"
          Precision="15"
          Scale="2"
          sap:label="Credit Limit"
          sap:unit="CurrencyCode" />
<Property Name="CurrencyCode"
          Type="Edm.String"
          MaxLength="5"
          sap:label="Currency Code"
          sap:semantics="currency-code" />
```

Dans `MPC_EXT`, la relation peut être adaptée avec l’API du modèle. `CurrencyCode` est le nom OData externe :

```abap
METHOD define.
  super->define( ).

  DATA(lo_entity_type) = model->get_entity_type(
    iv_entity_name = 'BusinessPartner' ).

  DATA(lo_credit_limit) = lo_entity_type->get_property(
    iv_property_name = 'CreditLimit' ).

  lo_credit_limit->set_unit_property(
    iv_unit_property = 'CurrencyCode' ).
ENDMETHOD.
```

SAP Help indique que `SET_UNIT` est obsolète et qu’il faut utiliser `SET_UNIT_PROPERTY`. Lorsque la propriété référencée porte la sémantique devise, Gateway peut appliquer la conversion entre représentation ABAP interne et représentation externe. Tester notamment une devise sans décimales, telle que JPY.

## 3.I MODÉLISER UNE QUANTITÉ ET SON UNITÉ

```xml
<Property Name="OrderQuantity"
          Type="Edm.Decimal"
          Precision="13"
          Scale="3"
          sap:unit="QuantityUnit" />
<Property Name="QuantityUnit"
          Type="Edm.String"
          MaxLength="3"
          sap:semantics="unit-of-measure" />
```

Le type, la longueur et l’échelle doivent provenir du domaine métier. Ne pas recopier ces valeurs sans vérifier le data element ou le contrat d’API.

## 3.J MODÉLISER UNE VALEUR ET SON TEXTE

Une propriété technique ou codifiée peut référencer une propriété descriptive avec `sap:text`.

```xml
<Property Name="BusinessPartnerRole"
          Type="Edm.String"
          MaxLength="3"
          sap:text="BusinessPartnerRoleText" />
<Property Name="BusinessPartnerRoleText"
          Type="Edm.String"
          MaxLength="60"
          sap:creatable="false"
          sap:updatable="false" />
```

La propriété de texte doit exister dans le même modèle et être alimentée par l’implémentation. L’annotation ne déclenche pas seule la lecture du texte.

## 3.K GÉRER LES LIBELLÉS ET TRADUCTIONS

Un libellé importé depuis un data element DDIC peut être repris par le modèle. `/IWBEP/IF_MGW_ODATA_PROPERTY` fournit `BIND_DATA_ELEMENT_FOR_TEXT` pour remplacer la source de texte d’une propriété. `/IWBEP/IF_MGW_ODATA_ITEM` fournit `SET_LABEL_FROM_TEXT_ELEMENT` pour définir `sap:label` depuis un élément de texte.

Tester les langues dans `/IWFND/GW_CLIENT` :

```http
GET /sap/opu/odata/sap/ZBP_SRV/$metadata?sap-language=FR
GET /sap/opu/odata/sap/ZBP_SRV/$metadata?sap-language=EN
```

Ne pas coder en dur dans `MPC_EXT` un texte qui doit être traduit.

## 3.L UTILISER LES VOCABULAIRES UI, COMMON, CAPABILITIES ET MEASURES

| Vocabulaire | Exemples d’usage |
|---|---|
| `UI` | `LineItem`, `Identification`, `HeaderInfo`, `FieldGroup` |
| `Common` | `Label`, `Text`, `ValueList`, `FieldControl` |
| `Capabilities` | Restrictions de lecture, insertion, modification, suppression ou filtrage |
| `Measures` | Devise ou unité associée à une mesure |

Les attributs `sap:*` ne suffisent pas à définir une application Fiori elements. Les annotations UI décrivent les éléments affichés par un client compatible, pas la logique métier du service.

Exemple conceptuel `UI.LineItem` :

```xml
<Annotations Target="ZBP_SRV.BusinessPartner">
  <Annotation Term="com.sap.vocabularies.UI.v1.LineItem">
    <Collection>
      <Record Type="com.sap.vocabularies.UI.v1.DataField">
        <PropertyValue Property="Value" Path="BusinessPartnerID" />
      </Record>
      <Record Type="com.sap.vocabularies.UI.v1.DataField">
        <PropertyValue Property="Value" Path="CompanyName" />
      </Record>
    </Collection>
  </Annotation>
</Annotations>
```

Le `Target` doit reprendre exactement le namespace et le type publiés. Chaque `Path` doit désigner une propriété existante.

## 3.M CONTRÔLER AVEC GW_CLIENT

1. Dans `/IWFND/GW_CLIENT`, exécuter :

```http
GET /sap/opu/odata/sap/ZBP_SRV/$metadata
```

2. Rechercher `sap:label`, `sap:unit`, `sap:text` et les capacités attendues.
3. Rechercher les blocs `<Annotations>` et contrôler leurs `Target`.
4. Répéter l’appel avec `sap-language=FR` et `sap-language=EN`.
5. Vérifier que les propriétés référencées par `sap:unit`, `sap:text` et `Path` existent.
6. Tester les opérations annoncées : `$filter`, `$orderby`, `POST`, `PATCH` ou `DELETE` selon le contrat.
7. Nettoyer les caches metadata si une ancienne version reste visible.
8. Tester l’application consommatrice ; la présence dans le metadata ne prouve pas que le client interprète le terme.

## 3.N TESTS POSITIFS ET NÉGATIFS

| Test | Résultat attendu |
|---|---|
| Metadata FR puis EN | Libellés traduits lorsque les deux traductions existent |
| `sap:unit="CurrencyCode"` | Propriété `CurrencyCode` présente et renseignée |
| Propriété `Filterable` | `$filter` traité conformément au contrat |
| Propriété non modifiable | Payload rejeté ou valeur ignorée selon le contrat documenté |
| Target volontairement incorrect sur un système de test | Annotation non appliquée par le client, sans modifier la donnée métier |

## 3.O POINTS À REMPLACER

- `ZBP_SRV` par le nom technique du service.
- `BusinessPartner` par l’entity type publié.
- `CreditLimit`, `CurrencyCode` et les types EDM par les propriétés réelles.
- Namespace et targets par les valeurs exactes du `$metadata`.
- Vocabulaires et termes par ceux supportés sur la release cible.

## 3.P ERREURS FRÉQUENTES

| Symptôme | Cause probable | Correction |
|---|---|---|
| Annotation absente du metadata | Runtime objects non régénérés ou cache obsolète | Régénérer puis nettoyer les caches |
| Montant sans devise | `sap:unit` absent ou cible incorrecte | Référencer la propriété devise/unité |
| Conversion monétaire incorrecte | Sémantique ou mapping ABAP incohérent | Vérifier data element, devise et `SET_UNIT_PROPERTY` |
| Texte non affiché | `sap:text` cible une propriété absente ou non alimentée | Corriger le modèle et DPC_EXT |
| Libellé non traduit | Texte codé en dur ou traduction absente | Utiliser DDIC, élément de texte ou fournisseur traduisible |
| Annotation UI ignorée | `Target`, terme ou `Path` incorrect | Comparer avec le `$metadata` réel |
| UI autorisant une opération rejetée | Capacité incohérente avec DPC_EXT ou autorisation | Aligner modèle, implémentation et sécurité |
| Terme indisponible | Vocabulaire absent sur la release | Vérifier `Vocabulary Repository` et la compatibilité |

## 3.Q COMPATIBILITÉ

Ce chapitre traite principalement des services OData V2 créés avec SEGW. Les annotations OData V4 et RAP utilisent principalement des vocabulaires et des annotations CDS. Ne pas transposer directement une extension `sap:*` V2 dans un service binding RAP.

Les méthodes et champs disponibles peuvent varier avec la version de `SAP_GWFND`. Vérifier les interfaces dans le système cible.

## 3.R RÉFÉRENCES OFFICIELLES SAP

- [Explaining Open Data Protocol — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/explaining-open-data-protocol-odata-)
- [Implementing Navigation — SAP Learning](https://learning.sap.com/courses/building-odata-services-with-sap-gateway/implementing-navigation)
- [Creating a Service Builder Project — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_752/68bf513362174d54b58cddec28794093/6c4f22518bc72214e10000000a44176d.html)
- [Working With OData Annotations — SAPUI5](https://help.sap.com/docs/SAPUI5/b2f662dd9d7a4ec680056733050b4d34/8b55ead17bd54c56b5597977fbf4b123.html)
- [Vocabulary-Based Annotations — SAP Help Portal, version 2025 FPS01](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/296e3434bd4749708ceeb690b692eea1.html)
- [/IWBEP/IF_MGW_ODATA_PROPERTY — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/68bf513362174d54b58cddec28794093/dafb2651c294256ee10000000a445394.html)
- [OData Vocabulary Annotations APIs — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/68bf513362174d54b58cddec28794093/652c3419f01e48f7a7f67adc52fdf9a0.html)

[^terme-annotation]: **ANNOTATION.** Information ajoutée au modèle OData pour préciser la sémantique, les capacités ou la présentation d’un artefact. Voir [le lexique](<../🧩 00 ├── LEXIQUE ODATA ET SAP GATEWAY/02 ├── MODELE DE DONNEES ODATA.md#annotation>).
