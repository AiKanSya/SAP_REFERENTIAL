# 16. EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR

## 16.A RÉSULTAT ATTENDU

- Télécharger des données vers le poste
- Maîtriser le format produit
- Gérer la destination et les erreurs

## 16.B EXPORT TEXTE

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

lt_lines = VALUE #(
  ( `ARTICLE;QUANTITE;UNITE` )
  ( `MAT-001;10;PC` ) ).

cl_gui_frontend_services=>gui_download(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_write_error        = 1
    no_batch                = 2
    gui_refuse_filetransfer = 3
    OTHERS                  = 4 ).

IF sy-subrc <> 0.
  MESSAGE e004(zdev_file) WITH sy-subrc.
ENDIF.
```

## 16.C NOM ET EXTENSION

Le dialogue de sauvegarde choisit le chemin. `GUI_DOWNLOAD` écrit le contenu. L’extension ne convertit pas les données : nommer un fichier `.xlsx` ne crée pas un classeur Excel.

## 16.D CSV ET EXCEL

Un CSV reste un fichier texte. Son ouverture correcte dans Excel dépend notamment :

- du séparateur ;
- de l’encodage ;
- du format régional ;
- des guillemets ;
- des conversions automatiques de dates ou zéros initiaux.

Pour un vrai fichier Office Open XML, utiliser une technologie explicitement prévue pour ce format et disponible dans le système.

## 16.E SÉCURITÉ

Ne lancer aucune application locale automatiquement après téléchargement sans besoin justifié. Pour afficher un document temporaire, SAP fournit des services frontend spécifiques plus sûrs que l’enchaînement historique téléchargement puis exécution.

## 16.F PROCESS

### 16.F.1 ÉTAPE 1 — PRÉPARER LE CONTENU À EXPORTER

Construire le contenu final avant d’ouvrir la boîte de sauvegarde. Pour un texte délimité, formater explicitement l’en-tête, les séparateurs, les guillemets, les dates, les décimaux et les zéros initiaux. Pour un fichier binaire, produire un `XSTRING` puis le convertir dans le type de table attendu par le service frontend.

### 16.F.2 ÉTAPE 2 — CONTRÔLER LA DISPONIBILITÉ DU FRONTEND

Exécuter l’export en mode dialogue et vérifier les services SAP GUI avant tout appel local. Un programme prévu pour l’arrière-plan doit utiliser un fichier serveur ou un autre canal ; il ne doit pas tenter de contourner l’absence de frontend.

### 16.F.3 ÉTAPE 3 — CHOISIR LA DESTINATION

Appeler `CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG` avec un nom proposé et une extension cohérente avec le contenu. Récupérer le chemin complet retourné. En cas d’annulation ou de chemin vide, quitter sans écrire et sans réutiliser une ancienne valeur.

### 16.F.4 ÉTAPE 4 — TÉLÉCHARGER LE FICHIER

Appeler `CL_GUI_FRONTEND_SERVICES=>GUI_DOWNLOAD` avec le chemin retenu, le type texte ou binaire approprié et l’encodage prévu par le contrat. Ne pas nommer `.xlsx` un contenu CSV : l’extension ne crée pas un classeur Office Open XML.

### 16.F.5 ÉTAPE 5 — RESTITUER LE RÉSULTAT EXACT

Après succès, afficher le chemin choisi, le nombre de lignes ou la taille produite et le format réel. En cas d’échec, distinguer un refus de sécurité SAP GUI, un fichier verrouillé, un chemin invalide et une erreur de conversion. Ne pas annoncer la création du fichier si `GUI_DOWNLOAD` a échoué.

### 16.F.6 ÉTAPE 6 — OUVRIR ET CONTRÔLER LE FICHIER

Réouvrir le fichier avec un outil indépendant et vérifier les accents, séparateurs, dates, décimaux, zéros initiaux et fins de ligne. Tester aussi un export vide, un nom avec espaces ou accents, un fichier existant et un volume représentatif.

## 16.G VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## 16.H ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## 16.I SNIPPET À RÉUTILISER

> [!NOTE]
> Adapter les noms `Z*`, les types DDIC, les données et les autorisations au système cible. Effectuer un contrôle syntaxique avant activation.

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

lt_lines = VALUE #(
  ( `ARTICLE;QUANTITE;UNITE` )
  ( `MAT-001;10;PC` ) ).

cl_gui_frontend_services=>gui_download(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_write_error        = 1
    no_batch                = 2
    gui_refuse_filetransfer = 3
    OTHERS                  = 4 ).

IF sy-subrc <> 0.
  MESSAGE e004(zdev_file) WITH sy-subrc.
ENDIF.
```

## 16.J TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## 16.K RÉFÉRENCES OFFICIELLES SAP

- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)
- [SHOW_DOCUMENT — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/5a005e044eef436f8b27bbd3f73a3cfc/b174a19731f9424db1692ac6260a68c9.html)

---

[Chapitre suivant — CONSTRUIRE ET LIRE DES FICHIERS CSV](<./17 ├── CONSTRUIRE ET LIRE DES FICHIERS CSV.md>)
