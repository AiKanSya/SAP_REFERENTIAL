# EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR

## RÉSULTAT ATTENDU

- Télécharger des données vers le poste
- Maîtriser le format produit
- Gérer la destination et les erreurs

## EXPORT TEXTE

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

## NOM ET EXTENSION

Le dialogue de sauvegarde choisit le chemin. `GUI_DOWNLOAD` écrit le contenu. L’extension ne convertit pas les données : nommer un fichier `.xlsx` ne crée pas un classeur Excel.

## CSV ET EXCEL

Un CSV reste un fichier texte. Son ouverture correcte dans Excel dépend notamment :

- du séparateur ;
- de l’encodage ;
- du format régional ;
- des guillemets ;
- des conversions automatiques de dates ou zéros initiaux.

Pour un vrai fichier Office Open XML, utiliser une technologie explicitement prévue pour ce format et disponible dans le système.

## SÉCURITÉ

Ne lancer aucune application locale automatiquement après téléchargement sans besoin justifié. Pour afficher un document temporaire, SAP fournit des services frontend spécifiques plus sûrs que l’enchaînement historique téléchargement puis exécution.

## PROCÉDURE PAS À PAS

1. Saisir `/nSAT`.
2. Créer ou sélectionner une variante de mesure adaptée.
3. Définir le programme, la transaction ou l’utilisateur à mesurer.
4. Démarrer la mesure puis reproduire une seule fois le scénario.
5. Arrêter et analyser le hit list, la hiérarchie d’appels et les temps nets.
6. Répéter la mesure après correction avec les mêmes données et le même contexte.

## VÉRIFICATION

- Le scénario reproduit correspond au même utilisateur, mandant, transaction et jeu de données.
- L’horodatage et l’identifiant de l’analyse sont conservés.
- La cause retenue est soutenue par une ligne source, une trace ou une valeur observée.
- Après correction, le même scénario ne reproduit plus le défaut et le résultat métier reste identique.

## ERREURS FRÉQUENTES

- Copier un exemple sans adapter les types, noms d’objets et données disponibles dans le système.
- Tester uniquement le cas nominal et ignorer les valeurs initiales, absentes ou invalides.
- Mélanger fichiers frontend et serveur dans un même scénario.
- Parser un CSV par simple séparation alors que les champs peuvent être échappés.

## SNIPPET À RÉUTILISER

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

## TERMES DU LEXIQUE

- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)
- [Serveur d’application](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#fichier-serveur-application>)

## RÉFÉRENCES OFFICIELLES SAP

- [GUI_DOWNLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_FOR_SOH_740/5a005e044eef436f8b27bbd3f73a3cfc/c75ab8ec178c44a8aacd1dcac3460db8.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)
- [SHOW_DOCUMENT — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_AS_ABAP_751_IP/5a005e044eef436f8b27bbd3f73a3cfc/b174a19731f9424db1692ac6260a68c9.html)


---

[Chapitre suivant — CONSTRUIRE ET LIRE DES FICHIERS CSV](<./17 ├── CONSTRUIRE ET LIRE DES FICHIERS CSV.md>)
