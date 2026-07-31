# 🌸 LIRE UNE LIGNE AVEC READ TABLE

## 🌺 OBJECTIFS

- Lire une ligne par index ou par clé
- Utiliser `INTO`, `ASSIGNING` et `REFERENCE INTO`
- Interpréter `sy-subrc` et `sy-tabix`
- Distinguer `WITH KEY` et `WITH TABLE KEY`
- Éviter les lectures ambiguës

## 🌺 LECTURE PAR INDEX

```abap
READ TABLE lt_products
  INTO DATA(ls_product)
  INDEX 1.

IF sy-subrc = 0.
  WRITE: / ls_product-matnr.
ENDIF.
```

L’accès par index est disponible pour les tables standard et triées, pas pour l’index primaire d’une table hachée.

## 🌺 LECTURE PAR CLÉ LIBRE

```abap
READ TABLE lt_products
  INTO DATA(ls_product)
  WITH KEY matnr = 'MAT-001'.
```

`WITH KEY` décrit une clé de recherche libre. La stratégie utilisée dépend de la catégorie, de la clé de table et des composants fournis.

## 🌺 LECTURE AVEC LA CLÉ DE TABLE

```abap
READ TABLE lt_products
  INTO DATA(ls_product)
  WITH TABLE KEY matnr = 'MAT-001'.
```

Cette syntaxe exprime explicitement un accès au moyen de la clé de table correspondante.

Pour une clé nommée :

```abap
READ TABLE lt_products
  INTO DATA(ls_product)
  WITH TABLE KEY primary_key
  COMPONENTS matnr = 'MAT-001'.
```

## 🌺 CONTRÔLE DU RÉSULTAT

Après `READ TABLE` :

- `sy-subrc = 0` : ligne trouvée ;
- `sy-subrc <> 0` : aucune ligne correspondante ;
- `sy-tabix` contient l’index concerné pour les accès où un index est défini ;
- pour une table hachée, `sy-tabix` n’est pas un index de ligne exploitable.

```abap
READ TABLE lt_products
  INTO ls_product
  WITH KEY matnr = p_matnr.

IF sy-subrc <> 0.
  MESSAGE 'Produit absent de la table interne' TYPE 'I'.
  RETURN.
ENDIF.
```

## 🌺 TRANSPORTING NO FIELDS

Lorsque seule l’existence ou la position est nécessaire, éviter de copier la ligne.

```abap
READ TABLE lt_products
  TRANSPORTING NO FIELDS
  WITH KEY matnr = 'MAT-001'.

IF sy-subrc = 0.
  WRITE: / 'Produit trouvé'.
ENDIF.
```

## 🌺 LECTURE PAR ASSIGNING

```abap
READ TABLE lt_products
  ASSIGNING FIELD-SYMBOL(<ls_product>)
  WITH KEY matnr = 'MAT-001'.

IF sy-subrc = 0.
  WRITE: / <ls_product>-maktx.
ENDIF.
```

Le symbole de champ désigne directement la ligne trouvée.

## 🌺 LECTURE PAR RÉFÉRENCE

```abap
READ TABLE lt_products
  REFERENCE INTO DATA(lr_product)
  WITH KEY matnr = 'MAT-001'.

IF sy-subrc = 0.
  WRITE: / lr_product->maktx.
ENDIF.
```

## 🌺 CHOIX DE LA VARIANTE

```mermaid
flowchart TD
    A["Lire une ligne"] --> B{"Copie nécessaire ?"}
    B -- "Oui" --> C["INTO"]
    B -- "Non" --> D{"Accès direct temporaire ?"}
    D -- "Oui" --> E["ASSIGNING"]
    D -- "Non" --> F["REFERENCE INTO"]
```

## 🌺 ERREUR FRÉQUENTE

Ne pas utiliser la zone de travail sans contrôler le résultat.

```abap
READ TABLE lt_products INTO ls_product WITH KEY matnr = p_matnr.

IF sy-subrc = 0.
  " Utilisation sûre de ls_product
ENDIF.
```

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [Working with Complex Internal Tables — SAP Learning](https://learning.sap.com/courses/basic-abap-programming/working-with-complex-internal-tables_f8c923f3-6f95-4b47-960f-557001f13977)
- [READ TABLE — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPREAD_TABLE.html)
- [Internal Tables, Key Accesses — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENREAD_ITAB_USING_KEY_ABEXA.html)

---

➡️ [Chapitre suivant — EXPRESSIONS DE TABLE ET TEST D EXISTENCE](<./07 - 🍧 EXPRESSIONS DE TABLE ET TEST D EXISTENCE.md>)
