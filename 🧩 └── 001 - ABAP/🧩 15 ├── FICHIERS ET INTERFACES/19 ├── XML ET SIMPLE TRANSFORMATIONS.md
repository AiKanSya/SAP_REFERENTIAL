# 19. XML ET SIMPLE TRANSFORMATIONS

## 19.A RÉSULTAT ATTENDU

- Sérialiser des données ABAP en XML
- Distinguer transformation identité et format métier
- Utiliser `STRANS` dans SAP GUI

## 19.B `CALL TRANSFORMATION`

```abap
DATA ls_product TYPE zdev_product.
DATA lv_xml     TYPE xstring.

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lv_xml.
```

La transformation prédéfinie `ID` produit la représentation canonique SAP appelée **asXML**. Elle est utile pour des échanges techniques contrôlés, mais ne correspond pas automatiquement au schéma XML demandé par un partenaire.

## 19.C SIMPLE TRANSFORMATION

Une **Simple Transformation** créée dans `STRANS` permet de définir un document métier.

```abap
CALL TRANSFORMATION zdev_product_xml
  SOURCE product = ls_product
  RESULT XML lv_xml.
```

```mermaid
flowchart LR
    A["Structure ABAP"] --> B["Simple Transformation"]
    B --> C["XML métier"]
    C --> D["Validation du contrat"]
```

## 19.D IMPORT XML

```abap
CALL TRANSFORMATION zdev_product_xml
  SOURCE XML lv_xml
  RESULT product = ls_product.
```

Les erreurs de syntaxe XML, de transformation ou de mapping doivent être capturées avec les classes d’exception appropriées, notamment dans la hiérarchie `CX_TRANSFORMATION_ERROR`.

## 19.E BONNES PRATIQUES

- Versionner le schéma et la transformation.
- Contrôler les namespaces.
- Limiter la taille du document chargé en mémoire.
- Refuser les éléments inattendus selon le niveau de contrôle attendu.
- Tester les valeurs vides, caractères spéciaux et listes répétées.

## 19.F PROCESS

### 19.F.1 Étape 1 — Définir le contrat XML

Fixer l’élément racine, les espaces de noms, les éléments obligatoires, les cardinalités, les types et l’encodage. Conserver un exemple valide et des exemples invalides représentatifs.

### 19.F.2 Étape 2 — Créer une transformation simple dans `STRANS`

Nommer la transformation dans l’espace client, définir les nœuds racine et mapper les champs vers des types DDIC ou ABAP stables.

### 19.F.3 Étape 3 — Sérialiser une structure typée

Préparer les données dans une structure dédiée, puis appeler `CALL TRANSFORMATION` avec `SOURCE` et `RESULT XML`. Éviter de construire le document par concaténation de chaînes.

### 19.F.4 Étape 4 — Désérialiser vers une cible typée

Fournir le contenu XML et une structure cible initialisée. Après transformation, valider les règles métier qui ne sont pas exprimées par la structure XML.

### 19.F.5 Étape 5 — Traiter les erreurs de transformation

Intercepter `CX_TRANSFORMATION_ERROR` et retourner un message contrôlé. Journaliser le contexte technique utile sans recopier le document complet s’il contient des données sensibles.

### 19.F.6 Étape 6 — Borner et sécuriser l’entrée

Limiter la taille du document avant transformation. N’accepter que les transformations prévues par le programme ; leur nom ne doit pas provenir librement d’une entrée externe.

### 19.F.7 Étape 7 — Tester les variantes du contrat

Tester un document valide, un élément obligatoire absent, un type invalide, un espace de noms incorrect, un document trop volumineux et des caractères non ASCII.

## 19.G VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 19.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 19.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_product TYPE zdev_product.
DATA lv_xml     TYPE xstring.

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lv_xml.
```

## 19.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 19.K RÉFÉRENCES OFFICIELLES SAP

- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Simple Transformations — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENST.html)
- [Canonical XML Representation — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_XMLS.html)

---

[Chapitre suivant — JSON AVEC LA BIBLIOTHÈQUE SXML](<./20 ├── JSON AVEC LA BIBLIOTHEQUE SXML.md>)
