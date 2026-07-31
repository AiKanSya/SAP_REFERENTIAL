# 🌸 POSITION, TAILLE, TRONCATURE ET SUPPRESSION

## 🌺 OBJECTIFS

- Interroger les propriétés d’un fichier ouvert
- Positionner le pointeur de fichier
- Tronquer ou supprimer avec prudence

## 🌺 INSTRUCTIONS

| Instruction        | Rôle                                           |
| ------------------ | ---------------------------------------------- |
| `GET DATASET`      | Lire des attributs, une position ou une taille |
| `SET DATASET`      | Modifier la position courante                  |
| `TRUNCATE DATASET` | Réduire la longueur d’un fichier ouvert        |
| `DELETE DATASET`   | Supprimer un fichier physique                  |

## 🌺 POSITIONNEMENT

```abap
DATA lv_position TYPE i.

GET DATASET lv_file POSITION lv_position.
SET DATASET lv_file POSITION 0.
```

Le positionnement est principalement pertinent en mode binaire ou dans des traitements techniques contrôlés. Il ne remplace pas un format structuré avec identifiants et contrôles de reprise.

## 🌺 SUPPRESSION

```abap
DELETE DATASET lv_file.
IF sy-subrc <> 0.
  MESSAGE e002(zdev_file) WITH lv_file.
ENDIF.
```

La suppression exige des autorisations et ne doit intervenir qu’après validation de l’archivage ou de la rétention.

## 🌺 PRÉCAUTIONS

- Ne jamais supprimer un chemin construit à partir d’une saisie libre.
- Vérifier que le fichier appartient bien à l’interface attendue.
- Préférer une zone d’archive avec purge planifiée.
- Journaliser le nom logique, le nom physique résolu et l’issue de l’opération.
- Réserver la troncature aux formats qui l’exigent réellement.

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **concevoir ou exécuter position, taille, troncature et suppression en contrôlant emplacement, format, encodage, sécurité et reprise**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
DELETE DATASET lv_file.
IF sy-subrc <> 0.
  MESSAGE e002(zdev_file) WITH lv_file.
ENDIF.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **concevoir ou exécuter position, taille, troncature et suppression en contrôlant emplacement, format, encodage, sécurité et reprise**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [GET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPGET_DATASET.html)
- [SET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSET_DATASET.html)
- [TRUNCATE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRUNCATE_DATASET.html)
- [DELETE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_DATASET.html)


---

➡️ [Chapitre suivant — ENCODAGE, CODE PAGES, BOM ET FINS DE LIGNE](<./12 - 🍧 ENCODAGE CODE PAGES BOM ET FINS DE LIGNE.md>)
