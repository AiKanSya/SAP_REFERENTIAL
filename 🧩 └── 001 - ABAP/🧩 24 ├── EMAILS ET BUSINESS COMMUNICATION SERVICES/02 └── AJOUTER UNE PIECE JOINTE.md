# AJOUTER UNE PIÈCE JOINTE

## RÉSULTAT ATTENDU

Ajouter un contenu binaire à un document BCS existant.

## CODE PRÊT À ADAPTER

Fragment à placer après la création de `LO_DOCUMENT` :

```abap
DATA lt_binary_content TYPE solix_tab.
DATA lv_size           TYPE so_obj_len.

"Alimenter LT_BINARY_CONTENT et LV_SIZE depuis la source réelle.
lo_document->add_attachment(
  i_attachment_type    = 'PDF'
  i_attachment_subject = 'Document'
  i_attachment_size    = lv_size
  i_att_content_hex     = lt_binary_content ).
```

## CONTRÔLE

- La taille transmise correspond au nombre réel d’octets.
- Le contenu est binaire et non une chaîne convertie implicitement.
- Le fichier s’ouvre depuis la demande visible dans `SOST`.
