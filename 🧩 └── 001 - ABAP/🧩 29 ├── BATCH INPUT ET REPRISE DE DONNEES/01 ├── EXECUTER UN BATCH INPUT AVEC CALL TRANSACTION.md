# 1. EXÉCUTER UN BATCH INPUT AVEC `CALL TRANSACTION`

## 1.A RÉSULTAT ATTENDU

Rejouer une séquence d’écran contrôlée et récupérer tous les messages produits.

## 1.B PROCESS

### 1.B.1 ÉTAPE 1 — VÉRIFIER L’ABSENCE D’API ADAPTÉE

Utiliser le batch input pour maintenir un flux existant ou lorsqu’aucune API stable ne couvre le besoin. Pour une nouvelle reprise S/4HANA, vérifier d’abord les outils de migration et API officiellement prévus par l’objet métier.

### 1.B.2 ÉTAPE 2 — ENREGISTRER LE SCÉNARIO DANS SHDB

Créer un enregistrement avec les mêmes données et la même variante fonctionnelle que le traitement cible. Conserver l’ordre exact des dynpros, champs et `BDC_OKCODE` observés sur le système cible.

### 1.B.3 ÉTAPE 3 — CONSTRUIRE LT_BDCDATA

Ajouter une ligne `DYNBEGIN` au début de chaque écran, puis les champs et commandes dans leur ordre. Convertir dates, nombres et codes dans le format externe attendu par l’écran.

### 1.B.4 ÉTAPE 4 — EXÉCUTER D’ABORD EN MODE VISIBLE

Appeler la transaction en mode `A` avec un petit échantillon. Après validation, tester le mode `E`, puis seulement le mode invisible `N`.

### 1.B.5 ÉTAPE 5 — CAPTURER TOUS LES MESSAGES

Transmettre `MESSAGES INTO LT_MESSAGES`, tester `SY-SUBRC` et convertir chaque message avec son identifiant, son numéro et ses variables. Conserver la clé source associée à chaque exécution.

### 1.B.6 ÉTAPE 6 — RECHERCHER LE RÉSULTAT MÉTIER

Après l’appel, vérifier si le document a été créé même lorsque le code retour indique un problème. Ne pas relancer automatiquement une entrée sans ce contrôle.

### 1.B.7 ÉTAPE 7 — TESTER LA REPRISE

Provoquer une erreur avant et après la sauvegarde, corriger la donnée puis rejouer. Vérifier qu’une entrée source produit au maximum le document métier prévu.

## 1.C CODE PRÊT À ADAPTER

Fragment : la table `LT_BDCDATA` doit être construite depuis un enregistrement `SHDB` validé sur le système cible.

```abap
DATA lt_bdcdata  TYPE STANDARD TABLE OF bdcdata WITH EMPTY KEY.
DATA lt_messages TYPE STANDARD TABLE OF bdcmsgcoll WITH EMPTY KEY.

" Ajouter chaque dynpro et chaque champ dans l’ordre exact enregistré par SHDB.
APPEND VALUE #( program = 'SAPLZDEMO' dynpro = '0100' dynbegin = abap_true ) TO lt_bdcdata.
APPEND VALUE #( fnam = 'BDC_OKCODE' fval = '=SAVE' ) TO lt_bdcdata.

CALL TRANSACTION 'ZDEMO'
  USING lt_bdcdata
  MODE 'N'
  UPDATE 'S'
  MESSAGES INTO lt_messages.

IF sy-subrc <> 0.
  " Conserver LT_MESSAGES : il contient le diagnostic détaillé du traitement.
  MESSAGE e001(zdemo) WITH sy-subrc.
ENDIF.
```

## 1.D CONTRÔLE

- Tester d’abord en mode `A`, puis `E`, avant le mode invisible `N`.
- La transaction, les écrans et les OK_CODE existent dans la version S/4HANA cible.
- Le document métier est recherché après l’appel afin de détecter un succès partiel.
