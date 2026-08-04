# 🌸 ENCODAGE, CODE PAGES, BOM ET FINS DE LIGNE

## 🌺 OBJECTIFS

- Comprendre les causes des caractères corrompus
- Définir un encodage explicite
- Tester les différences de plateformes

## 🌺 ENCODAGE

Un fichier texte est une séquence d’octets. L’encodage définit la correspondance entre ces octets et les caractères.

```mermaid
flowchart LR
    A["Caractères ABAP Unicode"] --> B["Conversion selon l encodage"]
    B --> C["Octets du fichier"]
    C --> D["Décodage par le consommateur"]
```

## 🌺 UTF-8

UTF-8 constitue généralement le meilleur contrat pour une nouvelle interface. Le contrat doit préciser si un **BOM** est attendu.

```abap
OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8
  WITH BYTE-ORDER MARK.
```

La disponibilité et le comportement exact des additions doivent être vérifiés sur la version ABAP cible.

## 🌺 FINS DE LIGNE

Windows utilise généralement CRLF, tandis que les systèmes Unix utilisent LF. En mode texte, l’interface ABAP gère les séparateurs selon les options et la plateforme. Le système consommateur doit accepter le format produit ou le contrat doit l’imposer explicitement.

## 🌺 TEST MINIMAL

Tester au minimum :

```text
Élément;Garçon;東京;€;"texte";ligne vide
```

Puis vérifier :

- le nombre de caractères ;
- le nombre d’octets ;
- les séparateurs ;
- l’ouverture dans l’outil consommateur ;
- la présence éventuelle du BOM.

## 🌺 ERREURS COURANTES

- écrire en `DEFAULT` et lire en UTF-8 ;
- confondre encodage et langue ;
- convertir plusieurs fois le même contenu ;
- utiliser Excel comme seul outil de validation ;
- ignorer les caractères de contrôle invisibles.

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
OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8
  WITH BYTE-ORDER MARK.
```

## 🌺 TERMES DU LEXIQUE

- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Code page](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#code-page>)
- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [GET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPGET_DATASET.html)


---

➡️ [Chapitre suivant — SERVICES FICHIERS DU FRONTEND](<./13 - 🍧 SERVICES FICHIERS DU FRONTEND.md>)
