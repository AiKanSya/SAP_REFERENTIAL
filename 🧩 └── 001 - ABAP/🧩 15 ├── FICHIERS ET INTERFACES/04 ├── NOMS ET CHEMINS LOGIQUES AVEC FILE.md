# NOMS E" Appeler l’API classique et traiter explicitement son résultat.
T CHEMINS LOGIQUES AVEC `FILE`

## RÉSULTAT ATTENDU

- Éviter les chemins physiques codés en dur
- Configurer des noms indépendants de la plateforme
- Résoudre un nom logique dans un programme ABAP

## PRINCIPE

La transaction `FILE` permet de définir des chemins et noms de fichiers logiques indépendants du système d’exploitation. Chaque environnement résout ensuite le même nom logique vers un chemin physique adapté.

```mermaid
flowchart LR
    A["Programme ABAP"] --> B["Nom logique Z_DEV_EXPORT"]
    B --> C["Configuration FILE"]
    C --> D["Chemin DEV"]
    C --> E["Chemin QAS"]
    C --> F["Chemin PRD"]
```

## ÉLÉMENTS

| Élément                | Rôle                                                             |
| ---------------------- | ---------------------------------------------------------------- |
| Chemin logique         | Représente un répertoire selon la plateforme                     |
| Nom de fichier logique | Décrit le fichier et son format physique                         |
| Syntax group           | Permet des définitions spécifiques au système d’exploitation     |
| Paramètres             | Injectent une date, un identifiant ou une autre valeur contrôlée |

## RÉSOLUTION DANS LE PROGRAMME

```abap
" Appeler l’API classique et traiter explicitement son résultat.
DATA lv_file TYPE string.

CALL FUNCTION 'FILE_GET_NAME'
  EXPORTING
    logical_filename = 'Z_DEV_EXPORT_PRODUCTS'
    parameter_1      = sy-datum
  IMPORTING
    file_name        = lv_file
  EXCEPTIONS
    file_not_found   = 1
    OTHERS           = 2.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_file).
ENDIF.
```

L’interface exacte du module fonction doit être vérifiée dans `SE37` sur la version du système.

## RÈGLES

- Utiliser des noms explicites préfixés par l’espace client.
- Contrôler les paramètres injectés.
- Ne jamais injecter directement un chemin saisi librement par l’utilisateur.
- Tester la résolution dans tous les environnements.
- Documenter le propriétaire de la configuration `FILE`.

## PROCÉDURE PAS À PAS

1. Saisir `/nSE37`.
2. Entrer le nom du module fonction puis choisir **Afficher**, **Modifier** ou **Créer** selon l’autorisation.
3. Analyser les onglets Import, Export, Changing, Tables et Exceptions.
4. Lire la documentation et le code source avant tout appel.
5. Utiliser **Test/Exécuter** avec des données non destructives.
6. Pour un module Z, contrôler, activer puis tester les cas nominal et d’erreur.

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
" Appeler l’API classique et traiter explicitement son résultat.
DATA lv_file TYPE string.

CALL FUNCTION 'FILE_GET_NAME'
  EXPORTING
    logical_filename = 'Z_DEV_EXPORT_PRODUCTS'
    parameter_1      = sy-datum
  IMPORTING
    file_name        = lv_file
  EXCEPTIONS
    file_not_found   = 1
    OTHERS           = 2.

IF sy-subrc <> 0.
  MESSAGE e001(zdev_file).
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

- [Physical and Logical File Names — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/7bfe8cdcfbb040dcb6702dada8c3e2f0/9e49819d5b2a440fb508772494b9a473.html)
- [Defining Logical Path and File Names — SAP Help Portal](https://help.sap.com/docs/SAP_NETWEAVER_700/10907a5e6c531014a252fdc4265a1f8e/4d88692f8d7a40ade10000000a15822b.html)


---

[Chapitre suivant — AUTORISATIONS ET SÉCURITÉ DES FICHIERS](<./05 ├── AUTORISATIONS ET SECURITE DES FICHIERS.md>)
