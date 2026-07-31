# 🌸 XML ET SIMPLE TRANSFORMATIONS

## 🌺 OBJECTIFS

- Sérialiser des données ABAP en XML
- Distinguer transformation identité et format métier
- Utiliser `STRANS` dans SAP GUI

## 🌺 `CALL TRANSFORMATION`

```abap
DATA ls_product TYPE zdev_product.
DATA lv_xml     TYPE xstring.

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lv_xml.
```

La transformation prédéfinie `ID` produit la représentation canonique SAP appelée **asXML**. Elle est utile pour des échanges techniques contrôlés, mais ne correspond pas automatiquement au schéma XML demandé par un partenaire.

## 🌺 SIMPLE TRANSFORMATION

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

## 🌺 IMPORT XML

```abap
CALL TRANSFORMATION zdev_product_xml
  SOURCE XML lv_xml
  RESULT product = ls_product.
```

Les erreurs de syntaxe XML, de transformation ou de mapping doivent être capturées avec les classes d’exception appropriées, notamment dans la hiérarchie `CX_TRANSFORMATION_ERROR`.

## 🌺 BONNES PRATIQUES

- Versionner le schéma et la transformation.
- Contrôler les namespaces.
- Limiter la taille du document chargé en mémoire.
- Refuser les éléments inattendus selon le niveau de contrôle attendu.
- Tester les valeurs vides, caractères spéciaux et listes répétées.

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

## 🌺 PROCÉDURE PAS À PAS

1. Saisir `/nSE38` dans le champ de commande.
2. Entrer le nom d’un programme Z de test, par exemple `ZREF_DEMO`, puis choisir **Créer** ou **Modifier** selon le cas.
3. Pour un exercice local uniquement, affecter `$TMP` ; pour un développement livrable, utiliser le package et l’ordre fournis par le projet.
4. Coller ou adapter le snippet du chapitre.
5. Exécuter le contrôle syntaxique avec `Ctrl+F2`.
6. Activer avec `Ctrl+F3`.
7. Exécuter avec `F8` et comparer le résultat avec la section **Vérification**.

## 🌺 VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 🌺 ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 🌺 SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA ls_product TYPE zdev_product.
DATA lv_xml     TYPE xstring.

CALL TRANSFORMATION id
  SOURCE root = ls_product
  RESULT XML lv_xml.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **extraire un traitement procédural réutilisable dans un sous-programme clairement typé**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [CALL TRANSFORMATION — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCALL_TRANSFORMATION_SHORTREF.html)
- [Simple Transformations — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENST.html)
- [Canonical XML Representation — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENABAP_XMLS.html)


---

➡️ [Chapitre suivant — JSON AVEC LA BIBLIOTHÈQUE SXML](<./20 - 🍧 JSON AVEC LA BIBLIOTHEQUE SXML.md>)
