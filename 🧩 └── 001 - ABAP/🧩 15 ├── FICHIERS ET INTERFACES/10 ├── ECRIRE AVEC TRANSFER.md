# ÉCRIRE" Ouvrir le fichier avec le mode et l’encodage attendus.

AVEC `TRANSFER`

## RÉSULTAT ATTENDU

- Créer ou compléter un fichier serveur
- Produire des lignes déterministes
- Fermer correctement le fichier après écriture

## ÉCRITURE TEXTE

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
DATA lv_file TYPE string.
DATA lv_line TYPE string.

OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8.

lv_line = 'ARTICLE;QUANTITE;UNITE'.
TRANSFER lv_line TO lv_file.

lv_line = 'MAT-001;10;PC'.
TRANSFER lv_line TO lv_file.

CLOSE DATASET lv_file.
```

En mode texte, `TRANSFER` ajoute normalement une fin de ligne après chaque objet transféré. L’addition `NO END OF LINE` existe pour des formats particuliers, mais elle ne doit pas être utilisée dans un CSV standard sans justification.

## `FOR OUTPUT` OU `FOR APPENDING`

| Mode            | Conséquence                 |
| --------------- | --------------------------- |
| `FOR OUTPUT`    | Crée ou remplace le contenu |
| `FOR APPENDING` | Ajoute à la fin             |

L’ajout en fin de fichier complique la reprise et la détection des doublons. Une interface automatique produit généralement un fichier complet dans une zone de travail, puis le rend disponible une fois terminé.

## ÉCRITURE ATOMIQUE

Lorsque l’architecture le permet :

1. écrire dans un nom temporaire ;
2. fermer le fichier ;
3. vérifier les compteurs et la taille ;
4. publier ou déplacer le fichier terminé.

ABAP ne fournit pas une opération de renommage portable équivalente pour tous les contextes. La publication doit être conçue avec l’équipe Basis ou le middleware.

## PROCESS

### Étape 1 — Choisir la politique de création

Décider si le programme remplace le fichier, ajoute des lignes ou refuse un fichier existant. Documenter ce comportement avant d’utiliser `OUTPUT` ou `APPENDING`.

### Étape 2 — Ouvrir le fichier avec un contrat explicite

Résoudre le nom logique et appeler `OPEN DATASET` dans le mode texte ou binaire prévu. Traiter l’autorisation et l’échec d’ouverture.

### Étape 3 — Sérialiser la ligne ou le bloc

Construire le contenu complet dans une variable typée. Valider longueur, séparateurs, échappement et encodage avant l’écriture.

### Étape 4 — Exécuter `TRANSFER`

Écrire une unité logique à la fois. Traiter les erreurs d’écriture et arrêter le traitement lorsque le fichier n’est plus dans un état fiable.

### Étape 5 — Fermer et publier le résultat

Fermer le dataset avant de signaler le succès. Retourner le nombre de lignes ou d’octets écrits et ne jamais considérer une ouverture réussie comme la preuve d’une écriture complète.

### Étape 6 — Tester les échecs partiels

Tester un répertoire indisponible, un espace insuffisant selon les possibilités de l’environnement, une donnée invalide et une interruption au milieu du flux. Vérifier la règle de reprise ou de remplacement du fichier partiel.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Ouvrir le fichier avec le mode et l’encodage attendus.
DATA lv_file TYPE string.
DATA lv_line TYPE string.

OPEN DATASET lv_file
  FOR OUTPUT
  IN TEXT MODE
  ENCODING UTF-8.

lv_line = 'ARTICLE;QUANTITE;UNITE'.
TRANSFER lv_line TO lv_file.

lv_line = 'MAT-001;10;PC'.
TRANSFER lv_line TO lv_file.

CLOSE DATASET lv_file.
```

## TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)

---

[Chapitre suivant — POSITION, TAILLE, TRONCATURE ET SUPPRESSION](<./11 ├── POSITION TAILLE TRONCATURE ET SUPPRESSION.md>)
