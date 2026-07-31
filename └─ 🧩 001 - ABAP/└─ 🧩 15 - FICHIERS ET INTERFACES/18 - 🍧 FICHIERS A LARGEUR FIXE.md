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

## 🌺 CAS D’USAGE

Dans un contexte où SAP échange un fichier structuré avec une application externe et doit garantir format, encodage, sécurité et reprise, le besoin consiste à **concevoir ou exécuter fichiers à largeur fixe en contrôlant emplacement, format, encodage, sécurité et reprise**. Cette notion est pertinente lorsque le lecteur doit pouvoir relier la syntaxe ou l’outil à une situation professionnelle concrète.

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
DATA lv_line TYPE c LENGTH 71.

lv_line+0(18)  = ls_item-matnr.
lv_line+18(10) = |{ ls_item-quantity DECIMALS = 3 }|.
lv_line+28(3)  = ls_item-unit.
lv_line+31(40) = ls_item-description.
```

## 🌺 TERMES DU LEXIQUE

- [Interface](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../└─ 🧩 00 - LEXIQUE SAP ET ABAP/07 - 🍧 INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 🌺 À RETENIR

- À l’issue du chapitre, le lecteur sait **concevoir ou exécuter fichiers à largeur fixe en contrôlant emplacement, format, encodage, sécurité et reprise**.
- Toujours tester sur un objet Z ou un jeu de données sans impact avant d’intervenir sur un traitement réel.
- La documentation `F1` du système reste la référence pour la syntaxe disponible dans sa release.

## 🌺 RÉFÉRENCES OFFICIELLES SAP

- [ABAP File Interface — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/fa2fd3be291f469f862c4c8215e0549b.html)
- [Character Set and File Interface Guidelines — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENCODEPAGE_FILE_GUIDL.html)
- [Offset and Length Access — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENOFFSET_LENGTH.html)


---

➡️ [Chapitre suivant — XML ET SIMPLE TRANSFORMATIONS](<./19 - 🍧 XML ET SIMPLE TRANSFORMATIONS.md>)
