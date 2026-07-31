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

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [GET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPGET_DATASET.html)
- [SET DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPSET_DATASET.html)
- [TRUNCATE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPTRUNCATE_DATASET.html)
- [DELETE DATASET — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPDELETE_DATASET.html)

---

➡️ [Chapitre suivant — ENCODAGE CODE PAGES BOM ET FINS DE LIGNE](<./12 - 🍧 ENCODAGE CODE PAGES BOM ET FINS DE LIGNE.md>)
