# 7. FICHIERS TEXTE ET MODES D’ACCÈS

## 7.A RÉSULTAT ATTENDU

- Ouvrir correctement un fichier texte
- Comprendre l’effet de l’encodage et des fins de ligne
- Éviter les modes historiques non nécessaires

## 7.B MODE TEXTE

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
OPEN DATASET lv_file
  FOR INPUT
  IN TEXT MODE
  ENCODING UTF-8.
```

En mode texte :

- les données lues ou écrites doivent être de type caractère ;
- une conversion entre la représentation externe et le format interne Unicode est appliquée ;
- les séparateurs de lignes sont interprétés ou générés selon le mode et la plateforme.

## 7.C CHOIX DE L’ENCODAGE

| Option                 | Utilisation                                                                      |
| ---------------------- | -------------------------------------------------------------------------------- |
| `ENCODING UTF-8`       | Contrat moderne et explicite                                                     |
| `ENCODING DEFAULT`     | Code page par défaut du système ; dépendance à éviter dans une interface externe |
| `WITH BYTE-ORDER MARK` | Ajout ou prise en compte d’un BOM lorsque requis                                 |

## 7.D ACCÈS

- `FOR INPUT` ne modifie pas le fichier.
- `FOR OUTPUT` remplace le contenu existant lors de l’ouverture réussie.
- `FOR APPENDING` conserve le contenu et ajoute à la fin.
- `FOR UPDATE` doit être réservé aux scénarios nécessitant un positionnement précis.

## 7.E MODES LEGACY

Les modes `LEGACY TEXT MODE` et `LEGACY BINARY MODE` existent pour la compatibilité avec d’anciens formats et règles de conversion. Ils ne doivent pas être choisis par défaut pour une nouvelle interface.

## 7.F RÈGLES

- Inscrire l’encodage dans le contrat d’interface.
- Tester les accents, caractères non latins et symboles.
- Tester le fichier produit sur le système consommateur.
- Éviter `DEFAULT` lorsque plusieurs plateformes participent à l’échange.

## 7.G PROCESS

### 7.G.1 Étape 1 — Définir le contrat texte

Fixer l’encodage, le séparateur de lignes, le mode de création et le comportement attendu lorsqu’un fichier existe déjà. Le producteur et le consommateur doivent partager ce contrat.

### 7.G.2 Étape 2 — Choisir `INPUT`, `OUTPUT` ou `APPENDING`

Utiliser `INPUT` pour lire, `OUTPUT` pour créer ou remplacer et `APPENDING` pour ajouter. Ne pas sélectionner le mode à partir d’une valeur externe non validée.

### 7.G.3 Étape 3 — Ouvrir en mode texte avec encodage explicite

Employer `IN TEXT MODE ENCODING UTF-8` lorsque le contrat est UTF-8. Traiter l’exception d’autorisation et `SY-SUBRC` avant de poursuivre.

### 7.G.4 Étape 4 — Lire ou écrire une unité logique à la fois

En lecture, traiter chaque ligne jusqu’à la fin du fichier. En écriture, sérialiser la ligne complète avant `TRANSFER` afin d’éviter un fichier partiellement formaté.

### 7.G.5 Étape 5 — Fermer et vérifier le résultat

Appeler `CLOSE DATASET`, puis contrôler le fichier avec le consommateur réel. Tester les caractères accentués, les lignes vides et la fin de fichier.

## 7.H VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 7.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 7.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
OPEN DATASET lv_file
  FOR INPUT
  IN TEXT MODE
  ENCODING UTF-8.
```

## 7.K TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 7.L RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)

---

[Chapitre suivant — FICHIERS BINAIRES ET `XSTRING`](<./08 ├── FICHIERS BINAIRES ET XSTRING.md>)
