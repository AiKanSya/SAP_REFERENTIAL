# IMPORTER UN FICHIER DU POSTE UTILISATEUR

## RÉSULTAT ATTENDU

- Charger un fichier local dans une table interne
- Choisir le type de fichier adapté
- Contrôler les erreurs de frontend

## IMPORT TEXTE

```abap
DATA lt_lines    TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA lv_filename TYPE string.

cl_gui_frontend_services=>gui_upload(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    OTHERS                  = 5 ).

IF sy-subrc <> 0.
  MESSAGE e003(zdev_file) WITH sy-subrc.
ENDIF.
```

Les exceptions exactes et les paramètres doivent être contrôlés dans `SE24`, car ils peuvent différer selon le niveau de composant.

## TYPES DE FICHIER

| Type  | Usage                                                   |
| ----- | ------------------------------------------------------- |
| `ASC` | Texte                                                   |
| `BIN` | Contenu binaire                                         |
| `DAT` | Format texte avec séparateurs selon le service frontend |

Pour un contrat d’interface strict, importer des lignes texte puis effectuer soi-même le parsing évite de dépendre de comportements implicites.

## LIMITES

- Impossible en arrière-plan.
- Le fichier traverse la connexion frontend vers le serveur ABAP.
- Le volume doit rester compatible avec une interaction utilisateur.
- La sélection locale ne dispense pas des contrôles métier.

## ARCHITECTURE

La méthode d’import doit retourner un contenu brut ou une table de lignes. Une méthode distincte transforme ce contenu en données métier. Le test du parsing devient alors indépendant de SAP GUI.

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

cl_gui_frontend_services=>gui_upload(
  EXPORTING
    filename = lv_filename
    filetype = 'ASC'
  CHANGING
    data_tab = lt_lines
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    OTHERS                  = 5 ).

IF sy-subrc <> 0.
  MESSAGE e003(zdev_file) WITH sy-subrc.
ENDIF.
```

## TERMES DU LEXIQUE

- [Import](<../🧩 00 ├── LEXIQUE SAP ET ABAP/03 ├── REPOSITORY PACKAGES ET TRANSPORTS.md#import-transport>)
- [Interface](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#interface-integration>)
- [Flux entrant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-entrant>)
- [Flux sortant](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#flux-sortant>)
- [CSV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#csv>)
- [Encodage](<../🧩 00 ├── LEXIQUE SAP ET ABAP/07 ├── INTERFACES ET INTEGRATION.md#encodage>)

## RÉFÉRENCES OFFICIELLES SAP

- [GUI_UPLOAD — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_702/ff557c806c5510149761a0c32c810458/1dac0155370648569fe843170e07c4da.html)
- [Files on the Presentation Server — ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/ABENFRONTEND_FILES.html)
- [File Upload and Download — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/5a005e044eef436f8b27bbd3f73a3cfc/9ff8506b2b8f4812904912c4b207096c.html)


---

[Chapitre suivant — EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR](<./16 ├── EXPORTER UN FICHIER VERS LE POSTE UTILISATEUR.md>)
