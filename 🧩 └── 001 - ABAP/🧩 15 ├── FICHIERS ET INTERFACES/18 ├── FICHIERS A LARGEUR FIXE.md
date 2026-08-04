# 18. FICHIERS À LARGEUR FIXE

## 18.A RÉSULTAT ATTENDU

- Définir des positions et longueurs stables
- Formater les valeurs sans dépendre des paramètres utilisateur
- Détecter les dépassements

## 18.B PRINCIPE

Chaque champ occupe une plage fixe de caractères.

```text
Position  Longueur  Champ
1         18        ARTICLE
19        10        QUANTITE
29        3         UNITE
32        40        DESIGNATION
```

## 18.C CONSTRUCTION

```abap
DATA lv_line TYPE c LENGTH 71.

lv_line+0(18)  = ls_item-matnr.
lv_line+18(10) = |{ ls_item-quantity DECIMALS = 3 }|.
lv_line+28(3)  = ls_item-unit.
lv_line+31(40) = ls_item-description.
```

Avant l’affectation, contrôler la longueur utile. Une affectation dans une zone trop courte tronque la valeur selon les règles de conversion et peut produire un fichier techniquement lisible mais métier incorrect.

## 18.D LECTURE

```abap
" Exemple à éviter : identifier le défaut avant de choisir la correction.
DATA lv_matnr TYPE c LENGTH 18.
DATA lv_qty   TYPE c LENGTH 10.

lv_matnr = lv_line+0(18).
lv_qty   = lv_line+18(10).
```

Contrôler d’abord que la ligne possède la longueur minimale prévue.

## 18.E CONTRAT

Définir pour chaque champ :

- position de départ ;
- longueur ;
- alignement ;
- caractère de remplissage ;
- format du signe ;
- nombre de décimales ;
- encodage ;
- traitement des dépassements.

## 18.F RISQUE UNICODE

La largeur fonctionnelle est généralement exprimée en caractères, alors que le transport physique est en octets. L’encodage doit être convenu avec le consommateur.

## 18.G PROCESS

### 18.G.1 Étape 1 — Formaliser les positions

Définir pour chaque champ sa position de départ, sa longueur, son alignement, son caractère de remplissage et son format. La somme des longueurs doit produire une longueur de ligne déterministe.

### 18.G.2 Étape 2 — Convertir les valeurs métier

Formater explicitement les dates, quantités, montants et signes selon le contrat d’interface. Ne pas dépendre des paramètres utilisateur pour les séparateurs décimaux ou les dates.

### 18.G.3 Étape 3 — Appliquer longueur et alignement

Compléter les valeurs courtes avec le caractère prévu. Rejeter ou traiter explicitement une valeur trop longue ; une troncature silencieuse peut modifier une clé.

### 18.G.4 Étape 4 — Assembler et contrôler la ligne

Concaténer les champs formatés dans l’ordre spécifié, puis comparer la longueur finale à la longueur contractuelle avant `TRANSFER`. Rejeter la ligne et journaliser sa clé source si la longueur diffère ; ne pas compléter ou tronquer l’enregistrement après ce contrôle.

### 18.G.5 Étape 5 — Lire par positions documentées

En import, vérifier d’abord la longueur minimale, extraire chaque segment par offset et longueur, puis convertir la valeur avec une gestion d’erreur explicite.

### 18.G.6 Étape 6 — Tester les bornes

Tester les valeurs initiales, maximales, négatives, trop longues et contenant des caractères multioctets. Vérifier la longueur en octets lorsque le protocole la définit ainsi.

## 18.H VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## 18.I ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 18.J SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lv_line TYPE c LENGTH 71.

lv_line+0(18)  = ls_item-matnr.
lv_line+18(10) = |{ ls_item-quantity DECIMALS = 3 }|.
lv_line+28(3)  = ls_item-unit.
lv_line+31(40) = ls_item-description.
```

## 18.K TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 18.L RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [Offset and Length Access — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENOFFSET_LENGTH.html)

---

[Chapitre suivant — XML ET SIMPLE TRANSFORMATIONS](<./19 ├── XML ET SIMPLE TRANSFORMATIONS.md>)
