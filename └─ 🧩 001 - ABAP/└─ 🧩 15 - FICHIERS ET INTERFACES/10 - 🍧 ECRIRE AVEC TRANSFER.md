# 🌸 ÉCRIRE AVEC `TRANSFER`

## 🌺 OBJECTIFS

- Créer ou compléter un fichier serveur
- Produire des lignes déterministes
- Fermer correctement le fichier après écriture

## 🌺 ÉCRITURE TEXTE

```abap
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

## 🌺 `FOR OUTPUT` OU `FOR APPENDING`

| Mode            | Conséquence                 |
| --------------- | --------------------------- |
| `FOR OUTPUT`    | Crée ou remplace le contenu |
| `FOR APPENDING` | Ajoute à la fin             |

L’ajout en fin de fichier complique la reprise et la détection des doublons. Une interface automatique produit généralement un fichier complet dans une zone de travail, puis le rend disponible une fois terminé.

## 🌺 ÉCRITURE ATOMIQUE

Lorsque l’architecture le permet :

1. écrire dans un nom temporaire ;
2. fermer le fichier ;
3. vérifier les compteurs et la taille ;
4. publier ou déplacer le fichier terminé.

ABAP ne fournit pas une opération de renommage portable équivalente pour tous les contextes. La publication doit être conçue avec l’équipe Basis ou le middleware.

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **écrire un contenu serveur sans mélange d’encodages ni de formats**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **écrire un contenu serveur sans mélange d’encodages ni de formats**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [TRANSFER — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRANSFER.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [CLOSE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPCLOSE_DATASET.html)


---

➡️ [Chapitre suivant — POSITION, TAILLE, TRONCATURE ET SUPPRESSION](<./11 - 🍧 POSITION TAILLE TRONCATURE ET SUPPRESSION.md>)
