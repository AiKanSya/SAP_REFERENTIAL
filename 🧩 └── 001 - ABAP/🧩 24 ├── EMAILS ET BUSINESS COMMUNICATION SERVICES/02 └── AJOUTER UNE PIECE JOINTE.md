# 2. AJOUTER UNE PIÈCE JOINTE

## 2.A RÉSULTAT ATTENDU

Ajouter un contenu binaire à un document BCS existant.

## 2.B PROCESS

### 2.B.1 ÉTAPE 1 — DÉFINIR LE CONTRAT DE LA PIÈCE JOINTE

Fixer le type de document, le nom affiché, la source, la taille maximale et la sensibilité du contenu. Refuser les pièces qui dépassent la limite applicative avant de les charger complètement en mémoire.

### 2.B.2 ÉTAPE 2 — CHARGER LES OCTETS

Lire la source en mode binaire et remplir une table `SOLIX_TAB`. Ne pas convertir un PDF, une image ou une archive par un passage intermédiaire en `STRING`.

### 2.B.3 ÉTAPE 3 — CALCULER LA TAILLE RÉELLE

Déterminer le nombre exact d’octets du contenu et le convertir dans `SO_OBJ_LEN`. Ne pas déduire la taille du nombre de lignes de `SOLIX_TAB`, car la dernière ligne peut être partielle.

### 2.B.4 ÉTAPE 4 — AJOUTER LA PIÈCE AU DOCUMENT

Appeler `ADD_ATTACHMENT` sur l’instance `LO_DOCUMENT` avec le type, le sujet, la taille et `I_ATT_CONTENT_HEX`. Réutiliser le document ensuite affecté à la demande BCS.

### 2.B.5 ÉTAPE 5 — ENVOYER SELON LE PROCESS BCS

Ajouter les destinataires, appeler `SEND`, traiter `CX_BCS` puis laisser l’unité de travail responsable effectuer le commit.

### 2.B.6 ÉTAPE 6 — CONTRÔLER LE FICHIER REÇU

Ouvrir la pièce depuis la demande dans `SOST`, comparer sa taille et vérifier son intégrité avec l’application adaptée. Tester un fichier vide, un fichier proche de la limite et un contenu invalide.

## 2.C CODE PRÊT À ADAPTER

Fragment à placer après la création de `LO_DOCUMENT` :

```abap
DATA lt_binary_content TYPE solix_tab.
DATA lv_size           TYPE so_obj_len.

" Alimenter LT_BINARY_CONTENT et LV_SIZE depuis la source réelle.
lo_document->add_attachment(
  i_attachment_type    = 'PDF'
  i_attachment_subject = 'Document'
  i_attachment_size    = lv_size
  i_att_content_hex     = lt_binary_content ).
```

## 2.D CONTRÔLE

- La taille transmise correspond au nombre réel d’octets.
- Le contenu est binaire et non une chaîne convertie implicitement.
- Le fichier s’ouvre depuis la demande visible dans `SOST`.
