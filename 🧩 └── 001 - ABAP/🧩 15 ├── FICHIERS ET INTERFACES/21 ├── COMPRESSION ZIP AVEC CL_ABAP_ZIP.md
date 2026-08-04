# COMPRE" Construire les dépendances avant d’exécuter le traitement.

" Construire les dépendances avant d’exécuter le traitement.
SSION ZIP AVEC `CL_ABAP_ZIP`

## RÉSULTAT ATTENDU

- Regrouper plusieurs contenus dans une archive ZIP
- Manipuler l’archive en mémoire
- Séparer compression et transport du fichier

## CRÉATION

```abap
" Construire les dépendances avant d’exécuter le traitement.
DATA lv_content TYPE xstring.
DATA lv_archive TYPE xstring.

DATA(lo_zip) = NEW cl_abap_zip( ).

lo_zip->add(
  name    = 'products.csv'
  content = lv_content ).

lv_archive = lo_zip->save( ).
```

Le contenu ajouté doit être binaire (`xstring`). Un texte doit donc être converti dans l’encodage prévu avant compression.

## LECTURE

```abap
" Construire les dépendances avant d’exécuter le traitement.
lo_zip = NEW cl_abap_zip( ).
lo_zip->load( zip = lv_archive ).

DATA(lv_file_content) = lo_zip->get( name = 'products.csv' ).
```

Les signatures doivent être vérifiées dans `SE24` selon la version.

## TRANSPORT

`CL_ABAP_ZIP` crée ou lit l’archive en mémoire. Il faut ensuite :

- écrire le `xstring` sur le serveur en mode binaire ;
- ou le télécharger avec `GUI_DOWNLOAD` en mode binaire ;
- ou le transmettre à une API adaptée.

## SÉCURITÉ

Lors de l’extraction :

- contrôler les noms internes ;
- refuser les chemins absolus et `../` ;
- limiter la taille et le nombre d’entrées ;
- ne pas extraire automatiquement vers un chemin construit depuis l’archive.

## PROCESS

### ÉTAPE 1 — PRÉPARER CHAQUE ENTRÉE EN BINAIRE

Définir le nom interne de chaque fichier, son contenu et son encodage. Convertir les textes en `XSTRING` avec l’encodage prévu avant de les ajouter à l’archive. Pour un contenu déjà binaire, conserver les octets d’origine sans conversion texte intermédiaire.

### ÉTAPE 2 — CRÉER L’ARCHIVE EN MÉMOIRE

Instancier `CL_ABAP_ZIP`. Ajouter chaque entrée avec un nom relatif explicite et son contenu `XSTRING`. Refuser les noms vides, les doublons et les chemins relatifs ambigus avant l’appel ; les noms stockés dans le ZIP constituent le contrat de l’archive.

### ÉTAPE 3 — PRODUIRE LE CONTENU ZIP

Appeler la méthode de sauvegarde de l’objet ZIP afin d’obtenir l’archive complète sous forme de `XSTRING`. Vérifier que le résultat n’est pas initial et relever sa taille. Une archive n’est publiable qu’après l’ajout réussi de toutes les entrées attendues.

### ÉTAPE 4 — PERSISTER OU TRANSMETTRE L’ARCHIVE

Pour un fichier serveur, écrire le contenu en mode binaire avec `OPEN DATASET`. Pour un téléchargement local, convertir l’`XSTRING` dans la table binaire attendue par `GUI_DOWNLOAD`. Pour HTTP, transmettre les octets avec le type de contenu approprié sans conversion en texte.

### ÉTAPE 5 — CONTRÔLER L’ARCHIVE PRODUITE

Réouvrir l’archive avec un lecteur ZIP indépendant. Comparer la liste des entrées, leurs noms, leurs tailles et leur contenu aux sources. Vérifier au minimum une entrée texte avec accents et une entrée binaire afin de détecter une conversion destructive.

### ÉTAPE 6 — TESTER LES CAS D’ÉCHEC

Tester une archive vide, une entrée vide, deux noms identiques, un volume représentatif et un contenu ZIP corrompu lors de la lecture. Restituer l’entrée concernée dans le journal et ne pas publier une archive partielle comme un résultat valide.

## VÉRIFICATION

- Le fichier est créé ou lu dans l’emplacement attendu.
- Le nombre de lignes, la taille et l’encodage correspondent au contrat.
- Les caractères accentués, séparateurs, guillemets et fins de ligne sont testés.
- Le traitement journalise les rejets et permet une reprise sans doublon.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
" Construire les dépendances avant d’exécuter le traitement.
lo_zip = NEW cl_abap_zip( ).
lo_zip->load( zip = lv_archive ).

DATA(lv_file_content) = lo_zip->get( name = 'products.csv' ).
```

## TERMES DU LEXIQUE

- [ABAP](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-abap>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [CL_ABAP_ZIP Example — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/abap/3353524363.html)
- [OPEN DATASET Modes — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABAPOPEN_DATASET_MODE.html)
- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)

---

[Chapitre suivant — CONCEVOIR UNE INTERFACE D’IMPORT](<./22 ├── CONCEVOIR UNE INTERFACE D IMPORT.md>)
