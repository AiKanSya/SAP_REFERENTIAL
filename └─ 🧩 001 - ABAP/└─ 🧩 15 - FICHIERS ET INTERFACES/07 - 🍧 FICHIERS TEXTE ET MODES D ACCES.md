# 🌸 FICHIERS TEXTE ET MODES D’ACCÈS

## 🌺 OBJECTIFS

- Ouvrir correctement un fichier texte
- Comprendre l’effet de l’encodage et des fins de ligne
- Éviter les modes historiques non nécessaires

## 🌺 MODE TEXTE

```abap
OPEN DATASET lv_file
  FOR INPUT
  IN TEXT MODE
  ENCODING UTF-8.
```

En mode texte :

- les données lues ou écrites doivent être de type caractère ;
- une conversion entre la représentation externe et le format interne Unicode est appliquée ;
- les séparateurs de lignes sont interprétés ou générés selon le mode et la plateforme.

## 🌺 CHOIX DE L’ENCODAGE

| Option                 | Utilisation                                                                      |
| ---------------------- | -------------------------------------------------------------------------------- |
| `ENCODING UTF-8`       | Contrat moderne et explicite                                                     |
| `ENCODING DEFAULT`     | Code page par défaut du système ; dépendance à éviter dans une interface externe |
| `WITH BYTE-ORDER MARK` | Ajout ou prise en compte d’un BOM lorsque requis                                 |

## 🌺 ACCÈS

- `FOR INPUT` ne modifie pas le fichier.
- `FOR OUTPUT` remplace le contenu existant lors de l’ouverture réussie.
- `FOR APPENDING` conserve le contenu et ajoute à la fin.
- `FOR UPDATE` doit être réservé aux scénarios nécessitant un positionnement précis.

## 🌺 MODES LEGACY

Les modes `LEGACY TEXT MODE` et `LEGACY BINARY MODE` existent pour la compatibilité avec d’anciens formats et règles de conversion. Ils ne doivent pas être choisis par défaut pour une nouvelle interface.

## 🌺 RÈGLES

- Inscrire l’encodage dans le contrat d’interface.
- Tester les accents, caractères non latins et symboles.
- Tester le fichier produit sur le système consommateur.
- Éviter `DEFAULT` lorsque plusieurs plateformes participent à l’échange.

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
  FOR INPUT
  IN TEXT MODE
  ENCODING UTF-8.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [OPEN DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET.html)


---

➡️ [Chapitre suivant — FICHIERS BINAIRES ET `XSTRING`](<./08 - 🍧 FICHIERS BINAIRES ET XSTRING.md>)
