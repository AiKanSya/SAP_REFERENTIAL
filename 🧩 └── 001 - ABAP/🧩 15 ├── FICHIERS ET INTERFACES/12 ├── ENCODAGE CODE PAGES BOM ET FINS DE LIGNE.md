# 12. ENCODAGE, CODE PAGES, BOM ET FINS DE LIGNE

## 12.A RÉSULTAT ATTENDU

- Comprendre les causes des caractères corrompus
- Définir un encodage explicite
- Tester les différences de plateformes

## 12.B ENCODAGE

Un fichier texte est une séquence d’octets. L’encodage définit la correspondance entre ces octets et les caractères.

```mermaid
flowchart LR
    A["Caractères ABAP Unicode"] --> B["Conversion selon l encodage"]
    B --> C["Octets du fichier"]
    C --> D["Décodage par le consommateur"]
```

## 12.C UTF-8

UTF-8 constitue généralement le meilleur contrat pour une nouvelle interface. Le contrat doit préciser si un **BOM** est attendu.

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8
  WITH BYTE-ORDER MARK.
```

La disponibilité et le comportement exact des additions doivent être vérifiés sur la version ABAP cible.

## 12.D FINS DE LIGNE

Windows utilise généralement CRLF, tandis que les systèmes Unix utilisent LF. En mode texte, l’interface ABAP gère les séparateurs selon les options et la plateforme. Le système consommateur doit accepter le format produit ou le contrat doit l’imposer explicitement.

## 12.E TEST MINIMAL

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

## 12.F ERREURS COURANTES

- écrire en `DEFAULT` et lire en UTF-8 ;
- confondre encodage et langue ;
- convertir plusieurs fois le même contenu ;
- utiliser Excel comme seul outil de validation ;
- ignorer les caractères de contrôle invisibles.

## 12.G PROCESS

### 12.G.1 Étape 1 — Identifier l’encodage contractuel

Obtenir du producteur ou du consommateur le nom exact de l’encodage, la présence attendue d’un BOM et la convention de fin de ligne. Ne pas déduire ces paramètres d’un seul fichier d’exemple.

### 12.G.2 Étape 2 — Ouvrir avec une conversion explicite

En mode texte, préciser l’encodage dans `OPEN DATASET`. Utiliser les additions de gestion du BOM uniquement si elles existent sur la version cible et correspondent au contrat.

### 12.G.3 Étape 3 — Normaliser les fins de ligne au bon niveau

Laisser le mode texte gérer les lignes lorsque le format le permet. Pour un protocole imposant des octets exacts, produire le contenu en mode binaire selon sa spécification.

### 12.G.4 Étape 4 — Traiter les caractères non représentables

Définir si le traitement rejette le fichier, remplace le caractère ou journalise l’anomalie. Une substitution silencieuse peut corrompre une clé ou un texte métier.

### 12.G.5 Étape 5 — Tester avec un jeu discriminant

Inclure des caractères accentués, des caractères hors alphabet latin, une ligne vide, une dernière ligne sans terminateur et le marqueur BOM attendu ou absent.

### 12.G.6 Étape 6 — Vérifier avec le consommateur réel

Contrôler le fichier dans l’application cible et, si nécessaire, examiner ses octets avec un outil adapté. L’affichage correct dans l’éditeur local du développeur ne suffit pas.

## 12.H VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 12.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 12.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8
  WITH BYTE-ORDER MARK.
```

## 12.K TERMES DU LEXIQUE

- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Code page](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#code-page>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)

## 12.L RÉFÉRENCES OFFICIELLES SAP

- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [GET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPGET_DATASET.html)

---

[Chapitre suivant — SERVICES FICHIERS DU FRONTEND](<./13 ├── SERVICES FICHIERS DU FRONTEND.md>)
