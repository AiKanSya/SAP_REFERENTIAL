# 🌸 FICHIERS À LARGEUR FIXE

## 🌺 OBJECTIFS

- Définir des positions et longueurs stables
- Formater les valeurs sans dépendre des paramètres utilisateur
- Détecter les dépassements

## 🌺 PRINCIPE

Chaque champ occupe une plage fixe de caractères.

```text
Position  Longueur  Champ
1         18        ARTICLE
19        10        QUANTITE
29        3         UNITE
32        40        DESIGNATION
```

## 🌺 CONSTRUCTION

```abap
DATA lv_line TYPE c LENGTH 71.

lv_line+0(18)  = ls_item-matnr.
lv_line+18(10) = |{ ls_item-quantity DECIMALS = 3 }|.
lv_line+28(3)  = ls_item-unit.
lv_line+31(40) = ls_item-description.
```

Avant l’affectation, contrôler la longueur utile. Une affectation dans une zone trop courte tronque la valeur selon les règles de conversion et peut produire un fichier techniquement lisible mais métier incorrect.

## 🌺 LECTURE

```abap
DATA lv_matnr TYPE c LENGTH 18.
DATA lv_qty   TYPE c LENGTH 10.

lv_matnr = lv_line+0(18).
lv_qty   = lv_line+18(10).
```

Contrôler d’abord que la ligne possède la longueur minimale prévue.

## 🌺 CONTRAT

Définir pour chaque champ :

- position de départ ;
- longueur ;
- alignement ;
- caractère de remplissage ;
- format du signe ;
- nombre de décimales ;
- encodage ;
- traitement des dépassements.

## 🌺 RISQUE UNICODE

La largeur fonctionnelle est généralement exprimée en caractères, alors que le transport physique est en octets. L’encodage doit être convenu avec le consommateur.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [Offset and Length Access — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENOFFSET_LENGTH.html)

---

➡️ [Chapitre suivant — XML ET SIMPLE TRANSFORMATIONS](<./19 - 🍧 XML ET SIMPLE TRANSFORMATIONS.md>)
